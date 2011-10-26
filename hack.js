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