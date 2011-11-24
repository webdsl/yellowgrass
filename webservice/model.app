module webservice/model

entity Release{
	name	:: String
	issues	-> List<Issue>
	project -> Project

	function toJSON():JSONObject{
		var jsonObject := JSONObject();
		jsonObject.put("id",project.name.substring(0, min(20,project.name.length() -1)) + name);
		jsonObject.put("name",name);
		var jsonArray := JSONArray();
		for(issue:Issue in issues){
			jsonArray.put(issue.toSimpleJSON());		
		}
		jsonObject.put("issues",jsonArray);
		return jsonObject;
	}		
}

function generateRoadmap(project:Project):List<Release>{
	var releaselist := List<Release>();
 	var releasenames:=releases(project);
 	for(tag:Tag in releasenames){
 		var release := Release { name:=tag.name
 								 project := project
 								 issues := releaseIssues(tag) 
 								 };
 		releaselist.add(release);
 	}
 	return releaselist;
	
}


function min (a:Int, b:Int): Int{
	if(a<b){
		return a;
		
	}else{
		return b;
	}
	
}