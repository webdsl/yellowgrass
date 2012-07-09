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

derive webservices for Project 
service test() {
		var event := 
		Event{
		test := true,
		test2 := "test",
		test3 := 42,
		test4 := "chrismelman@hotmail.com",
		test5 := 1.923,
		test6 := 9223372036854775807L,
		test7 := "http://webdsl.org",
		test8 := "1234",//.makePatch("23"),
		test9 := "text for win",
		test13 := "*1*<b>2</b>",
		moment := now(),
		test14 := Time("22:08"),
		test15 := today(), 
		test16 := Issue{},
		test17 := null
 
			
	};
	return event.toJSON();
}