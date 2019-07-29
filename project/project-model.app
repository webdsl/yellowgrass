module project/project-model

section data model

  entity Project {
    name        :: String (id, 
      validate(isUniqueProject(this), "Another project with this name already exists"), 
      validate(/\w[\w. ]*\w/.match(name), "Project names should start and end with a letter/number/underscore and should at least be 2 characters long."))

    description      :: WikiText
    url              :: URL
    issues           -> Set<Issue>
    private          :: Bool (searchable)
    email            :: Email

    key              :: String    
    extend function setName(x: String) {
      key := x.toLowerCase();
    }
    getkey :: String := getkey()  
    function getkey(): String {
      if(key == null || key == "") { key := name.toLowerCase(); }
      return key; 
    }
    
    search mapping{
    	name using none //index untokenized
    }
    
  }

section queries

  function activeProjects(): List<Project> {
    // return select p
    //   from Project as p
    //   join p.issues as i
    //   where _private=false
    //   group by p
    //   order by max(i._submitted) desc
    //   limit 10;
    return select p
      from Project as p
      where _private=false
      order by p.modified desc
      limit 10;
  }

  extend entity Project { 
    
    function issueTypes(): List<Tag> {
      return select t1
      from Tag as t1 left join t1.tags as t2
      where 
        t1.project = ~this and
        t2.project = ~this and
        t2.name = ~ISSUE_TYPE_TAG()
      group by t1.name, t1.id
      order by t1.name;
    }
    
    function taggedIssues(tag: Tag): List<Issue> {
      return select i
      from Issue as i
      left join i._tags as t
      where t._name = ~(tag.name) and t._project = ~this
      limit 500;
    } 
     
    function recentIssues(n: Int): List<Issue> {
      return from Issue
        where _open = true and _project = ~this
        order by _submitted desc
        limit ~n;
    }
  
    function popularIssues(n: Int): List<Issue> {
      //Use 2 separate queries to obtain the issues, because selecting the whole issue (including wikitext props)
      //in this group-by query causes a temp disk table to be created.
      var ids := select i.id
        from Issue as i 
        left join i.tags as t
        where 
          i._open = true and 
          i._project = ~this and
          t._name like ~"!%"
        group by i 
        order by count(t._name) desc //order by aggregation is not supported in MySQL :(
        limit ~n;
        
        if(ids.length > 0){
          return from Issue where id in ~ids;
        } else {
          return List<Issue>();
        }
    }
  
    function getCommonTags(nr : Int): List<Tag> {
      var result :List<Tag> := 
        ( select t
          from Issue as i inner join i.tags as t
          where   (i._project = ~this) and 
              (t._project = ~this) and // Not needed, but used for performance
              (t._name not like ~"@%") and 
              (t._name not like ~"!%")
          group by substring(t._name,1,100), t.id
          order by count(i) desc
          limit ~nr
        ) as List<Tag>;
      return result;
    }
  
    function getIssueTypeTags(): List<Tag> { 
      return select t1
        from Tag as t1 left join t1.tags as t2
        where 
          t1.project = ~this and
          t2.project = ~this and
          t2.name = ~ISSUE_TYPE_TAG()
        group by t1.name
        order by t1.name;
    }
  
    function getOrderedIssues(filterOpen : Bool) : List<Issue> {
      if(filterOpen) {
        return
          from Issue
          where _project = ~this and _open = true
          order by _number desc
          limit 2000;
      } else {
        return
          from Issue
          where _project = ~this
          order by _number desc
          limit 2000;
      }
    }
  
    function getIssueStatsWeekly() : List<Int> {
      // TODO Use version below when supported in WebDSL
      /*    var start : DateTime := now().addYears(-1);
       return
        select count(i)
        from Issue as i
        where (i._project = ~this and i._submitted > ~start)
        group by month(i._submitted)
        order by i._submitted;
     */    
    
      // This is ugly, but webdsl does not support any better right now
      var yearStart : DateTime := now().addYears(-1);
      var stats : List<Int>;
      for(week : Int from 1 to 51) {
        var start := yearStart.addDays(week * 7);
        var end := yearStart.addDays((week+1) * 7);
        stats.add(
          select count(*)
          from Issue
          where _project = ~this
          and _submitted > ~start 
          and _submitted < ~end
        );
      }
      return stats;
    }
  
    function getWeeklyStatsGraph() : String {
      var stats := getIssueStatsWeekly();
      var maxStat := maxList(stats);
  
      var prefix := "http://chart.apis.google.com/chart?cht=bvg&chs=230x100&chco=bbcebb&chbh=a,5,10&chxt=y";
      var rangePrefix := "&chds=0," + maxStat;
      var axisPrefix := "&chxr=0,0," + maxStat;
      var dataPrefix := "&chd=t:";
    
      var url : List<String>;
      url.add(prefix);
      url.add(rangePrefix);
      url.add(axisPrefix);
      url.add(dataPrefix);
      for(nr : Int from 0 to stats.length - 2) {
        url.add(stats.get(nr).toString() + ",");
      }
      url.add(stats.get(stats.length - 1).toString());
    
      return url.concat();
    }
  
  }
  
