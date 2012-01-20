module issue/issue

imports issue/ac
imports comment/comment
imports comment/event
imports comment/issueControl
imports issue/emails
imports issue/register
imports issue/sidebar
imports issue/types
imports user/user
imports project/project
imports issue/attachment
imports issue/issueBrowser
imports issue/ghost

entity Issue {
	number		:: Int		(searchable)
	title		:: String	(searchable, validate(title.length() >= 5, "Use a longer and more descriptive title"))
	description	:: WikiText (searchable)
	submitted 	:: DateTime
	project		-> Project	(searchable, inverse = Project.issues)
	reporter	-> User
	open		:: Bool
	log			-> Set<Event> (searchable(name=comments, subclass=Comment))
	tags		-> Set<Tag>
	email		:: Email // Only when reporter == null
	nrVotes		:: Int := [ t | t : Tag in tags where /!.*/.match(t.name)].length
	attachments -> Set<Attachment>
	
	projectName  :: String (searchable) := project.name
	reporterName :: String (searchable) := 
		if (reporter != null && reporter.name != null)
			reporter.name
		else
			""
		
	
	function getReporterName() : String {
		if (reporter != null && reporter.name != null) {
			return reporter.name;
		} else {
			return "";
		}
	}
	
	function getTitle() : String {
		if( title == null || title =="" || title == " ") { // TODO Improve this test by using a regexp
			return "<< no title >>";
		} else {
			return title;
		}
	}
	
	function close() {
		open := false;
		log.add(
			IssueClose{ 
				moment := now()
				actor := securityContext.principal
			}
		);
	}
	
	function reopen() { 
		open := true;
		log.add(
			IssueReopen{ 
				moment := now()
				actor := securityContext.principal
			}
		);

	}
	
	function notifyRegister() {
		for(e : Email in mailinglist()){
			email(issueNotification(this, e));
		}
	}
	
	function notifyClose() {
		for(e : Email in mailinglist()){
			email(issueCloseNotification(this, e));
		}
	}
	function notifyReopen() {
		for(e : Email in mailinglist()){
			email(issueReopenNotification(this, e));
		}
	}
	function addComment(c : Comment) {
		log.add(c);
		this.save();
		for(e : Email in mailinglist()){
			email(issueCommentNotification(this, e, c));
		}
	}
	function commentClose(c : Comment) {
		log.add(c);
		close();
		this.save();
		for(e : Email in mailinglist()){
			email(issueCommentCloseNotification(this, e, c));
		}
	}
	
	function isAssigned() : Bool {
		for(tag : Tag in tags) {
			if(/@.+/.match(tag.name)) {
				return true;
			}
		}
		return false;
	}
	
	function assign() {
		if (project.members.length == 1) {
			tags.add(tag("@"+project.members.list().get(0).tag, project));
		}
	}
	
	function toJSON(): JSONObject{
		
		var json := JSONObject();
		json.put("id",id);
		json.put("number", number);
		json.put("title",title);
		// json.put("description",description.format());
		json.put("submitted",submitted.getTime()/1000L);

		json.put("nrVotes",nrVotes);
		json.put("project",project.toSimpleJSON());
		if (reporter!=null){json.put("reporter",reporter.toJSON());}
		json.put("open",open);
		// var jsonArray := JSONArray();
		// for(event: Event in log){
		// 	if(event.toJSON()!=null){
		// 		jsonArray.put(event.toJSON());
		// 		}
		// 	
		// } 
		// json.put("comments",jsonArray);
		// var jsonArrayTags := JSONArray();
		// for(tag: Tag in tags){
		// 	jsonArrayTags.put(tag.toJSON());
		// }
		// json.put("tags",jsonArrayTags);
		return json;
	}
	function toSimpleJSON(): JSONObject{
		var json := JSONObject();
		json.put("id",id);
		return json;
	}
	
	function toExtendedJSON(): JSONObject{
		
		var json := JSONObject();
		json.put("id",id);
		json.put("number", number);
		json.put("title",title);
		json.put("description",description.format());
		json.put("submitted",submitted.getTime()/1000L);

		json.put("nrVotes",nrVotes);
		json.put("project",project.toSimpleJSON());
		if (reporter!=null){json.put("reporter",reporter.toJSON());}
		json.put("open",open);
		var jsonArray := JSONArray();
		for(event: Event in log){
			if(event.toJSON()!=null){
				jsonArray.put(event.toJSON());
			}
			
		} 
		json.put("comments",jsonArray);
		var jsonArrayTags := JSONArray();
		for(tag: Tag in tags){
			jsonArrayTags.put(tag.toJSON());
		}
		json.put("tags",jsonArrayTags);
		json.put("version",version);
		return json;
	}
}


function getIssue(p : Project, issueNumber : Int) : Issue {
	var issuesWithNumber : List<Issue> := 
		from Issue as i
		where i._project = ~p and i._number = ~issueNumber
		limit 1;
	
	if(issuesWithNumber.length != 0) {
		return issuesWithNumber.get(0);
	} else {
		return Issue {};
	}
}

