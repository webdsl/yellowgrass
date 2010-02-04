module user/ac

principal is User with credentials email, password
 
access control rules
	
	rule page registerUser() {	
		true
	}
	
	rule page home(u:User) {
		principal == u
	}
	
	rule template login() {
		true
	}
	
	rule template logout() {
		true
	}