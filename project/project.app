module project/project

imports project/ac
imports project/register

entity Project {
	name			:: String (id, validate(isUniqueProject(this), "Another project with this name already exists"), validate(name.length() >= 3, "Project names should be three characters or longer"))
	description		:: WikiText
	url				:: URL
	issues			-> Set<Issue>
	members			-> Set<User>
	memberRequests	-> Set<User>
	created			:: DateTime
}

define page project(p : Project) {
	var recentIssues : List<Issue> := 
		from Issue
		where _open = true and _project = ~p
		order by _submitted
		limit 5;
	var openIssues : List<Issue> := 
		from Issue
		where _open = true and _project = ~p
		order by _submitted
		limit 2000;
	var unassignedIssues : List<Issue> := [ i | i : Issue in openIssues where !(i.isAssigned()) ];
	var tags : List<Tag> := 
		from Tag
		where _project = ~p
		order by _name
		limit 200;
	
	
	title{"YellowGrass.org - " output(p.name)}
	main()
	define body() {
		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					" È "
					navigate(home(securityContext.principal)) {"Home"}
					" È "
					"Project " output(p.name) 
				}
			}
			projectMembershipRequests(p)
			
			if(unassignedIssues.length > 0) {
				par { <h2>"Unassigned Issues"</h2>	}
				par { issues(unassignedIssues.set(), false, false, true, 60, true) }
			}
			
			par { <h2>"Tags"</h2> }
			par { tags(tags, p) }
			
			par { <h2>"Recent Issues"</h2> }
			par { issues(recentIssues.set(), false, false, true, 60, true) }
			par { navigate(projectIssues(p)) {"View All Issues"} }
			
			par { <h2>"Project Members"</h2> }
			par { users(p.members) }
		}
		block [class := "sidebar"] {
			par { 
				<h1> output(p.name) </h1>
			}
			sidebarSeparator()
			par { navigate(createIssue(p))	{"New Issue"} }
			par { navigate(edit(p))			{"Project Settings"} }
			par { actionLink("Leave Project", leaveProject(p)) }
			par { actionLink("Request Project Membership", requestJoinProject(p)) }
			sidebarSeparator()
			par { output(p.description) }
			par { output(p.url) }
			sidebarSeparator()
			par { output(openIssues.length) " open issues"}
			par { output(p.members.length) " members"}
		}
	}
	action requestJoinProject(p : Project) {
		p.memberRequests.add(securityContext.principal);
		message("Project membership requested, awaiting project member approval...");
		return project(p);
	}
	action leaveProject(p : Project) {
		p.members.remove(securityContext.principal);
		tagCleanup(tag("@"+securityContext.principal.tag, p));
		return home(securityContext.principal);
	}
}

define template projectMembershipRequests(p : Project) {
	par { <h2>"Membership Requests"</h2>	}
	for(r : User in p.memberRequests order by r.name) {
		par { 
			navigate(user(r.tag)){output(r.name)}
			" - "
			actionLink("Accept", acceptMembershipRequest(r, p))
			" - "
			actionLink("Decline", declineMembershipRequest(r, p))
		}
	}
	action acceptMembershipRequest(u : User, p : Project) {
		p.members.add(u);
		p.memberRequests.remove(u);
		tag("@"+u.tag, p);
		return project(p);
	}
	action declineMembershipRequest(u : User, p : Project) {
		p.memberRequests.remove(u);
		return project(p);
	}
}

define template projects(ps : Set<Project>) {	 
	table {
		var psSorted : Set<Project> := 
			[punsorted | punsorted : Project in ps order by punsorted.name asc]
		
		for(p : Project in psSorted) {
			row { 
				navigate project(p) {output(p.name)}
				block {
					output([i | i : Issue in p.issues where i.open].length) 
					" open issues "
				}
				block { 
					output(p.members.length) 
					" members "
				}
			}
		}
	}
}

define page projectList() {
	title{"YellowGrass.org - Project List"}
	main()
	define body(){
		<h1>"Project List"</h1>
		var projectList : List<Project> := 
			from Project;
		block [class := "Listing"] {
			projects(projectList.set())
		}
	}
}

define page edit(p : Project) {
	title{"YellowGrass.org - " output(p.name)}
	main()
	define body(){
		<h1> "Edit Project" </h1>
		form {
			par {
				label("Project name") { input(p.name) }
			}
			par {
				label("Project description") { input(p.description)}
			}
			par {
				label("Project web page") { input(p.url) }
			}
			par {
				navigate(project(p)) {"Cancel"}
				" "
				action("Save",save())
				action save(){
					p.save();
					//message("Project saved");
					return project(p);
				}
			}
		}
	}
}

define page projectIssues(p : Project) {
	title{"YellowGrass.org - " output(p.name)}
	main()
	define body() {
		block [class := "main"] {
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					" È "
					navigate(home(securityContext.principal)) {"Home"}
					" È "
					navigate(project(p)) {"Project " output(p.name)}
					" È "
					"Issues"
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {"Ç Back to Project"} }
			}
			 
			par { issues(p.issues, false, true, true, 60, true) }
		}
		block [class := "sidebar"] {
			par {
				<h1> output(p.name) </h1>
			}
			
			par { navigate(createIssue(p))	{"New Issue"} }
			
			par { output(p.description) }
		}
	}
}