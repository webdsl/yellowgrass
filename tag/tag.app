module tag/tag

imports tag/ac
imports tag/sidebar
imports tag/manual
imports user/user
// imports issue/issue
imports project/roadmap
imports comment/tagControl

entity Tag {
	name 		:: String	(validate(name.length() > 1, "Tags need to have at least 2 characters"),
							 validate(/[a-z0-9\.-_@!]*/.match(name),"Tags may consist of: a-z 0-9 . _ @ ! -"))
	description :: String
	project 	-> Project
	tags		-> Set<Tag>
	
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
		}else{
			return "yellow";
			}
	}
	
	function getStylingClass() : String{
		  if(hasTag("release")) {
			return "ReleaseTag Tag";
		} if(hasTag("red")) {
			return "RedTag Tag";
		} if(hasTag("green")) {
			return "GreenTag Tag";
		} if(hasTag("grey")) {
			return "GreyTag Tag";
		} if(hasTag("purple")) {
			return "PurpleTag Tag";
		}if(hasTag(ISSUE_TYPE_TAG())) { // Can be overridden by custom colors 
			return "IssuetypeTag Tag";
		} else {
			return "Tag";
		}
	}
	
	function isColored() : Bool {
		return 	hasTag("red") 	|| 
				hasTag("green") ||
				hasTag("grey");
	}
}

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
		for( t : Tag in tags) {
			if(t.name == tagName) {
				return true;
			}
		}
		return false;
	}
}

function tag(t : String, p : Project) : Tag {
	var tags : List<Tag> := 
		from Tag
		where _name = ~t.toLowerCase() and _project = ~p;
	if(tags.length == 0) {
		var newTag := Tag { 
			name := t.toLowerCase()
			project := p
		};
		newTag.save();
		return newTag; 
	} else {
		return tags.get(0);
	}
}