function newIssueNumber(p: Project) : Int {
	var lastProjectIssues : List<Issue> := 
		from Issue
		where _project = ~p
		order by _number desc
		limit 1;
	if(lastProjectIssues.length == 0) {
		return 1;
	} else {
		return lastProjectIssues.get(0).number + 1;
	}
}

define template issues(is : Set<Issue>, showProjectName : Bool) {
	issues(is, showProjectName, false)
}
define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool) {
	issues(is, showProjectName, showTicks, true)
}
define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool) {
	issues(is, showProjectName, showTicks, showNumbers, 33)
}
define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int) {
	issues(is, showProjectName, showTicks, showNumbers, titleLength, false, false)
}

define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool) {
	issues([i | i : Issue in is.list()  order by i.submitted desc], 
		showProjectName, showTicks, showNumbers, titleLength, showTags, showNrVotes)
}

define template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool, showNrVotes : Bool) {
	block [class := "Listing"] {
		table {
			for(i : Issue in is) {
				row {
					if(showTicks) {
						column {
							if(!i.open) { 
								image("/images/tick.png") 
							} else { 
								"" 
							}
						}
					}
					if(showNumbers) {
						column { output(i.number) }
					}
					column {
						block[class := "Date"] { output(format(i.submitted)) }
					}
					if(showProjectName) {
						column { output(abbreviate(i.project.name, 20)) }
					}
					column { 
						block[class := "AbbreviatedIssueTitle"] {
							navigate(issue(i.project, i.number)) {
								output(abbreviate(i.getTitle(), titleLength))
							}
							if(showNrVotes && i.nrVotes > 0) {
								" (" output(i.nrVotes) ")"
							}
						}
					}
					if(showTags) { 
						column { tags(i, false, true) }
					}
				}
			}
		}
	}
}

define page issue(p : Project, issueNumber : Int) {
	var i := getIssue(p, issueNumber);
	var nrVotes := i.nrVotes; // Derived props are not cached and executed on demand
	
	title{"#" output(i.number) " " output(i.getTitle()) " (project " output(i.project.name) " on YellowGrass.org)"}
	main(p)
	define body(){
		block [class := "main"] {
			if(securityContext.loggedIn) {
				par [class := "Back"] {
					rawoutput { " &raquo; " } 
					navigate(home()) {"Home"}
					rawoutput { " &raquo; " }
					navigate(project(i.project)) {"Project " output(i.project.name)}
					rawoutput { " &raquo; " }
					"Issue " output(i.number)
				}
			} else {
				par [class := "Back"] { navigate(project(i.project)) {rawoutput { " &raquo; " } " To Project"} }
			}
			
			par{ <h2> 
				output(i.getTitle())
				if(nrVotes > 0) { " (" output(nrVotes) ") " } 
				if(!i.open) {
					image("/images/tick.png")
				}
			</h2> }
			par{
				<i> 
				block [class := "IssueTitle"] {
					output(i.project.name) 
					" #" output(i.number)
					" ("
					if(i.reporter != null) {
						"by " navigate(user(i.reporter.tag)){output(i.reporter.name) " "}
					}
					if(i.reporter == null && i.email != "" && securityContext.principal in p.members) {
						"by " output(i.email) " "
					}
					"on " output(format(i.submitted)) 
					") " 
				}
				" "
				</i>
				tags(i, true)
			}
			par { output(i.description) }
			
			// output(/\n/.replaceAll("<br />", b1.text) as WikiText)
			
			attachmentList(i)
			attachmentAddition(i)
			
			image("/images/hr.png")
			
			if(i.log.length > 0) {
				par { <h2> "Issue Log" </h2> }
				par { events(i.log) }
			}
			commentAddition(i)
			noCommentAddition()
			
		}
		issueSideBar(i)
	}
}
	
define page editIssue(i : Issue) {
	title{output(i.project.name) " issue #" output(i.number) " on YellowGrass.org [editing]"}
	main(i.project)
	define body(){
		<h1> "Edit Issue " output(i.number) </h1>
		form {
			par {
				label("Title") {input(i.title)}
			}
			par {
				label("Description") {input(i.description)}
			}
			par {
				navigate(issue(i.project, i.number)) {"Cancel"}
				" "
				submit("Save",save())
			}
		}
	}
	action save(){
		i.save();
		return issue(i.project, i.number);
	}
}

define page postedIssues() {
	var postedIssues := 
		from Issue
		where _reporter = ~securityContext.principal
		order by _submitted desc
		limit 200

	title{"Issues posted by " output(securityContext.principal.name) " on YellowGrass.org [editing]"}
	main()
	define body() {
		par [class := "Back"] { 
			rawoutput { " &raquo; " }
			navigate(home()) {"Home"}
			rawoutput { " &raquo; " }
			"Posted Issues"
		}
		par { <h1> "Issues Posted by You" </h1> }
		par { issues(postedIssues.set(), true, true, true, 50, true, true) }
	}
}