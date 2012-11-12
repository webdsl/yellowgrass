module ac

	access control rules
	
	rule page root() {	
		true
	}
	
	rule page about() {
		true
	}
	
	// rule template mainheader(p : Project) {
	// 	mayAccess(p)
	// }
	// 
	rule page search(p: Project, q : String) {
		mayAccess(p)
	}
	rule page searchAllProjects(q : String){
		true
	}

	 rule page features() {
	 	true
	 }
	 
	 rule ajaxtemplate validationFeedback(vem : ValidationExceptionMultiple){
	 	true
	 }
	 
	 rule ajaxtemplate empty() { 
	 	true
	 }
	 
	rule page getProjects(){
	 	true
	}
	
	rule page getMyProjects() {
	 	securityContext.loggedIn
	}
	 
	rule page getPopularProjects() {
	 	true
	}
	 
	rule page getProject() {
	 	true
	}
	 
	rule page createIssueService() {
	 	true
	}
	 
	rule page getIssues() {
	 	true
	}
	 
	rule page getRoadmap() {
	 	true
	}
	 
	rule page getIssuesDetails() { 
	 	true
	}
	 
	rule page authenticate() {
		true
	}
	
	rule page checkAuthenticate() {
		true
	}
	rule page logoutDevice() {
		true
	} 
	 rule logsql {
	 	loggedIn && principal.email=="sandervermolen@gmail.com"
	 }
