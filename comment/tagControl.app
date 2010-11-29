module comment/tagControl

imports comment/ac
imports comment/comment

entity TagAddition : Event {
	actor -> User
	tag -> Tag
}

define template tagAddition(ta : TagAddition) {
	block [class := "CommentHeader"] {
		"On " output(ta.moment.format("MMM d")) " " output(ta.actor.name) " tagged " output(ta.tag.name)
	}
}

entity TagRemoval : Event {
	actor -> User
	tag -> Tag
}

define template tagRemoval(tr : TagRemoval) {
	block [class := "CommentHeader"] {
		"On " output(tr.moment.format("MMM d")) " " output(tr.actor.name) " removed tag " output(tr.tag.name)
	}
}
