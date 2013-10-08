module generic/editable-text

imports generic/entity 

access control rules  

  rule ajaxtemplate editableText(text : Ref<WikiText>, preview: Ref<WikiText>) {
    true 
  }
  rule ajaxtemplate showWikiText(editT: String, text : Ref<WikiText>, preview: Ref<WikiText>) {
    mayView(text.getEntity()) 
    rule action edit() { mayEdit(text.getEntity()) }
  }
  rule ajaxtemplate editWikiText(editT: String, text : Ref<WikiText>, preview: Ref<WikiText>) {
    mayEdit(text.getEntity())
  }
  rule ajaxtemplate textPreview(text: Ref<WikiText>) {
    mayEdit(text.getEntity()) 
  }
  
section templates 

  define ajax editableText(text : Ref<WikiText>, preview: Ref<WikiText>) { 
    var t := getTemplate().getUniqueId();
    placeholder "showText" + t { showWikiText(t, text, preview){ elements } }
  }
  
  define ajax showWikiText(t: String, text : Ref<WikiText>, preview: Ref<WikiText>) {
  	// var owningEntity := text.getEntity(); //does not work -> http://yellowgrass.org/issue/WebDSL/754
  	var isComment := (text.getEntity() is a Comment);
    action edit(){ 
      replace("showText" + t, editWikiText(t, text, preview)); 
      toggleCommentAdditionBox();
    }   
    blockquote{
      if (isComment) { small{ byline(text.getEntity()) } }  
      pullRight{ 
        submitlink edit() [class="btn", style="height:14px;padding:7px;margin:0 0 10px 30px;", title="Edit"] { iPencil } 
      }
      output(text)
      if (!isComment) { small{ byline(text.getEntity()) } }  
    }
  }
  
  function toggleCommentAdditionBox(){
    visibility(commentAdditionBox, toggle);
  }
  
  define ajax editWikiText(editT: String, text : Ref<WikiText>, preview: Ref<WikiText>) {
    var t := getTemplate().getUniqueId();
    init{ preview := text; }
    action save() { text := preview; replace("showText" + editT, showWikiText(editT, text, preview)); toggleCommentAdditionBox(); }
    action cancel() { replace("showText" + editT, showWikiText(editT, text, preview)); toggleCommentAdditionBox(); }
    action updateTextPreview() {    
      replace("preview" + t, textPreview(preview));  
    }
    form{  
      input(preview)[onkeyup := updateTextPreview(), style="height: 300px;width: 98.5%;"]
      par{
        <a href="http://en.wikipedia.org/wiki/Markdown#Syntax_examples"
           class="btn" target="_blank" title="Learn about markdown syntax; opens in new window/tab">        
          iQuestionSign " Markdown Syntax Help"
        </a>
        pullRight{
          submitlink save() [class="btn btn-primary"] { "Save" } " "
          submitlink cancel() [class="btn"] { "Cancel" }
        }
      }
    }
    clear
    placeholder "preview" + t { textPreview(preview) }
  }
  
  ajax template textPreview(text: Ref<WikiText>) {
    par{ "Preview" }
    blockquote{ 
      output(text)  
      small{ byline(text.getEntity()) } 
    }
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
    div[onclick=edit(), ondblclick=edit(), title= "Click to edit"]{ output(x) elements }
  }
  
  ajax template editableStringEdit(t: String, x: Ref<String>, old: String) {
    action save() { 
      replace(t as String, editableStringShow(t, x));
    } 
    action cancel() { 
      x := old; 
      replace(t as String, editableStringShow(t, x));
    }
    buttonGroup{
      form{ 
        inputAppend{ 
          input(x)[style="width: 60%;"] 
          submit save() [style="display:none;"] { "Save" }
          submitlink save() [class="btn btn-primary"] { "Save" } " "
          submitlink cancel() [class="btn"] { "Cancel" }
        }
      }
    }
    clear
  }
  
  