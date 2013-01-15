module questions/question-emails

imports emails 

  extend entity Question {
    
	  function mailinglist() : Set<Email> {
		  var mailinglist := Set<Email>();
		  if(project.email != null && project.email != "") {
			  mailinglist.add(project.email);
		  } else {
			  // for(u : User in this.project.members) {
				 //  if(u.notifications) {
					//   mailinglist.add(u.email);
				 //  }
			  // }
			  mailinglist.addAll([u.email | u: User in project.members where u.notifications]);
		  }
		 
		  if(author != null && author.notifications) {
			  mailinglist.add(author.email);
		  }
		  if(author == null && email != "") {
			  mailinglist.add(email); 
		  }
		 
		  var answerersEmails := [a.author.email | a : Answer in answers where a.author.notifications];
		  mailinglist.addAll(answerersEmails); 
		
		  // var issueFollowers : Set<User> := getFollowers(tags);
		  // mailinglist.addAll([u.email | u : User in issueFollowers where u.notifications]);
		
		  var projectFollowers : Set<User> := project.followers;
		  mailinglist.addAll([u.email | u : User in projectFollowers where u.notifications]); 
		
		  if(securityContext.principal != null) {
			  mailinglist.remove(securityContext.principal.email);
		  }
		
		  return mailinglist;
	  } 
	
	  function mailSubject() : String {
		  return project.name + " - Question " + number;
	  }
	  
    function notifyQuestion() {
      for(e : Email in mailinglist()){
        email questionNotification(this, e);
      }
    }
    function notifyAnswer(a: Answer) {
      for(e : Email in mailinglist()){
        email questionAnswerNotification(this, e, a);
      }  
    }    
    function notifyClose() {
      for(e : Email in mailinglist()){
        email questionCloseNotification(this, e);
      }
    }
    function notifyReopen() {
      for(e : Email in mailinglist()){
        email questionReopenNotification(this, e);
      }
    }
  }
  
section email templates

  template questionHeader(q: Question) {
    par { 
      navigate project(q.project) { output(q.project.name) }
      " " 
      navigate question(q.project, q.number) { "#" output(q.number) }
      " (" output(q.created.format("MMM hh:mm ")) ")"
    }
  }
  
  template questionByLine(q: Question) {
    if(q.author != null) {
      par { "By " output(q.author.name) }
      par {}
    }
  }
  
  template questionFooter(q: Question) {
    par { " -- " navigate question(q.project, q.number) {"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
    par { " -- " output(navigate(issue(q.project, q.number))) }
  }
  
section emails

  email template questionNotification(q: Question, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(q.mailSubject())
    questionHeader(q)
	  par {}
	  questionByLine(q) 
	  par { output(q.title) }
	  par {}
	  par { output(q.description) }
	  par {}
	  questionFooter(q)
  } 

  email template questionCloseNotification(q: Question, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(q.mailSubject())
    questionHeader(q)
	  par{}
	  par { output(q.title) }
	  par {}
	  par { "Question has been closed by " output(securityContext.principal.name) "." }
	  par {}
    questionFooter(q)
  }

  email template questionReopenNotification(q: Question, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(q.mailSubject())
    questionHeader(q)
	  par {}
	  par { output(q.title) }
	  par {}
	  par { "Issue has been reopened by " output(securityContext.principal.name) "." }
	  par {}
    questionFooter(q)
  } 

  email template questionAnswerNotification(q: Question, e : Email, a: Answer) {
	  to(e)
	  from(EMAIL_FROM())
	  subject(q.mailSubject())
    questionHeader(q)
	  par {}
 	  par { output(q.title) }
	  par {}
	  par { output(a.author.name) " answered:" }
 	  par {}
	  par { output(a.text) }
	  par {}
    questionFooter(q)
  }

  // email template questionCommentCloseNotification(q: Question, e : Email, c : Comment) {
	 //  to(e)
	 //  from(EMAIL_FROM())
	 //  subject(q.mailSubject())
  //   questionHeader(q)
	 //  par {}
	 //  par { output(q.title) }
	 //  par {}
	 //  par { "Question has been closed by " output(securityContext.principal.name)", saying:" }
	 //  par {}
	 //  par { output(c.text) }
	 //  par {}
  //   questionFooter(q)
  // }
