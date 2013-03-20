module comment/comment

imports comment/ac
imports comment/event

section data model

  entity Comment : Event {
	  // submitted		:: DateTime
	  text			:: WikiText		(searchable(default))
	  preview   :: WikiText
	  author		-> User 
	
	  function toJSON() : JSONObject {
		  var json := JSONObject();
		  json.put("id", id);
		  json.put("text", text.format());
		  json.put("author", author.toJSON());
		  json.put("submitted", moment.getTime() / 1000L);
		  json.put("version", version);
		  return json;
	  }
  }

section operations

  function checkNewCommentObjects(json : JSONArray) : List<Comment> {
		var newObjects := List<Comment> ();
		for(i : Int from 0 to json.length()) {
			var object := json.getJSONObject(i);
			if(object.has("new") && object.getBoolean("new")) { 
				var newObject :=  Comment {
					author 	:= loadUser(object.getJSONObject("author").getString("id").parseUUID())
					moment 	:= now()
					text   	:= object.getString("text") 
				};
				newObject.save();
				newObjects.add(newObject);
				log("new Comment : " + newObject.text);
			 }
		}
		return newObjects;
	}

  function createComment(t : WikiText) : Comment {
	  var c := Comment {
		  text := t
		  moment := now()
		  author := securityContext.principal
	  };
	  c.save();
	  return c;
  }
  
section view

  template byline(c: Comment) {
    "Submitted on " output(c.moment.format("d MMMM yyyy 'at' HH:mm")) " by " nav(c.author)
  }

  template comment(c : Comment) {
	  // block [class := "CommentHeader"] {
		 //  "On " output(c.moment.format("d MMMM yyyy 'at' HH:mm")) " " nav(c.author) " wrote: "
		 //  navigate editComment(c) [title="edit comment"] { iPencil }
	  // } 	  
	  editableText(c.text, c.preview)  
	  hrule
  }

  template commentAddition(i : Issue) { 
	  placeholder commentAdditionBox {
	    commentAdditionInput(i)
		  // pullRight { par{
		  //   submitlink showCommentAdditionInput(i) [class="btn btn-mini"] { iPlus " New Comment" } 
		  // } }
	  }
	  // action showCommentAdditionInput( i : Issue ) {
		 //  replace(commentAdditionBox, commentAdditionInput(i));
	  // }
  }

  // template commentAdditionTool(i : Issue) { 
  //   submitlink showCommentAdditionInput(i) [class="btn btn-mini", title="New Comment", style="height:14px;padding:7px;"] { 
  //     iComment  
  //   } 
  //   action showCommentAdditionInput( i : Issue ) {
  //     replace(commentAdditionBox, commentAdditionInput(i));
  //   }
  // }
    
  ajax template commentAdditionInput(i : Issue) {
  	
  	action ignore-validation updateCommentPreview(d : WikiText) {
      replace(commentPreview, commentPreview(d, false)); 
    }
	  var newCommentText : WikiText := ""; 
      
	  pageHeader3 { "New Comment" } 
	  horizontalForm { 
			par { 
			  input(newCommentText)[onkeyup := updateCommentPreview(newCommentText), placeholder="Your comment"]{
			    validate(!isEmptyString(newCommentText), "Comment should not be empty")
			  } }
			if(!i.open) {
				par { "This issue is closed! Are you sure you want to add a comment?" }
			}						
			placeholder commentPreview {} 
			formActions { 
				submitlink comment(newCommentText, i) [class="btn"] { "Post Comment" }
				" "
				submitlink commentClose(newCommentText, i) [class="btn"] { "Post Comment & Close" }
			}
		}
	
	  action comment(text : WikiText, issue : Issue) {
		  var comment := createComment(text);
		  issue.addComment(comment);
		  return issue(issue.project, issue.number);
	  }
	  action commentClose(text : WikiText, issue : Issue) {
		  var comment := createComment(text);
		  issue.commentClose(comment);
		  return issue(issue.project, issue.number);
	  }
  }

  ajax template commentPreview(d : WikiText, controlGroup: Bool) {
	  if(controlGroup) { 
	    controlGroup("Preview") { blockquote{ output(d) } } 
	  } else {
	    group("Preview") { blockquote { output(d) } }
	  }
  }
  
  template noCommentAddition() {
	  par { <i> "Log in to post comments" </i> }
  }

 //  page editComment(c : Comment) {    
 //    title{"YellowGrass.org - Edit Comment"}
	//   var is := 
	// 	 	select i
	// 		from Issue as i
	// 		left join i.log as l
	// 		where ~c = l
	// 		limit 1
	// 	var i := is.get(0);
	//   action save(){
 //      c.save();
 //      IndexManager.reindex(i); //reindex issue to reflect changed comment in search index of Issue (because Issue.comments is a derived prop -> not flagged dirty -> no reindex of Issue)
 //      return issue(i.project, i.number);
 //    }
 //    action ignore-validation updateCommentPreview(d : WikiText) {
 //      replace(commentPreview, commentPreview(d, true));
 //    }
	//   bmain(i.project){
	// 	  pageHeader4{ "Edit Comment" }
	//     horizontalForm {
	// 		   controlGroup("Comment") { 
	// 		     input(c.text)[onkeyup := updateCommentPreview(c.text), style="height:400px;"] 
	// 		   }
	// 		   placeholder commentPreview { }
	// 		   formActions {
	// 		     submitlink save() [class="btn btn-primary"] { "Save" } " "
	// 			   navigate issue(i.project, i.number) [class="btn"] {"Cancel"}
	// 			 }
	// 		}
	// 	}
	// }
