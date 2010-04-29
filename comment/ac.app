module comment/ac
  
access control rules
	
	rule page editComment(c : Comment) {
		(c.author != null) 
		&&
		(c.author == securityContext.principal)
	}
	
	rule template commentAddition(i : Issue) {
		loggedIn
	}
	
	rule ajaxtemplate commentAdditionInput(i : Issue) {
		loggedIn
	}
	
	rule template noCommentAddition() {
		!loggedIn
	}
	
	rule template events(es : Set<Event>) {
		true
	}

	rule template eventDescription(e : Event) {
		true
	}
	
	rule template eventDescription(c : Comment) {
		true
	}
	
	rule template eventDescription(ic : IssueClose) {
		true
	}
	
	rule template eventDescription(ic : IssueReopen) {
		true
	}