module templates

imports search

define main() {
	var p : Project := null
	main(p)
}

define main(project : Project) {
	includeCSS("tags.css")
	<div id="pagewrapper">
		<div id="header">
			mainheader(project)
		</div>
		<div id="content">
			messages()
			body()
		</div>
		<div id="footer">
			block [class := "Item"] { "YellowGrass.org  The Tag-Based Issue Tracker" }
			block [class := "Item"] { " - " }
			block [class := "Item"] { rawoutput {"&copy; "} " 2010 " <a href="http://www.sandervermolen.nl"> "Sander Vermolen" </a> ", " navigate(sources()){"Distributed under Affero General Public License"}}
			block [class := "Item"] { " - " }
			block [class := "Item"] { "Provide " <a href="http://yellowgrass.org/project/YellowGrass"> "Feedback" </a> } 
			block [class := "Item"] { " - " }
			block [class := "Item"] { "Powered by " <a href="http://webdsl.org">"WebDSL"</a> }
		</div>
	</div>
	<script type="text/javascript">
		var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
		document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
	</script>
	<script type="text/javascript">
		try {
			var pageTracker = _gat._getTracker("UA-12964403-1");
			pageTracker._trackPageview();
		} catch(err) {}
	</script>
}

define body(){
  "default body"
}
	
define mainheader(project : Project) {
	if(securityContext.loggedIn) {
		block [class:="logo"] {
			navigate(root()){
    			image("/images/logo.png")
  			}
  		}
  		logout()
	} else {
		block [class:="logo"] {
			navigate(root()){
    			image("/images/logo.png")
  			}
  		}
		login()
	}
	
	var query : String := "";
	block [class := "SearchBox"] {
		form {
			input(query)
			" "
			block [class := "LoginButton"] {
				submit("Search", doSearch())
			}
		}
	}
	block [class := "ProjectList"] {
		if(securityContext.loggedIn) {
			for(p : Project in securityContext.principal.projects) {
				if(p != project) {
					navigate(project(p)) {output(p.name)} rawoutput { "&nbsp;&nbsp;&nbsp;" } 
				} else {
					output(p.name) rawoutput { "&nbsp;&nbsp;&nbsp;" } 
				}
			}
		}
	}
	action doSearch() {
		if(project == null){
			return searchAllProjects(query);
		}else{
			return search(project,query);
		} 
		
	}
}

define override ignore-access-control errorTemplateInput(messages : List<String>){
	elements()
	for(ve: String in messages){
		block[class:="Error"] {
			output(ve)
		}
	}     
}

define override ignore-access-control errorTemplateForm(messages : List<String>){
	elements()
	for(ve: String in messages){
		block[class:="Error"] {
			output(ve)
		}
	}     
}

define override ignore-access-control errorTemplateAction(messages : List<String>){
	elements()
	for(ve: String in messages){
		block[class:="Error"] {
			output(ve)
		}
	}     
}

define template sidebarSeparator() {
	image("/images/sidebarSeparator.png")
}

define override page pagenotfound() {
	title{ "YellowGrass.org - Page not found (404)" }
	main()
	define body() {
		<h1>"Page not found"</h1>
		<p>
		"Oops, that page does not exist." <br/>
		"If I messed something up, please post an issue on " <a href="http://yellowgrass.org/project/YellowGrass">"my issue tracker"</a>"."
		</p><p>
		"Thanks, YellowGrass"
		</p> 
	}
}

define override page accessDenied() {
	title{ "YellowGrass.org - Access Denied" }
	main()
	define body() {
		<h1>"You are not allowed to visit this page"</h1>
		<p>
		"Perhaps you arrived here by accident." <br/>
		"Perhaps I made an error." <br/>
		"Perhaps you just need to log in to view this page." <br/>
		"Perhaps this item was removed." <br/>
		"If not, stop harrassing me, or I will call the police!"
		</p><p>
		" - YellowGrass - "
		</p> 
	}
}
