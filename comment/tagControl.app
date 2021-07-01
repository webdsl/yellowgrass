module comment/tagControl

imports built-in
imports comment/ac
imports comment/comment
imports comment/event
imports tag/tag
imports tag/tag-model
imports user/user
imports user/user-model

  entity TagAddition : Event {
	  actor -> User
	  tag -> Tag
  }

  template tagAddition(ta : TagAddition) {
	  block [class := "CommentHeader"] {
		  "On " output(ta.moment.format("d MMMM yyyy 'at' HH:mm")) " " nav(ta.actor) " tagged " nav(ta.tag)
	  }
  }
  
  entity TagRemoval : Event { 
	  actor -> User
	  tag -> Tag
  }

  template tagRemoval(tr : TagRemoval) {
	  block [class := "CommentHeader"] {
		  "On " output(tr.moment.format("d MMMM yyyy 'at' HH:mm")) " " nav(tr.actor) " removed tag " nav(tr.tag)
	  }  
  }
  