module user/user

imports user/ac
imports user/home
imports user/register
imports user/access

entity User {
	name			:: String		(validate(name.length() >= 3,	"Names need to be at least 3 characters"))
	email			:: Email		(validate(userEmailTaken(), "Another user already registered using this email address"), validate(email != "", "Enter a valid email address"))
	notifications   :: Bool
	password		:: Secret		(validate(password.length() >= 8, "Password needs to be at least 8 characters"))
	projects		-> Set<Project> (inverse = Project.members)
	url				:: URL
	tag				:: String		(validate(
										tag.length() >= 3 && 
										/[a-z0-9]*/.match(tag),	
										"User names consist of lowercase characters and numbers. Their minimum length is 3 characters."),
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
/*
var yellowGrass := 
	User {
		name := "YellowGrass"
		email := "info@yellowgrass.org"
		password := (randomUUID().toString() as Secret).digest()
		url := "http://yellowgrass.org"
		tag := "yellowgrass"
	};
*/
define page user(usertag : String) {
	var u : User := findUserByTag(usertag).get(0)
	var reportedIssues : List<Issue> := 
		from Issue
		where _reporter = ~u and _project._private=false//not( project.private)
		order by _submitted desc
		limit 15;
	var projects : List<Project> :=
		select p 
		from Project as p
		left join p.members as m 
		where _private=false and m = ~u
		limit 30;
	
	title{output(u.name) " on YellowGrass.org" }
	main()
	define body(){
		if(securityContext.loggedIn) {
			par [class := "Back"] { 
				rawoutput { " &raquo; " } 
				navigate(home()) {"Home"}
			}
		}
		par { <h1> output(u.name) </h1> }
		if(u.url != null && u.url != "") {
			par { label("Home Page") { output(u.url) } }
		}
		if(projects.length > 0) {
			par { label("Projects") { projects(projects) } }
		}
		par { <h2> "Recently Reported Issues" </h2> }
		par { issues(reportedIssues.set(), true, true, true, 50, true, true) }
	}
}

define template users(us : Set<User>) {
	for(u : User in us) {
		navigate(user(u.tag)) {output(u.name)}
		" "
	}
}

define page editUser(u : User) {
	title{output(u.name) " on YellowGrass.org [Editing]"}
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
				label("Receive notifications on issue changes via email?") { input(u.notifications) }
			}
			par {
				label("Home Page") { input(u.url)}
			}
			par {
				navigate(home()) {"Cancel"}
				" "	
				submit("Save",save())
			}
		}
	}
	action save(){
		u.save();
		//message("Profile saved");
		return home();
	}
}