section json 

  extend entity Project {
  function toJSON(old : JSONObject) : JSONObject {
    if(private && !(securityContext.principal in members)) { 
      return null;
    }
    var jsonobject := JSONObject();
    jsonobject.put("id", id);
    var version := old.getInt("version");
    if(version < this.version) {
      jsonobject.put("name", name);
      jsonobject.put("description", description.format());
      jsonobject.put("url", url);
      jsonobject.put("version", this.version);
    }
    jsonobject.put("weeklyStatsGraph", this.getWeeklyStatsGraph());
    if(version == 0) {
      var jsonArrayIssues := JSONArray();
      for (issue : Issue in issues order by issue.number desc limit 10) {
        jsonArrayIssues.put(issue.toJSON());
      }
      jsonobject.put("issues", jsonArrayIssues);
      var releases := generateRoadmap(this);
      var jsonmap := JSONArray();
      for(release : Release in releases order by release.name desc) {
        if(jsonmap.length() == 0) { 
          jsonmap.put(release.toJSON());
        } else {
          jsonmap.put(release.toJSONSimple());
        }
      }
      jsonobject.put("roadmap", jsonmap);
    }
    var jsonoldmembers := toVersionObejcts( old.getJSONArray("members"));
    var jsonArrayMembers := JSONArray();
    var dirty := false;
    for (member : User in members) {
      var vobject := VersionObject{
        id := member.id
      };
      var index := jsonoldmembers.indexOf(vobject);
      if(index == -1 || jsonoldmembers.get(index).version != member.version) {
        log(member.name + "is out dated");
        jsonArrayMembers.put(member.toJSON());
        dirty := true;
      } else {
        //var x := jsonoldmembers.toString();
        log(member.name + "(" + member.id + ")" + ":" + member.version + "is in ");
        for(object : VersionObject in jsonoldmembers) {
          log(object.toString2());
        }
        jsonArrayMembers.put(member.toSimpleJSON()); 
      }
    }
    
    if(dirty || (version < this.version)) {
      jsonobject.put("members", jsonArrayMembers);
    }
    var jsonoldfollowers := toVersionObejcts( old.getJSONArray("followers"));
    dirty := false;
    var jsonArrayFollowers := JSONArray();
    for (follower : User in followers) {
      var vobject := VersionObject{
        id := follower.id
      };
      var index := jsonoldfollowers.indexOf(vobject);
      if(index == -1 || jsonoldmembers.get(index).version != follower.version) {
        jsonArrayMembers.put(follower.toJSON());
        dirty := true;
      } else {
        jsonArrayMembers.put(follower.toSimpleJSON());
      }
    } 
    if(dirty|| (version < this.version)) {
      jsonobject.put("followers", jsonArrayFollowers);
    }
    var issuetags := JSONArray();
    for(tag : Tag in getIssueTypeTags()) {
      issuetags.put(tag.toJSON());
    }
    jsonobject.put("issueTypes", issuetags);
    return jsonobject;
  }
  
  function toSimpleJSON() : JSONObject {
    if(private && !(securityContext.principal in members)) { 
      return null;
    }
    var jsonobject := JSONObject();
    jsonobject.put("id", id);
    jsonobject.put("name", name);
    jsonobject.put("version", version); 
    return jsonobject;
  }
  
  function toJSONRef() : JSONObject{
    if(private && !(securityContext.principal in members)) { 
      return null;
    }
    var jsonobject := JSONObject();
    jsonobject.put("id", id);
    return jsonobject;
  }
  
}


