module issues/ac
  
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
	
	rule action close(issue : Issue) {
		principal in issue.project.members &&
		issue.open
	}
	
	rule action reopen(issue : Issue) {
		principal in issue.project.members &&
		(!issue.open)
	}
	
	rule action newComment(text : WikiText, issue : Issue) {
		loggedIn
	}
	
	rule action commentClose(text : WikiText, issue : Issue) {
		principal in issue.project.members &&
		issue.open
	}