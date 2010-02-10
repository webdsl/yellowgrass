module user/access

define template login(){
	var email : Email;
	var pass : Secret;
	form{ 
		label("Email ") {input(email)}
		" "
		label("Pass ") {input(pass)}
		" "
		block [class := "LoginButton"] {
			action("Log In", login())
		}
	
		action login(){
			var users : List<User> :=
				select u from User as u 
				where (u._email = ~email);
			for (us : User in users ){
				if (us.password.check(pass)){
					securityContext.principal := us;
					securityContext.loggedIn := true;
					return home(securityContext.principal);
				}
			}
			securityContext.loggedIn := false;
			return root();
		}	
	}
	" | "
	navigate(resetUserPassword()) {"Reset Pass"}
	" | "
	navigate(registerUser()) {"Register"}
}

define template logout(){
	"Logged in as " 
	navigate(home(securityContext.principal)) 
		{output(securityContext.principal.name)}
	" "
	form{
		actionLink("Log Out", logout())
		action logout(){
			securityContext.loggedIn := false;
			securityContext.principal := null;
			return root();
		}
	}
}
