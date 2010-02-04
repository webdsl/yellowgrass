module user/register

define page registerProject(){
	main()
	define body(){
		var p := Project{};
		<h1> "Create New Project" </h1>
		form{table{
			row{"Project name"		input(p.name)}
				
			break
			action("Create",create())
			action create(){
				p.members.add(securityContext.principal);
				p.save();
				message("New Project Created");
				return edit(p);
			}
		}}
	}
}