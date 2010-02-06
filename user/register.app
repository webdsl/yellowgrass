module user/register

define page registerUser(){ 
	main()
	define body(){
		var u := User{};
		var temp : Secret := "";
		<h1> "User Registration" </h1>
		
		form { 
			par{ label("Name") { input(u.name) } }
			par{ label("Email") { input(u.email) } }
			par{ label("Password") { input(u.password) } }
			par{ label("Repeat Password") { 
				input(temp){ validate(u.password == temp, "Passwords do not match") } } }
			par{ captcha() }
					
			par {
				navigate(root()) {"Cancel"}
				" "
				action("Register",register())
				action register(){
					u.password := u.password.digest();
					u.save();
					securityContext.principal := u;
					securityContext.loggedIn := true;
					message("Registration completed");
					return home(u);
				}
			}
		}
	}
}