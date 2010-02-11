module project/ac
  
access control rules
	
	rule page project(p : Project) {	
		true
	}
		
	rule page edit(p : Project) {
		principal in p.members
	}
	
	rule page registerProject() {
		loggedIn
	}
	
	rule page projectIssues(p : Project) {
		true
	}
	
	rule template projects(ps : Set<Project>) {
		true
	}
	
	rule page projectList() {
		true
	}
	
	rule action requestJoinProject(p : Project) {
		loggedIn && 
		!(principal in p.members) &&
		!(principal in p.memberRequests)
	}
	
	rule action leaveProject(p : Project) {
		principal in p.members &&
		p.members.length > 1
	}
	
	rule template projectMembershipRequests(p : Project) {
		principal in p.members && 
		p.memberRequests.length > 0
	}