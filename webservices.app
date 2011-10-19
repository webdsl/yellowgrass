module webservices

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
		jsonArray.put(project.toJSON());
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

