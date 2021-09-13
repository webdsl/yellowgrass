module issue/emails

imports built-in
imports emails
imports comment/-
imports issue/-
imports project/project
imports user/user-model
imports tag/tag-model

  extend entity Issue {
    
	  function mailinglist() : Set<Email> {
		  var mailinglist := Set<Email>();
		  if(project.email != null && project.email != "") {
			  mailinglist.add(project.email);
		  } else {
			  for(u : User in this.project.members) {
				  if(u.notifications) {
					  mailinglist.add(u.email);
				  }
			  }
		  }
		
		  if(reporter != null && reporter.notifications) {
			  mailinglist.add(reporter.email);
		  }
		  if(reporter == null && email != "") {
			  mailinglist.add(email); 
		  }
		
		  var commenters := [(e as Comment).author | e : Event in log where e is a Comment];
		  var commenterEmails := [u.email | u : User in commenters where u.notifications];
		  mailinglist.addAll(commenterEmails); 
		
		  var issueFollowers : Set<User> := getFollowers(tags);
		  mailinglist.addAll([u.email | u : User in issueFollowers where u.notifications]);
		
		  var projectFollowers : Set<User> := project.followers;
		  mailinglist.addAll([u.email | u : User in projectFollowers where u.notifications]); 
		
		  if(securityContext.principal != null) {
			  mailinglist.remove(securityContext.principal.email);
		  }
		
		  return mailinglist;
	  }
	
	  function mailSubject() : String {
		  return project.name + " - Issue #" + number + ": " + title;
	  } 
  }
  
section email templates

  template issueHeader(i: Issue) {
    par { 
      navigate project(i.project) { output(i.project.name) }
      " - " 
      navigate issue(i.project, i.number) { "Issue #" output(i.number) }
      " (" output(i.submitted.format("d MMMM yyyy hh:mm ")) ")"
    }
  }
  
  template issueByLine(i: Issue) {
    if(i.reporter != null) {
      par { "By " output(i.reporter.name) }
      par {}
    }
  }
  
  template issueFooter(i: Issue) {
    par { " -- " output(navigate(issue(i.project, i.number))) }
  }
  
section emails

  email template issueNotification(i : Issue, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(i.mailSubject()) 
    issueHeader(i)
	  par {}
	  issueByLine(i) 
	  par { output(i.getTitle()) }
	  par {}
	  par { "New Issue" }
	  par {}
	  par { output(i.description) }
	  par {}
	  issueFooter(i)
  }

  email template issueCloseNotification(i : Issue, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(i.mailSubject())
    issueHeader(i)
	  par{}
	  par { output(i.getTitle()) }
	  par {}
	  par { "Issue has been closed by " output(securityContext.principal.name) "." }
	  par {}
    issueFooter(i)
  }

  email template issueReopenNotification(i : Issue, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(i.mailSubject())
    issueHeader(i)
	  par {}
	  par { output(i.getTitle()) }
	  par {}
	  par { "Issue has been reopened by " output(securityContext.principal.name) "." }
	  par {}
    issueFooter(i)
  }

  email template issueCommentNotification(i : Issue, e : Email, c : Comment) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(i.mailSubject())
    issueHeader(i)
	  par {}
 	  par { output(i.getTitle()) }
	  par {}
	  par { output(c.author.name) " commented:" }
 	  par {}
	  par { output(c.text) }
	  par {}
    issueFooter(i)
  }

  email template issueCommentCloseNotification(i : Issue, e : Email, c : Comment) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(i.mailSubject())
    issueHeader(i)
	  par {}
	  par { output(i.getTitle()) }
	  par {}
	  par { "Issue has been closed by " output(securityContext.principal.name)", saying:" }
	  par {}
	  par { output(c.text) }
	  par {}
    issueFooter(i)
  }
