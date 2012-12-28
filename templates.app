module templates

imports templates-bootstrap

imports search

define main() {
	var p : Project := null
	main(p)
}

// define oldmain(project : Project) {
// 	includeCSS("tags.css")
// 	<div id="pagewrapper">
// 		<div id="header">
// 			mainheader(project)
// 		</div>
// 		<div id="content">
// 			messages()
// 			body()
// 		</div>
// 	</div>
// }

template main(project : Project) {
  includeCSS("tags.css")
  mainResponsive{  
    body()
  }
}

template bmain(project : Project) {
  includeCSS("tags.css")
  mainResponsive(project){  
    elements 
  }
}

template bmain() {
  includeCSS("tags.css")
  mainResponsive{  
    elements
  } 
}

template analytics() {
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
	
// define mainheader(project : Project) {
// 	if(securityContext.loggedIn) {
// 		block [class:="logo"] {
// 			navigate(root()){
//     			image("/images/logo.png")
//   			}
//   		}
//   		logout()
// 	} else {
// 		block [class:="logo"] {
// 			navigate(root()){
//     			image("/images/logo.png")
//   			}
//   		}
// 		login()
// 	}
// 	
// 	var query : String := "";
// 	block [class := "SearchBox"] {
// 		form {
// 			input(query)
// 			" "
// 			block [class := "LoginButton"] {
// 				submit("Search", doSearch())
// 			}
// 		}
// 	}
// 	block [class := "ProjectList"] {
// 		if(securityContext.loggedIn) {
// 			for(p : Project in securityContext.principal.projects) {
// 				if(p != project) {
// 					navigate(project(p)) {output(p.name)} rawoutput { "&nbsp;&nbsp;&nbsp;" } 
// 				} else {
// 					output(p.name) rawoutput { "&nbsp;&nbsp;&nbsp;" } 
// 				}
// 			}
// 		}
// 	}
// 	action doSearch() {
// 		if(project == null){
// 			return searchAllProjects(query);
// 		}else{
// 			return search(project,query);
// 		} 
// 		
// 	}
// }

  override ignore-access-control template errorTemplateInput(messages : List<String>){
	  elements()
	  for(ve: String in messages){
		  block[class:="Error"] {
			  output(ve)
		  }
	  }     
  }

  override ignore-access-control template errorTemplateForm(messages : List<String>){
	  elements()
	  for(ve: String in messages){
		  block[class:="Error"] {
			  output(ve)
		  }
	  }     
  }

  override ignore-access-control template errorTemplateAction(messages : List<String>){
	  elements()
	  for(ve: String in messages){
		  block[class:="Error"] {
			  output(ve)
		  }
	  }     
  }

// define template sidebarSeparator() {
// 	image("/images/sidebarSeparator.png")
// }

  override page pagenotfound() {
	  title{ "YellowGrass.org - Page not found (404)" }
	  bmain{
		  pageHeader2{ "Page not found" }
		  par{		
		    "Oops, that page does not exist." <br/>
		    "If I messed something up, please post an issue on " <a href="http://yellowgrass.org/project/YellowGrass">"my issue tracker"</a>"."
		  }
		  par{ "Thanks, YellowGrass" }
	  }
  }

  override page accessDenied() {
	  title{ "YellowGrass.org - Access Denied" }  
	  bmain{
		  pageHeader2{ "You are not allowed to visit this page" }
		  par{
		    "Perhaps you arrived here by accident." <br/>
		    "Perhaps I made an error." <br/>
		    "Perhaps you just need to log in to view this page." <br/>
		    "Perhaps this item was removed." <br/>
		    "If not, stop harrassing me, or I will call the police!"		
		  }
		  par{ " - YellowGrass - " }
	  }
  }
