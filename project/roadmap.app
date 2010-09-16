module project/roadmap

imports issue/issue

define page roadmap(p : Project) {
	title{output(p.name) " Roadmap - on YellowGrass.org"}
	main()
	define body(){
		var releases := releases(p)
		
		block [class := "main"] { 
			if(securityContext.loggedIn) {
				par [class := "Back"] { 
					rawoutput { " &raquo; " }
					navigate(home(securityContext.principal)) {"Home"}
					rawoutput { " &raquo; " }
					navigate(project(p)) {"Project " output(p.name)}
					rawoutput { "&raquo; " } " Roadmap "
				}
			} else { 
				par [class := "Back"] { navigate(project(p)) {rawoutput { "&raquo; " } " Back to Project"} }
			}
			par{ <h1> output(p.name) " Roadmap" </h1> }
			for(release : Tag in releases) {
				par { <h2> navigate(tag(p, release.name)) { output(release.name) } </h2> }
				par { actionLink("Postpone Open Issues", postponeOpen(p, release)) }
				par { issues(releaseIssues(release), false, true, true, 60, true) }
			}
		}
		projectSideBar(p)
	}
	
	action postponeOpen(project : Project, release : Tag) {
		var nextRelease : Tag := nextRelease(project, release);
		for(i : Issue in releaseIssues(release)) {
			if(i.open) {
				i.tags.remove(release);
				i.tags.add(nextRelease);
			}
		}
	}
}