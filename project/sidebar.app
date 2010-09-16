module project/sidebar

define template projectSideBar(p : Project) {
	block [class := "sidebar"] {
		projectCommands(p)
		sidebarSeparator()
		par { output( p.description + " " + p.url ) }
		par { image(p.getWeeklyStatsGraph()) }
		par { <i> "Weekly Issue Count" </i> }
	}
}

define template projectCommands(p : Project) {
	par { <h1> output(p.name) </h1> } 
	par { navigate(createIssue(p))	{"New Issue"} }
	par { navigate(edit(p))			{"Project Settings"} }
	par { navigate(roadmap(p)) 		{"Project Roadmap"} }
//	par { actionLink("Leave Project", leaveProject(p)) }
	par { actionLink("Request Project Membership", requestJoinProject(p)) }
	
	action requestJoinProject(p : Project) {
		p.memberRequests.add(securityContext.principal);
		message("Project membership requested, awaiting project member approval...");
		return project(p);
	}
/*	action leaveProject(p : Project) {
		p.members.remove(securityContext.principal);
		tagCleanup(tag("@"+securityContext.principal.tag, p));
		return home(securityContext.principal);
	}
*/
}