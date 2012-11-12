module project/members

  template projectMembershipRequests(p : Project) {
	  pageHeader3{ "Membership Requests"}
	  for(r : User in p.memberRequests order by r.name) {
		  par { 
			  navigate(user(r.tag)){output(r.name)}
			  " --- "
			  submitlink acceptMembershipRequest(r, p) [class="btn"] { "Accept" }
			  " - "
			  submitlink declineMembershipRequest(r, p) [class="btn"] { "Decline" }
			  " - "
			  submitlink turnMembershipRequestIntoFollower(r, p) [class="btn"] { "Make follower instead" }
		  }
	  }
	  action acceptMembershipRequest(u : User, p : Project) {
		  p.members.add(u);
		  p.memberRequests.remove(u);
		  tag("@"+u.tag, p);
		  return project(p);
	  }
	  action declineMembershipRequest(u : User, p : Project) {
		  p.memberRequests.remove(u);
		  return project(p);
	  }
	  action turnMembershipRequestIntoFollower(u : User, p : Project) {
		  p.memberRequests.remove(u);
		  p.followers.add(u);
		  email(memberRequestToFollower(p, u.email));
		  return project(p);
	  }
  }

  email template memberRequestToFollower(p : Project, e : Email) {
	  to(e)
	  from(EMAIL_FROM())
	  subject("Your " + p.name + " project membership request")
	  par { 
		  "Unfortunately, the project members of " output(p.name) " could not accept your membership request. "
	 	  "However, they have made you a follower of the project instead. "
		  "You will now receive email updates upon events."
	  }
	  par {}
	  par { " -- http://yellowgrass.org -- " }
  }
  