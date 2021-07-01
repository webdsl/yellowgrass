module features

imports built-in
imports templates
imports tag/manual

define page features() {
	title{"The features of YellowGrass.org - The Tag-Based Issue Tracker"}
	main()
	define body() {
		par { <h1> "YellowGrass in a Nutshell"</h1> }
		par {
			"In YellowGrass you can collect, manage and process issues. " 
			"It has a strong focus on usability, flexibility and availability. " 
			"Using highly flexible tag-based issue management, YellowGrass is suitable for small and large-scale projects. " 
		} 
			
		par { <h2> "Project Management" </h2> }
		list {
			listitem { "Create any number of projects" }
			listitem { "Join projects by issuing a project membership request" }
			listitem { "Move issues back and forth between projects" }
			listitem { "Choose your project to be private (closed) or public (open)" }
			listitem { "Vote for issues to increase their priority" }
		}
		
		par { <h2> "Tags Everywhere" </h2> }
		list {
			listitem { "Use any tag you like, as long as it is text, it will do" }
			listitem { "Use tags to group, categorize or subdivide issues within a project" }
			listitem { "Decide on your own priority scheme" }
			listitem { "Assign isues to software components or subprojects" }
			listitem { "Filter issues on tags" }
		}
		
		par { <h2> "What's Up?" </h2> }
		list {
			listitem { "Users and projects get YellowGrass home pages showing most recent issues, most popular issues, recent open issues, issues you have reported, etc. " }
			listitem { "Quickly search issues and browse tags " }
			listitem { "Receive email updates for your projects" }
			listitem { "Receive email updates for issues you reported, commented on, or voted for" }
		}
			
		par { <h2> "Software Releases" </h2> }
		list {
			listitem { "Use any release 'number' as release tag" }
			listitem { "Assign issues to future or past releases" }
			listitem { "Release tags receive dedicated support, such as coloring, filtering and use on project pages" } 
			listitem { "Use automatically created road maps and change logs" }
		}
		
		par { <h2> "Tagging Ninja" </h2> }
		list {
			listitem { "Assign issues to project members using '@fred' tags" }
			listitem { "Follow reported issues using '!wilma' tags" }
			listitem { "Tag tags (meta tagging), to call on dedicated behavior of YellowGrass, such as tag coloring, ordering and road maps" }
			listitem { "Want to know more about tags? Visit the " navigate(tagManual()){"tag manual"}}
		}	
	}
}