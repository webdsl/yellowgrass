module project/sidebar

section project toolbar

  template projectToolbar(p: Project) {
    gridRow{
      gridSpan(12){
        pullLeft{     
          buttonToolbar{ 
            projectTools(p)
          }
        }
      }
    }    
  }
   
  template projectButton(p: Project) {
    buttonGroup{     
      navigate project(p) [class="btn", title=(if(p.private) "Private " else "") + "Project " + p.name] { 
        if(p.private) { iLock " " }
        output(abbreviateNE(p.name,12)) 
      }
    }
  }

  template projectTools(p: Project) {
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
    
    projectButton(p)
    
    buttonGroup{ 
      navigate questions(p) [class="btn"] { "Q&A" }
    }
    buttonGroup{     
      navigate createIssue(p)          [class="btn", title="New Issue", style="height:14px;padding:7px;"] { iPlus  }        
      navigate roadmap(p)              [class="btn", title="Roadmap", style="height:14px;padding:7px;"] { iRoad }    
      navigate projectIssues(p, true)  [class="btn", title=" Open issues", style="height:14px;padding:7px;"] { iList }  
      navigate projectIssues(p, false) [class="btn", title=" All issues", style="height:14px;padding:7px;"] { iListAlt }     
      navigate edit(p)                 [class="btn", title=" Project Settings", style="height:14px;padding:7px;"] { iWrench } 
        
      submitlink followProject(p)      [class="btn", title="Follow Project", style="height:14px;padding:7px;"] { iStarEmpty  }  
      submitlink unfollowProject(p)    [class="btn", title="Unfollow Project", style="height:14px;padding:7px;"] { iStar } 
      submitlink requestJoinProject(p) [class="btn", title="Request Project Membership", style="height:14px;padding:7px;"] { iUser }     
    }
    searchBoxInToolbar(p, "")
  }
  
  template searchBoxInToolbar(p: Project, q: String) {
    var query : String := q
    action search(q: String) { return search(p, q); }
    buttonGroup{
      form{
        inputAppend{
          input(query)[placeholder="Search", class="span2"]  
          submit search(query) [class="btn", style="height:18px; padding:5px; margin:0px;display:none;"] { "Search" }
          submitlink search(query) [class="btn", style="height:18px; padding:5px; margin:0px;"] { iSearch }
        }
      }
    }
  }
  
  // template projectDropdown(p: Project) {
  //   action followProject(p : Project) {
  //     p.follow();
  //     message("You will now receive email updates upon events in this project");
  //   } 
  //   action unfollowProject(p : Project) {
  //     p.unfollow();
  //     message("You will no longer receive email updates upon events in this project");
  //   }  
  //   action requestJoinProject(p : Project) {
  //     p.requestJoin();
  //     message("Project membership requested, awaiting project member approval...");
  //   }
  //   
  //   navigate project(p) [class="btn"] { output(abbreviateNE(p.name,12)) }
  //   dropdownCaret { 
  //       dropdownMenuItem { navigate createIssue(p)          { iPlus " New Issue" } }        
  //       dropdownMenuItem { navigate roadmap(p)              { iRoad " Roadmap"} }   
  //       dropdownMenuItem { navigate projectIssues(p, true)  { iList " Open issues"} } 
  //       dropdownMenuItem { navigate projectIssues(p, false) { iList " All issues"} }    
  //       dropdownMenuItem { navigate edit(p)                 { iWrench " Project Settings"} }
  //       
  //       dropdownMenuItem { submitlink followProject(p)      { "Follow Project" } }
  //       dropdownMenuItem { submitlink unfollowProject(p)    { "Unfollow Project" } }
  //       dropdownMenuItem { submitlink requestJoinProject(p) { "Request Project Membership" } }
  //   }
  // }
  
section project menu

  template projectMenu(p: Project) {
    //searchBox(p, "")
  }
   
section old code

  // template projectMenuOld(p: Project) {
  //   action followProject(p : Project) {
  //     p.follow();
  //     message("You will now receive email updates upon events in this project");
  //   } 
  //   action unfollowProject(p : Project) {
  //     p.unfollow();
  //     message("You will no longer receive email updates upon events in this project");
  //   }  
  //   action requestJoinProject(p : Project) {
  //     p.requestJoin();
  //     message("Project membership requested, awaiting project member approval...");
  //   }
  //     
  //   dropdownInNavbar(abbreviateNE(p.name,12)) {
  //     dropdownMenu{  
  //       dropdownMenuItem { navigate project(p) { output(abbreviateNE(p.name,12)) } }
  //       dropdownMenuItem { navigate createIssue(p)          { iPlus " New Issue" } }        
  //       dropdownMenuItem { navigate roadmap(p)              { iRoad " Roadmap"} }   
  //       dropdownMenuItem { navigate projectIssues(p, true)  { iList " Open issues"} } 
  //       dropdownMenuItem { navigate projectIssues(p, false) { iList " All issues"} }    
  //       dropdownMenuItem { navigate edit(p)                 { iWrench " Project Settings"} }
  //       
  //       dropdownMenuItem { submitlink followProject(p)      { "Follow Project" } }
  //       dropdownMenuItem { submitlink unfollowProject(p)    { "Unfollow Project" } }
  //       dropdownMenuItem { submitlink requestJoinProject(p) { "Request Project Membership" } }
  //     }
  //   }
  // }

  // template projectSideBar(p : Project) {
  // 	div[class="sidebar"]{
		//   //projectCommands(p)
		//   // par { image(p.getWeeklyStatsGraph()) }
		//   // par { <i> "Weekly Issue Count" </i> }
  //     //hrule
		//   par{ tags(p.getCommonTags(80), p) }
		// }
  // }

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
  