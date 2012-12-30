module search

  page search(p: Project, q : String) {
	  searchtmpl(p ,q)
  }
 
  page searchAllProjects(q : String) {
	  var p : Project := null;
	  searchtmpl(p ,q)
  }                     

  template searchtmpl(p : Project, q : String) {
    var query := q;
	  var issues : List<Issue>;
	  var issueSearcher := search Issue matching q limit 50;
 	
	  init{
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
				issues(issues, true, true, false, 80, true, true)
			}
	  }
  }
  
  // template searchBox(p: Project, q: String) {
  //   var query : String := q
  //   action search(q: String) { return search(p, q); }
  //   form{
  //   	input(query)
  //     submitlink search(query) [class="btn"] { iSearch }
  //   }
  // }

  template searchBox(p: Project, q: String) {
    var query : String := q
    action search(q: String) { return search(p, q); }
    form[class="navbar-form"]{
    	inputAppend{ 
    	  input(query)[placeholder="Search"] 
        submitlink search(query) [class="btn", style="height:18px; padding:5px; margin:0px;"] { iSearch }
      }
    }
  }
  