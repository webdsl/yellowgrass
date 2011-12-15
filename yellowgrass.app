application yellowgrass 

imports templates
imports webservices
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
			limit 10;

		var recentIssues : List<Issue> := 
			from Issue as i
			where i._project._private=false
			order by _submitted desc
			limit 27;
		
		table [class = "columns"] { row { 
			column [class = "column1"] {
				par { <h2>"About YellowGrass"</h2> }
				par {
					"YellowGrass is a user-friendly, tag-based issue tracker."<br/>
					"It supports issue voting, issue tagging, roadmaps, assigning and following issues, private and public projects, full text search, email updates, action logging and much more. "
					"YellowGrass is fully web-based and free of charge. Registering your project is just a few clicks away. "
					"Take a look at YellowGrass's " navigate(features()){"Feature List"} " or " navigate(registerUser()){"Register"} " right away."
				}
				par { <h2>"Some Screenshots"</h2> }
				<a href="images/screenshotRoadmap.png"> image("/images/screenshotRoadmap.png")[class="Screenshot"] </a>
				<a href="images/screenshotIssue.png"> image("/images/screenshotIssue.png")[class="Screenshot"] </a>
				par { <h2>"Some Active Projects"</h2> }
				par {
					table {
						for(p : Project in activeProjects) {
							row { 
								column { navigate(project(p)) {output(p.name)} }
								column { output(p.url) }
							}
						}
					}
				}
				par { navigate(projectList()) {"View all Projects"} }				
			}
			column [class = "column2"] {
				par { <h2>"Recent Issues"</h2> }
				par { issues(recentIssues.set(), true, false, false, 40) }
			}
		}} 
	}
}

define page sources() {
	title{"YellowGrass.org - Source Code"}
	main()
	define body() {
		par { <h1>"YellowGrass Source Code"</h1> }
		par {
			" YellowGrass is open and freely available for personal usage."
			" Its source code is distributed under under the " <a href="http://www.affero.org/agpl2.html">"Affero General Public License"</a> "."
			" More flexible licenses are negotiable, feel free to contact us."
			" Contact information can be found at " <a href="http://www.sandervermolen.nl"> "http://www.sandervermolen.nl" </a> "."
		}
		par {
			"The source code repository can be found at: " <a href="https://svn.strategoxt.org/repos/issolar">"https://svn.strategoxt.org/repos/issolar"</a>
		}
	}
}

