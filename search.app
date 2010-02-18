module search

define page search(q : String) {
	title{"YellowGrass.org - Search"}
	main()
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		issues(searchIssue(q, 50).set(), true, true, true, 100, true)
	}
}