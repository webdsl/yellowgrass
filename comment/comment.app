module comment/comment

imports comment/ac

entity Comment {
	submitted		:: Date
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

define template comments(cs : Set<Comment>) {
	if(cs.length() == 0) {
		par { "No comments" }
	}
	for(c : Comment in cs order by c.submitted desc) {
		par [class := "CommentHeader"] {
			"On " output(c.submitted) " " output(c.author.name) " wrote:"
		}
		block [class := "CommentText"] {
			output(c.text)
		}
	}
}