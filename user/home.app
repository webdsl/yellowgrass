module user/home

imports user/password

define page home(){
	// Workaround for bug that access control is enforced after variable initialization (init block is executed after access control)
	var u : User; var assignedTag : String; var assignedIssues : List<Issue>;
	init {
		u := securityContext.principal;
		assignedTag := "@" + u.tag;
		assignedIssues := 
			select i from Issue as i
			left join i._tags as t
			where t._name = ~assignedTag and i._open=true
			order by i._submitted desc
			limit 20;
	}
	
	title{"YellowGrass.org - " output(u.name)}
	main()
	define body(){
		block [class := "main"] {
			par [class := "Back"] { rawoutput { "&raquo;" } " Home" }
//			block [class := "Block"] { 
				par { <h2>"Your Projects"</h2>	}
				par { projects(u.projects.list()) }
//			}
//			block [class := "Block"] {
				par { <h2>"Assigned Issues"</h2>	}
				par { issues(assignedIssues.set(), true, false, true, 50, true) }
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