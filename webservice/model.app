module webservice/model

entity Release{
	name	:: String
	issues	-> List<Issue>
	project -> Project

	function toJSON():JSONObject{
		var jsonObject := JSONObject();
		jsonObject.put("id",project.name.substring(0, min(20,project.name.length() -1)) + name);
		jsonObject.put("name",name);
		// var releaseobject := JSONObject();
		// releaseobject.put("id",jsonObject.get("id"));
		var jsonArray := JSONArray();
		for(issue:Issue in issues){
			var jsonobject := issue.toJSON();
			// jsonobject.put("release",releaseobject);
			jsonArray.put(jsonobject);		
		}
		jsonObject.put("issues",jsonArray);
		return jsonObject;
	}	 
	
	function toJSONSimple():JSONObject{
		var jsonObject := JSONObject();
		jsonObject.put("id",project.name.substring(0, min(20,project.name.length() -1)) + name);
		jsonObject.put("name",name);
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

entity VersionObject{
	 function  toString2(): String{
	 	return"{ id:"+ id + ", version:" + version+" }";
	 }
 }

function toVersionObejcts(json:JSONArray):List<VersionObject>{
	var versionobjects := List<VersionObject>();
	for(i:Int from 0 to json.length()){
		var object := json.getJSONObject(i);
		versionobjects.add(
			VersionObject{
				id :=  object.getString("id").parseUUID() 
				version:= object.getInt("version") });
	}
	return versionobjects;	
}
