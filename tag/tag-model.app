module tag/tag-model

section data model

  entity Tag { 
    name        :: String (validate(name.length() > 1, "Tags need to have at least 2 characters"),
                           validate(/[a-zA-Z0-9\.\-_@!]*/.match(name),"Tags may consist of: a-z 0-9 . _ @ ! -"),
                           searchable(default, analyzer=none))
    description :: String
    project     -> Project
    tags        -> Set<Tag>
    
    function makeRelease(p: Project) {
      tags.add(tag("release", p));
    }
    
    function makeIssueType(p: Project) {
      tags.add(tag(ISSUE_TYPE_TAG(), p));
    }
    
    function color(p : Project, color : String) {
      tags.add(tag(color, p));
    }
  
    function hasTag(tagName : String) : Bool {
      for( t : Tag in tags) {
        if(t.name == tagName) {
          return true; 
        }
      }
      return false;
    }
      
    function toJSON():JSONObject{
      var json := JSONObject();
      json.put("id",id);
      json.put("name",name);
      // json.put("project",project.toSimpleJSON());
      json.put("color",getColor());
      return json;
    }
  
    function getColor() : String{
      if(hasTag("release")){
        return "blue";
      }
      if(hasTag("red")) {
        return "red";
      } if(hasTag("green")) {
        return "green";
      } if(hasTag("grey")||hasTag(ISSUE_TYPE_TAG())) {
        return "black";
      } if(hasTag("purple")) {
        return "purple";
      } else {
        return "yellow";
      }
    }
  
    function getStylingClass() : String{
      if(hasTag("release")) {
        return "ReleaseTag";
      } if(hasTag("red")) {
        return "RedTag";
      } if(hasTag("green")) {
        return "GreenTag";
      } if(hasTag("grey")) {
        return "GreyTag";
      } if(hasTag("purple")) {
        return "PurpleTag";
      } if(hasTag(ISSUE_TYPE_TAG())) { // Can be overridden by custom colors 
        return "IssuetypeTag";
      } else {
        return "DefaultTag";
      }
    }
  
    function isColored() : Bool {
      return  hasTag("red")   || 
          hasTag("green") ||
          hasTag("grey") ||
          hasTag("purple");
    }
  }
  
  function tagify(x: String): String {
    return /[^a-z0-9\.\-_@!]/.replaceAll("", x.toLowerCase());
  } 
  
section suggest tags

  function tagSuggestions(tagPrefix : String, issue : Issue): List<Tag> {
    var tagSearchString := tagPrefix.toLowerCase() + "%";
    var suggestions : List<Tag> := (
      select t
      from  Issue as i left join i.tags as t  // Joint to only select used tags (subqueries not supported)
      where i._project = ~issue.project and
        t._project = ~issue.project and   // Not really needed, but improves performance
        t._name like ~tagSearchString and
        t._name not like ~tagSuggestionFilter(tagPrefix)
      group by t._name
      order by count(i) desc
      limit 5
    ) as List<Tag>;
    return suggestions;  
  }
  
