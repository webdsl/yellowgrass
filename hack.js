//setTimeOut(function() {		
//  		var d = $("tbody > span"); 
//  		d.replaceWith(d.contents());
// },500);

function fixTablePopulairIssues(){
	setTimeout(function() {		
		var body = $("#myTable > tbody > span")
		body.replaceWith(body.contents());
	},300);

}	
function fixDB(){
	var db = openDatabase('Yellowgrassmobile', '1.0', 'Test DB', 2 * 1024 * 1024);
	db.transaction(function (tx) {  
		tx.executeSql('DROP TABLE IF EXISTS `servicemodel__Project_members_servicemodel__User`');
	});
	db.transaction(function (tx) {  
		tx.executeSql('CREATE TABLE IF NOT EXISTS `servicemodel__Project_members_servicemodel__User` (`servicemodel__Project_members` VARCHAR(36), `servicemodel__User_projects` VARCHAR(36), PRIMARY KEY (`servicemodel__Project_members`, `servicemodel__User_projects`))');
	});
	
	db.transaction(function (tx) {  
		tx.executeSql('DROP TABLE IF EXISTS `servicemodel__Project_followers_servicemodel__User`');
	});
	db.transaction(function (tx) {  
		tx.executeSql('CREATE TABLE IF NOT EXISTS `servicemodel__Project_followers_servicemodel__User` (`servicemodel__Project_followers` VARCHAR(36), `servicemodel__User_projects` VARCHAR(36), PRIMARY KEY (`servicemodel__Project_followers`, `servicemodel__User_projects`))');
	});
	// prefere to call excute again by root but oke
	mobl.reload();
}
