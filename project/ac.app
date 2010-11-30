module project/ac

imports tag/release

access control rules
	
	predicate mayAccess(p : Project){
		( !p.private ) || 
		securityContext.principal in p.members
	}
	
	rule page project(p : Project) {	
		mayAccess(p)
	}
		
	rule page edit(p : Project) {
		principal in p.members
		rule action save() {
			principal in p.members
		}
		rule action leaveProject(p : Project) {
			principal in p.members &&
			p.members.length > 1
		}
		rule action regenerateIssueTypes(p : Project) {
			principal in p.members
		}
	}
	
	rule page registerProject() {
		loggedIn
	}
	
	rule page projectIssues(p : Project, filterOpen : Bool) {
		mayAccess(p)
	}
	
	rule page projectUnAssignedIssues(p : Project) {
		mayAccess(p)
	}
	
	rule template projects(ps : List<Project>) {
		mayAccess(ps)
	}
	
	rule page projectList() {
		true
	}
	
	rule template projectMembershipRequests(p : Project) {
		principal in p.members && 
		p.memberRequests.length > 0
	}
	
	rule template projectSideBar(p : Project) {
		mayAccess(p)
	}
	
	rule page projectStats(p : Project) {
		mayAccess(p)
	}
	
	rule page roadmap(p : Project) {
		mayAccess(p) &&
		(	from Tag as t
			left join t.tags as ts
			where t._project=~p and ts._name=~"release"
			limit 1
		).length > 0
		
		rule action postponeOpen(project : Project, release : Tag) {
			principal in project.members && 
			isRelease(release) && 
			!releaseDone(project, release) &&
			nextRelease(project, release) != null
		}
	}
	
	rule template projectCommands(p : Project) {
		mayAccess(p)
		
		rule action requestJoinProject(p : Project) {
			loggedIn && 
			!(principal in p.members) &&
			!(principal in p.memberRequests)
		}
	}