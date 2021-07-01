module user/access

imports built-in
imports yellowgrass
imports templates-bootstrap
imports user/ac
imports user/home
imports user/password
imports user/register

imports elib-bootstrap-3/icons
imports elib/elib-bootstrap/lib

  page signin() {
    mainResponsive{
      gridRow{ gridCol(12){ login } }
    }
  }

  template signInOut() {
    navItems{
	    if(loggedIn()) {
		    logout
	    } else {
		    navItem{
			    navigate signin() { "Sign In" } 
        }
        navItem{
    	    navigate registerUser() { "Sign Up" }
        }
	    }
	  }
  }

extend session securityContext {
	newIssueDesc :: WikiText
	newIssueTitle :: String
	newIssueType :: String
}

// define override template login(){
// 	var email : Email;
// 	var pass : Secret;
// 	form{
// 		block {
// 			label("Email ") {input(email)}
// 			" "
// 			label("Pass ") {input(pass)}
// 			" "
// 			block [class := "LoginButton"] {
// 				// Workaround for reconstrucing the input data of a new issue when logging in on the create issue page.
// 				// As part of the login form submit the create issue information is gathered, 
// 				// and the action stores this data temporarily in the securityContext session entity.
// 				// The new issue data is requested on the create issue page in issue/register.app.
// 				<input type="hidden" id="keep-issue-desc" name="issue-desc"/>
// 				<input type="hidden" id="keep-issue-title" name="issue-title"/>
// 				<input type="hidden" id="keep-issue-type" name="issue-type"/>
// 				action("Log In", login())
// 				  [onclick="javascript:$('#keep-issue-desc').attr('value',$('p#new-issue-desc textarea').val());"+
// 				                      "$('#keep-issue-title').attr('value',$('p#new-issue-title input').val());"+
// 				                      "$('#keep-issue-type').attr('value',$('p#new-issue-type select').val());"]
// 			}
// 		}
// 		navigate(registerUser()) {"Register"}
// 		" | "
// 		navigate(resetUserPassword()) {"Reset Pass"}
// 	}
// 	action login(){
// 		securityContext.newIssueDesc := getRequestParameter("issue-desc"); 
// 		securityContext.newIssueTitle := getRequestParameter("issue-title"); 
// 		securityContext.newIssueType := getRequestParameter("issue-type"); 
// 		securityContext.principal := null;
// 		if(authenticate(email,pass)) {
// 			message("Login successful");
// 		} else {
// 			message("Incorrect email address or incorrect password");
// 		}
// 		/*
// 		securityContext.principal := null;
// 		securityContext.loggedIn := false;
// 		var users : List<User> :=
// 			select u from User as u 
// 			where (u._email = ~email);
// 		if(users.length > 0 && users.get(0).password.check(pass)) {
// 			securityContext.principal := users.get(0);
// 			securityContext.loggedIn := true;
// 			return home();
// 		} else {
// 			message("Incorrect email address or incorrect password");
// 			return root();
// 		}
// 		*/
// 	}
// }

  function login(email: Email, pass: Secret, keepLoggedIn: Bool) {
    securityContext.principal := null;
    getSessionManager().stayLoggedIn := keepLoggedIn;
    validate(authenticate(email,pass), "Incorrect email address or incorrect password");
  }
  
  override template login() {
	  var email : Email;
	  var pass : Secret;
	  var keepLoggedIn : Bool;
    action login(){
      login(email, pass, keepLoggedIn);
      return home();
    }
    pageHeader2{ "Sign In" }
	  horizontalForm{
		  controlGroup("Email") { input(email) }
	    controlGroup("Password") { input(pass) }
	    controlGroup("Stay logged in") { input(keepLoggedIn) }
		  formActions {
			  submitlink login() [ignore default class, class="btn btn-primary"] { "Sign In" } " "
		    navigate resetUserPassword() [submit attributes] { "Reset Password" } 
		  }
	  }
  }

  override template logout() {
    action logout(){
      if(principal().isByProxy()){
        principal().unProxy();
      } else {
      securityContext.principal := null;
      }
      return root();
    }
    yourProjects
	  navItem{	      
	    navigate home() { 
	      iUser " " output(principal().tag)
	      if(principal().isByProxy()){
	        " " small[title="proxied"]{ iSunglasses } 
	      }
	    }
	  }
	  navItem{ submitlink logout()[ignore default class] { "Sign Out" } }
  }
