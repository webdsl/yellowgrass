module user/home

imports user/password

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
				var recentIssues : List<Issue> := 
					select i from Issue as i
					left join i._project._members as m
					where m = ~u
					order by i._submitted desc
					limit 10;
				issues(recentIssues.set(), true, false, true, 60)
			}
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