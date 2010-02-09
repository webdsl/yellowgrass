module user/access

define template login(){
	var email : Email;
	var pass : Secret;
	form{ 
		" Email "
		input(email)
		" Pass "
		input(pass)
		" "
		actionLink("Log In", login())
	
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
