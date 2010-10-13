module issue/types

entity IssueType {
	name	:: String	(id)
}

var improvementIssueType : IssueType := 
	IssueType { name := "Improvement" };
var errorIssueType : IssueType := 
	IssueType { name := "Error" };
var featureIssueType : IssueType := 
	IssueType { name := "New Feature" };
var questionIssueType : IssueType := 
	IssueType { name := "Question" };

function ISSUE_TYPE_TAG() : String {return "issuetype";}
	
function createIssueTypes(project : Project) {
	var imp : Tag := tag("improvement", project);
	var err : Tag := tag("error", project);
	var fea : Tag := tag("feature", project);
	var que : Tag := tag("question", project);
	
	var meta : Tag := tag(ISSUE_TYPE_TAG(), project);
	imp.tags.add(meta);
	err.tags.add(meta);
	fea.tags.add(meta);
	que.tags.add(meta);
	
	imp.save();
	err.save();
	fea.save();
	que.save();
}