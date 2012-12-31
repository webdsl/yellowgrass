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

section navigation

  template nav(i: Issue) {
    navigate issue(i.project, i.number) [all attributes] { "#" output(i.number) }
  }
  
  template reporter(i: Issue) {
    reporter(i, "")
  }
  
  template reporter(i: Issue, prefix: String) {
    if(i.reporter != null) {
      output(prefix) navigate(user(i.reporter.tag)){ output(i.reporter.name) }  " "
    } else { if(i.email != "" && securityContext.principal in i.project.members) {
      output(prefix) output(i.email) " " 
    } }    
  }

section issue page

  page issue(p : Project, issueNumber : Int) {
    var i := getIssue(p, issueNumber);
    var nrVotes := i.nrVotes; // Derived props are not cached and executed on demand
  
    title{"#" output(i.number) " " output(i.getTitle()) " (project " output(i.project.name) " on YellowGrass.org)"}
    bmain(p){  
      issueCommandsMenu(i)
      pageHeader2{
        output(i.getTitle()) " "
        if(nrVotes > 0) { " (" output(nrVotes) ") " } 
        if(!i.open) { iOk }
      }
      gridRow{
        gridSpan(12){
          blockquote { output(i.description) } 
          pullRight{ addTag(i) }          
          tags(i, true) 
          hrule
        }
      }
      gridRow{
        gridSpan(12){             
          par{
            nav(i.project) " issue # " output(i.number)
            " submitted "
            reporter(i, "by ")
            "on " output(format(i.submitted))
          }
        }
      }
      gridRow{
        gridSpan(12){
          hrule
          // output(/\n/.replaceAll("<br />", b1.text) as WikiText)
      
          attachmentList(i)
          attachmentAddition(i)
      
          hrule
      
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
						column { if(!i.open) { iOk } }
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
						column { tags(i, true, true) }
					}
				}
			}
		}
	}
} 


section edit issue 
	
  page editIssue(i : Issue) {
	  title{output(i.project.name) " issue #" output(i.number) " on YellowGrass.org [editing]"}

    action save(){
      return issue(i.project, i.number);
    }
    
    bmain(i.project){
	    issueCommandsMenu(i)
		  pageHeader2{ "Edit Issue " output(i.number) }
		  horizontalForm {
			  controlGroup("Title") { input(i.title) }
			  controlGroup("Description") { 
			    input(i.description)[style="height: 400px;"] 
			  }
			  formActions{
			    submitlink save() [class="btn btn-primary"] { "Save" } " " 
				  navigate issue(i.project, i.number) [class="btn"] {"Cancel"}			
			  }
		  }
	  }
  } 

section issues posted by principal

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