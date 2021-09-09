module issue/ac

imports issue/-
imports project/-
imports tag/tag-model
imports user/-

section predicates

  extend entity Issue {
    
    function mayView(): Bool {
      return mayAccess(project);
    }
    
    function mayEdit(): Bool {
      return principal() in project.members 
          || (loggedIn() && principal() == reporter);
    }
  }

access control rules

	rule page issue(p : Project, number : Int) { 
		mayAccess(p)
		// Not checking whether issue exists anymore, due to performance issues in generating navigates
	}
		
	// rule page editIssue(i : Issue) {
	// 	principal in i.project.members || 
	// 	(loggedIn && principal == i.reporter)
	// }
	
	rule page createIssue(p : Project) {
		mayAccess(p)
	}
	
	rule page createTaggedIssue(p : Project, initialTag : Tag) {
		principal in p.members
	}
	
	rule template createIssue(p : Project, initialTag : Tag) {
		initialTag == null || 
		principal in p.members
	}
		
	rule page postedIssues() {
		loggedIn
	}
	
	rule ajaxtemplate issueSuggestions(t : String, p : Project) {
		mayAccess(p)
	}
	
	rule ajaxtemplate issuePreview(d : WikiText) {
		true
	}
	
	rule action showIssueMoveTargets(issue : Issue){
		principal in issue.project.members && 
		principal.projects.length > 1
	}

  rule template issueMoveTargetsMenu (issue : Issue){
    loggedIn() && 
    principal in issue.project.members && 
    principal.projects.length > 1
  }
  	
	rule ajaxtemplate issueMoveTargets (issue : Issue){
		principal in issue.project.members && 
		principal.projects.length > 1
	}

	// rule template attachmentAddition(i : Issue) {
	// 	principal in i.project.members || 
	// 	principal == i.reporter
	// }
  rule template attachmentAdditionTool(i : Issue) {
    principal in i.project.members || 
    principal == i.reporter
  }
  	
	rule template attachmentAdditionInput(i : Issue) {
		principal in i.project.members || 
		principal == i.reporter 
	} 
	
	rule ajaxtemplate attachmentList(i : Issue) {
		mayAccess(i.project)		
		rule action deleteAttachment(a : Attachment) {
			principal in i.project.members || 
			principal == i.reporter
		}
	}
	
	rule page attachment(i: Issue) {
	  principal in i.project.members || 
    principal == i.reporter 
	}

  rule template issueCommandsMenu(i : Issue) {
    mayAccess(i.project)
    
    rule action close(issue : Issue) {
      principal in issue.project.members &&
      issue.open
    }
    
    rule action reopen(issue : Issue) {
      principal in issue.project.members &&
      (!issue.open)
    }
    
    rule action vote(issue : Issue) {
      loggedIn &&
      mayAccess(issue.project) && 
      !issue.hasTag("!"+principal.tag) && 
      !(principal == issue.reporter)
    }
  }
  	
	// rule template issueCommands(i : Issue) {
	// 	mayAccess(i.project)
	// 	
	// 	rule action close(issue : Issue) {
	// 		principal in issue.project.members &&
	// 		issue.open
	// 	}
	// 	
	// 	rule action reopen(issue : Issue) {
	// 		principal in issue.project.members &&
	// 		(!issue.open)
	// 	}
	// 	
	// 	rule action vote(issue : Issue) {
	// 		loggedIn &&
	// 		mayAccess(issue.project) && 
	// 		!issue.hasTag("!"+principal.tag) && 
	// 		!(principal == issue.reporter)
	// 	}
	// }
	
	rule template issueSideBar(i : Issue) {
		mayAccess(i.project)
	}

	rule page issueConfirmation() {
		true
	}
	rule page confirmGhost(g :IssueGhost) {
		true
	}

   rule ajaxtemplate dueDateView(i: Issue) {
     mayAccess(i.project)
     rule action edit() { 
       i.mayEdit()
     }
   }
   
   rule template dueDateEdit(i: Issue) {
      i.mayEdit()
   } 
   