section issue tags

  extend entity Issue {
    
    function addTag(t : Tag) {
      tags.add(t);
      log.add(
        TagAddition{ 
          moment := now()
          actor := securityContext.principal
          tag := t
        }
      );
    }
    function deleteTag(t : Tag) {
      tags.remove(t);
      log.add(
        TagRemoval{ 
          moment := now()
          actor := securityContext.principal
          tag := t
        }
      );
    }
    function hasTag(tagName : String) : Bool {
      for(t : Tag in tags) {
        if(t.name == tagName) {
          return true;
        }
      }
      return false;
    }
  }

  function tag(t : String, p : Project) : Tag {
    var tags : List<Tag> :=  from Tag where _name = ~t and _project = ~p;
    if(tags.length == 0) {
      tags := from Tag where _name = ~tagify(t) and _project = ~p;
    }
    if(tags.length == 0) {
      var newTag := Tag { 
        name := tagify(t) 
        project := p
      };
      newTag.save();
      return newTag; 
    } else {
      return tags[0];
    } 
  }

  function getTag(t : String, p : Project) : Tag {
    var tags : List<Tag> :=  from Tag where _name = ~t and _project = ~p;
      //where _name = ~t.toLowerCase() and _project = ~p;
    if(tags.length == 0) {
      return null; 
    } else {
      return tags[0];
    }
  }

  function getFollowers(ts : Set<Tag>) : Set<User> {
    var followers : Set<User> := {User{}};
    followers.clear();
    for(t : Tag in ts) {
      if(/![a-z0-9]+/.match(t.name)) {
        var tagSuffixArray := t.name.split();
        tagSuffixArray.removeAt(0);
        var tagSuffix := tagSuffixArray.concat();
        var us : List<User> := 
          from User
          where _tag = ~tagSuffix;
        if(us.length > 0) {
          followers.add(us.get(0));
        }
      }
    }
    return followers;
  }

/**
 ** Deletes the given tag if:
 ** - It is not used on issues
 ** - It is not used on tags (as meta tag)
 ** - It is not tagged (by a meta tag)
 ** - It is not an assignment tag (@someone) of one of the project members
 **/
function tagCleanup(tag : Tag) {
  
// Tag cleanup temporarily disabled, as they cannot be deleted anyway: 
// tag usage is recorded, so tags can never be deleted again

// I am integrating permanently existing tags into the rest of the code, so at
// some point the code below should become obsolete and I will delete it.
/*  flush();
  var taggedIssues : List<Issue> :=
    select i
    from Issue as i
    left join i._tags as t
    where t = ~tag
    limit 1;
  var taggedTags : List<Tag> := 
    select tag
    from Tag as tag
    left join tag._tags as t
    where t = ~tag
    limit 1;
    
  // Is the tag used or tagged?
  if( taggedIssues.length == 0 && taggedTags.length == 0 && tag.tags.length == 0) {
    //  Are there any project memebers using this tag
    if(/@[a-z0-9]+/.match(tag.name)) {
      var tagSuffixArray := tag.name.split();
      tagSuffixArray.removeAt(0);
      var tagSuffix := tagSuffixArray.concat();
      var members : List<Project> := 
        select p // Selecting the project does not make sense, bu I am working around a bug in the type checker
        from Project as p
        left join p._members as m
        where m._tag = ~tagSuffix and p = ~tag.project;
        
      if(members.length == 0 ) {
        tag.delete();
      }
    } else { 
      tag.delete();
    }
  }
*/
}

  function arrangeTags(tags : Set<Tag>, summary : Bool) : List<Tag> {
    // TODO Maybe optimize this by little loops that add them on the fly, saves some list building
    var types :=    [t | t : Tag in tags where t.hasTag(ISSUE_TYPE_TAG()) order by t.name];
    var releases := [t | t : Tag in tags where t.hasTag("release") order by t.name]; 
    var assigns :=  [t | t : Tag in tags where t.name.contains("@") order by t.name];
    var others :=   [t | t : Tag in tags where !t.hasTag("release") && 
                                               !t.hasTag(ISSUE_TYPE_TAG()) && 
                                               !t.name.contains("!") &&
                                               !t.name.contains("@")
                                               order by t.name];
  
    var sortedTags : List<Tag> := List<Tag>();
    sortedTags.addAll(types);
    sortedTags.addAll(releases);
    if(!summary) {
      var votes :=  [t | t : Tag in tags where t.name.contains("!")];
      sortedTags.addAll(assigns);
      sortedTags.addAll(votes);
    } else { 
      if(sortedTags.length + others.length + assigns.length <= 3) {
        sortedTags.addAll(assigns);
      }
    }
    sortedTags.addAll(others);
    return sortedTags;
  }

