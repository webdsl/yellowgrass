module project/register

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
          submitlink create() [class="btn btn-primary"] { "Create" } " "
				  navigate home() [class="btn btn-default"] {"Cancel"}
			  }
		  }
	  }
  }
  
