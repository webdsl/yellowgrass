module project/ac
  
access control rules
	
	rule page project(p : Project) {	
		true
	}
		
	rule page edit(p : Project) {
		principal in p.members
	}
	
	rule page registerProject() {
		loggedIn
	}