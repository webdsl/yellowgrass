module project/settings

imports issue/types

  page edit(project : Project) {
	  title{output(project.name) " on YellowGrass.org [Editing]"}
	  bmain(project){  
      projectToolbar(project) 
		  pageHeader2{ "Edit Project " output(project.name) } 
		  horizontalForm {
			  controlGroup("Project name") { input(project.name) }
			  controlGroup("Project description") { input(project.description)}
			  controlGroup("Project web page") { input(project.url) }
			  controlGroup("Project mailing list") { 
			  	input(project.email) 
			  	helpBlock{ "Warn: When a mailing list is set, notifications will only be sent to the mailing list and not to individual members of the project." }
			  }
			  controlGroup("Project notifications enabled"){ input(project.notifications) }
			  controlGroup("Project is private") { input(project.private) }
			  formActions{
			    submitlink save() [ignore default class, class="btn btn-primary"] { "Save" } " "
				  navigate project(project) [submit attributes] {"Cancel"}
				}
			}
		  if(project.members.length > 1) {
			  pageHeader3{ "Leave project" }
			  par {
				  "Note that upon leaving, issues in this project assigned to you will no longer be assigned. "
				  "However, upon leaving a project, no issues will be lost. "
			  }
			  submitlink leaveProject(project) [] { output("Leave Project " + project.name) }
		  }
		  pageHeader3{ "Regenerate Issue Types" }
		  par {
			  "Issue types (e.g. 'error' and 'feature') are used to categorize issues. "
			  "They can be constructed manually as tags that are flagged as issue types. "
			  "A small set of default types is automatically generated on project creation. "
			  "This default set can be regenerated without loss of other issue types: "	  
		  }	
		  submitlink regenerateIssueTypes(project) [] { "Regenerate default issue types" }
	  }
	  action save(){
	    project.setName(project.name); 
		return project(project);
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
