module comment/issueControl

imports comment/ac
imports comment/comment

entity IssueClose : Event {
	actor -> User
}

define template issueClose(ic : IssueClose) {
	block [class := "CommentHeader"] {
		"On " output(ic.moment.format("MMM d")) " " output(ic.actor.name) " closed this issue."
	}
}

entity IssueReopen : Event {
	actor -> User
}

define template issueReopen(ic : IssueReopen) {
	block [class := "CommentHeader"] {
		"On " output(ic.moment.format("MMM d")) " " output(ic.actor.name) " reopened this issue."
	}
}

entity IssueMoved : Event {
	actor -> User
	target -> Issue
}

define template issueMoved(im : IssueMoved) {
	block [class := "CommentHeader"] {
		"On " output(im.moment.format("MMM d")) " " output(im.actor.name) " moved this issue to " 
		navigate(issue(im.target.project, im.target.number)){"issue " output(im.target.number)}
		" on project " output(im.target.project.name)
	}
}