module user/password

imports built-in
imports emails
imports templates
imports user/access
imports user/home
imports user/user-model

imports elib/elib-bootstrap/lib

section change password

  page editUserPassword(u : User){
    var pw   : Secret;
	  var temp : Secret;
    //var current : Secret;
	
	  title{"YellowGrass.org - Change Password"}
	  bmain{
      buttonToolbar{ homeToolbar(u) } 	    
		  pageHeader{ "Change Password" }
		  horizontalForm { 
			  // controlGroup("Current Password"){
			  // 		input(current){ validate(u.password.check(current), "Incorrect password") }
			  // 	}
			  // } // TODO This does not seem to work. Fix it and add it for security reasons
		    controlGroup("New Password"){
		      input(pw)
		    }
			  controlGroup("Repeat New Password"){
			    input(temp){ validate(pw == temp, "Passwords do not match") } 
			  }
			  formActions{
			    navigate home() [submit attributes] { "Cancel" } " "
			    submitlink changePassword() [ignore default class, class="btn btn-primary"] { "Change" }
			  }
		  }
	  }
	  action changePassword(){
		  u.password := pw.digest();
		  return home();
	  }
  }

section reset password

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
			    submitlink resetPassword() [ignore default class, class="btn btn-primary"] { "Reset Password" }
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
