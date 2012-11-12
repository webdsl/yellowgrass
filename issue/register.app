module issue/register

  page createIssue(p : Project) {
	  createIssue(p, null as Tag)
  }

  page createTaggedIssue(p : Project, initialTag : Tag) {
	  createIssue(p, initialTag)
  }

  template createIssue(p : Project, initialTag : Tag) { 
    title{output(p.name) " - Create new issue on YellowGrass.org"}
    
	  var issuetypes : List<Tag> := 
		  select t1
		  from Tag as t1 left join t1.tags as t2
		  where 
			  t1.project = ~p and
			  t2.project = ~p and
			  t2.name = ~ISSUE_TYPE_TAG()
		  group by t1.name
		  order by t1.name;
	  
    var ig := IssueGhost{ alive := false };
    var type : Tag;

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

	  bmain(p){		
		  gridRow{
		    gridSpan(2){ projectSideBar(p) }
		    gridSpan(10){		      
			    pageHeader2{ "Post New " output(p.name) " Issue" }
			    horizontalForm {		
				    controlGroup("Title") {
					    input (ig.title) [onkeyup := updateIssueSuggestions(ig.title, p), autocomplete:="off"]
				    }
				    div [class := "IssueSuggestions"] {
					    placeholder issueSuggestionsBox {} 
				    }
				    if(issuetypes.length > 0) {
					    controlGroup("Type") {
							  select(type from issuetypes)
						  }
					  }
				    controlGroup("Description") {
						  input(ig.description)[onkeyup := updateIssuePreview(ig.description)]
					  }			
				    div [class="Block"] {
					    placeholder issuePreview {} 
				    }
				    par [align = "center"] { 
				      navigate(url("http://en.wikipedia.org/wiki/Markdown#Syntax_examples")) [target:="_blank"] { "Syntax help" } 
				    }
				    if(!securityContext.loggedIn) {
					    controlGroup("Email") {
						    input(ig.email){validate(ig.email!="","Please enter your email address")}
			    		   <i> 	
			    		     "Email addresses are used for issue confirmation, notifications and questions only. "
								   "Email addresses are never presented publicly."
						     </i>
						  }
						}
					  formActions{
              submitlink post() [class="btn btn-primary"] { "Post" } " "
              navigate project(p) [class="btn"] { "Cancel" }
					  }
					}
				}
			}
		}
  }

  ajax template issueSuggestions(t : String, p : Project) {
	  // Cannot search on project names (yet), so doing bigger search and project limit
	  var suggestions := searchIssue(t+" "+p.name, 20);
	  var projectSuggestions := [ i | i : Issue in suggestions where i.project == p limit 5];
	  for(i : Issue in projectSuggestions) {
		  par {
			  navigate(issue(p, i.number)) [target:="_blank"] { output(i.getTitle()) }
	 	  }
	  }
  }

  ajax template issuePreview(d : WikiText) {
	  label("Description Preview") {
		  block {	// Needed to work around placeholder content displacement
			  output(d)
		  }
	  }
  }
  