module issue/issue

imports issue/ac

entity Issue {
	// TODO add optional user association
	number		:: Int
	title		:: String
	description	:: WikiText
	submitted 	:: DateTime
	project		-> Project (inverse = Project.issues)
	open		:: Bool
	
	function close() {
		open := false;
	}
	function reopen() { 
		open := true;
	}
	function notifyProjectMembers() {
		for(u : User in project.members){
			email(issueNotification(this, u));
		}
	}
}

function newIssueNumber(p: Project) : Int {
	var lastProjectIssues : List<Issue> := 
		from Issue
		where _project = ~p
		order by _number desc
		limit 1;
	if(lastProjectIssues.length == 0) {
		return 0;
	} else {
		return lastProjectIssues.get(0).number + 1;
	}
}

define template issues(is : Set<Issue>, showProjectName : Bool) {
	issues(is, showProjectName, false)
}
define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool) {
	issues(is, showProjectName, showTicks, true)
}
define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool) {
	block [class := "Listing"] {
		table {
			for(i : Issue in is order by i.submitted desc) {
				row {
					if(showNumbers) {
						output(i.number)
					}
					output(i.submitted.format("MMM d")) // TODO Add year if needed
					if(showProjectName) {
						output(
							abbreviate(i.project.name, 20))
					}
					navigate(issue(i)) {
						output(abbreviate(i.title, 33))
					}
					if(i.open || (!showTicks)) { 
						"" 
					} else {
						image("/images/tick.png") }
				}
			}
		}
	}
}

define page issue(i : Issue) {
	main()
	define body(){
		block [class := "main"] {
			par [class := "Back"] { navigate(project(i.project)) {"Ç Back to Project"} }
			par{ <h2> 
				output(i.project.name) 
				" #" output(i.number) 
				" ("  output(i.submitted.format("MMM d")) ")" // TODO Add year if needed
				</h2> 
			} 
			par{ <i> output(i.title) </i> }
			par{ output(i.description) }
		}
		block [class := "sidebar"] {
			par { 
				<h1> "Issue " output(i.number) </h1>
			}
			
			par { navigate(editIssue(i, false))	{"Edit this Issue"}}
			if(i.open) {
				par { actionLink("Close Issue", close() ) }
			} else {
				par { actionLink("Reopen Issue", reopen() ) }
			}
		}
	}
	action close(){
		i.close();
		i.save();
		return project(i.project);
	}
	action reopen(){
		i.reopen();
		i.save();
		return issue(i);
	}
}

define page editIssue(i : Issue, new : Bool) {
	main()
	define body(){
		<h1> "Edit Issue " output(i.number) </h1>
		form {
			par {
				label("Title") {input(i.title)}
				label("Description") {input(i.description)}
			}
			par {
				navigate(project(i.project)) {"Cancel"}
				" "
				submit("Save",save())
				action save(){
					i.save();
					if(new) { i.notifyProjectMembers(); }
					return project(i.project);
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
				navigate(project(p)) {"Cancel"}
				action("Post",post())
				action post(){
					i.submitted := now();
					i.project := p;
					i.number := newIssueNumber(p);
					i.open := true;
					i.save();
					return editIssue(i, true);
				}
			}
		}
	}
}

define email issueNotification(i : Issue, u : User) {
	to(u.email)
	from("YellowGrass@YellowGrass.org")
	subject(i.project.name+" - Issue "+i.number+" notification")
	par { output(i.project.name) " - Issue " output(i.number)}
	par {}
	par { output(i.title) }
	par {}
	par { "Submitted on " output(i.submitted.format("MMM d yyyy")) }
	par {}
	par { output(i.description) }
	par {}
	par { "-- The YellowGrass Team" }
}


function abbreviate(s : String, length : Int) : String {
	if(s.length() <= length) {
		return s;
	} else {
		return prefix(s, length - 4) + " ...";
	}
}

function prefix(s : String, length : Int) : String {
	if(s.length() <= length) {
		return s;
	} else {
		var sChar := s.split();
		sChar.removeAt(length);
		return prefix(sChar.concat(), length);
	}
}

function prefix(s : List<Issue>, length : Int) : List<Issue> {
	if(s.length <= length) {
		return s;
	} else {
		s.removeAt(length);
		return prefix(s, length);
	}
}
