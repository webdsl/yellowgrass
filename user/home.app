module user/home

imports user/password

// Projects recently posted to
// Important issues (votes / assigned / recent / recent comments)

section operations for user

  template homeToolbar(u: User) {
    gridRow{
      gridCol(12){
        buttonGroup{
          navigate home() [class="btn btn-default"] { iUser " " output(u.name) }
          navigate postedIssues() [class="btn btn-default", title="Issues posted by you"] { iListAlt }     
          navigate registerProject()   [class="btn btn-default", title="Create new project"] { iPlus }
          navigate editUser(u)         [class="btn btn-default", title="Edit your profile"] { iPencil  }
          navigate editUserPassword(u) [class="btn btn-default", title="Change your password"] { iLock  }
          if (u.deviceKeySet.length > 0) { 
            navigate manageDevices(u)  [class="btn btn-default", title="Manage devices"] { iCamera  } 
          }
        }
      } 
    }
  }

  template yourProjects() {
    if(securityContext.loggedIn) {
      dropdownInNavbar("Projects") {
        dropdownMenu{  
          for(p : Project in securityContext.principal.projects order by p.getkey asc) {
            dropdownMenuItem{
              navigate project(p) { output(p.name) }
            }
          }  
          dropdownMenuDivider
          dropdownMenuItem{
            navigate projectList() { "All Projects"}
          } 
          dropdownMenuDivider
          dropdownMenuItem{
            navigate registerProject() { iPlus " Create New Project"}
          }
        }
      }
    }
  }
  
section home page of user

  page home() {
	  // Workaround for bug that access control is enforced after variable initialization (init block is executed after access control)
	  var u : User; 
	  var assignedTag : String; 
	  var importantIssues : List<Issue>; 
	  var recentProjects : List<Project>; 
	  var recentIssues : List<Issue>;
	  init {
		  u := securityContext.principal;
		  assignedTag := "@" + u.tag;
		  recentProjects := u.recentProjects();
		  recentIssues := u.recentIssues();
	  }
	
	  title{"YellowGrass.org - " output(u.name)}
	  bmain{
      buttonToolbar{ homeToolbar(u) } 
	    gridRow{
        gridCol(12){
          pageHeader2{ output(u.name) } 
          
          pageHeader3{ "Your Projects" }     
          gridRow{
            // gridCol(2){
            //   pageHeader3{ "Recent Projects" }
            //   projectsAbbreviated(recentProjects)
            // }
            gridCol(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 0])
            }
            gridCol(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 5])
            }
            gridCol(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 10])
            }
            gridCol(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 15])
            }
            gridCol(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 20])
            }
          }
				  pageHeader3 { "Recent Issues" }
				  par { issues(recentIssues.set(), true, false, true, 50, true, false) }
				  par { navigate postedIssues() {"View issues posted by you"} }
				}
		  }
		}
	}
