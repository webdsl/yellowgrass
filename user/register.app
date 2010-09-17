module user/register

define page registerUser(){
	var u := User{};
	var temp : Secret := "";
		
	title{"YellowGrass.org - User Registration"} 
	main()
	define body(){
		<h1> "User Registration" </h1>
		
		form { 
			par{ label("Name") { input(u.name) } }
			par{ label("User Name") { input(u.tag) } }
			par{ "User names are used for tags (e.g. @johnsmith). Preferably choose a user name, which is easy to remember"} 
			
			par{ label("Email") { input(u.email) } }
			par{ label("Password") { input(u.password) } }
			par{ label("Repeat Password") { 
				input(temp){ validate(u.password == temp, "Passwords do not match") } } }
			par{ block [class:="Error"]{ captcha() }}
					
			par {
				navigate(root()) {"Cancel"}
				" "
				action("Register",register())
			}
		}
	}
	action register(){
		u.password := u.password.digest();
		u.save();
		securityContext.principal := u;
		securityContext.loggedIn := true;
		email(registerUserEmail(u));
		// message("Registration completed");
		return home(u);
	}
}

define email registerUserEmail(u : User) {
	to(u.email)
	from("YellowGrass <noreply@yellowgrass.org>")
	subject("Welcome to YellowGrass")
	par { "Dear " output(u.name) "," }
	par {}
	par { 	"Your account at YellowGrass has been registered successfully. "
			"You can now login at http://yellowgrass.org. " //output(navigate(root()))
			"Add your project to YellowGrass and start managing issues right away."}
	par {}
	par { "-- The YellowGrass Team" }
}
