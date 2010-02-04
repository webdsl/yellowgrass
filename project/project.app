module project/project

imports project/ac

entity Project {
	name		:: String
	description	:: WikiText
	url			:: URL
	issues		-> Set<Issue>
	members		-> Set<User>
}

define page view(p : Project){
	main()
	define body(){
		table {	row {
			projectIssueList(p)
		
			section {
				<h2> output(p.name) </h2>
				output(p.description)
			}
		}}
	}
}

define template projectIssueList(p : Project) {
	table {
		for(i : Issue in p.issues) {
			row { output(i.title)}
		}
	}
}