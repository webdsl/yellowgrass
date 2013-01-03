module comment/issueControl

imports comment/ac
imports comment/comment

  entity IssueClose : Event {
	  actor -> User
  }

  template issueClose(ic : IssueClose) {
	  block [class := "CommentHeader"] {
		  "On " output(ic.moment.format("d MMMM yyyy 'at' HH:mm")) " " nav(ic.actor) " closed this issue."
	  } 
  }
 
  entity IssueReopen : Event {
	  actor -> User
  }

  template issueReopen(ic : IssueReopen) {
	  block [class := "CommentHeader"] {
		  "On " output(ic.moment.format("d MMMM yyyy 'at' HH:mm")) " " nav(ic.actor) " reopened this issue."
	  }
  } 

  entity IssueMoved : Event {
	  actor -> User
	  target -> Issue 
  }

  template issueMoved(im : IssueMoved) {
	  block [class := "CommentHeader"] {
		  "On " output(im.moment.format("d MMMM yyyy 'at' HH:mm")) " " nav(im.actor) " moved this issue to " 
		  navigate issue(im.target.project, im.target.number) { "issue " output(im.target.number) }
		  " on project " nav(im.target.project)  
	  }
  }
  