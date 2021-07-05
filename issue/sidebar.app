module issue/sidebar

imports built-in
imports issue/-
imports project/-
imports tag/tag

imports elib/-
imports elib-bootstrap-3/icons

section issue commands

  template issueCommandsMenu(i : Issue) {      
    action close(issue : Issue) { issue.close();  }
    action reopen(issue : Issue){ issue.reopen(); }   
    action vote(issue : Issue)  { issue.vote();   }  
    gridRow{
      gridCol(7){
          
          pullLeft{
          	buttonToolbar{     
            	projectTools(i.project)
            }
          }
      }
      gridCol(5){
            pullRight{
	          buttonToolbar{
	            //buttonGroup{        
	              // dropdownCaret{
	              //   dropdownMenuItem{ reporter(i, "") } 
	              //   dropdownMenuItem{ <a href="#">"Submitted on " output(format(i.submitted)) </a> }
	              //   dropdownMenuItem{ if(i.nrVotes > 0) { <a href="#"> output(i.nrVotes) " Votes" </a> } }
	              // }
	            //}
	            buttonGroup{       
	              nav(i)[submit attributes]        
	              //navigate   editIssue(i)  [title="Edit Issue"] { iPencil } 
	              attachmentAdditionTool(i)
	              //commentAdditionTool(i)
	              submitlink close(i)      [title="Close Issue"] { iOk } 
	              submitlink reopen(i)     [ignore default class, class="btn btn-default btn-inverse", title="Reopen Issue"] { iOk }
	              submitlink vote(i)       [title="Vote and Follow"] { iThumbsUp  }
	              issueMoveTargetsMenu(i) 
	              // addTag(i) 
	            }
	          } 
	        }
          
        }
    }
    
  }
  
  template issueMoveTargetsMenu (i : Issue) {
    action moveIssue(old : Issue, p : Project) {
      var new : Issue := old.moveTo(p);
      return issue(p, new.number);
    }
    dropdownButton("Move") {
      for(p : Project in securityContext.principal.projects where p != i.project) {
        dropdownMenuItem{ submitlink moveIssue(i, p)[ignore default class] { output(p.name) } } 
      }
    }
  }
   
section sidebar
 
  template issueSideBar(i : Issue) {
	  div [class = "sidebar"] {
		  //projectCommands(i.project) 
		  //issueCommands(i)
      hrule
      par{ tags(i.project.getCommonTags(80), i.project) }
	  }
  }

  // template issueCommands(i : Issue) {   
  //   pageHeader4{ "Issue " output(i.number) }
	 //  par { navigate   editIssue(i)	 { iPencil " Edit Issue"} }
	 //  par { submitlink close(i)      { iOk " Close Issue" } }
	 //  par { submitlink reopen(i)     { "Reopen Issue" } }
	 //  par { submitlink vote(i)       { iThumbsUp " Vote and Follow" } }
	 //  par { submitlink showIssueMoveTargets(i) { iMove " Move Issue To" } }
	 //  par [class := "IssueMoveTargets"] { 
	 //    placeholder issueMoveTargetsBox {} 
	 //  }
	 //  par { addTag(i) }
	 //  action close(issue : Issue){
		//   issue.close();
		//   return issue(issue.project, issue.number);
	 //  }
	 //  action reopen(issue : Issue){
		//   issue.reopen();
		//   return issue(issue.project, issue.number);
	 //  }   
	 //  action vote(issue : Issue){
		//   issue.vote();
		//   return issue(issue.project, issue.number);
	 //  }
	 //  action showIssueMoveTargets(issue : Issue){
		//   replace(issueMoveTargetsBox, issueMoveTargets(issue));
	 //  }
  // }

  ajax template issueMoveTargets (i : Issue) {
	  for(p : Project in securityContext.principal.projects) {
		  if(p != i.project) {
			  par{ form{ actionLink(p.name, moveIssue(i, p)) [ajax] }}
		  }
	  }
	  action moveIssue(old : Issue, p : Project) {
		//   var new := Issue { // todo: define clone method on Issue
		// 	  title := old.title
		// 	  description := old.description
		// 	  submitted := now()
		// 	  project := p
		// 	  number := newIssueNumber(p)
		// 	  open := true
		// 	  reporter := old.reporter
		// 	  email := old.email
		//   };
		//   new.assign();
		//   new.save();
		// 
		//   old.log.add(
		// 	  IssueMoved {
		// 		  moment := now()
		// 		  actor := securityContext.principal
		// 		  target := new
		// 	  }
		//   );
		//   old.close();
		//   old.save();
		//   flush();
		//   new.notifyRegister();
		  var new : Issue := old.moveTo(p);
		  return issue(p, new.number);
	  }
  }

