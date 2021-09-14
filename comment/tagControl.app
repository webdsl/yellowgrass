module comment/tagControl

imports comment/-
imports tag/-
imports user/-

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
  