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

  template byline(issue: Issue) {
    "Submitted "
    reporter(issue, "by ")
    "on " output(issue.submitted.format("d MMMM yyyy 'at' HH:mm"))
  }  
 
  page issue(p : Project, issueNumber : Int) {
    var i := getIssue(p, issueNumber);
    var nrVotes := i.nrVotes; // Derived props are not cached and executed on demand
  
    title{"#" output(i.number) " " output(i.getTitle()) " (project " output(i.project.name) " on YellowGrass.org)"}
    bmain(p){  
      issueCommandsMenu(i)
      pageHeader2{
        editableString(i.title) " "
        if(nrVotes > 0) { " (" output(nrVotes) ") " } 
        if(!i.open) { iOk }         
      } 
      // gridRow{
      //   gridSpan(12) { 
      //     pullRight{ small{ par{
      //       "Submitted "
      //       reporter(i, "by ")
      //       "on " output(i.submitted.format("d MMMM yyyy 'at' HH:mm"))
      //     } } }
      //   }
      // }
      gridRow{
        gridSpan(12){
          editableText(i.description, i.preview)  
          pullRight{ addTag(i) }          
          tags(i, true, false, false)  
        }
      }
      gridRow{
        gridSpan(12){      
          attachmentList(i)
          //attachmentAddition(i)
            
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
    var projectSpan := 2;
    var titleSpan := 6;
    var tagsSpan := 4;
    init{
      if(showProjectName && showTags) {
        projectSpan := 4;
        titleSpan := 5; 
        tagsSpan := 3;
      }
      if(showProjectName && !showTags) {
        projectSpan := 4;
        titleSpan := 8;
        tagsSpan := 0;
      }
    }
    for(i : Issue in is) {
      gridRow{ gridSpan(12){ container{
        gridRow(if(!i.open) "issueRow issueRowDone" else "issueRow") { 
          gridSpan(projectSpan) { 
            if(!showProjectName) {
              output(i.number)          
            } else {
              navigate project(i.project) [title=i.project.name] { output(abbreviate(i.project.name, 20)) }
            } " "
            pullRight{ div[class := "Date"] { output(format(i.submitted)) } }  
          }
          gridSpan(titleSpan + tagsSpan) {
            if(!i.open) { iOk " " } 
              navigate issue(i.project, i.number) [title=i.getTitle()] {
                output(abbreviate(i.getTitle(), titleLength))          
                if(showNrVotes && i.nrVotes > 0) {
                  " (" output(i.nrVotes) ")"
                }
              }
              if(showTags) { tags(i, true, true, true) } 
          }
         }
      } } }
    }
  }

// section edit issue 
// 	
//    page editIssue(i : Issue) {
//  	  title{output(i.project.name) " issue #" output(i.number) " on YellowGrass.org [editing]"}
//  
//      action save(){
//        return issue(i.project, i.number);
//      }
//      action ignore-validation updateIssuePreview(d : WikiText) {
//        replace(issuePreview, issuePreview(d));
//      }
//          
//      bmain(i.project){
//  	    issueCommandsMenu(i)
//  		  pageHeader2{ "Edit Issue " output(i.number) }
//  		  horizontalForm {
//  			  controlGroup("Title") { input(i.title) }
//  			  controlGroup("Description") {  
//  			    input(i.description)[onkeyup := updateIssuePreview(i.description), style="height: 400px;"] 
//  			  }
//  			  placeholder issuePreview {} 
//  			  formActions{
//  			    submitlink save() [class="btn btn-primary"] { "Save" } " " 
//  				  navigate issue(i.project, i.number) [class="btn"] {"Cancel"}			
//  			  }
//  		  }
//  	  }
//   }

section issues posted by principal

  page postedIssues() {
	  var postedIssues := 
		  from Issue
		  where _reporter = ~securityContext.principal
		  order by _submitted desc
		  limit 200

	  title{"Issues posted by " output(securityContext.principal.name) " on YellowGrass.org [editing]"}
	  bmain{
	    buttonToolbar{ homeToolbar(securityContext.principal) }    
		  pageHeader2 { "Issues Posted by You" }
		  par { issues(postedIssues.set(), true, true, true, 50, true, true) }
	  }
  }
  