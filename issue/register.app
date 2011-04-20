module issue/register

define page createIssue(p : Project) {
	createIssue(p, null as Tag)
}

define page createTaggedIssue(p : Project, initialTag : Tag) {
	createIssue(p, initialTag)
}

define template createIssue(p : Project, initialTag : Tag) {
	var issuetypes : List<Tag> := 
		select t1
		from Tag as t1 left join t1.tags as t2
		where 
			t1.project = ~p and
			t2.project = ~p and
			t2.name = ~ISSUE_TYPE_TAG()
		group by t1.name
		order by t1.name;
	title{output(p.name) " - Create new issue on YellowGrass.org"}
	main()
	define body(){
		var i := Issue{
			reporter := securityContext.principal 
		};
		var title : String := "";
		var email : Email := "";
		var type : Tag;
		
		block [class := "main"] { 
			<h1> "Post New " output(p.name) " Issue" </h1>
			
			form { 
			
				par { label("Title") {
					if(securityContext.loggedIn) {
						input (title) [onkeyup := updateIssueSuggestions(title, p), autocomplete:="off"]
					} else {
						input (title) [autocomplete:="off"]
					}
				}}
				par [class := "IssueSuggestions"] {
					placeholder issueSuggestionsBox {} 
				}
				if(issuetypes.length > 0) {
					par {
						label("Type") {
							select(type from issuetypes)
						}
					}
				}
				par { 
					label("Description") {
						input(i.description) 
						[onkeyup := updateIssuePreview(i.description)]
					} 
				}
				par [align := "center"] { navigate(url("http://en.wikipedia.org/wiki/Markdown#Syntax_examples")) [target:="_blank"] { "Syntax help" } }
				if(!securityContext.loggedIn) {
					par { label("Email") {
						input(email){validate(email!="","Please enter your email address")}
					}}
					par { <i> 	"Email addresses are used for notifications and questions only. "
								"Email addresses are never presented publicly."</i> 
					}
					par { captcha() }
				}		
				par {
					navigate(project(p)) {"Cancel"}
					" "
					action("Post",post())
				}
				block [class := "Block"] {
					placeholder issuePreview {} 
				}
			}
		}
		projectSideBar(p)
		action post() {
			i.title := title;
			i.submitted := now();
			i.project := p;
			i.number := newIssueNumber(p);
			i.open := true;
			i.email := email;
			if(initialTag != null) {
				i.tags := {initialTag};
			}
			if(type != null) {
				i.tags.add(type);
			}
			i.assign();
			i.save();
			flush();
			i.notifyRegister();
			return issue(p, i.number);
		}
		action updateIssueSuggestions(t : String, p : Project) {
			replace(issueSuggestionsBox, issueSuggestions(t, p));
		}
		action updateIssuePreview(d : WikiText) {
			replace(issuePreview, issuePreview(d));
		}
	}
}

define ajax issueSuggestions(t : String, p : Project) {
	// TODO Cannot search on project names, so doing big search and project limit. Fix this when search for project name is enabled.
	var suggestions := searchIssue(t, 100);
	var projectSuggestions := [ i | i : Issue in suggestions where i.project == p limit 5];
	for(i : Issue in projectSuggestions) {
		par {
			navigate(issue(p, i.number)) [target:="_blank"] {output(i.getTitle())}
		}
	}
}

define ajax issuePreview(d : WikiText) {
	
		label("Description Preview") {
			block {	// Neded to work around placeholder content displacement
				output(d)
			}
	
	}
}