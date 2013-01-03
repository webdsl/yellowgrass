module issue/sidebar

section issue commands

  template issueCommandsMenu(i : Issue) {      
    action close(issue : Issue) { issue.close();  }
    action reopen(issue : Issue){ issue.reopen(); }   
    action vote(issue : Issue)  { issue.vote();   }  
    gridRow{
      gridSpan(12){
        pullLeft{     
          buttonToolbar{     
            projectTools(i.project)
          }
        }
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
              nav(i)[class="btn"]        
              navigate   editIssue(i)  [class="btn", title="Edit Issue", style="height:14px;padding:7px;"] { iPencil } 
              attachmentAdditionTool(i)
              //commentAdditionTool(i)
              submitlink close(i)      [class="btn", title="Close Issue", style="height:14px;padding:7px;"] { iOk } 
              submitlink reopen(i)     [class="btn btn-inverse", title="Reopen Issue", style="height:14px;padding:7px;"] { iOkWhite }
              submitlink vote(i)       [class="btn", title="Vote and Follow", style="height:14px;padding:7px;"] { iThumbsUp  }
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
        dropdownMenuItem{ submitlink moveIssue(i, p) { output(p.name) } } 
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

