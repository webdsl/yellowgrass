module project/register

define page registerProject(){
	var p := Project{};

	title{"YellowGrass.org - Project Registration"}
	main()
	define body(){
		<h1> "Create New Project" </h1>
		form { 
			par { label("Project name") { input(p.name) } }
			par {
				navigate(home()) {"Cancel"}
					" "	
				action("Create",create())
			}
		}
	}
	action create(){
		p.members.add(securityContext.principal);
		p.created := now();
		p.private := false;
		p.email := "";
		p.save();
		createIssueTypes(p);
		return edit(p);
	}
}