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
      navigate project(p) [submit attributes, title=(if(p.private) "Private " else "") + "Project " + p.name] { 
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
      navigate questions(p) [submit attributes] { "Q&A" }
    }
    buttonGroup{     
      navigate createIssue(p)          [submit attributes, title="New Issue"] { iPlus  }        
      navigate roadmap(p)              [submit attributes, title="Roadmap"] { iRoad }    
      navigate projectIssues(p, true)  [submit attributes, title="Open issues"] { iList }  
      navigate projectIssues(p, false) [submit attributes, title="All issues"] { iListAlt }     
      navigate edit(p)                 [submit attributes, title="Project Settings"] { iWrench } 
        
      submitlink followProject(p)      [submit attributes, title="Follow Project"] { iStarEmpty  }  
      submitlink unfollowProject(p)    [submit attributes, title="Unfollow Project"] { iStar } 
      submitlink requestJoinProject(p) [submit attributes, title="Request Project Membership"] { iUser }     
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
          inputGroupButton{ submitlink search(query) [] { iSearch } }
        }
      }
    }
  }

  


  