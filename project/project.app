module project/project

imports project/ac
imports project/register

entity Project {
	name			:: String (id, 
		validate(isUniqueProject(this), "Another project with this name already exists"), 
		validate(name.length() >= 3, "Project names should be three characters or longer"),
		validate(/[a-z0-9A-Z._]*/.match(name), "Project names may contain characters, numbers, dots and underscores."))
	description		:: WikiText
	url				:: URL
	issues			-> Set<Issue>
	members			-> Set<User>
	memberRequests	-> Set<User>
	created			:: DateTime
	
	function getCommonTags() : List<Tag>{
		return
			from Tag as t
			where (t._project = ~this) and (t._name not like ~"@%")
			limit 8; // Cannot parameterize this (syntax bug)
			
			/*select new Tag(t._name, t._project)
			from Issue as i left join i.tags as t
			where (t in i.tags) and (t._project = ~this) and (t._name not like ~"@%")
			group by t
			order by count(i)
			limit 8;	// Cannot parameterize this (syntax bug)
			*/
	}
	
	function getIssueStatsWeekly() : List<Int> {
		var year : Int := 2010;
		var weekDel : List<DateTime>; 
		for(week : Int from 1 to 51) {
			weekDel.add(
				DateTime(year +  "." + week, "yyyy.w")
			);
		}
		var stats : List<Int>;
		for(nr : Int from 0 to weekDel.length - 2) {
			var start : DateTime := weekDel.get(nr);
			var end : DateTime := weekDel.get(nr + 1);
			stats.add(
				select count(*)
				from Issue
				where _submitted > ~start 
				and _submitted < ~end
				and _project = ~this
			);
		}
		return stats;
	}
	
	function getWeeklyStatsGraph() : String {
		var stats := getIssueStatsWeekly();
		var maxStat := maxList(stats);
	
		var prefix := "http://chart.apis.google.com/chart?cht=bvg&chs=250x100&chco=bbcebb&chbh=a,5,10&chxt=y";
		var rangePrefix := "&chds=0," + maxStat;
		var axisPrefix := "&chxr=0,0," + maxStat;
		var dataPrefix := "&chd=t:";
		
		var url : List<String>;
		url.add(prefix);
		url.add(rangePrefix);
		url.add(axisPrefix);
		url.add(dataPrefix);
		for(nr : Int from 0 to stats.length - 2) {
			url.add(stats.get(nr).toString() + ",");
		}
		url.add(stats.get(stats.length - 1).toString());
		
		return url.concat();
	}
}

define page project(p : Project) {
	var recentIssues : List<Issue> := 
		from Issue
		where _open = true and _project = ~p
		order by _submitted desc
		limit 20;
		
	// TODO Make next two queries more efficient by integration
	var openIssues : List<Issue> := 
		from Issue
		where _open = true and _project = ~p
		order by _submitted desc
		limit 2000;
	var unassignedIssues : List<Issue> := [ i | i : Issue in openIssues where !(i.isAssigned()) ];
	var unassignedIssuesOrd : List<Issue> := [ i | i : Issue in unassignedIssues order by i.submitted desc ];
	var unassignedIssuesOrdSumm : List<Issue> := [ i | i : Issue in unassignedIssuesOrd limit 5 ]; // TODO Workaround
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
			
			par { tags(tags, p) }
			projectMembershipRequests(p)
			
			if(unassignedIssues.length > 0) {
				par { <h2>"Recent Unassigned Issues"</h2>	}
				par { issues(unassignedIssuesOrdSumm.set(), false, false, true, 50, true) }
				if(unassignedIssues.length > 5) {
					navigate(projectUnAssignedIssues(p)) {output(unassignedIssues.length - 5) " more unassigned issues"}
				}
			}
			
			par { <h2>"Recent Open Issues"</h2> }
			par { issues(recentIssues.set(), false, false, true, 50, true) }
			par { navigate(projectIssues(p)) {"View all issues"} }
			
			par { <h2>"Project Members"</h2> }
			par { users(p.members) }
		}
		projectSideBar(p)
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

define template projectSideBar(p : Project) {
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
		par { output(newIssueNumber(p) - 1) " issues"}	// TODO make query count
		par { output(p.members.length) " members"}
		sidebarSeparator()
		par { <i> "Weekly Issue Count" </i> }
		par { image(p.getWeeklyStatsGraph()) }
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

define page projectStats(p : Project) {
	par { <i> "Issue Count (weekly)" </i> }
	par { image(p.getWeeklyStatsGraph()) }
}

define template projects(ps : Set<Project>) {
	var psSorted : Set<Project> := 
		[punsorted | punsorted : Project in ps order by punsorted.name asc]	 
	table {
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
				block {
					tags(p.getCommonTags(), p)
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
			}
		}
	}
	action save(){
		p.save();
		//message("Project saved");
		return project(p);
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
		projectSideBar(p)
	}
}

define page projectUnAssignedIssues(p : Project) {
	// TODO Make next two queries more efficient by integration
	var openIssues : List<Issue> := 
		from Issue
		where _open = true and _project = ~p
		order by _submitted
		limit 2000;
	var unassignedIssues : List<Issue> := [ i | i : Issue in openIssues where !(i.isAssigned()) ];
	
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
					"Unassigned Issues"
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {"Ç Back to Project"} }
			}
			
			par { issues(unassignedIssues.set(), false, true, true, 60, true) }
		}
		projectSideBar(p)
	}
}

function max(i1 : Int, i2 : Int) : Int {
	if(i1 >= i2) {
		return i1;
	}
	return i2;
}

function maxList(is : List<Int>) : Int {
	var m : Int := is.get(0);
	for(i : Int from 0 to is.length - 1) {
		var current : Int := is.get(i); 
		m := max(m, current);
	}
	return m;
}