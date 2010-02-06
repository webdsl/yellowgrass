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
	main()
	define body() {
		// TODO Make two column: left the issues; right: the title and some actions like post and edit
	
		block [class := "main"] { 
			par { <h2>"Open Issues"</h2>	}
			par { issues(p.issues, false) }
			
			par { <h2>"Project Members"</h2> }
			par { users(p.members) }
		}
		block [class := "sidebar"] {
			par { 
				<h1> output(p.name) </h1>
			}
			
			par { navigate(createIssue(p))	{"New Issue"} }
			par { navigate(edit(p)) 		{"Project Settings"} }
			
			par { output(p.description) }
		}
	}
}

define page edit(p : Project) {
	main()
	define body(){
		<h1> "Edit Project" </h1>
		form {
			par {
				"Project name" 
				input(p.name)
			}
			par {
				label("Project description") { input(p.description)}
			}
			par {
				label("Project web page") { input(p.url) }
			}
			par {	
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