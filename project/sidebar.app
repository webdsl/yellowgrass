module project/sidebar

  template projectSideBar(p : Project) {
  	div[class="sidebar"]{
		  projectCommands(p)
		  // par { image(p.getWeeklyStatsGraph()) }
		  // par { <i> "Weekly Issue Count" </i> }
      hrule
		  par{ tags(p.getCommonTags(80), p) }
		}
  }

  template projectCommands(p : Project) {
    
    action followProject(p : Project) {
      p.followers.add(securityContext.principal);
      message("You will now receive email updates upon events in this project");
      return project(p);
    }
  
    action unfollowProject(p : Project) {
      p.followers.remove(securityContext.principal);
      message("You will no longer receive email updates upon events in this project");
      return project(p);
    }
  
    action requestJoinProject(p : Project) {
      p.memberRequests.add(securityContext.principal);
      message("Project membership requested, awaiting project member approval...");
      return project(p);
    }
      
    pageHeader4{ navigate project(p) { output(abbreviateNE(p.name,12)) } }
    par {  navigate createIssue(p)          { iPlus " New Issue" } }        
    par {  navigate roadmap(p)              { iRoad " Roadmap"} }   
    par {  navigate projectIssues(p, true)  { iList " Open issues"} } 
    par {  navigate projectIssues(p, false) { iList " All issues"} } 	  
	  par { navigate edit(p) 			           { iWrench " Project Settings"} }
	  	  
	  par { submitlink followProject(p)      { "Follow Project" } }
	  par { submitlink unfollowProject(p)    { "Unfollow Project" } }
	  par { submitlink requestJoinProject(p) { "Request Project Membership" } }
	
  }
  