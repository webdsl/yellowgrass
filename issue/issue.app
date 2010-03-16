module issue/issue

imports issue/ac
imports comment/comment
imports issue/emails
imports issue/tag
imports issue/register
imports user/user

entity Issue {
	// TODO add optional user association
	number		:: Int		(searchable)
	title		:: String	(searchable, validate(title.length() >= 5, "Use a longer and more descriptive title"))
	description	:: WikiText (searchable)
	submitted 	:: DateTime
	project		-> Project	(inverse = Project.issues)
	projectName :: String 	(searchable) := project.name	// TODO Does not work yet
	reporter	-> User
	type		-> IssueType
	open		:: Bool
	comments	-> Set<Comment>
	tags		-> Set<Tag>
	email		:: Email // Only when reporter == null
	
	function close() {
		open := false;
	}
	function reopen() { 
		open := true;
	}
	function notifyProjectMembers() {
		for(u : User in project.members){
			email(issueNotification(this, u.email));
		}
	}
	
	function mailinglist(ignore : Email) : Set<Email> {
		var mailinglist := [u.email | u : User in this.project.members];
		
		if(reporter != null && !(reporter in project.members)) {
			mailinglist.add(reporter.email);
		}
		if(reporter == null && email != "") {
			mailinglist.add(email);
		}
		
		var commenters := [c.author.email | c : Comment in comments];
		mailinglist.addAll(commenters);
		
		var followers : Set<User> := getFollowers(tags);
		mailinglist.addAll([u.email | u : User in followers]);
		
		mailinglist.remove(ignore);
		
		return mailinglist;
	}
	
	function notifyClose() {
		for(e : Email in mailinglist(securityContext.principal.email)){
			email(issueCloseNotification(this, e));
		}
	}
	function notifyReopen() {
		for(e : Email in mailinglist(securityContext.principal.email)){
			email(issueReopenNotification(this, e));
		}
	}
	function addComment(c : Comment) {
		comments.add(c);
		this.save();
		for(e : Email in mailinglist(c.author.email)){
			email(issueCommentNotification(this, e, c));
		}
	}
	function commentClose(c : Comment) {
		comments.add(c);
		close();
		this.save();
		for(e : Email in mailinglist(c.author.email)){
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

entity IssueType {
	name	:: String	(id)
}

var improvementIssueType : IssueType := 
	IssueType { name := "Improvement" };
var errorIssueType : IssueType := 
	IssueType { name := "Error" };
var featureIssueType : IssueType := 
	IssueType { name := "New Feature" };
var questionIssueType : IssueType := 
	IssueType { name := "Question" };

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
	block [class := "Listing"] {
		table {
			for(i : Issue in is order by i.submitted desc) {
				row {
					if(showNumbers) {
						output(i.number)
					}
					output(i.submitted.format("MMM d")) // TODO Add year if needed
					if(showProjectName) {
						output(
							abbreviate(i.project.name, 20))
					}
					navigate(issue(i.project, i.number)) {
						output(abbreviate(i.title, titleLength))
					}
					if(showTags) { 
						tags(i, false)
					}
					if(i.open || (!showTicks)) { 
						"" 
					} else {
						image("/images/tick.png") 
					}
				}
			}
		}
	}
}

define page issue(p : Project, issueNumber : Int) {
	var i := getIssue(p, issueNumber)
	
	title{"YellowGrass.org - " output(i.project.name) " - #" output(i.number)}
	main()
	define body(){
		block [class := "main"] {
			if(securityContext.loggedIn) {
				par [class := "Back"] {
					" È " 
					navigate(home(securityContext.principal)) {"Home"}
					" È "
					navigate(project(i.project)) {"Project " output(i.project.name)}
					" È "
					"Issue " output(i.number)
				}
			} else {
				par [class := "Back"] { navigate(project(i.project)) {"Ç To Project"} }
			}
			
			par{ <h2> 
				output(i.project.name) 
				" #" output(i.number)
				" - " output(i.type.name)
				" ("  output(i.submitted.format("MMM d")) ") " // TODO Add year if needed
				if(!i.open) {
					image("/images/tick.png")
				}
				</h2>
			}
			par{
				<i> 
				block [class := "IssueTitle"] {
					output(i.title)
				}
				" "
				if(i.reporter != null) {
					"(by " navigate(user(i.reporter.tag)){output(i.reporter.name) ")"}
				}
				if(i.reporter == null && i.email != "" && securityContext.principal in p.members) {
					"(by " output(i.email) ")"
				}
				</i>
				tags(i, true)
			}
			par { output(i.description) }
			if(i.comments.length > 0) {
				par { <h2> "Comments" </h2> }
				par { comments(i, i.comments) }
			}
			commentAddition(i)
			noCommentAddition()
		}
		block [class := "sidebar"] {
			par { 
				<h1> "Issue " output(i.number) </h1>
			}
			sidebarSeparator()
			par { navigate(editIssue(i))	{"Edit this Issue"}}
			par { actionLink("Close Issue", close(i) ) }
			par { actionLink("Reopen Issue", reopen(i) ) }
			par { actionLink("Move Issue To", showIssueMoveTargets(i)) [ajax] }
			par [class := "IssueMoveTargets"] { placeholder issueMoveTargetsBox {} }
			par { navigate(createIssue(p))	{"New Issue"} }
			par { addTag(i) }
		}
	}
	action close(issue : Issue){
		issue.close();
		issue.save();
		issue.notifyClose();
		return project(issue.project);
	}
	action reopen(issue : Issue){
		issue.reopen();
		issue.save();
		issue.notifyReopen();
		return issue(issue.project, issue.number);
	}
	action showIssueMoveTargets(issue : Issue){
		replace(issueMoveTargetsBox, issueMoveTargets(issue));
	}
}

define ajax issueMoveTargets (i : Issue){
	for(p : Project in securityContext.principal.projects) {
		if(p != i.project) {
			par{ form{ actionLink(p.name, moveIssue(i, p)) [ajax] }}
		}
	}
	action moveIssue(old : Issue, p : Project) {
		var new := Issue {
			title := old.title
			description := old.description
			type := old.type
			submitted := old.submitted
			project := p
			number := newIssueNumber(p)
			open := true
			reporter := old.reporter
			email := old.email
		};
		new.assign();
		new.save();
		
		var moveComment := Comment {
			submitted := now()
			text := "Issue has been moved to [" + p.name + "](/project/" + p.name + ") / " +
					"[Issue " + new.number + "](/issue/" + p.name + "/" + new.number + ")" 
			author := yellowGrass
		};
		old.comments.add(moveComment);
		old.close();
		old.save();
		flush();
		new.notifyProjectMembers();
		return issue(p, new.number);
	}
}

define page editIssue(i : Issue) {
	title{"YellowGrass.org - " output(i.project.name) " - #" output(i.number)}
	main()
	define body(){
		<h1> "Edit Issue " output(i.number) </h1>
		form {
			par {
				label("Title") {input(i.title)}
			}
			par {
				label("Type") {
					select(i.type from [improvementIssueType, errorIssueType, featureIssueType, questionIssueType])
				}
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

	main()
	define body() {
		par [class := "Back"] { 
			" È "
			navigate(home(securityContext.principal)) {"Home"}
			" È "
			"Posted Issues"
		}
		par { <h1> "Issues Posted by You" </h1> }
		par { issues(postedIssues.set(), true, true, true, 60, true) }
	}
}

function prefix(s : List<Issue>, length : Int) : List<Issue> {
	if(s.length <= length) {
		return s;
	} else {
		s.removeAt(length);
		return prefix(s, length);
	}
}
