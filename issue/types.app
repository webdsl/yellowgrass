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
	if(!imp.hasTag(meta.name)) { imp.tags.add(meta); }
	if(!err.hasTag(meta.name)) { err.tags.add(meta); }
	if(!fea.hasTag(meta.name)) { fea.tags.add(meta); }
	if(!que.hasTag(meta.name)) { que.tags.add(meta); }
	
	imp.save();
	err.save();
	fea.save();
	que.save();
}

function migrateToIssueTypeTags(p: Project) : Int {
	if(p.name != "YellowGrass") {return 0;}
	
	for(p : Project) {
		createIssueTypes(p);
		p.save();
	}
	
	var nonmigIssues : List<Issue> := 
		select i
		from Issue as i
		where i.type != null
		limit 500;
		
	for(i : Issue in nonmigIssues) {
		if(i.type == improvementIssueType && !i.hasTag("improvement")) {
			i.tags.add(tag("improvement", i.project));
		}
		if(i.type == errorIssueType && !i.hasTag("error")) {
			i.tags.add(tag("error", i.project));
		}
		if(i.type == featureIssueType && !i.hasTag("feature")) {
			i.tags.add(tag("feature", i.project));
		}
		if(i.type == questionIssueType && !i.hasTag("question")) {
			i.tags.add(tag("question", i.project));
		}
		i.type := null;
		i.save();
	}
	flush();
	return 0;
}