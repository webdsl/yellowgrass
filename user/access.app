module user/access

define template login(){
	var email : Email;
	var pass : Secret;
	form{
		block {
			label("Email ") {input(email)}
			" "
			label("Pass ") {input(pass)}
			" "
			block [class := "LoginButton"] {
				action("Log In", login())
			}
		}
		navigate(registerUser()) {"Register"}
		" | "
		navigate(resetUserPassword()) {"Reset Pass"}
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
		message("Incorrect email address or incorrect password");
		return root();
	}
}

define template logout(){
	"Logged in as " 
	navigate(home(securityContext.principal)) 
		{output(securityContext.principal.name)}
	" "
	form{
		block [class := "LoginButton"] {
			action("Log Out", logout())
		}
	}
	action logout(){
		securityContext.loggedIn := false;
		securityContext.principal := null;
		return root();
	}
}
