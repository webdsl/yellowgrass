module search

define page search(q : String) {
	// TODO combine to a decent query
	var issues := searchIssue(q, 200).set()
	var publicIssues := [i | i : Issue in issues where !i.project.private limit 50]
	
	title{"YellowGrass.org - Search"}
	main()
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		block [class := "Listing"] {
			table {
				for(i : Issue in publicIssues) {
					row {
						output(i.number)
						output(i.submitted.format("MMM d")) // TODO Add year if needed
						output(	abbreviate(i.project.name, 20))
						navigate(issue(i.project, i.number)) {
							output(abbreviate(i.getTitle(), 80))
						}
					}
				}
			}
		}
	}
}