module comment/tagControl

imports comment/ac
imports comment/comment

  entity TagAddition : Event {
	  actor -> User
	  tag -> Tag
  }

  template tagAddition(ta : TagAddition) {
	  block [class := "CommentHeader"] {
		  "On " output(format(ta.moment)) " " nav(ta.actor) " tagged " nav(ta.tag)
	  }
  }
 
  entity TagRemoval : Event { 
	  actor -> User
	  tag -> Tag
  }

  template tagRemoval(tr : TagRemoval) {
	  block [class := "CommentHeader"] {
		  "On " output(format(tr.moment)) " " nav(tr.actor) " removed tag " nav(tr.tag)
	  } 
  }
  