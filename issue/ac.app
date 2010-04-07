module issues/ac
  
access control rules
	
	rule template issues(is : Set<Issue>, showProjectName : Bool) {	
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool) {
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool) {
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int) {
		true
	}
	
	rule template issues(is : Set<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
		true
	}
	
	rule page issue(p : Project, number : Int) { 
		true
	}
		
	rule page editIssue(i : Issue) {
		principal in i.project.members || 
		(loggedIn && principal == i.reporter)
	}
	
	rule page createIssue(p : Project) {
		true
	}
	
	rule action updateIssueSuggestions(t : String) {
		loggedIn
	}
	
	rule action close(issue : Issue) {
		principal in issue.project.members &&
		issue.open
	}
	
	rule action reopen(issue : Issue) {
		principal in issue.project.members &&
		(!issue.open)
	}
	
	rule action newComment(text : WikiText, issue : Issue) {
		loggedIn
	}
	
	rule action commentClose(text : WikiText, issue : Issue) {
		principal in issue.project.members &&
		issue.open
	}
	
	rule template addTag(i : Issue) {
		principal in i.project.members || 
		(loggedIn && principal == i.reporter)
	}
	
	rule ajaxtemplate tagSuggestions(tagPrefix : String, i : Issue) {
		true
	}
	
	rule action addSuggestedTag(suggestion : Tag, i : Issue) {
		principal in i.project.members || 
		(loggedIn && principal == i.reporter)
	}
	
	rule page tag(p : Project, tag : String) {
		true
	}
	
	rule template tags(i : Issue, editing : Bool) {
		true
	}
	
	rule template tags(ts : List<Tag>, p : Project) {
		true
	}
	
	rule action deleteTag(i : Issue, t : Tag) {
		principal in i.project.members || 
		(loggedIn && principal == i.reporter)
	}
	
	rule page postedIssues() {
		loggedIn
	}
	
	rule ajaxtemplate issueSuggestions(t : String, p : Project) {
		loggedIn
	}
	
	rule action showIssueMoveTargets(issue : Issue){
		principal in issue.project.members && 
		principal.projects.length > 1
	}
	
	rule ajaxtemplate issueMoveTargets (issue : Issue){
		principal in issue.project.members && 
		principal.projects.length > 1
	}