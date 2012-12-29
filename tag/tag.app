module tag/tag

imports tag/tag-model
imports tag/ac
imports tag/sidebar
imports tag/manual
imports user/user
// imports issue/issue
imports project/roadmap
imports comment/tagControl

section user interface

  page tag(p : Project, tag : String) {
    var t := getTag(tag, p);
    var taggedIssues : List<Issue> :=
      select i
      from Issue as i
      left join i._tags as t
      where t._name = ~tag and t._project = ~p
      limit 500
      
	  title{output(p.name) " / " output(tag) " - on YellowGrass.org"}
	  bmain(p){  
      gridRow{
        gridSpan(2) { tagSideBar(t) }
        gridSpan(10) {
		      // block [class := "main"] {  }
		      // 	if(securityContext.loggedIn) {
		      // 		par [class := "Back"] { 
		      // 			rawoutput { " &raquo; " }
		      // 			navigate(home()) {"Home"}
		      // 			rawoutput { " &raquo; " }
	 	      // 			navigate(project(p)) {"Project " output(p.name)}
		      // 			rawoutput { "&raquo; " } " Tag " output(tag)
		      // 		}
		      // 	} else { 
		      // 		par [class := "Back"] { navigate(project(p)) {rawoutput { "&raquo; " } " Back to Project"} }
		      // 	}
			    pageHeader2{ 
				    "Tagged " output(t.name) tags(t, true)
				  }
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
		  t.save();
		  return tag(t.project, t.name);
	  }
  }
  
  template showTag(owner: Tag, tag : Tag, editing : Bool) {
    div[class=tag.getStylingClass()] {
      output(tag.name) 
      if(editing) { " "
        submitlink deleteTag(owner, tag) { "[x]" }
      }
    }
    action deleteTag(tagToRemoveFrom : Tag, tagToRemove : Tag) {
      tagToRemoveFrom.tags.remove(tagToRemove);
      tagCleanup(tagToRemove);
      return tag(tag.project, tag.name);
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
	  div [class = getTagsStylingClass(summary)] {
		  for(tag : Tag in arrangeTags(i.tags, summary)) {
			  div [class:=tag.getStylingClass()] {
				  navigate tag(i.project, tag.name) { output(tag.name) } 
				  if(editing) {
					  " " submitlink deleteTag(i, tag) { "[x]" }
				  }
			  }
		  } separated-by { " " }
	  }
	  action deleteTag(i : Issue, t : Tag) {
		  i.deleteTag(t);
		  i.save();
		  tagCleanup(t);
		  return issue(i.project, i.number);
	  }
  }

  template tags(ts : List<Tag>, p : Project) {
	  div [class:="Tags"] {
		  for(tag : Tag in ts) {
			  navigate tag(p, tag.name) { output(tag.name) }
		  } separated-by { " " }
	  }
  }

  template addTag(i : Issue) {
	  var t : String := ""
	  div [class := "TagAddition"] {
		  form {
			  label("Tag") {
				  input(t) [onkeyup := updateTagSuggestions(t), autocomplete:="off"]
			  }
			  submitlink addTag(t, i) [class="btn"] { iPlus }
			  tagHelp
			  placeholder tagValidityFeedback {""}
		  }
		  placeholder tagSuggestionsBox {
			  tagSuggestions(t, i)
		  }
	  }
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
  }

  function tagSuggestionFilter(tagPrefix : String) : String{
	  if(tagPrefix != "") {
		  return "";
 	  }
	  return "@%";
  }

// NOTE: Do not make this publicly available, the AJAX causes a lot of bad links
ajax template tagSuggestions(tagPrefix : String, issue : Issue) {
	var tagSearchString := tagPrefix.toLowerCase() + "%"
	var suggestions : List<Tag> := (
		select	t
		from	Issue as i left join i.tags as t	// Joint to only select used tags (subqueries not supported)
		where	i._project = ~issue.project and
				t._project = ~issue.project and		// Not really needed, but improves performance
				t._name like ~tagSearchString and
				t._name not like ~tagSuggestionFilter(tagPrefix)
		group by t._name
		order by count(i) desc
		limit 5
		) as List<Tag>;
		
/*	var suggestions : List<Tag> := (
		select	t
		from	Tag as t
		where	i._project = ~issue.project and
				t._project = ~issue.project and
				t._name like ~tagSearchString and
				t._name not like ~tagSuggestionFilter(tagPrefix)
		order by (select count(i) from Issue as i where t in i._tags) desc
		limit 5
		) as List<Tag>;
*/	
	for(suggestion : Tag in suggestions) {
		form { block [class := "Suggestion"] {
			actionLink(suggestion.name, addSuggestedTag(suggestion))[ajax]
		}}
	}
	
	action addSuggestedTag(suggestion : Tag) {
		issue.addTag(suggestion);
		issue.save();
		refresh();
	}
} 