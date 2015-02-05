module user/register

page registerUser(){
	var u := User{};
	var temp : Secret := "";
	 
	action register(){
    u.password := u.password.digest();
    u.notifications := true;
    u.save();
    securityContext.principal := u;
    email(registerUserEmail(u));
    message("You are successfully registered. Your username is '" + u.tag +"'.");
    return home();
  }
		
	title{"YellowGrass.org - User Registration"} 
	bmain{
		pageHeader{ "User Registration" }	
		horizontalForm { 
			controlGroup("Name") { input(u.name) }
			controlGroup("User Name") { 
			  input(u.tag) 
			  par{ "User names are used for tags (e.g. @johnsmith). Preferably choose a user name, which is easy to remember"} 
			}
			controlGroup("Email") { input(u.email) }
			controlGroup("Password") { input(u.password) }
			controlGroup("Repeat Password") { 
				input(temp){ validate(u.password == temp, "Passwords do not match") } 
		  }
			controlGroup("Are you human?"){
			  captcha() 
			}	
			formActions {
        submitlink register() [ignore default class, class="btn btn-primary"] { "Register" } " "
				navigate root() [submit attributes] {"Cancel"}
			}
		}
	}
}

email template registerUserEmail(u : User) {
	to(u.email)
	from(EMAIL_FROM())
	subject("Welcome to YellowGrass")
	par { "Dear " output(u.name) " (" output(u.tag) ")," }
	par { "" }
	par { 	"Your account at YellowGrass has been registered successfully. "
			"You can now login at http://yellowgrass.org." //output(navigate(root()))
			"Add your project to YellowGrass and start managing issues right away."}
	par { "" }
	par { "-- The YellowGrass Team" }
}
