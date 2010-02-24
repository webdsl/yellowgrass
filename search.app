module search

define page search(q : String) {
	var issues := searchIssue(q, 50).set()
	
	title{"YellowGrass.org - Search"}
	main()
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		block [class := "Listing"] {
			table {
				for(i : Issue in issues) {
					row {
						output(i.number)
						output(i.submitted.format("MMM d")) // TODO Add year if needed
						output(	abbreviate(i.project.name, 20))
						navigate(issue(i.project, i.number)) {
							output(abbreviate(i.title, 80))
						}
					}
				}
			}
		}
	}
}