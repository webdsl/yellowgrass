module issue/issue

imports issue/ac
imports comment/comment
imports comment/event
imports comment/issueControl
imports issue/emails
imports issue/register
imports issue/sidebar
imports user/user
imports project/project
imports issue/attachment
imports issue/types
imports issue/issueBrowser

entity Issue {
	// TODO add optional user association
	number		:: Int		(searchable)
	title		:: String	(searchable, validate(title.length() >= 5, "Use a longer and more descriptive title"))
	description	:: WikiText (searchable)
	submitted 	:: DateTime
	project		-> Project	(inverse = Project.issues)
	reporter	-> User
	type		-> IssueType
	open		:: Bool
	log			-> Set<Event>
	tags		-> Set<Tag>
	email		:: Email // Only when reporter == null
	nrVotes		:: Int := [ t | t : Tag in tags where /!.*/.match(t.name)].length
	attachments -> Set<Attachment>
	
	projectName  :: String (searchable) := project.name
	reporterName :: String (searchable) := getReporterName()
	
	function getReporterName() : String {
		if (reporter != null && reporter.name != null) {
			return reporter.name;
		} else {
			return "";
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
	
	function mailinglist() : Set<Email> {
		var mailinglist := Set<Email>();
		if(project.email != null && project.email != "") {
			mailinglist.add(project.email);
		} else {
			for(u : User in this.project.members) {
				if(u.notifications) {
					mailinglist.add(u.email);
				}
			}
		}
		
		if(reporter != null && !(reporter in project.members)) {
			mailinglist.add(reporter.email);
		}
		if(reporter == null && email != "") {
			mailinglist.add(email);
		}
		
		var commenters := [(e as Comment).author.email | e : Event in log where e is a Comment];
		mailinglist.addAll(commenters);
		
		var followers : Set<User> := getFollowers(tags);
		mailinglist.addAll([u.email | u : User in followers]);
		
		if(securityContext.principal != null) {
			mailinglist.remove(securityContext.principal.email);
		}
		
		return mailinglist;
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
	issues(is, showProjectName, showTicks, showNumbers, titleLength, false)
}

define template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
	issues([i | i : Issue in is.list()  order by i.submitted desc], 
		showProjectName, showTicks, showNumbers, titleLength, showTags)
}

define template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
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
						if(now().format("yyyy") == i.submitted.format("yyyy")) {
							block[class := "DateMD"] { output(i.submitted.format("MMM d")) }
						} else {
							block[class := "DateMDY"] { output(i.submitted.format("MMM d yyyy")) }
						}
					}
					if(showProjectName) {
						column { output(abbreviate(i.project.name, 20)) }
					}
					column { 
						block[class := "AbbreviatedIssueTitle"] {
							navigate(issue(i.project, i.number)) {
								output(abbreviate(i.title, titleLength))
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
	var i := getIssue(p, issueNumber)
	
	title{"#" output(i.number) " " output(i.title) " (project " output(i.project.name) " on YellowGrass.org)"}
	main()
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
				output(i.title) 
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
					"on " output(i.submitted.format("MMM d")) // TODO Add year if needed 
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
	
// TODO Adapt this to the new issue types
define page editIssue(i : Issue) {
	title{output(i.project.name) " issue #" output(i.number) " on YellowGrass.org [editing]"}
	main()
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
		par { issues(postedIssues.set(), true, true, true, 50, true) }
	}
}