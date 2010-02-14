module user/password

define page editUserPassword(u : User){
	var temp : Secret;
	
	title{"YellowGrass.org - Change Password"}
	main()
	define body(){
		//var current : Secret;
		<h1> "Change Password" </h1>
		form {
			/*par { 
				label("Current Password"){
					input(current){ validate(u.password.check(current), "Incorrect password") }
				}
			} */ // TODO This does not seem to work. Fix it and add it for security reasons
			par { 
				label("New Password"){input(u.password)}
			}
			par { 
				label("Repeat New Password"){
					input(temp){ validate(u.password == temp, "Passwords do not match") } 
				}
			}
			navigate(home(u)){"Cancel"} " "
			action("change",changePassword())
			action changePassword(){
				var pass : String := u.password.toString();
				u.password := u.password.digest();
				u.save();
				return home(u);
			}
		}
	}
}

define page resetUserPassword(){
	var email : Email;
	
	title{"YellowGrass.org - Request Password Reset"}
	main()
	define body(){
		<h1> "Request Password Reset" </h1>
		form {
			par { label("Email"){ 
				input(email){ validate(findUserByEmail(email).length > 0, "Unknown email address") } 
			} }
			action("Reset Password", resetPassword())
			action resetPassword(){
				// Lookup user
				var users : List<User> := findUserByEmail(email);
				var user : User := users.get(0);
				// Generate new pass
				var newPassword : String := randomUUID().toString();
				var secret : Secret := newPassword;
				secret := secret.digest();
				email(notifyNewPassword(user, newPassword));
				user.password := secret;
				user.save();
				return resetUserPasswordComplete();
			}
		}
	}
}

define page resetUserPasswordComplete(){
	title{"YellowGrass.org - Password Reset Complete"}
	main()
	define body(){
		<h2> "Password reset complete" </h2>
		par { "Your password has been reset, a new password has been emailed to you." }
	}
}

define email notifyNewPassword(u:User, p: String){
	to(u.email)
	from("info@yellowgrass.org")
	subject("Password reset")
    
	par{ "Dear " output(u.name) ", " }
	par {}
	par{
		"Your password has been changed to: " output(p)
	}
	par {}
	par { " -- http://yellowgrass.org -- " }
}
