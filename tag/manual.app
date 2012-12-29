module tag/manual

  template tagHelp(){
	  navigate tagManual() [class="btn btn-mini", style="height:14px;padding:7px;", title="Tag Help"] { "?" }
  }
 
page tagManual() {
	title{"How to Tag on YellowGrass"}
	main()
	define body() {
		par { <h1> "How to tag"</h1> }
		par { <h2> "Whatever You Prefer"</h2> }
		par {
			"As nothing is perfect, projects gather issues. Sometimes a few, sometimes a lot. " 
			"To keep things organized, we use tags. "
			"Tags are generally issue types, classes, versions, characteristics, etcetera. " 
			"But in reality, they can be any word of at least two characters. " 
			"Dots, hyphens, underscores and numbers are also allowed. "
			"Use tags you like and understand. "
			"Some tags are provided by default, but feel free to choose others. "
		}
			
		par { <h2> "Special Tags" </h2> }
		par {
			"Although you can choose any tag you like, two sets of tags are special, "
			"they trigger extra functionality in Yellowgrass:"
		}
		list {
			listitem { 
				<b>"@fred "</b> 
				"Assignment tags assign issues to members of the project team (fred in this case). "
				"They will for example cause issues to appear prominently on the user's home page. "
				"You can use any name after the @ symbol, but only for project members it is actually assigned. "
				"You can assign issues to users that are not member of the project yet. "
				"That way, they will have the isues assigned once they join the project. "
				"Do not worry about typos, the names are auto-completed. " 
			}
			listitem {
				<b>"!wilma "</b>
				"Follow tags have two functions. "
				"First, they make a user receive email updates "
				"and second, they represent a vote for an issue. "
				"Votes are counted and used in issue orderings, such that often-voted issues are fixed first. " 
			}
		}
		
		par { <h2> "Meta-tagging" </h2> }
		par {
			"If you really like tagging, you get a lot of tags. "
			"Fortunately, to manage your tags, you can tag tags: meta-tagging. "
			"To tag a tag, click on the tag and select the meta-tag you like from the menu on the (bottom) right. "
			"Meta-tagging is primarily used for three goals: "
		}	
		list {	
			listitem { 
				<b>"Coloring "</b>
				"To make your project page look nice, you can color tags the way you like. "
				"Select the prefered color from the menu. "
			}
			listitem { 
				<b>"Issue Types "</b>
				"There are different classes of issues, such as feature requests, bugs and improvements. "
				"Issue types are selected by an issue reporter upon issue submission. "
				"The issue types needed for a project can vary, therefore you can choose your own. "
				"Issue types are tags, that are meta-tagged 'issuetype'. "
				"To add an issue type, simply tag an issue with the prefered type, click on the new tag and select 'Make Issue Type'. "
				"To remove an issue type, click on the tag and remove the 'issuetype' meta-tag." 
			}
			listitem { 
				<b>"Versioning & Roadmap "</b>
				"Finally, we can organize issues accross versions or releases. "
				"To create a new version, tag an issue with the version number or version name you have in mind. "
				"Subsequently, select the tag and make it a release tag (in the right-hand menu). " 
				"Once you have a release tag in your project, you will automatically obtain a roadmap for your project. "
				"You will also get added functionality, such as postponing issues to a subsequent release, or closing releases. "
			}
		}
	}
}