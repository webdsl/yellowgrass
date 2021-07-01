module issue/types

imports project/project-model
imports tag/tag-model

function ISSUE_TYPE_TAG() : String {return "issuetype";}
	
function createIssueTypes(project : Project) {
	var imp : Tag := tag("improvement", project);
	var err : Tag := tag("error", project);
	var fea : Tag := tag("feature", project);
	var que : Tag := tag("question", project);
	
	var meta : Tag := tag(ISSUE_TYPE_TAG(), project);
	if(!imp.hasTag(meta.name)) { imp.tags.add(meta); }
	if(!err.hasTag(meta.name)) { err.tags.add(meta); }
	if(!fea.hasTag(meta.name)) { fea.tags.add(meta); }
	if(!que.hasTag(meta.name)) { que.tags.add(meta); }
	
	imp.save();
	err.save();
	fea.save();
	que.save();
}