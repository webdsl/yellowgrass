module tag/tag

imports tag/tag-model
imports tag/ac
imports tag/sidebar
imports tag/manual
imports user/user
imports issue/issue
imports project/roadmap
imports comment/tagControl

section navigation

  template nav(t: Tag) {
    navigate tag(t.project, t.name) { output(t.name) }
  }

section tag page

  page tag(p : Project, tag : String) {
    var t := getTag(tag, p);
    var taggedIssues : List<Issue> := p.taggedIssues(t);
      
	  title{output(p.name) " / " output(tag) " - on YellowGrass.org"}
	  bmain{  
	    tagCommandsToolbar(t) 
	    pageHeader2{ 
        "Tagged " output(t.name) 
      }
      gridRow{ gridSpan(12){ pullRight{ par{ tags(t, true) } } } } 
      gridRow{
        //gridSpan(2) { tagSideBar(t) }
        gridSpan(12) {
				  if(t.description != null && t.description != "") {
					  par{ <i> output(t.description) </i> }
				  }
			    issues(taggedIssues.set(), false, true, true, 50, true, false)
			  }
		  }
	  }
  }

  page editTag(p : Project, t : Tag) {
	  title{output(t.project.name) "." output(t.name) " on YellowGrass.org [Editing]"}
	  bmain(p){
      tagCommandsToolbar(t) 
		  pageHeader2{ "Edit Tag" }
		  horizontalForm {
			  controlGroup("Name") { input(t.name) }
			  controlGroup("Description") { input(t.description) }
			  formActions{
			    submitlink save() [class="btn btn-primary"] { "Save" } " "
				  navigate tag(t.project, t.name) [class="btn"] { "Cancel" }
				}
			}
		}
	  action save(){
		  return tag(t.project, t.name);
	  }
  }
  
section displaying tags
  
  template showTag(owner: Tag, tag : Tag, editing : Bool) {
    action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
      tagToRemoveFrom.tags.remove(tagToRemove);
      tagCleanup(tagToRemove);
      //return tag(tag.project, tag.name);
    }   
    buttonGroupSpan{
      navigate tag(tag.project, tag.name) [class="btn btn-mini " + tag.getStylingClass()] { output(tag.name) } 
      if(editing) {
        submitlink deleteTag(owner, tag) [class="btn btn-mini " + tag.getStylingClass()] { "x" }
      }
    }
  }
  
  template showTag(i: Issue, tag: Tag, editing: Bool) {
    action deleteTag(i : Issue, t : Tag) {
      i.deleteTag(t);
      i.save();
      tagCleanup(t);
      //return issue(i.project, i.number);
    }
    buttonGroupSpan{
      navigate tag(i.project, tag.name) [class="btn btn-mini " + tag.getStylingClass()] { output(tag.name) }     
      if(editing) {
        submitlink deleteTag(i, tag) [class="btn btn-mini " + tag.getStylingClass()] { "x" }
      }
    }
  }

  template tags(t : Tag, editing : Bool) {
	  div[class="Tags"] {
		  for(tag : Tag in arrangeTags(t.tags, false)) {			  
			  showTag(t, tag, editing)
		  } separated-by { " " }
		  tagHelp
	  }
  }

  function getTagsStylingClass(summary : Bool) : String {
	  if(summary) {
		  return "Tags TagsSummary";
	  } else {
		  return "Tags";
	  }
  }

  template tags(i : Issue, editing : Bool) {
	  tags(i, editing, false)
  }

  template tags(i : Issue, editing : Bool, summary : Bool) {
    for(tag : Tag in arrangeTags(i.tags, summary)) {
		  showTag(i, tag, editing)
		} separated-by { " " } 
  }

  template tags(ts : List<Tag>, p : Project) {
	  for(tag : Tag in ts) {
			navigate tag(p, tag.name) { output(tag.name) }
		} separated-by { " " }
  }

section tagging

  template addTag(i : Issue) {
	  var t : String := ""
    action addTag(t : String, i : Issue) {
      var f := Tag{ name := t };
      var feedback := f.validateName();
      if(feedback.exceptions.length > 0) {
        log("Validation failed!!");
        replace(tagValidityFeedback, validationFeedback(feedback));
      } else {
        log("Validation succeeded!!");
        i.addTag(tag(t, i.project));
        i.save();
        return issue(i.project, i.number);
      }
    }
    action updateTagSuggestions(t : String) {
      replace(tagSuggestionsBox, tagSuggestions(t, i));
    }
    
	  div [class := "TagAddition"] {
		  form { 
		    inputAppend{
			    input(t) [class="input-mini", onkeyup := updateTagSuggestions(t), autocomplete:="off"]		  
			    submitlink addTag(t, i) [class="btn btn-mini", style="height:14px;padding:7px;", title="Add tag"] { iTag }
			    tagHelp
			  }
			  placeholder tagValidityFeedback {""}
		  }
		  placeholder tagSuggestionsBox { }
	  }
  }

  function tagSuggestionFilter(tagPrefix : String) : String{
	  if(tagPrefix != "") {
		  return ""; 
 	  }
	  return "@%";
  } 
  
  // NOTE: Do not make this publicly available, the AJAX causes a lot of bad links
  ajax template tagSuggestions(tagPrefix : String, issue : Issue) {
	  var suggestions : List<Tag> := tagSuggestions(tagPrefix, issue);
    action addSuggestedTag(suggestion : Tag) {
      issue.addTag(suggestion);
    } 
    div[class="dropdown open"]{   
      dropdownMenu{
	      for(suggestion : Tag in suggestions) {
			    dropdownMenuItem{ submitlink addSuggestedTag(suggestion) { output(suggestion.name) } }
	      }
	    }
	  }
    /*  var suggestions : List<Tag> := (
      select  t
      from  Tag as t
      where i._project = ~issue.project and
          t._project = ~issue.project and
          t._name like ~tagSearchString and
          t._name not like ~tagSuggestionFilter(tagPrefix)
      order by (select count(i) from Issue as i where t in i._tags) desc
      limit 5
      ) as List<Tag>;
    */  
  }
   