function executeOfflinefunc(func,params){
	var paramNames = getParamNames(func);
	var paramval= [];
	for(var i =0; i<paramNames.length;i++){
		paramval.push(params[paramNames[i]]);
	}
	func.apply(this,paramval);
	
}

function getParamNames(func){
	var reg = /\(([\s\S]*?)\)/;
	var params = reg.exec(func);
	if (params){ 
	     var param_names = params[1].split(',');
	}
	for(var i =0; i<param_names.length;i++){
		param_names[i]=param_names[i].trim();
	}
	
	return param_names
}