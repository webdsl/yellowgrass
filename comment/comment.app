module comment/comment

imports comment/ac

entity Comment {
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

define template comments(i : Issue, cs : Set<Comment>) {
	if(cs.length == 0) {
		par { "No comments" }
	}
	for(c : Comment in cs order by c.submitted asc) {
		par [class := "CommentHeader"] {
			"On " output(c.submitted.format("MMM d")) " " output(c.author.name) " wrote: "
			navigate(editComment(i, c)){"[edit]"}
		}
		block [class := "CommentText"] {
			output(c.text)
		}
	}
}

define page editComment(i : Issue, c : Comment) {
	title{"YellowGrass.org - Edit Comment"}
	main()
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
				action save(){
					c.save();
					return issue(i.project, i.number);
				}
			}
		}
	}
}