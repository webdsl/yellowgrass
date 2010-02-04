module user/register

define page registerUser(){ 
	main()
	define body(){
		var u := User{};
		var temp : Secret := "";
		<h1> "User Registration" </h1>
		form{table{
			row{"Name"				input(u.name)}
			row{"Email"				input(u.email)}
			row{"Password"			input(u.password)}
			row{"Repeat Password"	input(temp){ validate(u.password == temp, "Passwords do not match") }}
			row{ captcha() }
				
			break
			action("Register",register())
			action register(){
				u.password := u.password.digest();
				u.save();
				securityContext.principal := u;
				securityContext.loggedIn := true;
				message("Registration completed");
				return home(u);
			}
		}}
	}
}