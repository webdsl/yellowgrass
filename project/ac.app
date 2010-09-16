module project/ac

imports tag/release

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
	
	rule page projectIssues(p : Project, filterOpen : Bool) {
		true
	}
	
	rule page projectUnAssignedIssues(p : Project) {
		true
	}
	
	rule template projects(ps : Set<Project>) {
		true
	}
	
	rule page projectList() {
		true
	}
	
	rule template projectMembershipRequests(p : Project) {
		principal in p.members && 
		p.memberRequests.length > 0
	}
	
	rule template projectSideBar(p : Project) {
		true
	}
	
	rule page projectStats(p : Project) {
		true
	}
	
	rule page roadmap(p : Project) {
		(
			from Tag as t
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
		true
		
		rule action requestJoinProject(p : Project) {
			loggedIn && 
			!(principal in p.members) &&
			!(principal in p.memberRequests)
		}
		
/*		rule action leaveProject(p : Project) {
			principal in p.members &&
			p.members.length > 1
		}
*/	}