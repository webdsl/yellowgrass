application yellowgrass

imports templates
imports ac
imports auxiliary
imports issue/issue
imports user/user
imports project/project

define page root() {
	title{"YellowGrass.org - The Tag-Based Issue Tracker"}
	main()
	define body() {
		block [class := "column1"] {
			par { <h2>"About YellowGrass"</h2> }
			par {
				"YellowGrass is a tag-based issue tracker. "
				"It provides a complete issue and bug tracking solution, geared towards software development projects. "
				"YellowGrass is fully web-based and free of charge. Registering your project is just a few clicks away... "
				navigate(registerUser()){"Register"}
			}
			par { <h2>"New projects on YellowGrass"</h2> }
			par {
				var recentProjects : List<Project> := 
					from Project as p
					order by _created desc
					limit 15;
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
				issues(recentIssues.set(), true, false, false, 40)
			}
		}
	}
}

/*test colorsInitialized {
  assert((from Color).length == 4);
}*/

