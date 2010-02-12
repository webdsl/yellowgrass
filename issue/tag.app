module issue/tag

entity Tag {
	name 		:: String (id)
	project 	-> Project
}

function tag(t : String, p : Project) : Tag {
	var tags : List<Tag> := 
		from Tag
		where _name = ~t and _project = ~p;
	if(tags.length == 0) {
		var newTag := Tag { 
			name := t
			project := p
		};
		newTag.save();
		return newTag; 
	} else {
		return tags.get(0);
	}
}

define template addTag(i : Issue) {
	var t : String := ""
	block [class := "TagAddition"] {
		form {
			label("Tag") {
				input(t) [onkeyup := updateTagSuggestions(t)]
			}
			action("+", addTag(t, i))
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

define ajax tagSuggestions(tagPrefix : String, i : Issue) {
	var tagSearchString := tagPrefix + "%"
	placeholder tagSuggestionsBox { block [class := "Suggestions"] {
		if(tagPrefix == "") {} 
		else {
			var suggestions : List<Tag> :=
				from	Tag as t
				where	t._project = ~i.project and 
						t._name like ~tagSearchString
				order by t._name	// TODO Improve ordering based on usage
				limit 5;
			for(suggestion : Tag in suggestions) {
				par {
					actionLink(suggestion.name, addSuggestedTag(suggestion, i))
				}
			}
		}
	}}
	action addSuggestedTag(suggestion : Tag, i : Issue) {
		i.tags.add(suggestion);
		i.save();
	}
}