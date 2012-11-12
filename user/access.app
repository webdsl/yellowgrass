module user/access

define override template login(){
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
		securityContext.principal := null;
		if(authenticate(email,pass)) {
			message("Login successful");
		} else {
			message("Incorrect email address or incorrect password");
		}
		/*
		securityContext.principal := null;
		securityContext.loggedIn := false;
		var users : List<User> :=
			select u from User as u 
			where (u._email = ~email);
		if(users.length > 0 && users.get(0).password.check(pass)) {
			securityContext.principal := users.get(0);
			securityContext.loggedIn := true;
			return home();
		} else {
			message("Incorrect email address or incorrect password");
			return root();
		}
		*/
	}
}

define override template logout(){
	"Logged in as " 
	navigate(home()) 
		{output(securityContext.principal.name)}
	" "
	form{
		block [class := "LoginButton"] {
			action("Log Out", logout())
		}
	}
	action logout(){
		securityContext.principal := null;
		return root();
	}
}
