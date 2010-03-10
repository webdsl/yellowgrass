module user/register

define page registerProject(){
	var p := Project{};

	title{"YellowGrass.org - Project Registration"}
	main()
	define body(){
		<h1> "Create New Project" </h1>
		form { 
			par { label("Project name") { input(p.name) } }
			par {
				navigate(home(securityContext.principal)) {"Cancel"}
					" "	
				action("Create",create())
			}
		}
	}
	action create(){
		p.members.add(securityContext.principal);
		p.created := now();
		p.save();
		//message("New Project Created");
		return edit(p);
	}
}