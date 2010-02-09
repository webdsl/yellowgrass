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
		
	rule page editIssue(i : Issue, new : Bool) {
		// TODO This is of course not a safe check, creation should be done in edit page, 
		// if (or when) it is possible to pass unsaved objects
		principal in i.project.members || new
	}
	
	rule page createIssue(p : Project) {
		true //principal in i.project.memebers
	}
	
	rule action close(issue : Issue) {
		principal in issue.project.members
	}
	
	rule action reopen(issue : Issue) {
		principal in issue.project.members
	}
	
	rule action newComment(text : WikiText, issue : Issue) {
		loggedIn
	}