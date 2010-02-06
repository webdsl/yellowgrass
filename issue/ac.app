module issues/ac
  
access control rules
	
	rule template issues(is : Set<Issue>, showProjectName : Bool) {	
		true
	}
	
	rule page issue(i : Issue) { 
		true
	}
	
	rule page editIssue(i : Issue) {
		true //principal in i.project.memebers
	}
	
	rule page createIssue(p : Project) {
		true //principal in i.project.memebers
	}