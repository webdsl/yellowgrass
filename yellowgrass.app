application yellowgrass

imports templates
imports ac
imports auxiliary
imports issue/issue
imports user/user
imports project/project

define page root() {
	title{"YellowGrass.org"}
	main()
	define body() {
		block [class := "column1"] {
			par { <h2>"About YellowGrass"</h2> }
			par {
				"YellowGrass is a light-weight and easy to use issue tracker. "
				"It provides a complete issue tracking solution, geared towards software development. "
				"Using YellowGrass is free. Registering your project is just a few clicks away... "
				navigate(registerUser()){"Register"}
			}
			par { <h2>"New projects on YellowGrass"</h2> }
			par {
				var recentProjects : List<Project> := 
					from Project as p
					order by _created desc
					limit 8;
				table {
					for(p : Project in recentProjects) {
						row {
							navigate(project(p)) {output(p.name)}
							output(p.url)
						}
					}
				}
			}
			par { navigate(projectList()) {"View all Projects"} }
		}
		block [class:= "column2"] {
			par { <h2>"Recent Issues"</h2> }
			par {
				var recentIssues : List<Issue> := 
					from Issue as i
					order by _submitted desc
					limit 18;
				issues(recentIssues.set(), true, false, false)
			}
		}
	}
}

/*test colorsInitialized {
  assert((from Color).length == 4);
}*/