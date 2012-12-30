module project/project

imports project/project-model
imports project/ac
imports project/register
imports project/roadmap
imports project/members
imports project/sidebar
imports project/settings
imports project/statistics
imports issue/issue
imports tag/tag
imports user/user 

section all projects

  template projects(ps : List<Project>) {
      tableBordered {
        for(p : Project in ps) { 
          row {
            column { navigate project(p) {output(p.name)} }
            column {
              output((select count(i) from Issue as i where i.open=true and i.project = ~p)) 
              " open issues "
            }
          }
        }
      }
  }

section navigation

  template nav(p: Project) {
    navigate project(p) { output(p.name) }
  }

section user interface

  page project(p : Project) {
    title{output(p.name) " on YellowGrass.org" }
    
	  var recentIssues : List<Issue> := p.recentIssues(10)
	  var popularIssues : List<Issue> := p.popularIssues(10);
	
	  bmain{ 
      projectToolbar(p) 
	    gridRow{
        gridSpan(12){        
        	pageHeader { output(p.name) } 
        	
        	par{ output( p.description ) }
        	par{ navigate url(p.url) { output(p.url) } }
			
			    if(popularIssues.length > 0) {
				    pageHeader2 { "Popular Open Issues" }
				    par { issues(popularIssues, false, false, true, 50, true, true) }
			    }
			
			    pageHeader2 { "Recent Open Issues" }
			    par { issues(recentIssues, false, false, true, 50, true, true) }
			
			    pageHeader2 { "Project Members" }
			    par { users(p.members) }
			    		    
          projectMembershipRequests(p)
			
			    if(p.followers.length > 0) {
				    pageHeader2 { "Project Followers" }
				    par { users(p.followers) }
				  }				
			  }
		  }
	  }
  }

  page projectStats(p : Project) {
	  par { <i> "Issue Count (weekly)" </i> }
	  par { image(p.getWeeklyStatsGraph()) }
  }

  template projectsAbbreviated(ps : List<Project>) {
	  tableBordered {
		  for(p : Project in ps) { 
			  row {
				  column { navigate project(p) { output(p.name) } }
			  }
		  }
	  }
  }

  page projectList() {
    var projectList : List<Project> := 
      from Project
      where _private=false
      order by _name;
      
	  title{"YellowGrass.org - Public Projects List"}
	  bmain{
	    gridRow{
		    gridSpan(8,2){
		      pageHeader{ "Project List" }			
		      block [class := "Listing"] {
			      projects(projectList)
			    }
			  }
		  }
	  }
  }

  page projectIssues(p : Project, filterOpen : Bool) {
	  title{output(p.name) " issues on YellowGrass.org"}
	  bmain(p){
	    projectToolbar(p) 
	    gridRow{      
	      gridSpan(12){
          pageHeader2{ 
            if(filterOpen) { "Open " } "Issues of Project " output(p.name)
          }
          par { issues(p.getOrderedIssues(filterOpen), false, true, true, 50, true, true) }   
	      }
	    }
	  }
  }

  function mayAccess(ps : List<Project>) : Bool {
	  return [p | p : Project in ps where !mayAccess(p)].length == 0;
  }
