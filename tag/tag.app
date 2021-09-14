module tag/tag

imports auxiliary
imports templates
imports comment/tagControl
imports issue/-
imports project/-
imports tag/-
imports user/user

imports elib/-
imports elib-bootstrap-3/icons

section navigation

  template nav(t: Tag) {
    navigate tag(t.project, t.name) [target = "_blank"] { output(t.name) }
  }

section tag page
  
  page tag(p : Project, tag : String) {
    var t : Tag := getTag(tag, p);
    var taggedIssues : List<Issue>;
    init{
      if(t == null) {
        message("No tag '" + tag + "' defined on this project");
        return project(p);
      } else {
        taggedIssues := p.taggedIssues(t);
      }    
    }
	  title{output(p.name) " / " output(tag) " - on YellowGrass.org"}
	  bmain{  
	    tagCommandsToolbar(t) 
	    pageHeader2{ "Tagged " output(t.name) }
      gridRow{ gridCol(12){ pullRight{ par{ tags(t, true) } } } } 
      gridRow{
        gridCol(12) {
				  if(t.description != null && t.description != "") {
					  par{ <i> output(t.description) </i> }
				  }
			    issues(taggedIssues.set(), false, true, true, 50, true, false)
			  }
		  }
	  }
  }

  page editTag(p : Project, t : Tag) {
    var tagName := t.name;
    action save() {
      t.name := tagify(tagName); 
      return tag(t.project, t.name);
    }
	  title{ output(t.project.name) "." output(t.name) " on YellowGrass.org [Editing]" }
	  bmain(p){
      tagCommandsToolbar(t) 
		  pageHeader2{ "Edit Tag" }
		  horizontalForm {
			  controlGroup("Name") { input(tagName) }
			  controlGroup("Description") { input(t.description) }
			  formActions{
			    submitlink save() [ignore default class, class="btn btn-primary"] { "Save" } " "
				  navigate tag(t.project, t.name) [submit attributes] { "Cancel" }
				}
			}
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
      navigate tag(tag.project, tag.name) [ignore default class, class="btn btn-default btn-xs " + tag.getStylingClass()] { output(tag.name) } 
      if(editing) {
        submitlink deleteTag(owner, tag) [ignore default class, class="btn btn-default btn-xs " + tag.getStylingClass()] { "x" }
      }
    }
  }
  
  template showTag(i: Issue, tag: Tag, editing: Bool) {
    span[id="showTag" + tag.id]{ showTagView(i, tag, editing) } 
  } 
    
  template showTagView(issue: Issue, tag: Tag, editing: Bool) {
    action deleteTag(i : Issue, t : Tag) {
      var id_ := tag.id;
      i.deleteTag(t);
      replace("showTag" + id_, empty);
    }
    buttonGroupSpan{
      navigate tag(issue.project, tag.name) [ignore default class, class="btn btn-default btn-xs " + tag.getStylingClass()] { output(tag.name) }     
      if(editing) {
        submitlink deleteTag(issue, tag) [ignore default class, class="btn btn-default btn-xs " + tag.getStylingClass()] { "x" }
      }
    }
  }

  template showTag(p: Project, tag: Tag) {
    buttonGroupSpan{
      navigate tag(p, tag.name) [ignore default class, class="btn btn-default btn-xs " + tag.getStylingClass()] { output(tag.name) }     
    }
  } 
  
  template tags(t : Tag, editing : Bool) {
	  div[class="tags"] {
		  for(tag : Tag in arrangeTags(t.tags, false)) {			  
			  showTag(t, tag, editing)
		  } separated-by { " " }
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
    tags(i, editing, false, false)
  }
  
  template tags(i : Issue, editing : Bool, right: Bool) {
	  tags(i, editing, false, right)
  }

  template tags(i : Issue, editing : Bool, summary : Bool, right: Bool) {
    span[class="tags"] { 
      for(tag : Tag in arrangeTags(i.tags, summary)) {
		    if(right) { 
		      pullRight{ showTag(i, tag, editing) } 
		    } else { 
		      showTag(i, tag, editing) 
		    }
		  } separated-by { " " } 
		}
  }

  template tags(ts : List<Tag>, p : Project) {
    span[class="tags"] { //pullRight{
	    for(tag : Tag in ts) {
			  showTag(p, tag) 
		  } separated-by { " " }
		} //} 
  }
  
section tag bar on issue page
  
  template tagBar(i: Issue) {
    well{
      placeholder "tagBar" { tagBarTags(i) }
    } 
  }
  
  ajax template tagBarTags(i: Issue) {
     gridRow{ 
     	gridCol(8){ span[class="tags"]{
	      for(tag : Tag in arrangeTags(i.tags, false)) {
	        showTag(i, tag, true) 
	      }	      
        } }
    	gridCol(4){
    		pullRight{ addTag(i) }
    // clear 
		}
	}
  }

section tagging

  template addTag(issue : Issue) { 
    var tag : String := ""
    action addTag(tagname : String, i : Issue) {
      var t := tagify(tagname); 
      var f := Tag{ name := t };
      var feedback := f.validateName();
      if(feedback.exceptions.length > 0) {
        //log("Validation failed!!");
        replace("tagValidityFeedback", validationFeedback(feedback));
      } else {
        //log("Validation succeeded!!");
        i.addTag(tag(t, i.project));
        i.save();
        //return issue(i.project, i.number);
        replace("tagBar", tagBarTags(i));
      }
    }
    action updateTagSuggestions(t : String) {
      replace("tagSuggestionsBox", tagSuggestions(t, issue));
    }
    
	  div [class = "TagAddition"] {
		  form { 
		    inputGroup{
			    input(tag) [class="input-sm", onkeyup := updateTagSuggestions(tag), autocomplete:="off"]
          		submit addTag(tag, issue) [style="display:none;", title="Add tag"] { "Add Tag" }
			    inputGroupButton{ 
			    	submitlink addTag(tag, issue) [ignore default class, class="btn btn-default btn-sm", title="Add tag"] { iTag }
			    	tagHelp
		    	} 
			  }
			  placeholder "tagValidityFeedback" { }
		  }
		  placeholder "tagSuggestionsBox" { }
	  }
  }

  function tagSuggestionFilter(tagPrefix : String) : String {
	  if(tagPrefix != "") {
		  return ""; 
 	  }
	  return "@%";
  }
  
  ajax template tagSuggestions(tagPrefix : String, issue : Issue) {
	  var suggestions : List<Tag> := tagSuggestions(tagPrefix, issue);
    action addSuggestedTag(suggestion : Tag) {
      issue.addTag(suggestion);
      replace("tagBar", tagBarTags(issue));
    } 
    div[class="dropdown open"]{   
      dropdownMenu{
	      for(suggestion : Tag in suggestions) {
			    dropdownMenuItem{ submitlink addSuggestedTag(suggestion)[ignore default class] { output(suggestion.name) } }
	      }
	    }
	  }
  }
   