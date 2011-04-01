module ac

	access control rules
	
	rule page root() {	
		true
	}
	
	rule template main() {
		true
	}
	
	rule template body() {
		true
	}
	
	rule template mainheader() {
		true
	}
	
	rule template sidebarSeparator() {
		true
	}
	
	rule page search(q : String) {
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
	 
	 rule logsql {
	 	loggedIn && principal.email=="sandervermolen@gmail.com"
	 }
