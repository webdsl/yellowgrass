module user/access

define template login(){
	var email : Email;
	var pass : Secret;
	
	<h1> "Login" </h1>
	form{ 
		table{
			row{ "Email: "		input(email) }
			row{ "Password: "	input(pass) }
			row{ action("Log In", login()) "" }
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
}

define template logout(){
	"Logged in as " output(securityContext.principal.name)
	form{
		actionLink("Log Out", logout())
		action logout(){
			securityContext.loggedIn := false;
			securityContext.principal := null;
			return root();
		}
	}
}
