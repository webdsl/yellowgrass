module webservices

imports
webservice/model

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
	log("called service: getProject:"+name);
	var project := loadProject(name);
	return project.toJSON();
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

