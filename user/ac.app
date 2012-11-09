module user/ac

principal is User with credentials email, password

access control rules
	
	rule page registerUser() {	
		true
	}
	
	rule page home() {
		securityContext.principal != null
	}
	
	rule page user(tag : String) {
		true
		// Not checking whether user exists anymore, due to performance issues in generating navigates
	}
	
	rule page editUser(u : User) {
		principal == u
	}
	
	rule page editUserPassword(u : User) {
		principal == u
	}
	
	rule page manageDevices(u : User) {
		principal == u 
	}
	
	rule page resetUserPassword() {
		true
	}
	
	rule page resetUserPasswordComplete() {
		true
	}