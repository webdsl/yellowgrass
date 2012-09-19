application yellowgrassModel
imports model/main
imports entity-pages/main
imports webservices/json/main
imports webservices/services/interface
page root() {
	navigate showEntities() { "entities" }
	// init{
	// 	var x := Issue{};
	// 	x 
	// }
	   
}    
  
  
 
derive webservices for Project , with nameproperty name
service test() {  
		var event :=   
		Event{  
		// test := true, 
		// test2 := "test",
		// test3 := 42,
		// test4 := "chrismelman@hotma0il.com",
		// test5 := 1.923,
		// test6 := 9223372036854775807L,
		// test7 := "http://webdsl.org",
		// test8 := "1234",//.makePatch("23"),
		// test9 := "text for win", 
		// test13 := "*1*<b>2</b>",
		moment := now()
		// test14 := Time("22:08"),
		// test15 := today(), 
		// test16 := Issue{},
		// test17 := null
 
			
	};
	return event.toJSON();
}
 derive crud Project
// native class DispatchServletHelper as DispatchServletHelper : DispatchServlet{
//     getResponse() : HttpServletResponse
//     forwardRequest(String)
//     static get() : DispatchServlet
//   }
//   
//   function getDispatchServletHelper() : DispatchServletHelper{
//     var servlet := DispatchServletHelper.get();
//     if (servlet is a DispatchServletHelper) {
//     	return servlet as DispatchServletHelper;
//     } else { 
//     	return null;
//     }
//   } 
// 
// function getAvialableServices() : List<String> { 
// 		return ["sdfsd","sdfsdf"];
// }
//  
// page jala(service : String) {
// 	init {
// 		if (getAvialableServices().indexOf(service) >= 0) {
// 			getDispatchServletHelper().forwardRequest("http://www.google.nl");
// 		} else {
// 			getDispatchServletHelper().forwardRequest("/root");
// 		}
// 	}
// }
// 
// service testing(service : String) {
// 		// init{
// 		// 	getDispatchServletHelper().forwardRequest("www.google.nl");
// 		// }
// 		// var json := JSONObject(readRequestBody());
// 		if (getAvialableServices().indexOf(service) >= 0) {
// 			getDispatchServletHelper().forwardRequest("/tempgeneratedGetTopLevelEntities");
// 			return  "true";
// 		} else {
// 			return "false";
// 		}
// }
// service	tempgeneratedGetTopLevelEntities()  {  
// 	var request 	:= JSONObject(readRequestBody());  
// 	var result:= JSONObject();
// 	result.put("hello",request.get("test"));
// 	return result; 
// }
 

function test () : Set<Issue> {
	var project := findProjectByName("yellowgrass")[0];
	var todo := Set<Entity>();
	var seen := Set<UUID>();
	var found := Set<Issue>();
	addToSetWhereNotSeen(todo, seen, project.getRelatedEntities());
	for(ent : Entity in project.getRelatedEntities() where !(ent.id in seen)) {
		todo.add(ent);
		seen.add(ent.id);
	}
	for(ent: Entity in todo) {
		if(!(ent is a Project)) {
			if (ent is a Issue) {
				found.add(ent as Issue);
				addToSetWhereNotSeen(todo, seen, (ent as Issue).getRelatedEntities());
			}
			if(ent is a User ){
				addToSetWhereNotSeen(todo, seen, (ent as User).getRelatedEntities());
			}
			if(ent is a Event ){
				addToSetWhereNotSeen(todo, seen, (ent as Event).getRelatedEntities());
			}
			if(ent is a Attachment ){
				addToSetWhereNotSeen(todo, seen, (ent as Attachment).getRelatedEntities());
			}
			if(ent is a Tag ){
				addToSetWhereNotSeen(todo, seen, (ent as Tag).getRelatedEntities());
			}
		}
	}
	return found;
}  

page test3 (){
	output(test())
}
function addToSetWhereNotSeen(set : Set<Entity>, seen : Set<UUID>, add : Set<Entity> ){
	for(ent : Entity in add where !(ent.id in seen)) {
		set.add(ent);
		seen.add(ent.id);
	}
}

// function test2 (project : Project ) : Set<Entity> { 
// 	var set := Set<Entity>();	
// 	for (ent : Issue in project.issues){
// 		set.add(this.issues);
// 	}
// 	for (ent : User in project.followers){
// 		list.add(ent);
// 	}
// 	for (ent : User in project.members){ 
	// 		list.add(ent);
	// 	}
// 	return set;				
// }
// 		