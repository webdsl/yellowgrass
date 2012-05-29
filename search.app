module search

define page search(p: Project, q : String) {
	searchtmpl(p ,q)
}
define page searchAllProjects(q : String) {
	var p : Project := null;
	searchtmpl(p ,q)
}                        

define searchtmpl(p : Project, q : String) {
	var issues : List<Issue>;
	var issueSearcher := search Issue
	 matching q
	 limit 50;
 
			
	init{
		if (p != null) {
			~issueSearcher with filters project.name : p.name;
			
		} else {
			~issueSearcher with filters project.private : false;
		}
		issues := issueSearcher.results();
	}	
	
	title{"YellowGrass.org - Search"}
	main(p)
	define body() {
		par { <h1> "Results for " output(q) </h1> }
		block [class := "Listing"] {
			table {
				issues(issues, true, true, false, 80, true, true)
			}
		}	
	}
}
