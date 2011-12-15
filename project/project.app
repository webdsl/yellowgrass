module project/project

imports project/ac
imports project/register
imports project/roadmap
imports project/members
imports project/sidebar
imports project/settings
imports project/statistics
// imports issue/issue
imports tag/tag
imports user/user


entity Project {
	name				:: String (id, searchable,  
		validate(isUniqueProject(this), "Another project with this name already exists"), 
		validate(name.length() >= 3, "Project names should be three characters or longer"),
		validate(/[a-z0-9A-Z._]*/.match(name), "Project names may contain characters, numbers, dots and underscores."))
	description			:: WikiText
	url					:: URL
	issues				-> Set<Issue>
	members				-> Set<User>
	memberRequests		-> Set<User>
	followers			-> Set<User>
	created				:: DateTime
	private				:: Bool		(searchable)
	email				:: Email
	
	function getCommonTags(nr : Int) : List<Tag>{
		var result :List<Tag> := 
			(	select t
				from Issue as i inner join i.tags as t
				where 	(i._project = ~this) and 
						(t._project = ~this) and // Not needed, but used for performance
						(t._name not like ~"@%") and 
						(t._name not like ~"!%")
				group by t._name
				order by count(i) desc
				limit ~nr
			) as List<Tag>;
		return result;
	}
	
	function getIssueTypeTags():List<Tag>{
		var issuetypes : List<Tag> := 
		select t1
		from Tag as t1 left join t1.tags as t2
		where 
			t1.project = ~this and
			t2.project = ~this and
			t2.name = ~ISSUE_TYPE_TAG()
		group by t1.name
		order by t1.name;

	return 	issuetypes;	
	}
	
	function getOrderedIssues(filterOpen : Bool) : List<Issue> {
		if(filterOpen) {
			return
				from Issue
				where _project = ~this and _open = true
				order by _number desc
				limit 2000;
		} else {
			return
				from Issue
				where _project = ~this
				order by _number desc
				limit 2000;
		}
	}
	
	function getIssueStatsWeekly() : List<Int> {
		// TODO Use version below when supported in WebDSL
/*		var start : DateTime := now().addYears(-1);
		return
			select count(i)
			from Issue as i
			where (i._project = ~this and i._submitted > ~start)
			group by month(i._submitted)
			order by i._submitted;
*/		
		// This is ugly, but webdsl does not support any better right now
		var yearStart : DateTime := now().addYears(-1);
		var stats : List<Int>;
		for(week : Int from 1 to 51) {
			var start := yearStart.addDays(week * 7);
			var end := yearStart.addDays((week+1) * 7);
			stats.add(
				select count(*)
				from Issue
				where _project = ~this
				and _submitted > ~start 
				and _submitted < ~end
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
	function toJSON():JSONObject{
		if(private){ return null;}
		var jsonobject := JSONObject();
		jsonobject.put("id",id);
		jsonobject.put("name", name);
		jsonobject.put("description",description.format());
		jsonobject.put("url",url);
		jsonobject.put("weeklyStatsGraph",this.getWeeklyStatsGraph());
		var jsonArrayIssues := JSONArray();
		for (issue:Issue in issues order by issue.number desc limit 10){
			jsonArrayIssues.put(issue.toJSON());
		}
		jsonobject.put("issues", jsonArrayIssues);
		var jsonArrayMembers := JSONArray();
		for (member:User in members  ){
			jsonArrayMembers.put(member.toJSON());
		}
		jsonobject.put("members",jsonArrayMembers);
		var jsonArrayFollowers := JSONArray();
		for (follower:User in followers ){
			jsonArrayFollowers.put(follower.toJSON());
		} 
		jsonobject.put("followers",jsonArrayFollowers);
		var releases:=generateRoadmap(this);
		var jsonmap := JSONArray();
		for(release:Release in releases order by release.name desc){
			if(jsonmap.length() == 0){ 
				jsonmap.put(release.toJSON());
			}else{
				jsonmap.put(release.toJSONSimple());
			}
		}
		jsonobject.put("roadmap",jsonmap);
		var issuetags:=JSONArray();
		for(tag:Tag in getIssueTypeTags()){
			issuetags.put(tag.toJSON());
		}
		jsonobject.put("issueTypes",issuetags);
		return jsonobject;
	}
	
	function toSimpleJSON():JSONObject{
		if(private){ return null;}
	
		var jsonobject := JSONObject();
		jsonobject.put("id",id);
		jsonobject.put("name", name);
		
		return jsonobject;
	}
	function toJSONRef():JSONObject{
		if(private){ return null;}
	
		var jsonobject := JSONObject();
		jsonobject.put("id",id);
		return jsonobject;
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
	main(p)
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
			
			if(p.followers.length > 0) {
				par { <h2>"Project Followers"</h2> }
				par { users(p.followers) }
			}
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
	main(p)
	define body() {
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
			
			par { issues(p.getOrderedIssues(filterOpen), false, true, true, 50, true, true) }
		}
		projectSideBar(p)
	}
}

function mayAccess(ps : List<Project>) : Bool {
	return [p | p : Project in ps where !mayAccess(p)].length == 0;
}
