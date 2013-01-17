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
    action edit(){ 
      replace("showText" + t, editWikiText(t, text, preview)); 
    }   
    blockquote{  
      pullRight{ 
        submitlink edit() [class="btn", style="height:14px;padding:7px;margin:0 0 10px 30px;", title="Edit"] { iPencil } 
      }
      output(text)
      small{ byline(text.getEntity()) } 
    }
  }
  
  define ajax editWikiText(editT: String, text : Ref<WikiText>, preview: Ref<WikiText>) {
    var t := getTemplate().getUniqueId();
    init{ preview := text; }
    action save() { text := preview; replace("showText" + editT, showWikiText(editT, text, preview)); }
    action cancel() { replace("showText" + editT, showWikiText(editT, text, preview)); }
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
  
  