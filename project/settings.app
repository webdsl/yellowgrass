module project/settings

imports issue/types

define page edit(p : Project) {
	title{output(p.name) " on YellowGrass.org [Editing]"}
	main()
	define body(){
		<h1> "Edit Project" </h1>
		form {
			par {
				label("Project name") { input(p.name) }
			}
			par {
				label("Project description") { input(p.description)}
			}
			par {
				label("Project web page") { input(p.url) }
			}
			par {
				label("Project is private") { input(p.private) }
			}
			par {
				navigate(project(p)) {"Cancel"}
				" "
				action("Save",save())
			}
		}
		if(p.members.length > 1) {
			<h1> "Leave project" </h1>
			par {
				"Note that upon leaving, issues in this project assigned to you will no longer be assigned. "
				"However, upon leaving a project, no issues will be lost. "
				actionLink("Leave Project " + p.name, leaveProject(p))
			}
		}
		<h1> "Regenerate Issue Types" </h1>
		par {
			"Issue types (e.g. 'error' and 'feature') are used to categorize issues. "
			"They can be constructed manually as tags that are flagged as issue types. "
			"A small set of default types is automatically generated on project creation. "
			"This default set can be regenerated without loss of other issue types: "
			actionLink("Regenerate default issue types", regenerateIssueTypes(p))
		}		
	}
	action save(){
		p.save();
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
