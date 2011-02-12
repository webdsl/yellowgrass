module auxiliary

function abbreviate(s : String, length : Int) : String {
	if(s.length() <= length) {
		return s;
	} else {
		return prefix(s, length - 4) + " ...";
	}
}

function prefix(s : String, length : Int) : String {
	if(s.length() <= length) {
		return s;
	} else {
		var sChar := s.split();
		sChar.removeAt(length);
		return prefix(sChar.concat(), length);
	}
}

function max(i1 : Int, i2 : Int) : Int {
	if(i1 >= i2) {
		return i1;
	}
	return i2;
}

function maxList(is : List<Int>) : Int {
	var m : Int := is.get(0);
	for(i : Int from 0 to is.length - 1) {
		var current : Int := is.get(i); 
		m := max(m, current);
	}
	return m;
}

function prefix(s : List<Issue>, length : Int) : List<Issue> {
	if(s.length <= length) {
		return s;
	} else {
		s.removeAt(length);
		return prefix(s, length);
	}
}

define ajax validationFeedback(vem : ValidationExceptionMultiple){
	for(ve : ValidationException in vem.exceptions){
		output(ve.message)
	} separated-by { "; " }
}
  
function format(date : DateTime) : String {
	if(now().format("yyyy") == date.format("yyyy")) {
		return date.format("d MMM");
	} else {
		return date.format("d MMM ''yy");
	}
}

define ajax template empty() {}

/* Provides continously loading pages: whenever the user scrolls down, more page is loaded
 * While higher-order templates are not yet supported:
 * Define an ajax template with a button of class continuousLoader, which triggers loading
 * of additional page content.
 */
define template continuousLoading() {
	includeJS("https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js")
	<script>
		var earlyLoadOffset = 400;
		var lastLoader = null;
		var allLoaded = false;
	
		function loadMore(){
			var newLoader = $(".continuousLoader:last");
			if(newLoader == lastLoader) {
				allLoaded = true;
			} else {
				newLoader.click();
				lastLoader = newLoader;
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
	</script>
}