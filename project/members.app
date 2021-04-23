module project/members

section members and followers

  extend entity Project {  
    followers        -> Set<User> 
    members          -> Set<User>
    memberRequests   -> Set<User>
    
    function addMember(u: User) {
      members.add(u);
      followers.remove(u); 
      memberRequests.remove(u);
      tag("@"+u.tag, this);
      if(notifications){
        email membershipNotification(this, u);
      }
    }    
    function requestJoin() {
      var u: User := securityContext.principal;
      memberRequests.add(u);
      if(notifications){
        for(member: User in members) {
          email membershipRequest(this, u, member);
        }
      }
    }
    function declineMembershipRequest(u: User) {
      memberRequests.remove(u);
      if(notifications){
        email membershipDeclined(this, u);
      }
    }
    function acceptRequestAsFollower(u: User) {
      memberRequests.remove(u);
      followers.add(u);
      if(notifications){
        email memberRequestToFollower(this, u.email);
      }
    }
    function follow() {
      followers.add(securityContext.principal);
    }
    function unfollow() {
      followers.remove(securityContext.principal);
    }
  }

section memberhship invitation

  template inviteMember(p: Project) {
    var query: String
    action showCandidates() {
      replace("candidatesMenu", invitationCandidates(p, query));
    }   
    pageHeader2{ "Invite Registered User as Member" } 
    gridRow{ gridCol(5){ buttonGroup{
      form{
        inputPrepend{
          span[class="input-group-addon"]{ iUser } 
          input(query)[placeholder="Name of new member", onkeyup=showCandidates()]
        }
      }
    }
    placeholder "candidatesMenu" { } 
    } }
  }
  
  ajax template invitationCandidates(p: Project, query: String) {
    var candidates : List<User> := searchUser(query)
    action add(u: User) {
      p.addMember(u); 
    }
    div[class="dropdown open"]{   
      dropdownMenu{
        for(u : User in candidates where !(u in p.members)) {
          dropdownMenuItem{ 
            submitlink add(u) { output(u.name) } 
          } 
        }
      }
    }
  }
 
section membership request

  template projectMembershipRequests(project : Project) {
	  pageHeader3{ "Membership Requests"}
	  for(r : User in project.memberRequests order by r.name) {
		  par { 
		    buttonGroup{
			    navigate user(r.tag) [submit attributes] { output(r.name) }
			    submitlink acceptMembershipRequest(r, project) [ignore default class, class="btn btn-success"] { "Accept" }
			    submitlink declineMembershipRequest(r, project) [ignore default class, class="btn btn-danger"] { "Decline" }
			    submitlink turnMembershipRequestIntoFollower(r, project) [ignore default class, class="btn btn-info"] { "Make follower instead" }
		    }
		  }
	  }
	  action acceptMembershipRequest(u : User, p : Project) {
      p.addMember(u);
		  return project(p);
	  }
	  action declineMembershipRequest(u : User, p : Project) {
		  p.declineMembershipRequest(u);
		  return project(p);
	  }
	  action turnMembershipRequestIntoFollower(u : User, p : Project) {
      p.acceptRequestAsFollower(u);
		  return project(p);
	  }
  }
  
section emails

  email template membershipRequest(p: Project, u: User, member: User) {
    to(member.email)
    from(EMAIL_FROM())
    subject("Membership request for the " + p.name + " project on YellowGrass")
    par{
      "Dear " output(member.name) ","
    }
    par {}
    par{
      output(u.name) " has requested membership of the " nav(p) " project on "
      navigate root() { "YellowGrass" } "."
      "You can accept or decline this request on the " nav(p) " project page."
    }
    par {}
    par { " -- http://yellowgrass.org -- " }
  }
  
  email template membershipNotification(p: Project, u: User) {
    to(u.email)
    from(EMAIL_FROM())
    subject("Welcome to the " + p.name + " project on YellowGrass") 
    par{
      "Dear " output(u.name) "," 
    }
    par {}
    par{
      "You are now a member of the " nav(p) " project on the "
      navigate root() { "YellowGrass" } " issue tracker."
      "You can now manage issues for the project. "
      "You will receive email notifications upon events if you have email notification turned on in your profile."
    }
    par {}
    par { " -- http://yellowgrass.org -- " }
  }

  email template membershipDeclined(p: Project, u: User) {
    to(u.email)
    from(EMAIL_FROM())
    subject("Your " + p.name + " project membership request")
    par{
      "Dear " output(u.name) ","
    }
    par {}
    par{
      "Unfortunately, the project members of " output(p.name) 
      " have not accepted your membership request for the "
      nav(p) " project on YellowGrass."  
    }
    par {}
    par { " -- http://yellowgrass.org -- " }
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
  