module issue/ghost

entity IssueGhost {
	title		:: String	(validate(title.length() >= 5, "Use a longer and more descriptive title"))
	description	:: WikiText
	project		-> Project
	email		:: Email
	tags		-> Set<Tag>
	alive		:: Bool
	
	function tryRealize() : Issue {
		if(!alive) {
			return realize();
		} else {
			return null;
		}
	}
	
	function realize() : Issue {
		var i := Issue{
			number := newIssueNumber(this.project)
			title := this.title
			description := this.description
			submitted := now()
			project := this.project
			open := true
			email := this.email
			tags := this.tags
			reporter := securityContext.principal
		};
		i.assign();
		i.save();
		alive := true;
		flush();
		i.notifyRegister();
		return i;
	}
}

define page issueConfirmation() {
	title{"New issue created, please confirm"}
	main()
	define body(){
		<h1>"Issue Submitted and Awaiting Confirmation"</h1>
		par{
			"Your issue has successfully been submitted to YellowGrass. " 
			"You should receive a confirmation email from YellowGrass shortly. "
			"Please click on the link in this email to confirm issue submission. "
		}
		par{
			"Do you not want to confirm issues any longer? " 
			navigate(registerUser()){"Register!"}
			" It's free"
		} 
	}
}

define page confirmGhost(g : IssueGhost) {
	var i : Issue := g.tryRealize();
	
	title{output(g.project.name) " - Issue Confirmed"}
	main(g.project)
	define body(){
		<h1>"Issue Confirmed"</h1>
		par{
			"Thank you for submitting this issue."
		}
		if(i != null) {
			par{
				"You can follow its progress on "
				navigate(issue(i.project, i.number)){"the issue page"}
				"."
			}
		} 
	}
}

define email issueConfirmationEmail(g : IssueGhost) {
	to(g.email)
	from(EMAIL_FROM())
	subject("Confirm issue submission to "+g.project.name+" on YellowGrass")
	par {
		"Thank you for submitting an issue to " output(g.project.name) "."
		"Please confirm submission by visiting "
		navigate(confirmGhost(g)){"the confirmation page"}
		"."
	}
	par {" -- http://yellowgrass.org -- " }
}
