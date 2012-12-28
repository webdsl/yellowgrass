module issue/sidebar
  
  template issueSideBar(i : Issue) {
	  div [class = "sidebar"] {
		  //projectCommands(i.project) 
		  issueCommands(i)
      hrule
      par{ tags(i.project.getCommonTags(80), i.project) }
	  }
  }

  template issueCommands(i : Issue) {   
    pageHeader4{ "Issue " output(i.number) }
	  par { navigate   editIssue(i)	 { iPencil " Edit Issue"} }
	  par { submitlink close(i)      { iOk " Close Issue" } }
	  par { submitlink reopen(i)     { "Reopen Issue" } }
	  par { submitlink vote(i)       { iThumbsUp " Vote and Follow" } }
	  par { submitlink showIssueMoveTargets(i) { iMove " Move Issue To" } }
	  par [class := "IssueMoveTargets"] { 
	    placeholder issueMoveTargetsBox {} 
	  }
	  par { addTag(i) }
	  action close(issue : Issue){
		  issue.close();
		  issue.save();
		  issue.notifyClose();
		  return issue(issue.project, issue.number);
	  }
	  action reopen(issue : Issue){
		  issue.reopen();
		  issue.save();
		  issue.notifyReopen();
		  return issue(issue.project, issue.number);
	  } 
	  action vote(issue : Issue){
		  var tag := tag("!" + securityContext.principal.tag, issue.project);
		  issue.addTag(tag);
		  return issue(issue.project, issue.number);
	  }
	  action showIssueMoveTargets(issue : Issue){
		  replace(issueMoveTargetsBox, issueMoveTargets(issue));
	  }
  }

  ajax template issueMoveTargets (i : Issue) {
	  for(p : Project in securityContext.principal.projects) {
		  if(p != i.project) {
			  par{ form{ actionLink(p.name, moveIssue(i, p)) [ajax] }}
		  }
	  }
	  action moveIssue(old : Issue, p : Project) {
		  var new := Issue { // todo: define clone method on Issue
			  title := old.title
			  description := old.description
			  submitted := now()
			  project := p
			  number := newIssueNumber(p)
			  open := true
			  reporter := old.reporter
			  email := old.email
		  };
		  new.assign();
		  new.save();
		
		  old.log.add(
			  IssueMoved {
				  moment := now()
				  actor := securityContext.principal
				  target := new
			  }
		  );
		  old.close();
		  old.save();
		  flush();
		  new.notifyRegister();
		  return issue(p, new.number);
	  }
  }

