module project/register

imports built-in
imports templates
imports issue/types
imports project/-
imports user/home

imports elib/elib-bootstrap/lib

  page registerProject(){
	  var p := Project{};
	  	  
    action create(){
      p.members.add(securityContext.principal);
      p.created := now();
      p.private := false;
      p.email := "";
      p.save();
      createIssueTypes(p);
      return edit(p);
    }
	  title{"YellowGrass.org - Project Registration"}
	  bmain{     
      buttonToolbar{ homeToolbar(securityContext.principal) }  
		  pageHeader{ "Create New Project" } 
		  horizontalForm { 
			  controlGroup("Project name") { input(p.name) }
			  formActions {
          submitlink create() [ignore default class, class="btn btn-primary"] { "Create" } " "
				  navigate home() [submit attributes] {"Cancel"}
			  }
		  }
	  }
  }
  
