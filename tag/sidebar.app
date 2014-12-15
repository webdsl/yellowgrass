module tag/sidebar

  template tagCommandsToolbar(t : Tag) {
    action makeRelease(t : Tag, p : Project) {
      t.makeRelease(p);
    }
    action makeIssueType(t : Tag, p : Project) {
      t.makeIssueType(p);
    }
    action color(t : Tag, p : Project, color : String) {
      t.color(p, color);
    }
    
    gridRow{
      gridCol(12) {
        pullLeft{     
          buttonToolbar{
            buttonGroup{     
              //projectDropdown(t.project) 
              projectTools(t.project)   
            }
          }
        }
        pullRight{
          buttonToolbar{ 
            buttonGroup{
              navigate createTaggedIssue(t.project, t) [class="btn btn-default", title="New " + t.name + " Issue"] { iPlus }
              navigate editTag(t.project, t) [class="btn btn-default", title="Edit"] { iPencil }            
              submitlink makeRelease(t, t.project) [class="btn btn-default ReleaseTag", title="Make release"] {"Release" }
              submitlink makeIssueType(t, t.project) [class="btn btn-default IssuetypeTag", title="Make issue type"] {"Issue Type" }
              submitlink color(t, t.project, "red") [class="btn btn-default RedTag", title="Color red"] { "Red" }
              submitlink color(t, t.project, "green") [class="btn btn-default GreenTag", title="Color green"] { "Green" }
              submitlink color(t, t.project, "grey") [class="btn btn-default GreyTag", title="Color grey"] { "Grey" }
              submitlink color(t, t.project, "purple") [class="btn btn-default PurpleTag", title="Color purple"] { "Purple" }      
            }
          } 
        } 
      }
    }
    //pageHeader4 { output(abbreviateNE(t.name,12)) }
  }
  
  template tagSideBar(t : Tag) {
	  block [class := "sidebar"] {
		  //projectCommands(t.project) 
		  hrule
		  //tagCommands(t) 
      hrule
      par{ tags(t.project.getCommonTags(80), t.project) }
	  }
  } 

  // template tagCommands(t : Tag) {
	 //  pageHeader4 { output(abbreviateNE(t.name,12)) }
	 //  par { navigate(createTaggedIssue(t.project, t))	{iPlus " New " output(t.name) " Issue"} }
	 //  par { navigate(editTag(t.project, t)) {iPencil " Edit tag"} }
	 //  par { actionLink("Make Release", makeRelease(t, t.project) ) }
	 //  par { actionLink("Make Issue Type", makeIssueType(t, t.project) ) }
	 //  par { actionLink("Color Red", color(t, t.project, "red") ) }
	 //  par { actionLink("Color Green", color(t, t.project, "green") ) }
	 //  par { actionLink("Color Grey", color(t, t.project, "grey") ) }
	 //  par { actionLink("Color Purple", color(t, t.project, "purple") ) }
		// 	
	 //  action makeRelease(t : Tag, p : Project) {
		//   t.makeRelease(p);
		//   return tag(p, t.name);
	 //  }
	 //  action makeIssueType(t : Tag, p : Project) {
		//   t.makeIssueType(p);
		//   return tag(p, t.name);
	 //  }
	 //  action color(t : Tag, p : Project, color : String) {
		//   t.color(p, color);
		//   return tag(p, t.name);
	 //  }
  // }
  