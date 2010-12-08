module issue/emails

imports emails

define email issueNotification(i : Issue, e : Email) {
	to(e)
	from(EMAIL_FROM())
	subject(i.project.name+" - Issue "+i.number)
	par {	output(i.project.name)
			" #" output(i.number)
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	if(i.reporter != null) {
		par { "By " output(i.reporter.name) }
		par {}
	}
	par { output(i.title) }
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
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
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
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
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
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
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
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
	par {}
	par { "Issue has been closed by " output(securityContext.principal.name)", saying:" }
	par {}
	par { output(c.text) }
	par {}
	par { " -- " navigate(issue(i.project, i.number)){"Issue on YellowGrass"} " -- http://yellowgrass.org -- " }
}
