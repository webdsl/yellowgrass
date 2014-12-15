module project/sidebar

section project toolbar

  template projectToolbar(p: Project) {
    gridRow{
      gridCol(12){
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
      navigate project(p) [class="btn btn-default", title=(if(p.private) "Private " else "") + "Project " + p.name] { 
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
      navigate questions(p) [class="btn btn-default"] { "Q&A" }
    }
    buttonGroup{     
      navigate createIssue(p)          [class="btn btn-default", title="New Issue"] { iPlus  }        
      navigate roadmap(p)              [class="btn btn-default", title="Roadmap"] { iRoad }    
      navigate projectIssues(p, true)  [class="btn btn-default", title="Open issues"] { iList }  
      navigate projectIssues(p, false) [class="btn btn-default", title="All issues"] { iListAlt }     
      navigate edit(p)                 [class="btn btn-default", title="Project Settings"] { iWrench } 
        
      submitlink followProject(p)      [class="btn btn-default", title="Follow Project"] { iStarEmpty  }  
      submitlink unfollowProject(p)    [class="btn btn-default", title="Unfollow Project"] { iStar } 
      submitlink requestJoinProject(p) [class="btn btn-default", title="Request Project Membership"] { iUser }     
    }
    searchBoxInToolbar(p, "")
  }
  
  template searchBoxInToolbar(p: Project, q: String) {
    var query : String := q
    action search(q: String) { return search(p, q); }
    buttonGroup[style="width:180px"]{
      form{
        inputAppend{
          input(query)[placeholder="Search", class="span2 search-bar", autofocus=""]  
          submit search(query) [style="display:none;"] { "Search" }
          inputGroupButton{ submitlink search(query) [class="btn btn-default"] { iSearch } }
        }
      }
    }
  }

  


  