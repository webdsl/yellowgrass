module project/roadmap

imports built-in
imports auxiliary
imports templates
imports templates-bootstrap
imports issue/issue
imports issue/issue-model
imports project/project-model
imports project/sidebar
imports tag/release
imports tag/tag
imports tag/tag-model

imports elib/elib-bootstrap/lib

section project roadmap

  page roadmap(p : Project) {
    var releases := releases(p); 
	  continuousLoading()
	  title{output(p.name) " Roadmap - on YellowGrass.org"}
	  bmain(p){		
      projectToolbar(p) 
		  gridRow{
		    gridCol(12){
			    pageHeader2{ "Roadmap" }
			    placeholder "releases" roadmapRelease( releases[0], 50)
			  }
		  }
		}
	}
	
  ajax template roadmapRelease(r : Tag, issuesToShow : Int) {
	  var previousRelease := previousRelease(r);
	  var issues := releaseIssues(r);
	  var completed := completed(issues);
	  var releaseDone := releaseDone(r);
	  var issuesLeftToShow := issuesToShow - issues.length;
	  pageHeader2{ 
		  navigate tag(r.project, r.name) { output(r.name) } 
		  " (" if(!releaseDone) { output(completed[0]) "/" } output(completed[1]) ") "
		  
		  if(r.description != null && r.description != "") {
			  output(" -- ") <i> output(r.description) </i>
		  }
	  } 
	  if(!releaseDone) {
	    gridRow{	    
        gridCol(6) { progressBar(completed[0],completed[1])  }
	      pullRight{
	        par { submitlink postponeOpen(r) [] { "Postpone Open Issues to " output(nextRelease(r).name) } }
	      }
	    }
    }
	  issues(issues, false, true, true, 50, true, true)
	  if(previousRelease != null) {
		  if(issuesLeftToShow > 0){
		    roadmapRelease(previousRelease, issuesLeftToShow)
		  } else {
        block[class="Ghost"] {
	        submitlink showPreviousRelease(previousRelease) [id="continuousLoader"+r.name+r.id, ignore default class, class="btn btn-default continuousLoader"] { "Show More" }
	      } 
		  }
	  }
	
	  action postponeOpen(release : Tag) {
		  var nextRelease : Tag := nextRelease(release);
		  for(i : Issue in releaseIssues(release)) {
			  if(i.open) {
				  i.deleteTag(release);
				  i.addTag(nextRelease);
			  }
		  }
	  }
	  action showPreviousRelease(release : Tag) {
		  if(release != null) {
			  append("releases", roadmapRelease(release, 50));
		  }
	  }
  }
  
  