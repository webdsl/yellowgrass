module search

define page search(p: Project, q : String) {
	var issueSearcher := 
		IssueSearcher()
		.fields(["comments","title","description","projectName","reporterName"])
		.filterByField("project.name",p.name)
		.filterByField("project.private", "false")
	var issues := issueSearcher.query(q).maxResults(50).list()
	
	title{"YellowGrass.org - Search"}
	main(p)
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		block [class := "Listing"] {
			table {
				issues(issues, true, false, false, 80, true, true)
			}
		}
	}
}