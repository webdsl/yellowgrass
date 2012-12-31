module user/home

imports user/password

// Projects recently posted to
// Important issues (votes / assigned / recent / recent comments)

  template homeToolbar(u: User) {
    gridRow{
      gridSpan(12){
        buttonGroup{
          navigate home() [class="btn"] { iUser " " output(u.name) }
          navigate registerProject()   [class="btn", title="Create New Project", style="height:14px;padding:7px;"] { iPlus }
          navigate editUser(u)         [class="btn", title="Edit Your Profile", style="height:14px;padding:7px;"] { iPencil  }
          navigate editUserPassword(u) [class="btn", title="Change Password", style="height:14px;padding:7px;"] { iLock  }
          if (u.deviceKeySet.length > 0) { 
            navigate manageDevices(u)  [class="btn", title="Manage Devices", style="height:14px;padding:7px;"] { iCamera  } 
          }
        }
      } 
    }
  }

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
        gridSpan(12){
          pageHeader2{ output(u.name) } 
          
          pageHeader3{ "Your Projects" }     
          gridRow{
            // gridSpan(2){
            //   pageHeader3{ "Recent Projects" }
            //   projectsAbbreviated(recentProjects)
            // }
            gridSpan(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 0])
            }
            gridSpan(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 5])
            }
            gridSpan(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 10])
            }
            gridSpan(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 15])
            }
            gridSpan(2){
              projectsAbbreviated([p | p : Project in u.projects.list() limit 5 offset 20])
            }
          }
				  pageHeader3 { "Recent Issues" }
				  par { issues(recentIssues.set(), true, false, true, 50, true, false) }
				  par { navigate(postedIssues()) {"View issues posted by you"} }
				}
		  }
		}
	}
