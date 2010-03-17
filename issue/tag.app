module issue/tag

entity Tag {
	name 		:: String	(validate(name.length() > 1, "Tags need to have at least 2 characters"),
							 validate(/[a-z0-9\._@!]*/.match(name),"Tags may consist of: a-z 0-9 . _ @ !"))
	project 	-> Project
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

function tagCleanup(tag : Tag) {
	flush();
	var tagged : List<Issue> :=
		select i
		from Issue as i
		left join i._tags as t
		where t = ~tag
		limit 1;
		
	// Is the tag used?
	if(	tagged.length == 0) {
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
				
			//log("members.length: "+members.length);
				
			if(members.length == 0 ) {
				tag.delete();
			}
		} else { 
			tag.delete();
		}
	}
}

define page tag(p : Project, tag : String) {
	var taggedIssues : List<Issue> :=
		select i 
		from Issue as i
		left join i._tags as t
		where t._name = ~tag and t._project = ~p
		limit 500
	
	title{"YellowGrass.org - " output(p.name) " - " output(tag)}
	main()
	define body(){
		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					" È "
					navigate(home(securityContext.principal)) {"Home"}
					" È "
					navigate(project(p)) {"Project " output(p.name)}
					" È Tag " output(tag)
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {"Ç Back to Project"} }
			}
			par{ <h1> "Tagged " output(tag) </h1> }
			issues(taggedIssues.set(), false, true, true, 50, true)
		}
		projectSideBar(p)
	}
}
	
define template tags(i : Issue, editing : Bool) {
	block [class:="Tags"] {
		for(tag : Tag in i.tags order by tag.name) {
			navigate(tag(i.project, tag.name)){output(tag.name)} 
			if(editing) {
				block [class := "Delete"] {
					actionLink("x", deleteTag(i, tag))
				}
			}
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
		for(tag : Tag in ts order by tag.name) {
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
			actionLink(suggestion.name, addSuggestedTag(suggestion, i))[ajax]
		}}
	}
	
	action addSuggestedTag(suggestion : Tag, i : Issue) {
		i.tags.add(suggestion);
		i.save();
		refresh();
	}
} 