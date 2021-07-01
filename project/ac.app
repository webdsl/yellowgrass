module project/ac

imports project/members
imports project/project
imports project/project-model
imports project/register
imports project/roadmap
imports project/settings
imports project/statistics
imports tag/tag-model
imports tag/release
imports user/ac
imports user/user-model

access control rules
	
	predicate mayAccess(ps : List<Project>) {
    [p | p : Project in ps where !mayAccess(p)].length == 0
  }
  
	predicate mayAccess(p : Project){
		( !p.private ) || 
		securityContext.principal in p.members
	}
	
	predicate isAdministrator(){
	  loggedIn() && principal().isAdmin()
	}
	
	rule page project(p : Project) {	
		mayAccess(p)
	}
		
	rule page edit(project : Project) {
		principal in project.members
		rule action save() {
			principal in project.members
		}
		rule action leaveProject(p : Project) {
			principal in p.members &&
			p.members.length > 1
		}
		rule action regenerateIssueTypes(p : Project) {
			principal in p.members
		}
	}
	
	rule page registerProject() {
		loggedIn
	}
	
	rule page projectIssues(p : Project, filterOpen : Bool) {
		mayAccess(p)
	}
	
	rule template projects(ps : List<Project>) {
		mayAccess(ps)
	}
	
	rule template projectsAbbreviated(ps : List<Project>) {
		mayAccess(ps)
	}
	
	rule page projectList() {
		true
	}
	
	rule template projectMembershipRequests(p : Project) {
		principal in p.members && 
		p.memberRequests.length > 0
	}
	
	rule template inviteMember(p: Project) {
	  principal in p.members
	}
	
	rule ajaxtemplate invitationCandidates(p: Project, query: String) {
	  principal in p.members	
	}
	
	// rule template projectSideBar(p : Project) {
	// 	mayAccess(p)
	// }
	 
	rule page projectStats(p : Project) {
		mayAccess(p)
	}
	
	rule page roadmap(p : Project) {
		mayAccess(p) &&
		(	from Tag as t
			left join t.tags as ts
			where t._project=~p and ts._name=~"release"
			limit 1
		).length > 0
	}
	
/*	rule template roadmapReleaseLink(release : Tag) {
		true
		rule action unFoldRelease(release : Tag) {
			true
		}
	}
*/	

	rule ajaxtemplate roadmapRelease(r : Tag, issuesToShow : Int) {
		mayAccess(r.project) && r.isRelease()
		rule action postponeOpen(release : Tag) {
			principal in release.project.members && 
			release.isRelease() && 
			!releaseDone(release) &&
			nextRelease(release) != null
		}
		rule action showPreviousRelease(release : Tag) {
			mayAccess(r.project) && r.isRelease()
		}
	}

  rule template projectTools(project : Project) {
    mayAccess(project)
    
    rule action followProject(p : Project) {
      loggedIn && 
      !(principal in p.followers) &&
      !(principal in p.members) &&
      !(principal in p.memberRequests)
    } 
    
    rule action unfollowProject(p : Project) {
      loggedIn &&
      (principal in p.followers)
    }
    
    rule action requestJoinProject(p : Project) {
      loggedIn && 
      !(principal in p.members) &&
      !(principal in p.memberRequests)
    }
  }
  
  // rule template projectDropdown(p : Project) {
  //   mayAccess(p)
  //   
  //   rule action followProject(p : Project) {
  //     loggedIn && 
  //     !(principal in p.followers) &&
  //     !(principal in p.members) &&
  //     !(principal in p.memberRequests)
  //   }
  //   
  //   rule action unfollowProject(p : Project) {
  //     loggedIn &&
  //     (principal in p.followers)
  //   }
  //   
  //   rule action requestJoinProject(p : Project) {
  //     loggedIn && 
  //     !(principal in p.members) &&
  //     !(principal in p.memberRequests)
  //   } 
  // }
  
  // rule template projectMenu(p : Project) {
  //   mayAccess(p)
  //   
  //   rule action followProject(p : Project) {
  //     loggedIn && 
  //     !(principal in p.followers) &&
  //     !(principal in p.members) &&
  //     !(principal in p.memberRequests)
  //   }
  //   
  //   rule action unfollowProject(p : Project) {
  //     loggedIn &&
  //     (principal in p.followers)
  //   }
  //   
  //   rule action requestJoinProject(p : Project) {
  //     loggedIn && 
  //     !(principal in p.members) &&
  //     !(principal in p.memberRequests)
  //   }
  // }
  	
	// rule template projectCommands(p : Project) {
	// 	mayAccess(p)
	// 	
	// 	rule action followProject(p : Project) {
	// 		loggedIn && 
	// 		!(principal in p.followers) &&
	// 		!(principal in p.members) &&
	// 		!(principal in p.memberRequests)
	// 	}
	// 	
	// 	rule action unfollowProject(p : Project) {
	// 		loggedIn &&
	// 		(principal in p.followers)
	// 	}
	// 	
	// 	rule action requestJoinProject(p : Project) {
	// 		loggedIn && 
	// 		!(principal in p.members) &&
	// 		!(principal in p.memberRequests)
	// 	}
	// }
	
	rule page statistics() {
		true
	}
	
section proxy

  extend session securityContext {
      proxy -> User
  }
 
    extend entity User {
      function proxy() {
        validate(isAdministrator(), "Only administrators are allowed to proxy someone.");
        securityContext.proxy := securityContext.principal;
        securityContext.principal := this;
      }
      
      function unProxy() {
        securityContext.principal := securityContext.proxy;
        securityContext.proxy := null;
      }
      
      function mayProxy(): Bool {
        return isAdministrator()
          && principal() != this;
      }
      
      function isByProxy() : Bool {
        return loggedIn() 
          && securityContext.proxy != null;
      }
      
      function proxyBy() : User {
        if(isByProxy()){
          return securityContext.proxy;
        }
        return null;
      }
    }