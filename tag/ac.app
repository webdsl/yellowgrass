module tag/ac

imports tag/tag

access control rules
	
	rule template addTag(i : Issue) {
		principal in i.project.members
	}
	
	rule ajaxtemplate tagSuggestions(tagPrefix : String, i : Issue) {
		true
		rule action addSuggestedTag(suggestion : Tag) {
			principal in i.project.members
		}
	}
	
	rule page tag(p : Project, tag : String) {
		( 
			from Tag
			where _name=~tag and _project=~p
			limit 1
		).length > 0
	}
	
	rule template tags(i : Issue, editing : Bool) {
		true
	}
	
	rule template tags(i : Issue, editing : Bool, summary : Bool) {
		true
		rule action deleteTag(i : Issue, t : Tag) {
			principal in i.project.members || 
			(loggedIn && principal == i.reporter)
		}
	}
	
	rule template tags(t : Tag, editing : Bool) {
		true
		rule action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
			principal in tagToRemoveFrom.project.members
		}
	}
	
	rule template tags(ts : List<Tag>, p : Project) {
		true
	}
	
	rule template tagCommands(t : Tag) {
		true
		rule action makeRelease(tag : Tag, p : Project) {
			principal in p.members && !tag.hasTag("release")
		}
		rule action makeIssueType(tag : Tag, p : Project) {
			principal in p.members && !tag.hasTag(ISSUE_TYPE_TAG()) 
		}
		rule action color(t : Tag, p : Project, color : String) {
			principal in p.members && !t.isColored()
		}
	}
	
	rule template tagSideBar(t : Tag) {
		true
	}