module user/home

define page home(u : User){
	main()
	define body(){
		<h1> output(u.name) </h1>
		
		section {
			<h2> "Projects" </h2>
			table {
				for(p : Project in u.projects) {
					row { navigate project(p) {output(p.name)}}
				}
			}
			navigate(registerProject()) {"Create New Project"}
		}
	}
}