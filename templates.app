module templates

define main() {
	<div id="pagewrapper">
		<div id="header">
			mainheader()
		</div>
		<div id="content">
			body()
		</div>
		<div id="footer">
			<p/>
				"© 2010 " <a href="http://www.sandervermolen.nl"> "Sander Vermolen" </a> " All rights reserved"
				" --- "
				"Provide " <a href="http://yellowgrass.org/project/YellowGrass"> "Feedback" </a> 
				" --- "
				"Powered by " <a href="http://webdsl.org">"WebDSL"</a>
			<p/>
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

define mainheader() {
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
}

define ignore-access-control errorTemplateInput(messages : List<String>){
  validatedInput
  for(ve: String in messages){
    row[style := "color: #FF0000;border: 1px solid #FF0000;"]{
      column{}
      column{ 
        output(ve)
      }
    }
  }
}

define template sidebarSeparator() {
	image("/images/sidebarSeparator.png")
}

/*
function getDecoratedRowClass (highlighted : Bool) : String{
	if(highlighted) {
		return "high"; 
	} else {
		return "low";
	}
}*/

