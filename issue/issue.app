module issue/issue

imports issue/ac
imports comment/comment
imports issue/emails
imports issue/tag

entity Issue {
	// TODO add optional user association
	number		:: Int
	title		:: String
	description	:: WikiText
	submitted 	:: DateTime
	project		-> Project (inverse = Project.issues)
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
	
	function mailinglist() : Set<Email> {
		var mailinglist := [u.email | u : User in this.project.members];
		if(reporter != null && !(reporter in project.members)) {
			mailinglist.add(reporter.email);
		}
		if(reporter == null && email != "") {
			mailinglist.add(email);
		}
		return mailinglist;
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
		comments.add(c);
		this.save();
		for(e : Email in mailinglist()){
			email(issueCommentNotification(this, e, c));
		}
	}
	function commentClose(c : Comment) {
		comments.add(c);
		close();
		this.save();
		for(e : Email in mailinglist()){
			email(issueCommentCloseNotification(this, e, c));
		}
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
					if(i.open || (!showTicks)) { 
						"" 
					} else {
						image("/images/tick.png") 
					}
					if(showTags) { 
						tags(i, false)
					}
				}
			}
		}
	}
}

define page issue(p : Project, issueNumber : Int) {
	var issuesWithNumber : List<Issue> := 
		from Issue as i
		where i._project = ~p and i._number = ~issueNumber
		limit 1;
	if(issuesWithNumber.length == 0) {
		var i := Issue {};
	} else {
		var i := issuesWithNumber.get(0);
	}
	
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
				output(i.title)
				" "
				if(i.reporter != null) {
					"(by " navigate(user(i.reporter)){output(i.reporter.name) ")"}
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
			if(securityContext.loggedIn) {
				var newCommentText : WikiText := "";
				par { <h2> "Add Comment" </h2> }
				form {
					par { input(newCommentText) }
					par { 
						action("Post Comment", newComment(newCommentText, i)) 
						action("Post Comment & Close", commentClose(newCommentText, i)) 
					}
				}
			} else {
				par { <i> "Log in to post comments" </i> }
			}
		}
		block [class := "sidebar"] {
			par { 
				<h1> "Issue " output(i.number) </h1>
			}
			sidebarSeparator()
			par { navigate(editIssue(i))	{"Edit this Issue"}}
			par { actionLink("Close Issue", close(i) ) }
			par { actionLink("Reopen Issue", reopen(i) ) }
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
	action newComment(text : WikiText, issue : Issue) {
		var comment := createComment(text);
		issue.addComment(comment);
		return issue(issue.project, issue.number);
	}
	action commentClose(text : WikiText, issue : Issue) {
		var comment := createComment(text);
		issue.commentClose(comment);
		return project(issue.project);
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
				navigate(project(i.project)) {"Cancel"}
				" "
				submit("Save",save())
				action save(){
					i.save();
					return issue(i.project, i.number);
				}
			}
		}
	}
}

define page createIssue(p : Project) {
	title{"YellowGrass.org - " output(p.name) " - New Issue"}
	main()
	define body(){
		var i := Issue{ type := improvementIssueType };
		var email : Email := "" 
		<h1> "Post New Issue" </h1>
		form { 
			par { label("Title") {input(i.title)} }
			par {
				label("Type") {
					select(i.type from [improvementIssueType, errorIssueType, featureIssueType, questionIssueType])
				}
			}
			par { label("Description") {input(i.description)} }
			if(!securityContext.loggedIn) {
				par { label("Email") {input(email)} }
				par { captcha() }
			}
			
			par{
				navigate(project(p)) {"Cancel"}
				action("Post",post())
				action post(){
					i.submitted := now();
					i.project := p;
					i.number := newIssueNumber(p);
					i.open := true;
					i.reporter := securityContext.principal;
					i.email := email;
					if (p.members.length == 1) {
						i.tags.add(tag("@"+p.members.list().get(0).tag, p));
					}
					i.save();
					i.notifyProjectMembers();
					return issue(p, i.number);
				}
			}
		}
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
