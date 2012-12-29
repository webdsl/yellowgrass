module user/user

imports user/user-model
imports user/ac
imports user/home
imports user/register
imports user/access

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
  page user(usertag : String) {
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
	  bmain{
		  // if(securityContext.loggedIn) {
			 //  par [class := "Back"] { 
				//   rawoutput { " &raquo; " } 
				//   navigate(home()) {"Home"}
			 //  }
		  // }
		  pageHeader2 { output(u.name) }
		  if(u.url != null && u.url != "") {
			  par { label("Home Page") { output(u.url) } }
		  }
		  if(projects.length > 0) {
			  par { label("Projects") { projects(projects) } }
		  }
		  pageHeader3{ "Recently Reported Issues" }
		  par { issues(reportedIssues.set(), true, true, true, 50, true, true) }
	  }
  }
  
  template nav(u: User) {
    navigate user(u.tag) { output(u.name) } 
  }

  template users(us : Set<User>) {
	  for(u : User in us) {
		  navigate user(u.tag) { output(u.name) }
	  } separated-by { ", " }
  }

  page editUser(u : User) {
	  title{output(u.name) " on YellowGrass.org [Editing]"}	
	  action save(){
      u.save();
      return home();
    }
	  bmain{
		  pageHeader2{ "Edit Profile" }
		  horizontalForm {
			  controlGroup("Name") { input(u.name) }
			  controlGroup("Email") { input(u.email)}
			  controlGroup("Receive notifications on issue changes via email?") { input(u.notifications) }
			  controlGroup("Home Page") { input(u.url)}
			  formActions{
				  submitlink save() [class="btn btn-primary"]{ "Save" } " "
				  navigate home() [class="btn"] { "Cancel" }
			  }
		  }
	  }
  }

  page manageDevices(u : User) {
	  title{output(u.name) " on YellowGrass.org [Editing]"}
	  bmain{
		  pageHeader2{ "Manage Devices" }
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
