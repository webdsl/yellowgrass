module webservice/model

imports built-in
imports issue/issue-model
imports project/project-model
imports tag/-
imports user/user-model

entity Release{
	name	:: String
	issues	-> List<Issue>
	project -> Project

	function toJSON() : JSONObject {
		var jsonObject := JSONObject();
		jsonObject.put("id", project.name.substring(0, min(20,project.name.length() - 1)) + name);
		jsonObject.put("name", name);
		// var releaseobject := JSONObject();
		// releaseobject.put("id",jsonObject.get("id"));
		var jsonArray := JSONArray();
		for(issue : Issue in issues) {
			var jsonobject := issue.toJSON();
			// jsonobject.put("release",releaseobject);
			jsonArray.put(jsonobject);		
		}
		jsonObject.put("issues", jsonArray);
		return jsonObject;
	}	 
	
	function toJSONSimple() : JSONObject {
		var jsonObject := JSONObject();
		jsonObject.put("id", project.name.substring(0, min(20,project.name.length() - 1)) + name);
		jsonObject.put("name", name);
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


// function min (a : Int, b : Int) : Int {
// 	if(a < b) {
// 		return a;
// 		
// 	} else {
// 		return b;
// 	}
// }

entity VersionObject {
	 function  toString2() : String {
	 	return "{ id:" + id + ", version:" + version + " }";
	 }
 }

function toVersionObejcts(json : JSONArray) : List<VersionObject> {
	var versionobjects := List<VersionObject>();
	for(i : Int from 0 to json.length()) {
		var object := json.getJSONObject(i);
		versionobjects.add(
			VersionObject{
				id :=  object.getString("id").parseUUID() 
				version := object.getInt("version") 
			});
	}
	return versionobjects;	
}

section authentication

extend entity User {
 	deviceKeySet  -> Set<AuthenticationKey>
 	
 	function generateAuthenticationKey(deviceDescription : String) : UUID {
 		var key := getDeviceKey(deviceDescription);
 		if(key == null){
 			var newKey := AuthenticationKey {
 				deviceDescription := deviceDescription	
 			};
 			newKey.save();
 			deviceKeySet.add(newKey);
 			key := newKey.id;
 		}
 		return key;	
 	}
 	
 	function getDeviceKey(deviceDescription : String) : UUID {
 		var filteredList := [key | key : AuthenticationKey in deviceKeySet where  deviceDescription == key.deviceDescription ];
 		if(filteredList.length == 1) {
 			return filteredList[0].id;	
 		} else {
 			return null;
 		}
 		
 	}
 	
}

entity AuthenticationKey {
	deviceDescription 	:: String 
}

