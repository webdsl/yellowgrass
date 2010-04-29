module comment/comment

imports comment/ac
imports comment/event

entity Comment : Event {
	submitted		:: DateTime
	text			:: WikiText
	author			-> User 
}

function createComment(t : WikiText) : Comment {
	var c := Comment {
		text := t
		submitted := now()
		author := securityContext.principal
	};
	c.save();
	return c;
}

define template eventDescription(c : Comment) {
	block [class := "CommentHeader"] {
		"On " output(c.moment.format("MMM d")) " " output(c.author.name) " wrote: "
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
			par { 
				action("Post Comment", newComment(newCommentText, i))  [ajax]
				" "
				action("Post Comment & Close", commentClose(newCommentText, i)) [ajax]
			}
		}
	}
	
	action newComment(text : WikiText, issue : Issue) {
		var comment := createComment(text);
		issue.addComment(comment);
		return issue(issue.project, issue.number);
	}
	action commentClose(text : WikiText, issue : Issue) {
		var comment := createComment(text);
		issue.commentClose(comment);
		return project(issue.project);
	}
}

define template noCommentAddition() {
	par { <i> "Log in to post comments" </i> }
}

define page editComment(c : Comment) {
	title{"YellowGrass.org - Edit Comment"}
	main()
	define body(){
		var is := 
			from Issue
			where c in i.log
			limit 1
		var i := is.get(0);
		
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