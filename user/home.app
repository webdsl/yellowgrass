module user/home

imports user/password


// Projects recently posted to
// Important issues (votes / assigned / recent / recent comments)


define page home(){
	// Workaround for bug that access control is enforced after variable initialization (init block is executed after access control)
	var u : User; var assignedTag : String; var importantIssues : List<Issue>; var recentProjects : List<Project>; var recentIssues : List<Issue>;
	init {
		u := securityContext.principal;
		assignedTag := "@" + u.tag;
		recentProjects := ( 
			select p 
			from Issue as i
			left join i._project as p
			where i._reporter=~u
			group by p
			order by max(i._submitted) desc
			limit 5
			) as List<Project>;
		recentIssues := 
			select i from Issue as i
			left join i._project as p
			where ~u in elements(i._project._members)
			order by i._submitted desc
			limit 15;
	}
	
	title{"YellowGrass.org - " output(u.name)}
	main()
	define body(){
		block [class := "main"] {
			par [class := "Back"] { rawoutput { "&raquo;" } " Home" }
			
			table { 
				row { 
					column { <h2>"Supported Projects"</h2> }
					column { <h2>"Managed Projects"</h2> }
					column {}
					column {}
				}
				row { 
					column { projectsAbbreviated(recentProjects) }
					column { projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 0])}
					column { projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 5])}
					column { projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 10])}
				}
			}
			
//			block [class := "Block"] {
				par { <h2>"Recent Issues"</h2>	}
				par { issues(recentIssues.set(), true, false, true, 50, true) }
				par { navigate(postedIssues()) {"View issues posted by you"} }
//			}
		}
		block [class := "sidebar"] {
			par { 
				<h1> output(u.name) </h1>
			}
			sidebarSeparator()
			par { navigate(registerProject())	{"Create New Project"}}
			par { navigate(editUser(u)) 		{"Edit Your Profile"} }
			par { navigate(editUserPassword(u))	{"Change Your Password"} }
			sidebarSeparator()
		}
	}
}