module search

imports templates
imports issue/issue
imports issue/issue-model
imports project/project-model
imports project/sidebar

imports elib/elib-bootstrap/lib
imports elib-bootstrap-3/icons

  page search(p: Project, q : String) {
	  searchtmpl(p ,q)
	  <script>$('.search-bar').val('~q');</script>
  }
 
  page searchAllProjects(q : String) {
	  var p : Project := null;
	  searchtmpl(p ,q)
  }                     

  template searchtmpl(p : Project, q : String) {
      var query := q;
	  var issues : List<Issue>;
	  var issueSearcher := search Issue [loose matching, no lucene] limit 50;
	   	
	  init{
	  	  //matches in title and description are more important
	  	  issueSearcher.boost("title", 5.0);
	  	  issueSearcher.boost("description", 3.0);
	  	  //rank results higher when words appear next (at most 5 terms) to each other
	  	  ~issueSearcher matching q~5 q;
		  if (p != null) {
			  ~issueSearcher with filters project.name : p.name;
		  } else {
			  ~issueSearcher with filters project.private : false;
		  }  
		  issues := issueSearcher.results();
	  }	
	
	  title{"YellowGrass.org - Search"}
	  bmain(p){
	    projectToolbar(p) 
	    pageHeader{ "Search results for '" output(q) "'" } 
	    gridRow{ pullRight{ searchBox(p, q) } }
			tableBordered {
				highLightedIssues(issues, true, true, false, 80, true, true, issueSearcher)
			}
	  }
  }
  
  // template searchBox(p: Project, q: String) {
  //   var query : String := q
  //   action search(q: String) { return search(p, q); }
  //   form{
  //   	input(query)
  //     submitlink search(query) [] { iSearch }
  //   }
  // }

  template searchBox(p: Project, q: String) {
    var query : String := q
    action search(newq: String) { return search(p, newq); }
    form[class="navbar-form"]{
    	inputAppend{ 
    	  input(query)[placeholder="Search", class="span2 search-bar"]  
          inputGroupButton{ submitlink search(query) [] { iSearch } }
      }
    }
  }
  
  // template searchBoxInToolbar(p: Project, q: String) {
  //   var query : String := q
  //   action search(q: String) { return search(p, q); }
  //   form[class="navbar-form"]{
  //     input(query)[placeholder="Search", class="span2"]  
  //     submitlink search(query) [style="height:18px; padding:5px; margin:0px;"] { iSearch }
  //   }
  // }
  
  
