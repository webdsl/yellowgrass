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