module issue/emails

define email issueNotification(i : Issue, u : User) {
	to(u.email)
	from("YellowGrass@YellowGrass.org")
	subject(i.project.name+" - Issue "+i.number+" ("+i.type.name+")")
	par {	output(i.project.name)
			" #" output(i.number)
			" - " output(i.type.name)
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
	par {}
	par { output(i.description) }
	par {}
	par { " -- http://yellowgrass.org -- " }
}


define email issueCloseNotification(i : Issue, u : User) {
	to(u.email)
	from("YellowGrass <info@yellowgrass.org>")
	subject(i.project.name+" - Issue "+i.number+" has been closed")
	par {	output(i.project.name)
			" #" output(i.number)
			" - " output(i.type.name)
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
	par {}
	par { "Issue has been closed (" navigate(issue(i.project, i.number)){"Issue on YellowGrass"} ")." }
	par {}
	par { " -- http://yellowgrass.org -- " }
}

define email issueReopenNotification(i : Issue, u : User) {
	to(u.email)
	from("YellowGrass <info@yellowgrass.org>")
	subject(i.project.name+" - Issue "+i.number+" has been closed")
	par {	output(i.project.name)
			" #" output(i.number)
			" - " output(i.type.name)
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) }
	par {}
	par { "Issue has been reopened (" navigate(issue(i.project, i.number)){"Issue on YellowGrass"} ")." }
	par {}
	par { " -- http://yellowgrass.org -- " }
}

define email issueCommentNotification(i : Issue, u : User, c : Comment) {
	to(u.email)
	from("YellowGrass <info@yellowgrass.org>")
	subject(i.project.name+" - Issue "+i.number+" has received a comment")
	par {	output(i.project.name)
			" #" output(i.number)
			" - " output(i.type.name)
			" (" output(i.submitted.format("MMM d yyyy")) ")"
	}
	par {}
	par { output(i.title) " (" navigate(issue(i.project, i.number)){"Issue on YellowGrass"} ")"}
	par {}
	par { output(c.author.name) " commented:" }
	par {}
	par { output(c.text) }
	par {}
	par { " -- http://yellowgrass.org -- " }
}
