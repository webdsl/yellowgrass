module search

define page search(p: Project, q : String) {
	var issueSearcher := 
		IssueSearcher()
		.filterByField("project.name",p.name)
		.filterByField("project.private", "false")
	var issues:List<Issue> := issueSearcher.query(q).maxResults(50).list()
	
	title{"YellowGrass.org - Search"}
	main(p)
	title{"YellowGrass.org - Search"}
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		block [class := "Listing"] {
			table {
				issues(issues, true, true, false, 80, true, true)
			}
		}
	}
}
 
define page searchAll(q : String) {
	var issueSearcher := 
		IssueSearcher()
		.filterByField("project.private", "false")
	var issues:List<Issue> := issueSearcher.query(q).maxResults(50).list()
	main()
	title{"YellowGrass.org - Search"}
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		block [class := "Listing"] {
			table {
				issues(issues, true, true, false, 80, true, true)
			}
		}
	}
}
