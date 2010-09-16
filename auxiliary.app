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
