module user/user

imports user/ac
imports user/home
imports user/register
imports user/access

entity User {
	name			:: String		(validate(name.length() >= 4,	"Names need to be at least 4 characters"))
	email			:: Email		(validate(userEmailTaken(), "Another user already registered using this email address"))
	password		:: Secret		(validate(password.length() >= 8, "Password needs to be at least 8 characters"))
	projects		-> Set<Project> (inverse = Project.members)
	url				:: URL
	tag				:: String		(validate(
										tag.length() >= 4 && 
										/[a-z0-9]*/.match(tag),	
										"User names consist of lowercase characters and numbers. Their minimum length is 4 characters."),
									 validate(userTagTaken(), "Another user already registered this user name"))
	
	function userEmailTaken() : Bool {
		var users := findUserByEmail(email);
		return 
			users.length == 0 ||
			users.get(0) == this;
	}
	
	function userTagTaken() : Bool {
		var users := findUserByTag(tag);
		return
			users.length == 0 ||
			users.get(0) == this;
	}
}

define page user(usertag : String) {
	var u : User := findUserByTag(usertag).get(0)
	
	main()
	define body(){
		if(securityContext.loggedIn) {
			par [class := "Back"] { 
				" È "
				navigate(home(securityContext.principal)) {"Home"}
			}
		}
		par{ <h1> output(u.name) </h1> }
		par{ label("Home Page") { output(u.url) } }
		par{ label("Projects") { projects(u.projects) } }
	}
}

define template users(us : Set<User>) {
	for(u : User in us) {
		navigate(user(u.tag)) {output(u.name)}
		" "
	}
}

define page editUser(u : User) {
	title{"YellowGrass.org - " output(u.name)}
	main()
	define body(){
		<h1> "Edit Profile" </h1>
		form {
			par {
				label("Name") { input(u.name) }
			}
			par {
				label("Email") { input(u.email)}
			}
			par {
				label("Home Page") { input(u.url)}
			}
			par {
				navigate(home(u)) {"Cancel"}
				" "	
				submit("Save",save())
				action save(){
					u.save();
					//message("Profile saved");
					return home(u);
				}
			}
		}
	}
}
