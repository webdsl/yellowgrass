module issue/register

define page createIssue(p : Project) {
	var i := Issue{ type := improvementIssueType };
	var email : Email := ""
		
	title{"YellowGrass.org - " output(p.name) " - New Issue"}
	main()
	define body(){
		<h1> "Post New " output(p.name) " Issue" </h1>
		
		form { 
			par { label("Title") {
				input (i.title) [onkeyup := updateIssueSuggestions(i.title), autocomplete:="off"]
			}}
			par [class := "IssueSuggestions"] {
				placeholder issueSuggestionsBox {} 
			}
			par {
				label("Type") {
					select(i.type from [improvementIssueType, errorIssueType, featureIssueType, questionIssueType])
				}
			}
			par { label("Description") {input(i.description)} }
			par [align := "center"] { navigate(url("http://en.wikipedia.org/wiki/Markdown#Syntax_examples")){ "Syntax help" } }
			if(!securityContext.loggedIn) {
				par { label("Email") {input(email)} }
				par { <i> 	"Email addresses are used for notifications and questions only. "
							"Email addresses are never presented publicly."</i> 
				}
				par { captcha() }
			}
			
			par{
				navigate(project(p)) {"Cancel"}
				" "
				action("Post",post())
			}
		}
	}
	action post(){
		i.submitted := now();
		i.project := p;
		i.number := newIssueNumber(p);
		i.open := true;
		i.reporter := securityContext.principal;
		i.email := email;
		i.assign();
		i.save();
		flush();
		i.notifyProjectMembers();
		return issue(p, i.number);
	}
	action updateIssueSuggestions(t : String) {
		replace(issueSuggestionsBox, issueSuggestions(t, p));
	}
}

define ajax issueSuggestions(t : String, p : Project) {
	// TODO Cannot search on project names, so doing big search and project limit. Fix this when search for project name is enabled.
	var suggestions := searchIssue(t, 100);
	init { log(suggestions.length.toString()); }
	var projectSuggestions := [ i | i : Issue in suggestions where i.project == p limit 5];
	" Nr suggestions: " output(suggestions.length)
	" Nr project suggestions: " output(projectSuggestions.length)
	for(i : Issue in projectSuggestions) {
		par {
			navigate(issue(p, i.number)){output(i.title)}
		}
	}
}