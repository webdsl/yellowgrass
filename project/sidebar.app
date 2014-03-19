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
      navigate projectIssues(p, true)  [class="btn", title="Open issues", style="height:14px;padding:7px;"] { iList }  
      navigate projectIssues(p, false) [class="btn", title="All issues", style="height:14px;padding:7px;"] { iListAlt }     
      navigate edit(p)                 [class="btn", title="Project Settings", style="height:14px;padding:7px;"] { iWrench } 
        
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
          input(query)[placeholder="Search", class="span2 search-bar", autofocus=""]  
          submit search(query) [class="btn", style="height:18px; padding:5px; margin:0px;display:none;"] { "Search" }
          submitlink search(query) [class="btn", style="height:18px; padding:5px; margin:0px;"] { iSearch }
        }
      }
    }
  }

  


  