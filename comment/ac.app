module comment/ac

imports comment/tagControl

access control rules
	
	rule page editComment(c : Comment) {
		(c.author != null) &&
		(c.author == securityContext.principal)
	}
	
	rule template commentAddition(i : Issue) {
		loggedIn
	}
	
  // rule template commentAdditionTool(i : Issue) {
  //   loggedIn
  // }
  	
	rule ajaxtemplate commentAdditionInput(i : Issue) {
		loggedIn && mayAccess(i.project)
		
		rule action comment(text : WikiText, issue : Issue) {
			loggedIn && 
			mayAccess(issue.project)
		}
	
		rule action commentClose(text : WikiText, issue : Issue) {
			loggedIn && 
			principal in issue.project.members && 
			issue.open
		}
	}
	
	rule template noCommentAddition() {
		!loggedIn
	}
	
	rule template issueMoved(im : IssueMoved) {
		!im.target.project.private || 
		principal in im.target.project.members
	}
	