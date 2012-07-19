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
		// test4 := "chrismelman@hotmail.com",
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



		