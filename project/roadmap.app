module project/roadmap

imports issue/issue

section project roadmap

  page roadmap(p : Project) {
    var releases := releases(p)   
	  continuousLoading()
	  title{output(p.name) " Roadmap - on YellowGrass.org"}
	  bmain(p){		
      projectToolbar(p) 
		  gridRow{
		    gridCol(12){
			    pageHeader2{ "Roadmap" }
			    placeholder "releases" roadmapRelease(releases.get(0))
			  }
		  }
		}
	}
	

  ajax template roadmapRelease(r : Tag) {
	  var previousRelease := previousRelease(r);
	  var issues := releaseIssues(r);
	  var completed := completed(issues);
	  var releaseDone := releaseDone(r);
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
		  block[class="Ghost"] {
			  submitlink showPreviousRelease(previousRelease) [id="continuousLoader"+r.name+r.id, ignore default class, class="btn btn-default continuousLoader"] { "Show More" }
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
			  append("releases", roadmapRelease(release));
		  }
	  }
  }
  
  