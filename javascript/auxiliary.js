var earlyLoadOffset = 1000;
var lastLoader = null;
var allLoaded = false;

function loadMore(){
	var newLoader = $(".continuousLoader:last");
	if(newLoader != null) {
		if(lastLoader != null && newLoader[0].id == lastLoader[0].id) {
			allLoaded = true;
		} else {
			newLoader.click();
			lastLoader = newLoader;
		}
	}
}

function fillPage() {
	if(!allLoaded && $(document).height() <= $(window).height() + earlyLoadOffset){
		loadMore();
		setTimeout('fillPage()',500);
	}
}

$(document).ready(function() {
	fillPage()
	// Add additional items when needed
	$(window).scroll( function(){
		//if ($(window).scrollTop() == $(document).height() - $(window).height()){
		if ($(window).scrollTop() > $(document).height() - $(window).height() - earlyLoadOffset){
			loadMore();
		}
	});
});