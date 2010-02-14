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
	
	rule template users(us : Set<User>) {	
		true
	}
	
	rule page user(tag : String) {
		findUserByTag(tag).length == 1
	}
	
	rule page editUser(u : User) {
		principal == u
	}
	
	rule page editUserPassword(u : User){
		principal == u
	}
	
	rule page resetUserPassword() {
		true
	}
	
	rule page resetUserPasswordComplete() {
		true
	}