module user/password

imports emails

page editUserPassword(u : User){
	var temp : Secret;
	
	title{"YellowGrass.org - Change Password"}
	bmain{
		//var current : Secret;
		pageHeader{ "Change Password" }
		horizontalForm {
			/*par { 
				label("Current Password"){
					input(current){ validate(u.password.check(current), "Incorrect password") }
				}
			} */ // TODO This does not seem to work. Fix it and add it for security reasons
		  controlGroup("New Password"){
		    input(u.password)
		  }
			controlGroup("Repeat New Password"){
			  input(temp){ validate(u.password == temp, "Passwords do not match") } 
			}
			formActions{
			  navigate home() [class="btn"] { "Cancel" } " "
			  submitlink changePassword() [class="btn btn-primary"] { "Change" }
			}
		}
	}
	action changePassword(){
		var pass : String := u.password.toString();
		u.password := u.password.digest();
		u.save();
		return home();
	}
}

  page resetUserPassword(){
	  title{"YellowGrass.org - Request Password Reset"}
    var email : Email;
	  bmain{		
		  pageHeader{ "Request Password Reset" }
		  horizontalForm {
			  controlGroup("Email"){ 
				  input(email){ validate(findUserByEmail(email).length > 0, "Unknown email address") } 
			  }
			  formActions{ 
			    submitlink resetPassword() [class="btn btn-primary"] { "Reset Password" }
			  }
			}
		}
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
			message("Your password has been reset, a new password has been emailed to you.");
			return signin();
		}
	}

  email template notifyNewPassword(u:User, p: String){
	  to(u.email)
	  from(EMAIL_FROM())
	  subject("Password reset")   
	  par{ "Dear " output(u.name) ", " }
	  par {}
	  par{
		  "Your password has been changed to: " output(p)
	  }
	  par {}
	  par { " -- http://yellowgrass.org -- " }
  }
