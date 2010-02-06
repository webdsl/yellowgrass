module project/project

imports project/ac
imports project/register

entity Project {
	name		:: String (id, validate(isUniqueProject(this), "Another project with this name already exists"))
	description	:: WikiText
	url			:: URL
	issues		-> Set<Issue>
	members		-> Set<User>
	created		:: DateTime
}

define page project(p : Project) {
	var openIssues : Set<Issue> := [ i | i : Issue in p.issues where i.open ];

	main()
	define body() {
		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { navigate(home(securityContext.principal)) {"Ç Back Home"} }
			} 
			par { <h2>"Open Issues"</h2>	}
			par { issues(openIssues, false, false, true, 60) }	// Limit the length of this set
			par { navigate(projectIssues(p)) {"View All Issues"} }
			
			par { <h2>"Project Members"</h2> }
			par { users(p.members) }
		}
		block [class := "sidebar"] {
			par { 
				<h1> output(p.name) </h1>
			}
			
			par { navigate(createIssue(p))	{"New Issue"} }
			par { navigate(edit(p))			{"Project Settings"} }
			if(securityContext.loggedIn) {
				if(securityContext.principal in p.members) {
					if(p.members.length > 1) {
						par { actionLink("Leave Project", leaveProject()) }
					}
				} else {
					par { actionLink("Join Project", joinProject()) }
				}
			}
			
			par { output(p.description) }
		}
	}
	action joinProject() {
		p.members.add(securityContext.principal);
		return project(p);
	}
	action leaveProject() {
		p.members.remove(securityContext.principal);
		return home(securityContext.principal);
	}
}

define template projects(ps : Set<Project>) {	 
	table {
		var psSorted : Set<Project> := 
			[punsorted | punsorted : Project in ps order by punsorted.name asc]
		
		for(p : Project in psSorted) {
			row { 
				navigate project(p) {output(p.name)}
				block {
					output([i | i : Issue in p.issues where i.open].length) 
					" open issues "
				}
				block { 
					output(p.members.length) 
					" members "
				}
			}
		}
	}
}

define page edit(p : Project) {
	main()
	define body(){
		<h1> "Edit Project" </h1>
		form {
			par {
				label("Project name") { input(p.name) }
			}
			par {
				label("Project description") { input(p.description)}
			}
			par {
				label("Project web page") { input(p.url) }
			}
			par {
				navigate(project(p)) {"Cancel"}
				" "
				action("Save",save())
				action save(){
					p.save();
					message("Project saved");
					return project(p);
				}
			}
		}
	}
}

define page projectIssues(p : Project) {
	main()
	define body() {
		block [class := "main"] {
			par [class := "Back"] { navigate(project(p)) {"Ç Back to Project"} } 
			par { issues(p.issues, false, true, true, 60) }
		}
		block [class := "sidebar"] {
			par {
				<h1> output(p.name) </h1>
			}
			
			par { navigate(createIssue(p))	{"New Issue"} }
			
			par { output(p.description) }
		}
	}
}