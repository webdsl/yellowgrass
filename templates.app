module templates

define main() {
  <div id="pagewrapper">
     <div id="header">
        mainheader()
     </div>
     <div id="navbar">
       applicationmenu()
     </div>
     <div id="content">
       body()
     </div>
     <div id="footer">
       <p />"powered by " <a href="http://webdsl.org">"WebDSL"</a><p />
     </div>
  </div>
}

define body(){
  "default body"
}

define mainheader() {
	table {	row {
		navigate(root()){
    		image("/images/logosmall.png")
  		}
  		if(securityContext.loggedIn) {logout()}
  		else {login()}
  	}}
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
 