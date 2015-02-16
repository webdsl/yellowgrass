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

  template projectTools(project: Project) {
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
    
    projectButton(project)
    
    buttonGroup{ 
      navigate questions(project) [submit attributes] { "Q&A" }
    }
    buttonGroup{     
      navigate createIssue(project)          [submit attributes, title="New Issue"] { iPlus  }        
      navigate roadmap(project)              [submit attributes, title="Roadmap"] { iRoad }    
      navigate projectIssues(project, true)  [submit attributes, title="Open issues"] { iList }  
      navigate projectIssues(project, false) [submit attributes, title="All issues"] { iListAlt }     
      navigate edit(project)                 [submit attributes, title="Project Settings"] { iWrench } 
        
      submitlink followProject(project)      [submit attributes, title="Follow Project"] { iStarEmpty  }  
      submitlink unfollowProject(project)    [submit attributes, title="Unfollow Project"] { iStar } 
      submitlink requestJoinProject(project) [submit attributes, title="Request Project Membership"] { iUser }     
    }
    searchBoxInToolbar(project, "")
  }
  
  template searchBoxInToolbar(p: Project, q: String) {
    var query : String := q
    action search(newq: String) { return search(p, newq); }
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

  


  