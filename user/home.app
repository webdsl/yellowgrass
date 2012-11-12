module user/home

imports user/password

// Projects recently posted to
// Important issues (votes / assigned / recent / recent comments)

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
		  recentProjects := ( 
			  select p from Issue as i
			    left join i._project as p
			   where i._reporter=~u
			   group by p
			   order by max(i._submitted) desc
			   limit 25
			  ) as List<Project>;
		  recentIssues := 
			  select i from Issue as i
			  left join i._project as p
			  where	(~u in elements(i._project._members)) or 
					((i._reporter != null) and (i._reporter._name = ~u.name)) or
					(i._email = ~u.email)
			  order by i._submitted desc
			  limit 15;
	  }
	
	  title{"YellowGrass.org - " output(u.name)}
	  bmain{
	    gridRow{
	      gridSpan(2){
	        div[class = "sidebar"] {
	          pageHeader4{ "Profile" } 
            par { navigate registerProject()    { iPlus   " Create New Project" } }
            par { navigate(editUser(u))         { iPencil " Edit Your Profile" } }
            par { navigate(editUserPassword(u)) { iPencil " Change Password" } }
            if (u.deviceKeySet.length > 0) { 
              par { navigate manageDevices(u) { iCamera " Manage Devices" } }
            }
          }
        }
        gridSpan(10){
          pageHeader2{ output(u.name) } 
          
          pageHeader3{ "Your Projects" }     
          gridRow{
            // gridSpan(3){
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
