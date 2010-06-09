module issue/ac

imports issue/issue
imports project/project
imports user/user
imports issue/tag

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
	
	rule template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
		true
	}
	
	rule page issue(p : Project, number : Int) { 
		true

		rule action close(issue : Issue) {
			principal in issue.project.members &&
			issue.open
		}
		
		rule action reopen(issue : Issue) {
			principal in issue.project.members &&
			(!issue.open)
		}
		
		rule action vote(issue : Issue) {
			loggedIn && !issue.hasTag("!"+principal.tag) && !(principal == issue.reporter)
		}
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
		( 
			from Tag
			where _name=~tag and _project=~p
			limit 1
		).length > 0
		
		rule action makeRelease(tag : Tag, p : Project) {
			principal in p.members && !tag.hasTag("release")
		}
	}
	
	rule template tags(i : Issue, editing : Bool) {
		true
	}
	
	rule template tags(i : Issue, editing : Bool, summary : Bool) {
		true
		rule action deleteTag(i : Issue, t : Tag) {
			principal in i.project.members || 
			(loggedIn && principal == i.reporter)
		}
	}
	
	rule template tags(t : Tag, editing : Bool) {
		true
		rule action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
			principal in tagToRemoveFrom.project.members
		}
	}
	
	rule template tags(ts : List<Tag>, p : Project) {
		true
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

	rule template attachmentAddition(i : Issue) {
		principal in i.project.members || 
		principal == i.reporter
	}
	
	rule template attachmentAdditionInput(i : Issue) {
		principal in i.project.members || 
		principal == i.reporter
	}
	
	rule ajaxtemplate attachmentList(i : Issue) {
		true		
		rule action deleteAttachment(a : Attachment) {
			principal in i.project.members || 
			principal == i.reporter
		}
		rule action attachmentList_inline_action0(a : Attachment) {	// Bug in WebDSL: workaround
			true
		}
	}