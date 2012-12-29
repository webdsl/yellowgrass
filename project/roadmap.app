module project/roadmap

// imports issue/issue

  page roadmap(p : Project) {
    var releases := releases(p)   
	  continuousLoading()
	  title{output(p.name) " Roadmap - on YellowGrass.org"}
	  bmain{		
      projectToolbar(p) 
		  gridRow{
		    gridSpan(12){
			    pageHeader2{ "Roadmap" }
			    placeholder releases roadmapRelease(releases.get(0))
			  }
		  }
		}
	}

  ajax template roadmapRelease(r : Tag) {
	  var previousRelease := previousRelease(r);
	  header2{
		  navigate(tag(r.project, r.name)) { output(r.name) }
		  if(r.description != null && r.description != "") {
			  output(" -- ") <i> output(r.description) </i>
		  }
	  }
	  par { submitlink postponeOpen(r) { "Postpone Open Issues to " output(nextRelease(r).name) } }
	  issues(releaseIssues(r), false, true, true, 50, true, true)
	  if(previousRelease != null) {
		  block[class="Ghost"] {
			  submitlink showPreviousRelease(previousRelease) [id="continuousLoader"+r.name+r.id, class="btn continuousLoader"] { "Show More" }
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
			  append(releases, roadmapRelease(release));
		  }
	  }
  }
  