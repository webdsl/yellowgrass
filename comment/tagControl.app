module comment/tagControl

imports comment/ac
imports comment/comment

  entity TagAddition : Event {
	  actor -> User
	  tag -> Tag
  }

  template tagAddition(ta : TagAddition) {
	  block [class := "CommentHeader"] {
		  "On " output(format(ta.moment)) " " output(ta.actor.name) " tagged " output(ta.tag.name)
	  }
  }

  entity TagRemoval : Event {
	  actor -> User
	  tag -> Tag
  }

  template tagRemoval(tr : TagRemoval) {
	  block [class := "CommentHeader"] {
		  "On " output(format(tr.moment)) " " output(tr.actor.name) " removed tag " output(tr.tag.name)
	  }
  }
