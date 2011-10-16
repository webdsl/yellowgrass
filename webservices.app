module webservices

service getProjects(){
	log("called service: getProjects");
	var projectList : List<Project> := 
			from Project
			where _private=false
			order by _name;
	var jsonArray := JSONArray();
	for(project:Project in projectList ) {
		jsonArray.put(project.toJSON());
	}
	return jsonArray; 
}

service getPopularProjects(){
	var json := JSONObject(readRequestBody());
	log("called service: getPopularProjects");
	var number := json.getInt("number");
	log("called service: getPopularProjects");
	var json := JSONArray();
		var activeProjects : List<Project> := 
			select p 
			from Project as p
			join p.issues as i
			where _private=false
			group by p
			order by max(i._submitted) desc
			limit 10;
	
	for(project:Project in activeProjects ) {
		var jsonobject := JSONObject();
		jsonobject.put("name", project.name);
		jsonobject.put("description",project.description.format());
		jsonobject.put("url",project.url);
		jsonobject.put("weeklyStatsGraph",project.getWeeklyStatsGraph());
		json.put(jsonobject);
	}
	return json; 
}