module project/settings

imports issue/types

  page edit(p : Project) {
	  title{output(p.name) " on YellowGrass.org [Editing]"}
	  bmain(p){  
      projectToolbar(p) 
		  pageHeader2{ "Edit Project " output(p.name) } 
		  horizontalForm {
			  controlGroup("Project name") { input(p.name) }
			  controlGroup("Project description") { input(p.description)}
			  controlGroup("Project web page") { input(p.url) }
			  controlGroup("Project mailing list") { input(p.email) }
			  controlGroup("Project is private") { input(p.private) }
			  formActions{
			    submitlink save() [class="btn btn-primary"] { "Save" } " "
				  navigate project(p) [class="btn"] {"Cancel"}
				}
			}
		  if(p.members.length > 1) {
			  pageHeader3{ "Leave project" }
			  par {
				  "Note that upon leaving, issues in this project assigned to you will no longer be assigned. "
				  "However, upon leaving a project, no issues will be lost. "
			  }
			  submitlink leaveProject(p) [class="btn"] { output("Leave Project " + p.name) }
		  }
		  pageHeader3{ "Regenerate Issue Types" }
		  par {
			  "Issue types (e.g. 'error' and 'feature') are used to categorize issues. "
			  "They can be constructed manually as tags that are flagged as issue types. "
			  "A small set of default types is automatically generated on project creation. "
			  "This default set can be regenerated without loss of other issue types: "	  
		  }	
		  submitlink regenerateIssueTypes(p) [class="btn"] { "Regenerate default issue types" }
	  }
	  action save(){
		  return project(p);
	  }
	  action leaveProject(p : Project) {
		  p.members.remove(securityContext.principal);
		  tagCleanup(tag("@"+securityContext.principal.tag, p));
		  return home();
	  }
	  action regenerateIssueTypes(p : Project) {
		  createIssueTypes(p);
		  return project(p);
	  }
  }
