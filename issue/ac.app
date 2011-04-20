module issue/ac

imports issue/issue
imports project/project
imports user/user

access control rules
	
	// TODO Check whether user may access each of the issue projects in the templates below (or is this to computattion intensive?)
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
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool) {
		true
	}
	
	rule template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool) {
		true
	}
	
	rule page issue(p : Project, number : Int) { 
		mayAccess(p)
		// Not checking whether issue exists anymore, due to performance issues in generating navigates
	}
		
	rule page editIssue(i : Issue) {
		principal in i.project.members || 
		(loggedIn && principal == i.reporter)
	}
	
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
	
	rule action updateIssueSuggestions(t : String, p : Project) {
		loggedIn && mayAccess(p)
	}
		
	rule action newComment(text : WikiText, issue : Issue) {
		loggedIn && mayAccess(issue.project)
	}
	
	rule action commentClose(text : WikiText, issue : Issue) {
		principal in issue.project.members &&
		issue.open
	}
		
	rule page postedIssues() {
		loggedIn
	}
	
	rule ajaxtemplate issueSuggestions(t : String, p : Project) {
		loggedIn && mayAccess(p)
	}
	
	rule ajaxtemplate issuePreview(d : WikiText) {
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
		mayAccess(i.project)		
		rule action deleteAttachment(a : Attachment) {
			principal in i.project.members || 
			principal == i.reporter
		}
	}
	
	rule template issueCommands(i : Issue) {
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
	
	rule template issueSideBar(i : Issue) {
		mayAccess(i.project)
	}
/*	
	rule ajaxtemplate issueDetails(i : Issue){
		true
	}
*/