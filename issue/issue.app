module issue/issue

imports issue/ac

entity Issue {
	// TODO add optional user association
	title		:: String
	description	:: WikiText
	submitted 	:: DateTime
	project		-> Project (inverse = Project.issues)
}


define template issues(is : Set<Issue>) {
	table {
		for(i : Issue in is) {
			row { navigate(issue(i)){output(i.title)}}
		}
	}
}

define page issue(i : Issue) {
	main()
	define body(){
		<h1> "Issue" </h1>
		navigate(editIssue(i)) {"[Edit]"}
		
		form{table{
			row{"Title"				output(i.title)}
			row{"Submitted"			output(i.submitted)}
			row{"Description"		output(i.description)}
		}}
	}	
}

define page editIssue(i : Issue) {
	main()
	define body(){
		<h1> "Edit Issue" </h1>
		form{table{
			row{"Title"				input(i.title)}
			row{"Submitted"			output(i.submitted)}
			row{"Description"		input(i.description)}
			break
			action("Save",save())
			action save(){
				i.save();
				return (project(i.project));
			}
		}}
	}
}

define page createIssue(p : Project) {
	main()
	define body(){
		var i := Issue{};
		<h1> "Post New Issue" </h1>
		form{table{
			row{"Title"				input(i.title)}
			break
			action("Post",post())
			action post(){
				i.submitted := now();
				i.project := p;
				i.save();
				return editIssue(i);
			}
		}}
	}
}
