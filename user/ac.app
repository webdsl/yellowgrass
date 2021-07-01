module user/ac

imports user/access
imports user/home
imports user/password
imports user/register
imports user/user
imports user/user-model

section principal

  principal is User with credentials email, password

  function principal(): User {
    return securityContext.principal;
  }

access control rules 

  rule page signin() {  
    true
  }
	
	rule page registerUser() {	
		true
	}
	
	rule page home() {
		securityContext.principal != null
	}
	
	rule page user(tag : String) {
		true
		// Not checking whether user exists anymore, due to performance issues in generating navigates
	  
	  rule action proxy(u : User){
	    isAdministrator()
	  }
		
		
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
