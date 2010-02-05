module issue/issue

imports issue/ac

entity Issue {
	// TODO add optional user association
	number		:: Int
	title		:: String
	description	:: WikiText
	submitted 	:: DateTime
	project		-> Project (inverse = Project.issues)
}

function newIssueNumber(p: Project) : Int {
	var lastProjectIssues : List<Issue> := 
		from Issue as i
		where _project = ~p
		order by _number desc
		limit 1;
	if(lastProjectIssues.length == 0) {
		return 0;
	} else {
		return lastProjectIssues.get(0).number + 1;
	}
}

define template issues(is : Set<Issue>) {
	block [class := "Listing"] {
		table {
		//	var odd := -1;
			for(i : Issue in is order by i.submitted desc) {
				row {
					output(i.number)
					output(i.submitted.format("MMM d")) // TODO Add year if needed 
					navigate(issue(i)){output(i.title)}
				}
			//	init {
				//	odd := 0 - odd; }
			}
		}
	}
}

define page issue(i : Issue) {
	main()
	define body(){
		<h1> "Issue" output(i.number) </h1>
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
		<h1> "Edit Issue" output(i.number) </h1>
		form {
			par {
				label("Submitted") {output(i.submitted)} 
				label("Title") {input(i.title)}
				label("Description") {input(i.description)}
			}
			par {
				submit("Save",save())
				action save(){
					i.save();
					return (project(i.project));
				}
			}
		}
	}
}

define page createIssue(p : Project) {
	main()
	define body(){
		var i := Issue{};
		<h1> "Post New Issue" </h1>
		form { 
			par { 
				label("Title") {input(i.title)}
			}
		
			par{
				action("Post",post())
				action post(){
					i.submitted := now();
					i.project := p;
					i.number := newIssueNumber(p);
					i.save();
					return editIssue(i);
				}
			}
		}
	}
}
