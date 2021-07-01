module generic/editable-text

imports built-in
imports comment/comment
imports generic/entity

imports elib-bootstrap-3/icons
imports elib/elib-bootstrap/lib
imports elib/elib-utils/wikitext

access control rules  

  rule ajaxtemplate editableText(text : Ref<WikiText>) {
    true 
  }
  rule ajaxtemplate showWikiText(editT: String, text : Ref<WikiText>) {
    mayView(text.getEntity()) 
    rule action edit() { mayEdit(text.getEntity()) }
  }
  rule ajaxtemplate editWikiText(editT: String, text : Ref<WikiText>) {
    mayEdit(text.getEntity())
  }
  
section templates 

  define ajax editableText(text : Ref<WikiText>) { 
    var t := getTemplate().getUniqueId();
    placeholder "showText" + t { showWikiText(t, text){ elements } }
  }
  
  define ajax showWikiText(t: String, text : Ref<WikiText>) {
  	var owningEntity := text.getEntity(); //requires r5803 of Webdsl -> http://yellowgrass.org/issue/WebDSL/754
  	var isComment := (owningEntity is a Comment);
    action edit(){ 
      replace("showText" + t, editWikiText(t, text)); 
      toggleCommentAdditionBox();
    }   
    if (isComment) { byline(owningEntity) } 
    blockquote{
      pullRight{ 
        submitlink edit() [title="Edit"] { iPencil } 
      }
      output(text)
      if (!isComment) { small{ byline(owningEntity) } }  
    }
  }
  
  function toggleCommentAdditionBox(){
    visibility("commentAdditionBox", toggle);
  }
  
  define ajax editWikiText(editT: String, text : Ref<WikiText>) {
    action save() { /*text := preview;*/ replace("showText" + editT, showWikiText(editT, text)); toggleCommentAdditionBox(); }
    action cancel() { replace("showText" + editT, showWikiText(editT, text)); toggleCommentAdditionBox(); }
    form{
      inputWithPreview(text)[style="height: 300px;"]
      par{
        pullRight{
          submitlink save() [ignore default class, class="btn btn-primary"] { "Save" } " "
          submitlink cancel() [] { "Cancel" }
        }
      }
    }
    wikiTextPreview(text)
  }
  
access control rules 

  rule ajaxtemplate editableString(x: Ref<String>) { 
    mayView(x.getEntity())
  }
   
  rule ajaxtemplate editableStringShow(t: String, x: Ref<String>) {
    mayEdit(x.getEntity())
  }
  
  rule ajaxtemplate editableStringEdit(t: String, x: Ref<String>, old: String) {
    mayEdit(x.getEntity())
  }
      
section editable string

  ajax template editableString(x: Ref<String>) {
    var t := "editString" + getTemplate().getUniqueId();
    if(mayEdit(x.getEntity())) {
      placeholder (t as String) { editableStringShow(t, x){ elements } }
    } else { output(x) elements } 
  }
   
  ajax template editableStringShow(t: String, x: Ref<String>) {
    action edit() { replace(t as String, editableStringEdit(t, x, x)); } 
    div[onclick=edit(), ondblclick=edit(), title= "Click to edit"]{ output(x) elements " " small{submitlink edit()[ignore default class]{ iPencil }} }
    
  }
  
  ajax template editableStringEdit(t: String, x: Ref<String>, old: String) {
    action save() { 
      replace(t as String, editableStringShow(t, x));
    } 
    action cancel() { 
      x := old; 
      replace(t as String, editableStringShow(t, x));
    }
    
      form{ 
        <span class="input-group" style="width: 60%;"> 
          input(x)
          inputGroupButton{ 
          	// buttonGroup{
          	// submit save() [style="display:none;"] { "Save" }
	          submitlink save() [ignore default class, class="btn btn-primary"] { "Save" } " "
	          submitlink cancel() [] { "Cancel" }
	        // }
          }
        </span>
      }
    
    // clear
  }
  
  