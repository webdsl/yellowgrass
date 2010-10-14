module tag/tag

imports tag/ac
imports tag/sidebar
imports user/user
imports issue/issue
imports project/roadmap

entity Tag {
	name 		:: String	(validate(name.length() > 1, "Tags need to have at least 2 characters"),
							 validate(/[a-z0-9\._@!]*/.match(name),"Tags may consist of: a-z 0-9 . _ @ !"))
	project 	-> Project
	tags		-> Set<Tag>
//	issues		-> Set<Issue> (inverse=Issue.tags)
	
	function hasTag(tagName : String) : Bool {
		// TODO Optimize to query?
		for( t : Tag in tags) {
			if(t.name == tagName) {
				return true;
			}
		}
		return false;
	}
	
	function getStylingClass() : String{
		  if(hasTag("release")) {
			return "ReleaseTag Tag";
		} if(hasTag(ISSUE_TYPE_TAG())) { 
			return "IssuetypeTag Tag";
		} if(hasTag("red")) {
			return "RedTag Tag";
		} if(hasTag("green")) {
			return "GreenTag Tag";
		} if(hasTag("grey")) {
			return "GreyTag Tag";
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
	flush();
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
}

function arrangeTags(tags : Set<Tag>, summary : Bool) : List<Tag> {
	var types :=    [t | t : Tag in tags where t.hasTag(ISSUE_TYPE_TAG()) order by t.name];
	var releases := [t | t : Tag in tags where t.hasTag("release") order by t.name];
	var others :=   
		[t | t : Tag in tags where 
			!t.hasTag("release") && 
			!t.hasTag(ISSUE_TYPE_TAG()) && 
			(!summary || !t.name.contains("!"))
			order by t.name];
	
	var sortedTags : List<Tag> := List<Tag>();
	sortedTags.addAll(types);
	sortedTags.addAll(releases);
	sortedTags.addAll(others);
	return sortedTags;
}

define page tag(p : Project, tag : String) {
	title{output(p.name) " / " output(tag) " - on YellowGrass.org"}
	main()
	define body(){
		var tagMatches : List<Tag> := 
			from Tag
			where _name=~tag and _project=~p
			limit 1
		var t := tagMatches.get(0);
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
			}
			issues(taggedIssues.set(), false, true, true, 50, true)
		}
		tagSideBar(t)
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
	}
	action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
		tagToRemoveFrom.tags.remove(tagToRemove);
		tagCleanup(tagToRemove);
		return tag(t.project, t.name);
	}
}

define template tags(i : Issue, editing : Bool) {
	tags(i, editing, false)
}
define template tags(i : Issue, editing : Bool, summary : Bool) {
	block [class:="Tags"] {
		for(tag : Tag in arrangeTags(i.tags, summary)) {
			block [class:=tag.getStylingClass()] {
				navigate(tag(i.project, tag.name)){output(tag.name)} 
				if(editing) {
					block [class := "Delete"] {
						actionLink("x", deleteTag(i, tag))
					}
				}
			}
			output(" ")
		}
	}
	action deleteTag(i : Issue, t : Tag) {
		i.tags.remove(t);
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
			action("+", addTag(t, i))
		}
		placeholder tagSuggestionsBox {
			tagSuggestions(t, i)
		}
	}
	action addTag(t : String, i : Issue) {
		i.tags.add(tag(t, i.project));
		i.save();
		return issue(i.project, i.number);
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
define ajax tagSuggestions(tagPrefix : String, i : Issue) {
/*	var tagFilterString := "@%";
	init { if(tagPrefix != "") {
		tagFilterString := "";
	}}
*/	var tagSearchString := tagPrefix.toLowerCase() + "%"
	var suggestions : List<Tag> :=
		from	Tag as t
		where	t._project = ~i.project and 
				t._name like ~tagSearchString and
				t._name not like ~tagSuggestionFilter(tagPrefix)
		order by t._name	// TODO Improve ordering based on usage
		limit 5;
	
	for(suggestion : Tag in suggestions) {
		form { block [class := "Suggestion"] {
			actionLink(suggestion.name, addSuggestedTag(suggestion))[ajax]
		}}
	}
	
	action addSuggestedTag(suggestion : Tag) {
		i.tags.add(suggestion);
		i.save();
		refresh();
	}
} 