module features

define page features() {
	title{"YellowGrass.org - The Tag-Based Issue Tracker"}
	main()
	define body() {
		par { <h1> "YellowGrass features"</h1> }
		
		
		par { 
			<h2> "Project Management" </h2>
			image("/images/projectManagement.png")
			"YellowGrass sorts its issues in projects. Users can create and manage any number of projects. "
			"Projects are open to be joined, yet any membershuip requires approval of existing members. "
		}
		par { 
			<h2> "Issue Tagging" </h2>
			image("/images/issueTagging.png")
			"Issue management in YellowGrass is tag-based. "
			"Any tag is allowed. "
			"Content completion while tagging, prevents typos and makes tagging a breeze. "
		}
		par { <h2> "Issue Assignment" </h2> }
		par { <h2> "Assigned Issues" </h2> }
		par { <h2> "Unassigned Issues" </h2> }
		par { <h2> "Issue Followers" </h2> }
		
	}
}