module issue/sidebar

define template issueSideBar(i : Issue) {
	block [class := "sidebar"] {
		projectCommands(i.project)
		sidebarSeparator()
		issueCommands(i)
	}
}

define template issueCommands(i : Issue) {
	par { <h1> "Issue " output(i.number) </h1> }
	par { navigate(editIssue(i))	{"Edit Issue"}}
	par { actionLink("Close Issue", close(i) ) }
	par { actionLink("Reopen Issue", reopen(i) ) }
	par { actionLink("Vote and follow Issue", vote(i) ) }
	par { actionLink("Move Issue To", showIssueMoveTargets(i)) [ajax] }
	par [class := "IssueMoveTargets"] { placeholder issueMoveTargetsBox {} }
	par { addTag(i) }
	
	
	action close(issue : Issue){
		issue.close();
		issue.save();
		issue.notifyClose();
		return issue(issue.project, issue.number);
	}
	action reopen(issue : Issue){
		issue.reopen();
		issue.save();
		issue.notifyReopen();
		return issue(issue.project, issue.number);
	}
	action vote(issue : Issue){
		var tag := tag("!" + securityContext.principal.tag, issue.project);
		issue.addTag(tag);
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
			submitted := now()
			project := p
			number := newIssueNumber(p)
			open := true
			reporter := old.reporter
			email := old.email
		};
		new.assign();
		new.save();
		
		var moveComment := Comment {
			moment := now()
			text := "Issue has been moved to [" + p.name + "](/project/" + p.name + ") / " +
					"[Issue " + new.number + "](/issue/" + p.name + "/" + new.number + ")" 
			author := yellowGrass
		};
		old.log.add(moveComment);
		old.close();
		old.save();
		flush();
		new.notifyRegister();
		return issue(p, new.number);
	}
}

