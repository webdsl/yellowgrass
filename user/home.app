module user/home

define page home(u : User){
	title{"YellowGrass.org - " output(u.name)}
	main()
	define body(){
		block [class := "main"] {
			par [class := "Back"] { " È Home" } 
			par { <h2>"Your Projects"</h2>	}
			par { projects(u.projects) }
			par{ <h2>"Recent Issues"</h2>	}
			par {
			/*	var recentIssues : List<Issue> := 
					from Issue as i
				//	where ~u in i._project._members
				//	where _project in ~u.projects  TODO This fails in tomcat, fix it
					order by i._submitted desc
					limit 10;
			*/	
				var openIssues := u.getOpenIssues();
				issues(prefix(openIssues, 10).set(), true, false, true, 60)
			}
		}
		block [class := "sidebar"] {
			par { 
				<h1> output(u.name) </h1>
			}
			sidebarSeparator()
			par { navigate(registerProject())	{"Create New Project"}}
			par { navigate(editUser(u)) 		{"Edit Your Profile"} }
			sidebarSeparator()
		}
	}
}