module tag/ac

imports tag/tag

access control rules

  rule ajaxtemplate tagBarTags(i: Issue) {
    mayAccess(i.project)
  }  
	 
	rule template addTag(i : Issue) {
		principal in i.project.members
	}
	
	rule ajaxtemplate tagSuggestions(tagPrefix : String, i : Issue) {
		mayAccess(i.project)
		rule action addSuggestedTag(suggestion : Tag) {
			principal in i.project.members
		}
	}
	
	rule page tag(p : Project, tag : String) {
		mayAccess(p) 
		// Not checking whether tag exists anymore, due to performance issues in generating navigates
	}
	
	rule page editTag(p : Project, t : Tag) {
		principal in t.project.members
	}
	
	rule template tags(i : Issue, editing : Bool) {
		mayAccess(i.project)
	}
	
	rule template tags(i : Issue, editing : Bool, summary : Bool) {
		mayAccess(i.project)
		rule action deleteTag(i : Issue, t : Tag) {
			principal in i.project.members || 
			(loggedIn && principal == i.reporter)
		}
	}
	
	rule template tags(t : Tag, editing : Bool) {
		mayAccess(t.project)
	}
	
  rule template showTag(owner : Tag, t : Tag, editing : Bool) {
    mayAccess(owner.project)
    rule action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
      principal in tagToRemoveFrom.project.members
    }
  }

  rule template showTag(i: Issue, tag: Tag, editing: Bool) {
    mayAccess(i.project)
    rule action deleteTag(i : Issue, t : Tag) {
      principal in i.project.members
    }
  }
  	
	rule template tags(ts : List<Tag>, p : Project) {
		mayAccess(p)
	}

  rule template tagCommandsToolbar(t : Tag) {
    mayAccess(t.project)
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
  	
	// rule template tagCommands(t : Tag) {
	// 	mayAccess(t.project)
	// 	rule action makeRelease(tag : Tag, p : Project) {
	// 		principal in p.members && !tag.hasTag("release")
	// 	}
	// 	rule action makeIssueType(tag : Tag, p : Project) {
	// 		principal in p.members && !tag.hasTag(ISSUE_TYPE_TAG()) 
	// 	}
	// 	rule action color(t : Tag, p : Project, color : String) {
	// 		principal in p.members && !t.isColored()
	// 	}
	// }
	
	rule template tagSideBar(t : Tag) {
		mayAccess(t.project)
	}
	
	rule page tagManual() {
		true
	}