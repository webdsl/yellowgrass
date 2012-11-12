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
	main(p)
	define body(){
		var ig := IssueGhost{ 
			alive := false 
	  }; 
		var type : Tag;
		init{
			// reconstruct the input data for a new issue after a login without requiring ajax style page updates 
			// the securityContext properties are set when logging in on the create issue page, 
			// see user/access.app for the login action  
			ig.description := securityContext.newIssueDesc;
			ig.title := securityContext.newIssueTitle; 
			var selectedtypes := [t | t:Tag in issuetypes where t.id.toString() == securityContext.newIssueType];
			if(selectedtypes.length>0){
			  type := selectedtypes[0];
      }			 			
			securityContext.newIssueDesc := "";
			securityContext.newIssueType := "";
			securityContext.newIssueTitle := "";
		}
		
		block [class := "main"] {
			<h1> "Post New " output(p.name) " Issue" </h1>
			
			form {
			
				par[id="new-issue-title"] { label("Title") {
					input (ig.title) [onkeyup := updateIssueSuggestions(ig.title, p), autocomplete:="off"]
				}}
				par [class := "IssueSuggestions"] {
					placeholder issueSuggestionsBox {} 
				}
				if(issuetypes.length > 0) {
					par[id="new-issue-type"] {
						label("Type") {
							select(type from issuetypes)
						}
					}
				}
				par[id="new-issue-desc"] { 
					label("Description") {
						input(ig.description)
						[onkeyup := updateIssuePreview(ig.description)]
					} 
				}
				block [class := "Block"] {
					placeholder issuePreview {} 
				}
				par [align := "center"] { navigate(url("http://en.wikipedia.org/wiki/Markdown#Syntax_examples")) [target:="_blank"] { "Syntax help" } }
				if(!securityContext.loggedIn) {
					par { label("Email") {
						input(ig.email){validate(ig.email!="","Please enter your email address")}
					}}
					par { <i> 	"Email addresses are used for issue confirmation, notifications and questions only. "
								"Email addresses are never presented publicly."
						  </i> 
					}
				}		
				par {
					navigate(project(p)) {"Cancel"}
					" "
					action("Post",post())
				}
			}
		}
		projectSideBar(p)
		action post() {
			ig.project := p;
			if(initialTag != null) {
				ig.tags := {initialTag};
			}
			if(type != null) {
				ig.tags.add(type);
			}
			ig.save();
			
			if(securityContext.loggedIn) {
				var i : Issue := ig.realize();
				return issue(i.project, i.number);
			} else {
				email(issueConfirmationEmail(ig));
				return issueConfirmation();
			}
			
			
		}
		action ignore-validation updateIssueSuggestions(t : String, p : Project) {
			if(mayAccess(p)) {
				replace(issueSuggestionsBox, issueSuggestions(t, p));
			}
		}
		action ignore-validation updateIssuePreview(d : WikiText) {
			replace(issuePreview, issuePreview(d));
		}
	}
}

define ajax issueSuggestions(t : String, p : Project) {
	// Cannot search on project names (yet), so doing bigger search and project limit
	var suggestions := searchIssue(t+" "+p.name, 20);
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