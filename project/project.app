module project/project

imports project/ac
imports project/register

entity Project {
	name		:: String (id, validate(isUniqueProject(this), "Another project with this name already exists"))
	description	:: WikiText
	url			:: URL
	issues		-> Set<Issue>
	members		-> Set<User>
}

define page project(p : Project) {
	main()
	define body() {
		// TODO Make two column: left the issues; right: the title and some actions like post and edit
		table {
			row { 
				<h1> output(p.name) </h1>
				navigate(edit(p)) {"[edit]"} 
			} 
			row { output(p.description) }
			
			row { <h2>"Issues"</h2>	}
			row { issues(p.issues) }
			row { navigate(createIssue(p)) {"Post New Issue"} }

			row { <h2>"Members"</h2> }
			row { users(p.members) }
		}
	}
}

define page edit(p : Project) {
	main()
	define body(){
		<h1> "Edit Project" </h1>
		form{table{
			row{"Project name"			input(p.name)}
			row{"Project description"	input(p.description)}
			row{"Project web page"		input(p.url)}
			break
			action("Save",save())
			action save(){
				p.save();
				message("Project saved");
				return project(p);
			}
		}}
	}
}