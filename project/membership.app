module project/membership

define template projectMembershipRequests(p : Project) {
	par { <h2>"Membership Requests"</h2>	}
	for(r : User in p.memberRequests order by r.name) {
		par { 
			navigate(user(r.tag)){output(r.name)}
			" - "
			actionLink("Accept", acceptMembershipRequest(r, p))
			" - "
			actionLink("Decline", declineMembershipRequest(r, p))
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
}
