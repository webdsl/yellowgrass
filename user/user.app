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
	
	// TODO inefficient! : remove getOpenIssues function when HQL functionality is fixed
	function getOpenIssues() : List<Issue> {
		return getOpenIssues(projects.list(), 0);
	}
	function getOpenIssues(ps : List<Project>, index : Int) : List<Issue> {
		if(index >= ps.length) {
			var empty : List<Issue> := [Issue{}];
			empty.clear();
			return empty;
		} else {
			var openIssues : List<Issue> := [i | i : Issue in ps.get(index).issues where i.open].list();
			var otherIssues : List<Issue> := getOpenIssues(ps, index + 1);
			otherIssues.addAll(openIssues);
			return otherIssues;
		}
	}
}

define page user(u : User) {
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
	table {
		for(u : User in us) {
			row { navigate(user(u)) {output(u.name)}}
		}
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
