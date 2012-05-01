module user/user

imports user/ac
imports user/home
imports user/register
imports user/access

entity User {
	name			:: String		(validate(name.length() >= 3,	"Names need to be at least 3 characters"))
	email			:: Email		(validate(!userEmailTaken(), "Another user already registered using this email address"), validate(email != "", "Enter a valid email address"))
	notifications   :: Bool
	password		:: Secret		(validate(password.length() >= 8, "Password needs to be at least 8 characters"))
	projects		-> Set<Project> (inverse = Project.members)
	url				:: URL
	tag				:: String		(validate(
										tag.length() >= 3 && 
										/[a-z0-9]*/.match(tag),	
										"User names consist of lowercase characters and numbers. Their minimum length is 3 characters."),
									 validate(!userTagTaken(), "Another user already registered this user name"))
	
	function userEmailTaken() : Bool {
		var users := findUserByEmail(email);
		return users.length > 1 || (users.length == 1 && users[0] != this);	// Database view may be inconsistent, as queries in transaction are take into account
	}
	
	function userTagTaken() : Bool {
		var users := findUserByTag(tag);
		return users.length > 1;	// Database view may be inconsistent, as queries in transaction are take into account
	}
	function toJSON():JSONObject{
		var jsonobject := JSONObject();
		jsonobject.put("id",id);
		jsonobject.put("name", name);
		jsonobject.put("tag", tag);
		jsonobject.put("url",url);
		jsonobject.put("version",version);
		var jsonarray:= JSONArray();
		for (project:Project in projects){
			if(project.toSimpleJSON()!=null){
				jsonarray.put(project.toJSONRef());
			}
		} 
		jsonobject.put("projects",jsonarray);
		
		return jsonobject;
	}
	function toSimpleJSON():JSONObject{
		var jsonobject := JSONObject();
		jsonobject.put("id",id);	
		return jsonobject;
	}
}

function getUser(u : String) : User {
	var users : List<User> := 
		from User
		where _tag = ~u;
	if(users.length == 0) {
		return User {}; 
	} else {
		return users.get(0);
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
	var u : User := getUser(usertag)
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

define page manageDevices(u : User) {
	title{output(u.name) " on YellowGrass.org [Editing]"}
	main()
	define body(){
		<h1> "Manage Devices" </h1>
		form {
			par {
				block [class := "Listing"] {
					table {
						row {
							column{ <b> "Device Description" </b> }
							column{ <b> "Key" </b> }
							column{ empty() }
						}
						for(device : AuthenticationKey in u.deviceKeySet ) {
							row { 
								column{ output(device.deviceDescription) } 
								column{ output(device.id) }
								column{ submit action{u.deviceKeySet.remove(device);} { "x" } }
							}
						}
							
					}
				}
			}
			par {
				navigate(home()) {"Back"}
			}
		}
	}
	action save(){
		u.save();
		//message("Profile saved");
		return home();
	}
}
