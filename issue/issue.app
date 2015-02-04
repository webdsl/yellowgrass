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
    pullRight{
      dueDate(issue)
    }
  }
 
  page issue(p : Project, issueNumber : Int) {
    var i := getIssue(p, issueNumber);
    var nrVotes := i.nrVotes; // Derived props are not cached and executed on demand
  
    title{"#" output(i.number) " " output(i.getTitle()) " (project " output(i.project.name) " on YellowGrass.org)"}
    bmain(p){  
      issueCommandsMenu(i)
      pageHeader2{
        editableString(i.title) {
          " "
          if(nrVotes > 0) { " (" output(nrVotes) ") " } 
          if(!i.open) { iOk }
        }
      }
      gridRow{
        gridCol(12){
          editableText(i.description, i.preview)           
        }
      }
      gridRow{
        gridCol(12){ tagBar(i) }
      }
      gridRow{
        gridCol(12){      
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
      // gridRow{ gridCol(12){ container{
        gridRow(if(!i.open) "issueRow issueRowDone" else "issueRow") { 
          gridCol(projectSpan) { 
            if(!showProjectName) {
              output(i.number)          
            } else {
              navigate project(i.project) [title=i.project.name] { output(abbreviate(i.project.name, 20)) }
            } " "
            pullRight{ div[class := "Date"] { output(format(i.submitted)) } }  
          }
          gridCol(titleSpan + tagsSpan) {
            if(!i.open) { iOk " " } 
              navigate issue(i.project, i.number) [title=i.getTitle()] {
                //output(abbreviate(i.getTitle(), titleLength))    
                output(i.getTitle())      
                if(showNrVotes && i.nrVotes > 0) {
                  " (" output(i.nrVotes) ")"
                }
              }
              if(showTags) { tags(i, true, true, true) } 
          }
         }
      // } } }
    }
  }
  
  template highLightedIssues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool, searcher : IssueSearcher) { 
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
      // gridRow{ gridCol(12){ container{
        gridRow(if(!i.open) "issueRow issueRowDone" else "issueRow") { 
          gridCol(projectSpan) { 
            if(!showProjectName) {
              highlight(searcher, "number"){ output(i.number) }          
            } else {
              navigate project(i.project) [title=i.project.name] { output(abbreviate(i.project.name, 20)) }
            } " "
            pullRight{ div[class := "Date"] { output(format(i.submitted)) } }  
          }
          gridCol(titleSpan + tagsSpan) {
            if(!i.open) { iOk " " } 
              
	            //output(abbreviate(i.getTitle(), titleLength))    
	            
	            	navigate issue(i.project, i.number) [title=i.getTitle()] {
	                	highlight(searcher, "title"){ output(i.getTitle()) }    
		                if(showNrVotes && i.nrVotes > 0) {
		                  " (" output(i.nrVotes) ")"
		                }
	                }
	                if(showTags) { highlight(searcher, "tags.name"){ tags(i, true, true, true)  } } 
	            
	            gridRow{
	            	small{ highlightedSummary(searcher, "description", i.description) }
	            } 
              
              
          }
         }
      // } } }
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
//  			    submitlink save() [ignore default class, class="btn btn-primary"] { "Save" } " " 
//  				  navigate issue(i.project, i.number) [] {"Cancel"}			
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
  
// section due date
// 
//   template dueDate(i: Issue) {
//     placeholder dueDate { dueDateView(i) } 
//   }
//    
//   ajax template dueDateView(i: Issue) {
//     action edit() { 
//       replace(dueDate, dueDateEdit(i)); 
//     } 
//     submitlink edit() [ignore default class, class="btn btn-default " + i.dueWarning()] { 
//       iCalendar 
//       if(i.hasDueDate) {
//         " " output(i.due.format("d MM yyyy")) 
//       }
//     }
//   }
//    
//   ajax template dueDateEdit(i: Issue) {
//     action save() {  
//       i.hasDueDate := true;
//       replace(dueDate, dueDateView(i));
//     }
//     buttonGroup{
//       form{
//         inputAppend{
//           input(i.due)
//           submitlink save() [ignore default class, class="btn btn-primary"] { iCalendar " Save" }
//         }
//       }
//     }
//   }
  
section due date

  template dueDate(i: Issue) {
    div[id="dueDateView"]{ dueDateView(i) } 
    div[id="dueDateEdit", style="display:none;"]{ dueDateEdit(i) } 
  }
   
  ajax template dueDateView(i: Issue) {
  	init{if(i.hasDueDate==null){ i.hasDueDate:=false;}}
    action edit() { 
      visibility("dueDateView", hide);
      visibility("dueDateEdit", show); 
      //replace(dueDate, dueDateEdit(i)); 
    }
    submitlink edit() [
      class=i.dueWarning(), 
      title= if(i.hasDueDate) "Change due date" else "Set due date"
    ] { 
      if(i.hasDueDate) {
        iCalendar
        " " output(i.due.format("d/M/yyyy"))
      } else {
        iCalendar
      }
    }
  }
   
  template dueDateEdit(i: Issue) {
    action save() {  
      i.hasDueDate := true;
      replace("dueDateView", dueDateView(i));
      visibility("dueDateView", show);
      visibility("dueDateEdit", hide);
    }
    action notdue() {
      i.hasDueDate := false;
      replace("dueDateView", dueDateView(i));
      visibility("dueDateView", show);
      visibility("dueDateEdit", hide);     
    }
    buttonGroup{
      form{
        inputAppend{
          input(i.due)
          submitlink save() [ignore default class, class="btn btn-primary"] { "Save" }
          submitlink notdue() [] { "Cancel" }
        }
      }
    }
  }
   
  
  