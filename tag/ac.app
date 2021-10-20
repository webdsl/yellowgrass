module tag/ac

imports issue/-
imports project/-
imports tag/-
imports user/ac

access control rules

  rule ajaxtemplate tagBarTags(i: Issue) {
    mayAccess(i.project)
  }  
	 
	rule template addTag(i : Issue) {
		loggedIn && principal() in i.project.members
	}
	
	rule ajaxtemplate tagSuggestions(tagPrefix : String, i : Issue) {
		mayAccess(i.project)
		rule action addSuggestedTag(suggestion : Tag) {
			loggedIn && principal() in i.project.members
		}
	}
	
	rule page tag(p : Project, tag : String) {
		mayAccess(p) 
		// Not checking whether tag exists anymore, due to performance issues in generating navigates
	}
	
	rule page editTag(p : Project, t : Tag) {
		loggedIn && principal() in t.project.members
	}
	
	rule template tags(i : Issue, editing : Bool) {
		mayAccess(i.project)
	}
	
	rule template tags(issue : Issue, editing : Bool, summary : Bool) {
		mayAccess(issue.project)
		rule action deleteTag(i : Issue, t : Tag) {
			loggedIn && (principal in i.project.members
			             || principal == i.reporter)
		}
	}
	
	rule template tags(t : Tag, editing : Bool) {
		mayAccess(t.project)
	}
	
  rule template showTag(owner : Tag, t : Tag, editing : Bool) {
    mayAccess(owner.project)
    rule action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
      loggedIn && principal() in tagToRemoveFrom.project.members
    }
  }

  rule template showTag(issue: Issue, tag: Tag, editing: Bool) {
    mayAccess(issue.project)
    rule action deleteTag(i : Issue, t : Tag) {
      loggedIn && principal() in i.project.members
    }
  }
  
  rule template showTagView(issue: Issue, tag: Tag, editing: Bool) {
    mayAccess(issue.project)
    rule action deleteTag(i : Issue, t : Tag) {
      loggedIn && principal() in i.project.members
    }
  }
  	
	rule template tags(ts : List<Tag>, p : Project) {
		mayAccess(p)
	}

  rule template tagCommandsToolbar(t : Tag) {
    mayAccess(t.project)
    rule action makeRelease(tag : Tag, p : Project) {
      loggedIn && principal() in p.members && !tag.hasTag("release")
    }
    rule action makeIssueType(tag : Tag, p : Project) {
      loggedIn && principal() in p.members && !tag.hasTag(ISSUE_TYPE_TAG()) 
    }
    rule action color(tag : Tag, p : Project, color : String) {
      loggedIn && principal() in p.members && !tag.isColored()
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