module issue/emails

imports emails

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
		
		if(reporter != null) {
			mailinglist.add(reporter.email);
		}
		if(reporter == null && email != "") {
			mailinglist.add(email);
		}
		
		var commenters := [(e as Comment).author.email | e : Event in log where e is a Comment];
		mailinglist.addAll(commenters);
		
		var followers : Set<User> := getFollowers(tags);
		mailinglist.addAll([u.email | u : User in followers]);
		
		return mailinglist;
	}
}

define email issueNotification(i : Issue, e : Email) {
	to(e)
	from(EMAIL_FROM())
	subject(i.project.name+" - Issue "+i.number)
	par {	output(i.project.name)
			" #" output(i.number)
			" (" output(format(i.submitted)) ")"
	}
	par {}
	if(i.reporter != null) {
		par { "By " output(i.reporter.name) }
		par {}
	}
	par { output(i.getTitle()) }
	par {}
	par { output(i.description) }
	par {}
	par { " -- " navigate(issue(i.project, i.number)){"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
}


define email issueCloseNotification(i : Issue, e : Email) {
	to(e)
	from(EMAIL_FROM())
	subject(i.project.name+" - Issue "+i.number+" has been closed")
	par {	output(i.project.name)
			" #" output(i.number)
			" (" output(format(i.submitted)) ")"
	}
	par {}
	par { output(i.getTitle()) }
	par {}
	par { "Issue has been closed by " output(securityContext.principal.name) "." }
	par {}
	par { " -- " navigate(issue(i.project, i.number)){"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
}

define email issueReopenNotification(i : Issue, e : Email) {
	to(e)
	from(EMAIL_FROM())
	subject(i.project.name+" - Issue "+i.number+" has been reopened")
	par {	output(i.project.name)
			" #" output(i.number)
			" (" output(format(i.submitted)) ")"
	}
	par {}
	par { output(i.getTitle()) }
	par {}
	par { "Issue has been reopened by " output(securityContext.principal.name) "." }
	par {}
	par { " -- " navigate(issue(i.project, i.number)){"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
}

define email issueCommentNotification(i : Issue, e : Email, c : Comment) {
	to(e)
	from(EMAIL_FROM())
	subject(i.project.name+" - Issue "+i.number+" has received a comment")
	par {	output(i.project.name)
			" #" output(i.number)
			" (" output(format(i.submitted)) ")"
	}
	par {}
	par { output(i.getTitle()) }
	par {}
	par { output(c.author.name) " commented:" }
	par {}
	par { output(c.text) }
	par {}
	par { " -- " navigate(issue(i.project, i.number)){"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
}

define email issueCommentCloseNotification(i : Issue, e : Email, c : Comment) {
	to(e)
	from(EMAIL_FROM())
	subject(i.project.name+" - Issue "+i.number+" has been closed")
	par {	output(i.project.name)
			" #" output(i.number)
			" (" output(format(i.submitted)) ")"
	}
	par {}
	par { output(i.getTitle()) }
	par {}
	par { "Issue has been closed by " output(securityContext.principal.name)", saying:" }
	par {}
	par { output(c.text) }
	par {}
	par { " -- " navigate(issue(i.project, i.number)){"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
}
