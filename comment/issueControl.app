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