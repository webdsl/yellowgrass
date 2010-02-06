module templates

define main() {
	<div id="pagewrapper">
		<div id="header">
			mainheader()
		</div>
/* 	<div id="navbar">
		applicationmenu()
	</div>
*/     
		<div id="content">
			body()
		</div>
		<div id="footer">
			<p/>
				"© 2010 " <a href="http://www.sandervermolen.nl"> "Sander Vermolen" </a> " All rights reserved"
				" --- "
				<a href="http://yellowgrass.org/project/YellowGrass"> "Provide feedback on YellowGrass" </a> 
				" --- "
				"Powered by " <a href="http://webdsl.org">"WebDSL"</a>
			<p/>
		</div>
	</div>
}

define body(){
  "default body"
}

define mainheader() {
	if(securityContext.loggedIn) {
		block [class:="logo"] {
			navigate(home(securityContext.principal)){
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

define applicationmenu() {
  <ul>
    <li>navigate(root()){"Home"}</li>
    <li>navigate(registerUser()){"Register"}</li>
  </ul>
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

/*
function getDecoratedRowClass (highlighted : Bool) : String{
	if(highlighted) {
		return "high"; 
	} else {
		return "low";
	}
}*/

