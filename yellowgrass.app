application yellowgrass 

imports built-in
imports templates
imports webservices
imports ac
imports auxiliary
imports features
imports issue/-
imports project/-
imports user/-
imports tag/-
imports questions/question-view

imports elib/elib-bootstrap/lib

section root page

  page root() {
	  title{"YellowGrass.org - The Tag-Based Issue Tracker"}      
	  bmain{		
		  gridRow{
		    gridCol(4){		  
		      pageHeader2{ "About YellowGrass" }  
		      well{    
				    par {
					    "YellowGrass is a tag-based issue tracker."
				    }
            par {
					    "It supports issue voting, issue tagging, roadmaps, assigning and following issues, private and public projects, full text search, email updates, action logging and much more. "
					    "YellowGrass is fully web-based and free of charge. Registering your project is just a few clicks away. "
					    "Take a look at YellowGrass's " navigate(features()){"Feature List"} " or " navigate(registerUser()){"Register"} " right away."
				    }
				  }
		    }
        gridCol(8){ 
          pageHeader2{ "Some Active Projects" }
          tableBordered {
            for(p : Project in activeProjects()) {
              row { 
                column { navigate project(p) { output(p.name) } }
                column { output(p.url) }
              }
            }
          }
          par { navigate projectList() { "View all Projects" } }      
        }
	    }
	    gridRow{
	      gridCol(12){		
			    pageHeader2{ "Recent Issues" }
		      par { issues(recentIssues().set(), true, false, false, 40) }
		    }
		  }
	  }
  }

section about page

  page about() {
	  title{"About YellowGrass"}
	  bmain{
	    pageHeader{ "About YellowGrass" }
	    par{ "YellowGrass is a tag-based issue tracker" }

      par{
        " Provide " <a href="http://yellowgrass.org/project/YellowGrass"> "Feedback " </a> 
      }       
      par{
        " Powered by " <a href="http://webdsl.org">"WebDSL"</a>
      }
     
		  pageHeader { "YellowGrass Source Code" }
		  par {
			  " YellowGrass is open and freely available."
			  " Its source code is distributed under under the " <a href="http://www.affero.org/agpl2.html">"Affero General Public License"</a> "."
		  }
		  par {
			  "The source code repository can be found at: " <a href="https://github.com/webdsl/yellowgrass">"https://github.com/webdsl/yellowgrass"</a>
		  }
		  
		  pageHeader{ "Contributions" }
		  par{
        "YellowGrass was first developed by " 
        <a href="http://www.sandervermolen.nl"> "Sander Vermolen" </a> 
        " at " <a href="http://tudelft.nl">"TU Delft"</a> 
        " in the MoDSE project."
		  }
		  par{
		    "YellowGrass is now maintained by SLDE at TU Delft"
		  }
		  "Contributions "
		  list{
		    listitem{ "Sander Vermolen" }
		    listitem{ "Elmer van Chastelet" }
		    listitem{ "Chris Melman" }
		    listitem{ "Danny Groenewegen" }
		    listitem{ "Eelco Visser" }		    
		  }
	  }
  }


access control rules
rule page fixData(){
  isAdministrator()
}
section fixData

page fixData(){
  action ignore-validation setTagOrdinals(){
     for(t : Tag){
       if(t.name.length() > 1  && /[a-zA-Z0-9\.\-_@!]*/.match(t.name)){
          t.deriveOrdinal( t.name );
        }
      }
  }
  
  bmain{
    submit setTagOrdinals(){ "Set all tag orderString values" }

 
  }
}