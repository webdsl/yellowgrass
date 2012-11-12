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

section data model

entity Project {
	name				:: String (id, searchable,  
		validate(isUniqueProject(this), "Another project with this name already exists"), 
		validate(name.length() >= 3, "Project names should be three characters or longer"),
		validate(/[a-z0-9A-Z._]*/.match(name), "Project names may contain characters, numbers, dots and underscores."))

  code             :: String
	description			 :: WikiText
	url					     :: URL
	issues				   -> Set<Issue>
	members				   -> Set<User>
	memberRequests   -> Set<User>
	followers			   -> Set<User>
	//created				 :: DateTime
	private				   :: Bool (searchable)
	email				     :: Email
// =======
// 	description			:: WikiText
// 	url					:: URL
// 	issues				-> Set<Issue>
// 	members				-> Set<User>
// 	memberRequests		-> Set<User>
// 	followers			-> Set<User>
// 	// created				:: DateTime
// 	private				:: Bool		(searchable)
// 	email				:: Email
// >>>>>>> .r364
	
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
	function toJSON(old : JSONObject) : JSONObject {
		if(private && !(securityContext.principal in members)) { 
			return null;
		}
		var jsonobject := JSONObject();
		jsonobject.put("id", id);
		var version := old.getInt("version");
		if(version < this.version) {
			jsonobject.put("name", name);
			jsonobject.put("description", description.format());
			jsonobject.put("url", url);
			jsonobject.put("version", this.version);
		}
		jsonobject.put("weeklyStatsGraph", this.getWeeklyStatsGraph());
		if(version == 0) {
			var jsonArrayIssues := JSONArray();
			for (issue : Issue in issues order by issue.number desc limit 10) {
				jsonArrayIssues.put(issue.toJSON());
			}
			jsonobject.put("issues", jsonArrayIssues);
			var releases := generateRoadmap(this);
			var jsonmap := JSONArray();
			for(release : Release in releases order by release.name desc) {
				if(jsonmap.length() == 0) { 
					jsonmap.put(release.toJSON());
				} else {
					jsonmap.put(release.toJSONSimple());
				}
			}
			jsonobject.put("roadmap", jsonmap);
		}
		var jsonoldmembers := toVersionObejcts( old.getJSONArray("members"));
		var jsonArrayMembers := JSONArray();
		var dirty := false;
		for (member : User in members) {
			var vobject := VersionObject{
				id := member.id
			};
			var index := jsonoldmembers.indexOf(vobject);
			if(index == -1 || jsonoldmembers.get(index).version != member.version) {
				log(member.name + "is out dated");
				jsonArrayMembers.put(member.toJSON());
				dirty := true;
			} else {
				//var x := jsonoldmembers.toString();
				log(member.name + "(" + member.id + ")" + ":" + member.version + "is in ");
				for(object : VersionObject in jsonoldmembers) {
					log(object.toString2());
				}
				jsonArrayMembers.put(member.toSimpleJSON()); 
			}
		}
		
		if(dirty || (version < this.version)) {
			jsonobject.put("members", jsonArrayMembers);
		}
		var jsonoldfollowers := toVersionObejcts( old.getJSONArray("followers"));
		dirty := false;
		var jsonArrayFollowers := JSONArray();
		for (follower : User in followers) {
			var vobject := VersionObject{
				id := follower.id
			};
			var index := jsonoldfollowers.indexOf(vobject);
			if(index == -1 || jsonoldmembers.get(index).version != follower.version) {
				jsonArrayMembers.put(follower.toJSON());
				dirty := true;
			} else {
				jsonArrayMembers.put(follower.toSimpleJSON());
			}
		} 
		if(dirty|| (version < this.version)) {
			jsonobject.put("followers", jsonArrayFollowers);
		}
		var issuetags := JSONArray();
		for(tag : Tag in getIssueTypeTags()) {
			issuetags.put(tag.toJSON());
		}
		jsonobject.put("issueTypes", issuetags);
		return jsonobject;
	}
	
	function toSimpleJSON() : JSONObject {
		if(private && !(securityContext.principal in members)) { 
			return null;
		}
		var jsonobject := JSONObject();
		jsonobject.put("id", id);
		jsonobject.put("name", name);
		jsonobject.put("version", version); 
		return jsonobject;
	}
	
	function toJSONRef() : JSONObject{
		if(private && !(securityContext.principal in members)) { 
			return null;
		}
		var jsonobject := JSONObject();
		jsonobject.put("id", id);
		return jsonobject;
	}
}

section user interface

  page project(p : Project) {
    title{output(p.name) " on YellowGrass.org" }
    
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
	
	  bmain(p){
	    gridRow{
	      // gridSpan(12){ 
	      //   pageHeader { navigate(project(p))  { output(p.name) } } 
	      // }
		    gridSpan(2){
          projectSideBar(p)
        }
        gridSpan(10){
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

  template projects(ps : List<Project>) {
	  block [class := "Listing"] {
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
	    gridRow{
	      gridSpan(2){ projectSideBar(p) }
	      gridSpan(10){
	        // todo: breadcrumbs
          // if(securityContext.loggedIn) {
          //   par [class := "Back"] { 
          //     rawoutput { " &raquo; " }
          //     navigate(home()) {"Home"}
          //     rawoutput { " &raquo; " }
          //     navigate(project(p)) {"Project " output(p.name)}
          //     rawoutput { " &raquo; " }
          //     "Issues"
          //   }
          // } else { 
          //   par [class := "Back"] { navigate project(p) {rawoutput { " &raquo; " } " Back to Project"} }
          // }
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
