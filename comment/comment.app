module comment/comment

imports comment/ac
imports comment/event

entity Comment : Event {
	// submitted		:: DateTime
	text			:: WikiText		(searchable)
	author			-> User 
	
	function toJSON():JSONObject{
		var json:= JSONObject();
		json.put("text",text.format());
		json.put("author",author.toJSON());
		json.put("submitted", moment);
		return json;
	}
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

define template comment(c : Comment) {
	block [class := "CommentHeader"] {
		"On " output(format(c.moment)) " " output(c.author.name) " wrote: "
		navigate(editComment(c)){"edit"}
	}
	block [class := "CommentText"] {
		output(c.text)
	}
}

define template commentAddition(i : Issue) {
	placeholder commentAdditionBox {
		par { actionLink("New Comment", showCommentAdditionInput(i)) [ajax] }
	}
	action showCommentAdditionInput( i : Issue ) {
		replace(commentAdditionBox, commentAdditionInput(i));
	}
}

define ajax template commentAdditionInput(i : Issue) {
	var newCommentText : WikiText := "";
	par { <h2> "New Comment" </h2> }
	block [class := "CommentAdd"] {
		form {
			par { input(newCommentText) }
			if(!i.open) {
				par { "This issue is closed! Are you sure you want to add a comment?" }
			}
			par { 
				action("Post Comment", comment(newCommentText, i))  [ajax]
				" "
				action("Post Comment & Close", commentClose(newCommentText, i)) [ajax]
			}
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

define template noCommentAddition() {
	par { <i> "Log in to post comments" </i> }
}

define page editComment(c : Comment) {
	var is := 
			select i
			from Issue as i
			left join i.log as l
			where ~c = l
			limit 1
		var i := is.get(0);
	title{"YellowGrass.org - Edit Comment"}
	main(i.project)
	define body(){
		<h1> "Edit Comment" </h1>
		form {
			par {
				label("Comment") { input(c.text) }
			}
			par {
				navigate(issue(i.project, i.number)) {"Cancel"}
				" "	
				submit("Save",save())
			}
		}
		action save(){
			c.save();
			return issue(i.project, i.number);
		}
	}
}
