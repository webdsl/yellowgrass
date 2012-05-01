module webservices

imports
webservice/model
/**
@ param username: valid email of excisting user
@ param password: valid password of the user asociated to the username
@ param deviceDescription: string for descriptionDevice
*/
service authenticate() {
	var jsonErrors := JSONArray();
	var jsonResult := JSONObject();
	var json := JSONObject(readRequestBody());
	var email := json.getString("username");
	var password := json.getString("password");
	var deviceDescription  := json.getString("deviceDescription");
	log("called service: athenticate " + email + ":" + deviceDescription);
	if(!authenticate(email, password)) {
		jsonErrors.put("The login credentials are not valid.");
	}
	if(jsonErrors.length() > 0) {
		jsonResult.put("errors", jsonErrors);
	} else {
		jsonResult.put("key", securityContext.principal.generateAuthenticationKey(deviceDescription));
	}
	return jsonResult; 
}

service checkAuthenticate() {
	var jsonErrors := JSONArray();
	var jsonResult := JSONObject();
	var json := JSONObject(readRequestBody());
	var email := json.getString("username");
	var key := json.getString("key").parseUUID();
	var deviceDescription  := json.getString("deviceDescription");
	var users := findUserByEmail(email);
	log("called service: athenticate " + email + ":" + deviceDescription);
	if(users.length != 1) {
		jsonErrors.put("The user does not exists");
	} else {
		var user := users[0];
		if(user.getDeviceKey(deviceDescription) != key) {
			jsonErrors.put("The key is unvalid");
		} else {
			securityContext.principal := user;
		}
	}
	if(jsonErrors.length() > 0) {
		jsonResult.put("errors", jsonErrors);
		jsonResult.put("answer", false);
	} else {
		jsonResult.put("answer", true);
	}
	return jsonResult; 
}

service logoutDevice() {
	log("called service: logoutDevice");
	securityContext.principal := null;
	var jsonResult := JSONObject();
	jsonResult.put("answer", true);
}

function tryAuthenticate(email : String, password : String) {
	auth:validate(authenticate(email, password), "The login credentials are not valid.");
}

service getProjects(){
	log("called service: getProjects");
	var projectList : List<Project> := 
			from Project
			where _private=false
			order by _name;
	var jsonArray := JSONArray();
	for(project:Project in projectList ) {
		jsonArray.put(project.toSimpleJSON());
	}
	return jsonArray; 
}
/*
@ param number: expecting max number of projecs
*/
service getPopularProjects(){
	var json := JSONObject(readRequestBody());
	var number := json.getInt("number");
	log("called service: getPopularProjects:"+number);
		var activeProjects : List<Project> := 
			select p 
			from Project as p
			join p.issues as i
			where _private=false
			group by p
			order by max(i._submitted) desc
			limit 10;
	
	var jsonArray := JSONArray();
	for(project:Project in activeProjects ) {
		jsonArray.put(project.toSimpleJSON());
	}
	return jsonArray; 
}

service getProject(){
	var json:= JSONObject(readRequestBody());
	var name := json.getString("name");
	var versions := json.getJSONObject("versions");
	log("called service: getProject:"+name);
	var project := loadProject(name);
	return project.toJSON(versions); 
}

service getIssues(){
	var json:= JSONObject(readRequestBody());
	var name := json.getString("project");
	log("called service: getIssues:"+name);
	var project := loadProject(name);
	var jsonArrayIssues := JSONArray();
	

	for (issue:Issue in project.issues){
		
		jsonArrayIssues.put(issue.toJSON());
	}
	return jsonArrayIssues;
}

service getIssuesDetails(){
	var json:= JSONObject(readRequestBody());
	var name := json.getString("project");
	var versions := json.getJSONObject("versions").getJSONArray("issues");
	log("called service: getIssuesDetails:"+name);
	var project := loadProject(name);
	var versionobjects := toVersionObejcts(versions);
	var jsonArrayIssues := JSONArray();
	for (issue:Issue in project.issues){
		var vobject := VersionObject{id:=issue.id};
		var index := versionobjects.indexOf(vobject);
		if(index == -1 || versionobjects.get(index).version != issue.version){
			jsonArrayIssues.put(issue.toExtendedJSON());
		}else{
			jsonArrayIssues.put(issue.toSimpleJSON());
		}
		
	}
	return jsonArrayIssues;
}

service getRoadmap(){
	var json:= JSONObject(readRequestBody());
	var name := json.getString("project");
	log("called service: getRoadmap:"+name);
	var project := loadProject(name);
	var releases := generateRoadmap(project);
	var jsonArrayReleases := JSONArray();
	for(release:Release in releases){
		jsonArrayReleases.put(release.toJSON());
	}
	return jsonArrayReleases;
}

service createIssueService(){
	var jsonobject := JSONObject();
	
	var errors := JSONArray();
	var json:= JSONObject(readRequestBody());
	var project := loadProject(json.getString("project"));
	var title := json.getString("title");
	var description := json.getString("description") as WikiText;
	var tags := Set<Tag>();
	if(json.getString("tag").length()>0){
		tags.add(loadTag(json.getString("tag").parseUUID()));
	}
	var email := json.getString("email") as Email;
	log ("createIssue: project: "+ project.name + " title: "+ title);
	if (project == null){
		errors.put("Non excisting project selected");
	}
	if (json.getString("tag").length() > 0 && tags.length == 0){
		errors.put("Non excisting category selected");
	}if(!email.isValid()){
		errors.put("email is not valid");
	}
	var ig := IssueGhost{ alive := false
						  project := project 
						  email := email
						  description:=description
						  tags := tags
						  title := title};
	if(ig.validateSave().exceptions.length!=0){
		for(e: ValidationException in ig.validateSave().exceptions){
			errors.put(e.message);		
		}
	}
	if (errors.length() == 0){
		ig.save();
		email(issueConfirmationEmail(ig));
		jsonobject.put("answer", true);
	}else{
		jsonobject.put("errors", errors);
		jsonobject.put("id","CreateIssue: "+ title);
		jsonobject.put("answer", false);
	}
	return jsonobject;
}

define page testing(){
	var project := loadProject("WebDSL")
	// output(project.toJSON().toString())
}

access control rules

	rule page testing(){
		true
	}
	rule logsql{
		true
	}


