application yellowgrass

imports templates
imports ac
imports auxiliary
imports issue/issue
imports user/user
imports project/project

define page root() {
/*	var recentProjects : List<Project> := 
		from Project as p
		order by _created desc
		limit 15;
*/	
						
	title{"YellowGrass.org - The Tag-Based Issue Tracker"}
	main()
	define body() {
		var activeProjects : List<Project> := 
			select p
			from Project as p
			join p.issues as i
			group by p
			order by max(i._submitted) desc
			limit 15;

		var recentIssues : List<Issue> := 
			from Issue as i
			order by _submitted desc
			limit 18;

		
		
		block [class := "column1"] {
			par { <h2>"About YellowGrass"</h2> }
			par {
				"YellowGrass is a tag-based issue tracker. "
				"It provides a complete issue and bug tracking solution, geared towards software development projects. "
				"YellowGrass is fully web-based and free of charge. Registering your project is just a few clicks away... "
				navigate(registerUser()){"Register"}
			}
			par { <h2>"Some Active Projects"</h2> }
			par {
				table {
					for(p : Project in activeProjects) {
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
			par { issues(recentIssues.set(), true, false, false, 40) }
		}
	}
}

function debug(msg : String) {
	log(msg);
}

/*test colorsInitialized {
  assert((from Color).length == 4);
}*/

