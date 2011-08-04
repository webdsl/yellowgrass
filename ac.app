module ac

	access control rules
	
	rule page root() {	
		true
	}
	
	rule page sources() {
		true
	}
	
	rule template main() {
		true
	}
	
	rule template body() {
		true
	}
	
	rule template mainheader(p : Project) {
		mayAccess(p)
	}
	
	rule template sidebarSeparator() {
		true
	}
	
	rule page search(p: Project, q : String) {
		mayAccess(p)
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
	 
	 rule logsql {
	 	loggedIn && principal.email=="sandervermolen@gmail.com"
	 }
