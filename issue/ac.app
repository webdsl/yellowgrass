module issue/ac

imports issue/issue
imports project/project
imports user/user

access control rules
	
	rule template issues(is : Set<Issue>, showProjectName : Bool) {	
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool) {
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool) {
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int) {
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
		true
	}
	
	rule template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
		true
	}
	
	rule page issue(p : Project, number : Int) { 
		true
	}
		
	rule page editIssue(i : Issue) {
		principal in i.project.members || 
		(loggedIn && principal == i.reporter)
	}
	
	rule page createIssue(p : Project) {
		true
	}
	
	rule action updateIssueSuggestions(t : String) {
		loggedIn
	}
		
	rule action newComment(text : WikiText, issue : Issue) {
		loggedIn
	}
	
	rule action commentClose(text : WikiText, issue : Issue) {
		principal in issue.project.members &&
		issue.open
	}
		
	rule page postedIssues() {
		loggedIn
	}
	
	rule ajaxtemplate issueSuggestions(t : String, p : Project) {
		loggedIn
	}
	
	rule action showIssueMoveTargets(issue : Issue){
		principal in issue.project.members && 
		principal.projects.length > 1
	}
	
	rule ajaxtemplate issueMoveTargets (issue : Issue){
		principal in issue.project.members && 
		principal.projects.length > 1
	}

	rule template attachmentAddition(i : Issue) {
		principal in i.project.members || 
		principal == i.reporter
	}
	
	rule template attachmentAdditionInput(i : Issue) {
		principal in i.project.members || 
		principal == i.reporter
	}
	
	rule ajaxtemplate attachmentList(i : Issue) {
		true		
		rule action deleteAttachment(a : Attachment) {
			principal in i.project.members || 
			principal == i.reporter
		}
		rule action attachmentList_inline_action0(a : Attachment) {	// Bug in WebDSL: workaround
			true
		}
	}
	
	rule template issueCommands(i : Issue) {
		true
		
		rule action close(issue : Issue) {
			principal in issue.project.members &&
			issue.open
		}
		
		rule action reopen(issue : Issue) {
			principal in issue.project.members &&
			(!issue.open)
		}
		
		rule action vote(issue : Issue) {
			loggedIn && !issue.hasTag("!"+principal.tag) && !(principal == issue.reporter)
		}
	}
	
	rule template issueSideBar(i : Issue) {
		true
	}