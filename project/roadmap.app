module project/roadmap

imports issue/issue

define page roadmap(p : Project) {
	includeJS("https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js")
	<script>
		var lastLoader = null;
		var allLoaded = false;
	
		function loadMore(){
			var newLoader = $(".loadMore:last");
			if(newLoader == lastLoader) {
				allLoaded = true;
			} else {
				newLoader.click();
				lastLoader = newLoader;
			}
		}
		
		function fillPage() {
			if(!allLoaded && $(document).height() <= $(window).height()){
				loadMore();
				setTimeout('fillPage()',2000);
			}
		}
		
		$(document).ready(function() {
			fillPage()
			// Add additional items when needed
			$(window).scroll( function(){
				if ($(window).scrollTop() == $(document).height() - $(window).height()){
					loadMore();
				}
			});
		});
	</script>
		
	title{output(p.name) " Roadmap - on YellowGrass.org"}
	main()
	define body(){
		var releases := releases(p)
		
		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					rawoutput { " &raquo; " }
					navigate(home()) {"Home"}
					rawoutput { " &raquo; " }
					navigate(project(p)) {"Project " output(p.name)}
					rawoutput { "&raquo; " } " Roadmap "
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {rawoutput { "&raquo; " } " Back to Project"} }
			}
			par{ <h1> output(p.name) " Roadmap" </h1> }

			placeholder releases roadmapRelease(releases.get(0))

		}
		projectSideBar(p)
	}
}

define ajaxtemplate roadmapRelease(r : Tag) {
	<h2> 
		navigate(tag(r.project, r.name)) { output(r.name) }
		if(r.description != null && r.description != "") {
			output(" -- ") <i> output(r.description) </i>
		}
	</h2>
	par { actionLink("Postpone Open Issues", postponeOpen(r)) }
	issues(releaseIssues(r), false, true, true, 50, true)
	block[class="Ghost"] {
		actionLink("Show More", showPreviousRelease(previousRelease(r)))[class="loadMore" ]
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