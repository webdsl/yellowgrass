//setTimeOut(function() {		
//  		var d = $("tbody > span"); 
//  		d.replaceWith(d.contents());
// },500);

function fixTablePopulairIssues(){
	setTimeout(function() {		
		var bodies = $("#myTable > tbody > span");
		bodies.each(function(){$(this).replaceWith($(this).contents());});
		},300); 
}
//function fixTablePopulairIssues(){
//	setTimeout(function() {		
//		var body = $("#myTable > tbody > span");
//		var content = body.contents();
//		while(content.is("span")){
//			content = content.contents();
//		}
//		body.replaceWith(content);
//	},300); 
//}
//function fixTablePopulairIssues(){
//	setTimeout(function() {		
//		var body = $("#myTable > tbody > span");
//		body.replaceWith(body.contents());
//	},300); 
//}

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
	mobl.reload();
}

function fixDB2(){
	var db = openDatabase('Yellowgrassmobile', '1.0', 'Test DB', 2 * 1024 * 1024);
	db.transaction(function (tx) {  
		tx.executeSql('CREATE TABLE IF NOT EXISTS `servicemodel__Project_members_servicemodel__User` (`servicemodel__Project_members` VARCHAR(36), `servicemodel__User_projects` VARCHAR(36), PRIMARY KEY (`servicemodel__Project_members`, `servicemodel__User_projects`))');
	});
	db.transaction(function (tx) {  
		tx.executeSql('CREATE TABLE IF NOT EXISTS `servicemodel__Project_followers_servicemodel__User` (`servicemodel__Project_followers` VARCHAR(36), `servicemodel__User_projects` VARCHAR(36), PRIMARY KEY (`servicemodel__Project_followers`, `servicemodel__User_projects`))');
	});
}

function checkServiceStatus(URL){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.open("GET",URL,false);
	try{ 
		xmlhttp.send(null);
	}catch(e){
		return false;
	}
	
	return xmlhttp.readyState == 4 && xmlhttp.status == 200 
}

function checkStatus(){
	window.applicationCache.update();
	return lib.online;
}

function setCacheFunctions(){
	window.applicationCache.onerror= function(){lib.online = false};
	window.applicationCache.onupdateready=function(){lib.online = true};
	window.applicationCache.onnoupdate=function(){lib.online = true};
}

function testOnline(){
	var oRequest = new XMLHttpRequest();
	oRequest.open( "Get", "online.js", false );
	oRequest.send(null);
	var x = oRequest.responseText;
	return x ==='true'
}
