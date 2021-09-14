module tag/sidebar

imports issue/register
imports project/-
imports tag/-

imports elib/-
imports elib-bootstrap-3/icons

  template tagCommandsToolbar(tag : Tag) {
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
              projectTools(tag.project)   
            }
          }
        }
        pullRight{
          buttonToolbar{ 
            buttonGroup{
              navigate createTaggedIssue(tag.project, tag)[submitlink attributes, title="New " + tag.name + " Issue"] { iPlus }
              navigate editTag(tag.project, tag) [submitlink attributes, title="Edit"] { iPencil }            
              submitlink makeRelease(tag, tag.project) [class="ReleaseTag", title="Make release"] {"Release" }
              submitlink makeIssueType(tag, tag.project) [class="IssuetypeTag", title="Make issue type"] {"Issue Type" }
              submitlink color(tag, tag.project, "red") [class="RedTag", title="Color red"] { "Red" }
              submitlink color(tag, tag.project, "green") [class="GreenTag", title="Color green"] { "Green" }
              submitlink color(tag, tag.project, "grey") [class="GreyTag", title="Color grey"] { "Grey" }
              submitlink color(tag, tag.project, "purple") [class="PurpleTag", title="Color purple"] { "Purple" }      
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
  