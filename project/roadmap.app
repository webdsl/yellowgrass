module project/roadmap

imports issue/issue

define page roadmap(p : Project) {
	title{output(p.name) " Roadmap - on YellowGrass.org"}
	main()
	define body(){
		var releases := 
			select t
			from Tag as t
			left join t.tags as tt
			where t._project=~p	and tt._name = ~"release"
			order by t._name desc
			limit 5000;
		
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
				par {
					issues((
							select i 
							from Issue as i 
							left join i._tags as t 
							where t=~release
							order by i._open desc, i._submitted desc
						),
						false, true, true, 60, true
					)
				}
			}
		}
		projectSideBar(p)
	}
}