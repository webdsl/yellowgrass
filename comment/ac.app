module comment/ac
  
access control rules
	
	rule template comments(i : Issue, cs : Set<Comment>) {	
		true
	}
	
	rule page editComment(i : Issue, c : Comment) {
		(c.author != null) 
		&&
		(c.author == securityContext.principal)
	}