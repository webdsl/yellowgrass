module issue/issue

imports issue/issue-model
imports issue/ac
imports comment/comment
imports comment/event
imports comment/issueControl
imports issue/emails
imports issue/register
imports issue/sidebar
imports issue/types
imports user/user
imports project/project
imports issue/attachment
imports issue/issueBrowser
imports issue/ghost

section issue page

  page issue(p : Project, issueNumber : Int) {
    var i := getIssue(p, issueNumber);
    var nrVotes := i.nrVotes; // Derived props are not cached and executed on demand
  
    title{"#" output(i.number) " " output(i.getTitle()) " (project " output(i.project.name) " on YellowGrass.org)"}
    bmain(p){  
    // block [class := "main"] {
    //  if(securityContext.loggedIn) {
    //    par [class := "Back"] {
    //      rawoutput { " &raquo; " } 
    //      navigate(home()) {"Home"}
    //      rawoutput { " &raquo; " }
    //      navigate(project(i.project)) {"Project " output(i.project.name)}
    //      rawoutput { " &raquo; " }
    //      "Issue " output(i.number)
    //    }
    //  } else {
    //    par [class := "Back"] { navigate(project(i.project)) {rawoutput { " &raquo; " } " To Project"} }
    //  }
      gridRow{
        gridSpan(2){ issueSideBar(i) }
        gridSpan(10){
      
          pageHeader2{
            output(i.getTitle())
            if(nrVotes > 0) { " (" output(nrVotes) ") " } 
            if(!i.open) {
              iOk
              //image("/images/tick.png")
            }
          }
          
          par{
            <i> 
              block [class := "IssueTitle"] {
                output(i.project.name) 
                " #" output(i.number)
                " ("
                if(i.reporter != null) {
                  "by " navigate(user(i.reporter.tag)){output(i.reporter.name) " "}
                }
                if(i.reporter == null && i.email != "" && securityContext.principal in p.members) {
                  "by " output(i.email) " "
                }
                "on " output(format(i.submitted)) 
                ") " 
              }
              " "
           </i>
           tags(i, true)
         }
         par { output(i.description) }
      
        // output(/\n/.replaceAll("<br />", b1.text) as WikiText)
      
        attachmentList(i)
        attachmentAddition(i)
      
        image("/images/hr.png")
      
        if(i.log.length > 0) {
          pageHeader2 { "Issue Log" }
          par { events(i.log) }
        }
        commentAddition(i)
        noCommentAddition()
      
      }
    }
  }
  }


section user interface

template issues(is : Set<Issue>, showProjectName : Bool) {
	issues(is, showProjectName, false)
}
template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool) {
	issues(is, showProjectName, showTicks, true)
}
template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool) {
	issues(is, showProjectName, showTicks, showNumbers, 33)
}
template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int) {
	issues(is, showProjectName, showTicks, showNumbers, titleLength, false, false)
}

template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool) {
	issues([i | i : Issue in is.list()  order by i.submitted desc], 
		showProjectName, showTicks, showNumbers, titleLength, showTags, showNrVotes)
}

template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool) {
	block [class := "Listing"] {
		tableBordered {
			for(i : Issue in is) {
				row {
					if(showTicks) {
						column {
							if(!i.open) { 
								//image("/images/tick.png") 
								iOk
							} else { 
								"" 
							}
						}
					}
					if(showNumbers) {
						column { output(i.number) }
					}
					column {
						block[class := "Date"] { output(format(i.submitted)) }
					}
					if(showProjectName) {
						column { 
						  navigate project(i.project) { output(abbreviate(i.project.name, 20)) } }
					}
					column { 
						block[class := "AbbreviatedIssueTitle"] {
							navigate(issue(i.project, i.number)) {
								output(abbreviate(i.getTitle(), titleLength))
							}
							if(showNrVotes && i.nrVotes > 0) {
								" (" output(i.nrVotes) ")"
							}
						}
					}
					if(showTags) { 
						column { tags(i, false, true) }
					}
				}
			}
		}
	}
}


  
	
page editIssue(i : Issue) {
	title{output(i.project.name) " issue #" output(i.number) " on YellowGrass.org [editing]"}
	bmain(i.project){
		pageHeader2{ "Edit Issue " output(i.number) }
		horizontalForm {
			controlGroup("Title") {input(i.title)}
			controlGroup("Description") {input(i.description)}
			formActions{
			  submitlink save() [class="btn btn-primary"] { "Save" }
				navigate issue(i.project, i.number) [class="btn"] {"Cancel"}			
			}
		}
	}
	action save(){
		i.save();
		return issue(i.project, i.number);
	}
}

  page postedIssues() {
	  var postedIssues := 
		  from Issue
		  where _reporter = ~securityContext.principal
		  order by _submitted desc
		  limit 200

	  title{"Issues posted by " output(securityContext.principal.name) " on YellowGrass.org [editing]"}
	  bmain{
		  // par [class := "Back"] { 
			 //  rawoutput { " &raquo; " }
			 //  navigate(home()) {"Home"}
			 //  rawoutput { " &raquo; " }
			 //  "Posted Issues"
		  // }
		  pageHeader2 { "Issues Posted by You" }
		  par { issues(postedIssues.set(), true, true, true, 50, true, true) }
	  }
  }