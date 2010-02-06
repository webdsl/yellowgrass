module user/user

imports user/ac
imports user/home
imports user/register
imports user/access

entity User {
	name			:: String
	email			:: Email		(validate(userEmailTaken(), "Another user already registered using this email address"))
	password		:: Secret		(validate(password.length() >= 8, "Password needs to be at least 8 characters"))
	projects		-> Set<Project> (inverse = Project.members)
	url				:: URL
	
	function userEmailTaken() : Bool {
		var users := findUserByEmail(email);
		return 
			users.length == 0 ||
			users.get(0) == this;
	}
}

define page user(u : User) {
	main()
	define body(){
		<h1> output(u.name) </h1>
		par{ label("Home Page") { output(u.url) } }
		par{ label("Projects") { projects(u.projects) } }
	}
}

define template users(us : Set<User>) {
	table {
		for(u : User in us) {
			row { navigate(user(u)) {output(u.name)}}
		}
	}
}

define page editUser(u : User) {
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
					message("Profile saved");
					return home(u);
				}
			}
		}
	}
}
