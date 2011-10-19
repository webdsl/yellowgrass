module ac

	access control rules
	
	rule page root() {	
		true
	}
	
	rule page sources() {
		true
	}
	
	rule template mainheader(p : Project) {
		mayAccess(p)
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
	 
	 rule page getProjects*(){
	 	true
	 }
	 
	 rule page getPopularProjects*(){
	 	true
	 }
	 
	rule page getProject*(){
	 	true
	 }
	 
	 rule logsql {
	 	loggedIn && principal.email=="sandervermolen@gmail.com"
	 }
