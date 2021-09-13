module issue/register

imports built-in
imports templates
imports issue/-
imports project/-
imports tag/tag-model
imports user/access

imports elib/elib-bootstrap/lib

  page createIssue(p : Project) {
	  createIssue(p, null as Tag)
  }

  page createTaggedIssue(p : Project, initialTag : Tag) {
	  createIssue(p, initialTag)
  }

  template createIssue(project : Project, initialTag : Tag) { 
    title{output(project.name) " - Create new issue on YellowGrass.org"}

    var pass : Secret
    var keepLoggedIn : Bool
        
	var issuetypes : List<Tag> := project.issueTypes()
	  
    var ig := IssueGhost{ alive := false }
    var type : Tag

    action post() {
      ig.project := project; 
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
        if(pass != "") { 
          login(ig.email, pass, keepLoggedIn); 
          var i : Issue := ig.realize();
          return issue(i.project, i.number);
        } else {
          if(project.notifications){
            email issueConfirmationEmail(ig);
          }
        }
        return issueConfirmation();
      }
    }
    action ignore-validation updateIssueSuggestions(t : String, p : Project) {
      if(mayAccess(p)) {
        replace("issueSuggestionsBox", issueSuggestions(t, p));
      }
    }
    action ignore-validation updateIssuePreview(d : WikiText) {
      replace("issuePreview", issuePreview(d));
    }

	  bmain{		
      projectToolbar(project) 
		  gridRow{
		    gridCol(12){		      
			    pageHeader2{ "Post New " output(project.name) " Issue" }
			    horizontalForm {		
				    controlGroup("Title") {
					    input (ig.title) [class="span8", onkeyup := updateIssueSuggestions(ig.title, project), autocomplete:="off"]
					    placeholder "issueSuggestionsBox" { 
					      issueSuggestions(ig.title, project)
					    }
				    }
				    if(issuetypes.length > 0) {
					    controlGroup("Type") { 
							  input(type, issuetypes)
						  }
					  }
				    controlGroup("Description") { 
						  input(ig.description)[onkeyup := updateIssuePreview(ig.description), style="height:400px;"] 
					  }			
				    placeholder "issuePreview" {} 
				    par [align = "center"] { 
				      navigate(url("http://en.wikipedia.org/wiki/Markdown#Syntax_examples")) [target:="_blank"] { "Syntax help" } 
				    }
				    if(!loggedIn()) { 
					    controlGroup("Email") {
						    input(ig.email){ 
						      helpBlock{
						        validate(loggedIn() || ig.email != "", "Please enter your email address")
						      } 
			    		    helpBlock{ 
			    		      "Email addresses are used for issue confirmation, notifications and questions only. "
								    "Email addresses are never presented publicly."
						      }
						    }
						  }
						  controlGroup("Password") {
						    input(pass) {
						      validate(pass == "" || authenticate(ig.email,pass), 
						               "Incorrect email address or incorrect password")
						    }
						    helpBlock{ 
						      "Leave empty if you don't have an account."
						    }
						  }
						  controlGroup("Stay logged in") { input(keepLoggedIn) }
						}
					  formActions{
					    submit post() [style="display: none;"] { "Post" }
              submitlink post() [ignore default class, class="btn btn-primary"] { "Post" } " "
              navigate project(project) [submit attributes] { "Cancel" } 
					  }
					}
				}
			}
		}
  }

  ajax template issueSuggestions(t : String, project : Project) {
	  // Cannot search on project names (yet), so doing bigger search and project limit
	  var suggestions := searchIssue(t+" "+project.name, 20)
	  var projectSuggestions := [ i | i : Issue in suggestions where i.project == project limit 5]
	  list[class="listbox"] {
      for(i : Issue in projectSuggestions) {
		    listitem {
			    navigate(issue(project, i.number)) [target:="_blank"] { output(i.getTitle()) }
			  }
			}
	 	}
  }

  ajax template issuePreview(d : WikiText) {
	  controlGroup("Description Preview") {
		  blockquote { output(d) }
	  }
  }
  