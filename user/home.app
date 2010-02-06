module user/home

define page home(u : User){
	main()
	define body(){

		block [class := "main"] { 
			par { <h2>"Your Projects"</h2>	}
			par { 
				table {
					for(p : Project in u.projects) {
						row { 
							navigate project(p) {output(p.name)}
							output(p.issues.length)
						}
					}
				}
			}
			par{ <h2>"Recent Issues"</h2>	}
			par {
				var recentIssues : List<Issue> := 
					from Issue
				//	where _project in ~u.projects  TODO This fails in tomcat, fix it
					order by _submitted desc
					limit 15;
				issues(recentIssues.set(), true)
			}
		}
		block [class := "sidebar"] {
			par { 
				<h1> output(u.name) </h1>
			}
			
			par { navigate(registerProject())	{"Create New Project"}}
			//par { navigate(editUser(u)) 		{"Edit Your Profile"} }
		}
	}
}