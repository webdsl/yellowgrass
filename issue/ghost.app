module issue/ghost

imports emails
imports templates
imports issue/-
imports project/project-model
imports tag/tag-model
imports user/register

imports elib/elib-bootstrap/lib

section data model

  entity IssueGhost {
	  title		    :: String	(validate(title.length() >= 5, "Use a longer and more descriptive title"))
	  description	:: WikiText
	  project		  -> Project
	  email		    :: Email 	(validate(loggedIn() || email != null && email != "", "Please enter an email address"))
	  tags		    -> Set<Tag>
	  alive		    :: Bool
	
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
  
section view

  page issueConfirmation() {
	  title{"New issue created, please confirm"}
	  bmain{
		  pageHeader2{ "Issue Submitted and Awaiting Confirmation" }
		  par{
			  "Your issue has successfully been submitted to YellowGrass. " 
			  "You should receive a confirmation email from YellowGrass shortly. "
			  "Please click on the link in this email to confirm issue submission. "
		  }
		  par{
			  "Do you not want to confirm issues any longer? " 
			  navigate registerUser() {"Register!"}
			  " It's free"
		  } 
	  }
  }

  page confirmGhost(g : IssueGhost) {
	  var i : Issue := g.tryRealize();
	
	  title{output(g.project.name) " - Issue Confirmed"}
	  bmain(g.project){
		  pageHeader2{ "Issue Confirmed" }
		  par{
			  "Thank you for submitting this issue."
		  }
		  if(i != null) {
			  par{
				  "You can follow its progress on "
				  navigate issue(i.project, i.number) {"the issue page"}
				  "."
			  }
		  } 
	  }
  }

  email template issueConfirmationEmail(g : IssueGhost) {
	  to(g.email)
	  from(EMAIL_FROM())
	  subject("Confirm issue submission to "+g.project.name+" on YellowGrass")
	  par {
		  "Thank you for submitting an issue to " output(g.project.name) "."
		  "Please confirm submission by visiting "
		  navigate confirmGhost(g) {"the confirmation page"}
		  "."
	  }
	  par {" -- http://yellowgrass.org -- " }
  }
