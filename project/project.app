module project/project

imports project/ac
imports project/register
imports project/roadmap
imports project/membership
imports project/sidebar
imports project/settings
imports project/statistics
imports issue/issue
imports tag/tag
imports user/user


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
	private			:: Bool
	email			:: Email
	
	function getCommonTags(nr : Int) : List<Tag>{
		var result :List<Tag> := 
			(	select t
				from Issue as i inner join i.tags as t
				where (i._project = ~this) and (t._name not like ~"@%") and (t._name not like ~"!%")
				group by t._name
				order by count(i) desc
				limit ~nr
			) as List<Tag>;
		return result;
	}
	
	function getIssueStatsWeekly() : List<Int> {
		// This is ugly, but webdsl does not support any better right now
		var year : Int := 2011;
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
	
		var prefix := "http://chart.apis.google.com/chart?cht=bvg&chs=230x100&chco=bbcebb&chbh=a,5,10&chxt=y";
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
		limit 10;
	
	var popularIssues : List<Issue> := 
		select i
		from Issue as i
		left join i.tags as t
		where 
			i._open = true and 
			i._project = ~p and
			t._name like ~"!%"
		group by i 
		order by count(t._name) desc //order by aggregation is not supported in MySQL :(
		limit 10;
	
	title{output(p.name) " on YellowGrass.org" }
	main()
	define body() {
		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					rawoutput { " &raquo; " }
					navigate(home()) {"Home"}
					rawoutput { " &raquo; " }
					"Project " output(p.name) 
				}
			}
			
			par { tags(p.getCommonTags(80), p) }
			projectMembershipRequests(p)
			
			if(popularIssues.length > 0) {
				par { <h2>"Popular Open Issues"</h2> }
				par { issues(popularIssues, false, false, true, 50, true, true) }
			}
			par { <h2>"Recent Open Issues"</h2> }
			par { issues(recentIssues, false, false, true, 50, true, true) }

			par { navigate(projectIssues(p, true)) {"View all open issues"} " --- " navigate(projectIssues(p, false)) {"View all issues"} }
			
			par { <h2>"Project Members"</h2> }
			par { users(p.members) }
		}
		projectSideBar(p)
	}
}

define page projectStats(p : Project) {
	par { <i> "Issue Count (weekly)" </i> }
	par { image(p.getWeeklyStatsGraph()) }
}

define template projects(ps : List<Project>) {
	block [class := "Listing"] {
		table {
			for(p : Project in ps) { 
				row {
					column { navigate project(p) {output(p.name)} }
					column {
						output(
							(from Issue as i
							 where i.open=true and i.project = ~p
							).length
						) 
						" open issues "
					}
				}
			}
		}
	}
}

define template projectsAbbreviated(ps : List<Project>) {
	table {
		for(p : Project in ps) { 
			row {
				column { navigate project(p) {output(p.name)} }
			}
		}
	}
}


define page projectList() {
	title{"YellowGrass.org - Public Projects List"}
	main()
	define body(){
		<h1>"Project List"</h1>
		var projectList : List<Project> := 
			from Project
			where _private=false
			order by _name;
		block [class := "Listing"] {
			projects(projectList)
		}
	}
}


define page projectIssues(p : Project, filterOpen : Bool) {
	title{output(p.name) " issues on YellowGrass.org"}
	main()
	define body() {
		var issues := [i | i : Issue in p.issues where (!filterOpen) || i.open];
		
		block [class := "main"] {
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					rawoutput { " &raquo; " }
					navigate(home()) {"Home"}
					rawoutput { " &raquo; " }
					navigate(project(p)) {"Project " output(p.name)}
					rawoutput { " &raquo; " }
					"Issues"
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {rawoutput { " &raquo; " } " Back to Project"} }
			}
			 
			par { issues(issues, false, true, true, 50, true, true) }
		}
		projectSideBar(p)
	}
}

function mayAccess(ps : List<Project>) : Bool {
	return [p | p : Project in ps where !mayAccess(p)].length == 0;
}