function getTag(t : String, p : Project) : Tag {
	var tags : List<Tag> := 
		from Tag
		where _name = ~t.toLowerCase() and _project = ~p;
	if(tags.length == 0) {
		return Tag {}; 
	} else {
		return tags.get(0);
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
/*	flush();
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
	if(	taggedIssues.length == 0 && taggedTags.length == 0 && tag.tags.length == 0) {
		// 	Are there any project memebers using this tag
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
	var votes := 	[t | t : Tag in tags where t.name.contains("!")];
	var assigns := 	[t | t : Tag in tags where t.name.contains("@")];
	var others :=   [t | t : Tag in tags where 
						!t.hasTag("release") && 
						!t.hasTag(ISSUE_TYPE_TAG()) && 
						!t.name.contains("!") &&
						!t.name.contains("@")
						order by t.name];
	
	var sortedTags : List<Tag> := List<Tag>();
	sortedTags.addAll(types);
	sortedTags.addAll(releases);
	if(!summary) {
		sortedTags.addAll(assigns);
		sortedTags.addAll(votes);
	} else {
		if(sortedTags.length + assigns.length <= 3) {
			sortedTags.addAll(assigns);
		}
	}
	sortedTags.addAll(others);
	return sortedTags;
}

define page tag(p : Project, tag : String) {
	title{output(p.name) " / " output(tag) " - on YellowGrass.org"}
	main(p)
	define body(){
		var t := getTag(tag, p);
		var taggedIssues : List<Issue> :=
			select i
			from Issue as i
			left join i._tags as t
			where t._name = ~tag and t._project = ~p
			limit 500

		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					rawoutput { " &raquo; " }
					navigate(home()) {"Home"}
					rawoutput { " &raquo; " }
					navigate(project(p)) {"Project " output(p.name)}
					rawoutput { "&raquo; " } " Tag " output(tag)
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {rawoutput { "&raquo; " } " Back to Project"} }
			}
			par{ 
				<h1> "Tagged " output(t.name) tags(t, true) </h1>
				if(t.description != null && t.description != "") {
					<i> output(t.description) </i>
				}
			}
			issues(taggedIssues.set(), false, true, true, 50, true, false)
		}
		tagSideBar(t)
	}
}

define page editTag(p : Project, t : Tag) {
	title{output(t.project.name) "." output(t.name) " on YellowGrass.org [Editing]"}
	main(p)
	define body(){
		<h1> "Edit Tag" </h1>
		form {
			par {
				label("Name") { input(t.name) }
			}
			par {
				label("Description") { input(t.description) }
			}
			par {
				navigate(tag(t.project, t.name)) {"Cancel"}
				" "	
				submit("Save",save())
			}
		}
	}
	action save(){
		t.save();
		return tag(t.project, t.name);
	}
}

define template tags(t : Tag, editing : Bool) {
	block [class:="Tags"] {
		for(tag : Tag in arrangeTags(t.tags, false)) {
			block [class:=tag.getStylingClass()] {
				output(tag.name) 
				if(editing) {
					block [class := "Delete"] {
						actionLink("x", deleteTag(t, tag))
					}
				}
			}
			output(" ")
		}
		tagHelp()
	}
	action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
		tagToRemoveFrom.tags.remove(tagToRemove);
		tagCleanup(tagToRemove);
		return tag(t.project, t.name);
	}
}

function getTagsStylingClass(summary : Bool) : String {
	if(summary) {
		return "Tags TagsSummary";
	} else {
		return "Tags";
	}
}

define template tags(i : Issue, editing : Bool) {
	tags(i, editing, false)
}
define template tags(i : Issue, editing : Bool, summary : Bool) {
	block [class = getTagsStylingClass(summary)] {
		for(tag : Tag in arrangeTags(i.tags, summary)) {
			block [class:=tag.getStylingClass()] {
				navigate(tag(i.project, tag.name)){output(tag.name)} 
				if(editing) {
					block [class := "Delete"] {
						actionLink("x", deleteTag(i, tag))
					}
				}
			}
			" "
		}
	}
	action deleteTag(i : Issue, t : Tag) {
		i.deleteTag(t);
		i.save();
		tagCleanup(t);
		return issue(i.project, i.number);
	}
}

define template tags(ts : List<Tag>, p : Project) {
	block [class:="Tags"] {
		for(tag : Tag in ts) {
			navigate (tag(p, tag.name)){output(tag.name)} " "
		}
	}
}

define template addTag(i : Issue) {
	var t : String := ""
	block [class := "TagAddition"] {
		form {
			label("Tag") {
				input(t) [onkeyup := updateTagSuggestions(t), autocomplete:="off"]
			}
			action("+", addTag(t, i))[ajax]
			tagHelp()
			placeholder tagValidityFeedback {""}
		}
		placeholder tagSuggestionsBox {
			tagSuggestions(t, i)
		}
	}
	action addTag(t : String, i : Issue) {
		var f := Tag{ name := t };
		var feedback := f.validateName();
		if(feedback.exceptions.length > 0) {
			log("Validation failed!!");
			replace(tagValidityFeedback, validationFeedback(feedback));
		} else {
			log("Validation succeeded!!");
			i.addTag(tag(t, i.project));
			i.save();
			return issue(i.project, i.number);
		}
	}
	action updateTagSuggestions(t : String) {
		replace(tagSuggestionsBox, tagSuggestions(t, i));
	}
}

function tagSuggestionFilter(tagPrefix : String) : String{
	if(tagPrefix != "") {
		return "";
	}
	return "@%";
}

// NOTE: Do not make this publicly available, the AJAX causes a lot of bad links
define ajax tagSuggestions(tagPrefix : String, issue : Issue) {
	var tagSearchString := tagPrefix.toLowerCase() + "%"
	var suggestions : List<Tag> := (
		select	t
		from	Issue as i left join i.tags as t	// Joint to only select used tags (subqueries not supported)
		where	i._project = ~issue.project and
				t._project = ~issue.project and		// Not really needed, but improves performance
				t._name like ~tagSearchString and
				t._name not like ~tagSuggestionFilter(tagPrefix)
		group by t._name
		order by count(i) desc
		limit 5
		) as List<Tag>;
		
/*	var suggestions : List<Tag> := (
		select	t
		from	Tag as t
		where	i._project = ~issue.project and
				t._project = ~issue.project and
				t._name like ~tagSearchString and
				t._name not like ~tagSuggestionFilter(tagPrefix)
		order by (select count(i) from Issue as i where t in i._tags) desc
		limit 5
		) as List<Tag>;
*/	
	for(suggestion : Tag in suggestions) {
		form { block [class := "Suggestion"] {
			actionLink(suggestion.name, addSuggestedTag(suggestion))[ajax]
		}}
	}
	
	action addSuggestedTag(suggestion : Tag) {
		issue.addTag(suggestion);
		issue.save();
		refresh();
	}
} 