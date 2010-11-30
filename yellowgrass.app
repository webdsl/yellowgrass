application yellowgrass

imports templates
imports ac
imports auxiliary
imports features
imports issue/issue
imports user/user
imports project/project
imports user/register
imports tag/tag

define page root() {
	title{"YellowGrass.org - The Tag-Based Issue Tracker"}
	main()
	define body() {
		var activeProjects : List<Project> := 
			select p
			from Project as p
			join p.issues as i
			where _private=false
			group by p
			order by max(i._submitted) desc
			limit 15;

		var recentIssues : List<Issue> := 
			from Issue as i
			where i._project._private=false
			order by _submitted desc
			limit 18;
		
		block [class := "column1"] {
			par { <h2>"About YellowGrass"</h2> }
			par {
				"YellowGrass is a tag-based issue tracker. "
				"It provides a complete issue and bug tracking solution, geared towards software development projects. "
				"YellowGrass is fully web-based and free of charge. Registering your project is just a few clicks away... "
			} par {
				"Take a look at YellowGrass's " navigate(features()){"Feature List"} " or " navigate(registerUser()){"Register"} " right away."
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

