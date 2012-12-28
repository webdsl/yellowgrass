module project/sidebar

  template projectMenu(p: Project) {
    action followProject(p : Project) {
      p.follow();
      message("You will now receive email updates upon events in this project");
    } 
    action unfollowProject(p : Project) {
      p.unfollow();
      message("You will no longer receive email updates upon events in this project");
    }  
    action requestJoinProject(p : Project) {
      p.requestJoin();
      message("Project membership requested, awaiting project member approval...");
    }
      
    dropdownInNavbar(abbreviateNE(p.name,12)) {
      dropdownMenu{  
        dropdownMenuItem { navigate project(p) { output(abbreviateNE(p.name,12)) } }
        dropdownMenuItem { navigate createIssue(p)          { iPlus " New Issue" } }        
        dropdownMenuItem { navigate roadmap(p)              { iRoad " Roadmap"} }   
        dropdownMenuItem { navigate projectIssues(p, true)  { iList " Open issues"} } 
        dropdownMenuItem { navigate projectIssues(p, false) { iList " All issues"} }    
        dropdownMenuItem { navigate edit(p)                 { iWrench " Project Settings"} }
        
        dropdownMenuItem { submitlink followProject(p)      { "Follow Project" } }
        dropdownMenuItem { submitlink unfollowProject(p)    { "Unfollow Project" } }
        dropdownMenuItem { submitlink requestJoinProject(p) { "Request Project Membership" } }
      }
    }
  }

  template projectSideBar(p : Project) {
  	div[class="sidebar"]{
		  //projectCommands(p)
		  // par { image(p.getWeeklyStatsGraph()) }
		  // par { <i> "Weekly Issue Count" </i> }
      //hrule
		  par{ tags(p.getCommonTags(80), p) }
		}
  }

 //  template projectCommands(p : Project) {
 //    
 //    action followProject(p : Project) {
 //      p.follow();
 //      message("You will now receive email updates upon events in this project");
 //    }
 //  
 //    action unfollowProject(p : Project) {
 //      p.unfollow();
 //      message("You will no longer receive email updates upon events in this project");
 //    }
 //  
 //    action requestJoinProject(p : Project) {
 //      p.requestJoin();
 //      message("Project membership requested, awaiting project member approval...");
 //    }
 //      
 //    pageHeader4{ navigate project(p) { output(abbreviateNE(p.name,12)) } }
 //    par {  navigate createIssue(p)          { iPlus " New Issue" } }        
 //    par {  navigate roadmap(p)              { iRoad " Roadmap"} }   
 //    par {  navigate projectIssues(p, true)  { iList " Open issues"} } 
 //    par {  navigate projectIssues(p, false) { iList " All issues"} } 	  
	//   par { navigate edit(p) 			           { iWrench " Project Settings"} }
	//   	  
	//   par { submitlink followProject(p)      { "Follow Project" } }
	//   par { submitlink unfollowProject(p)    { "Unfollow Project" } }
	//   par { submitlink requestJoinProject(p) { "Request Project Membership" } }
	// 
 //  }
  