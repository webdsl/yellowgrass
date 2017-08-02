module tag/release

extend entity Tag {
	function isRelease() : Bool {
		return hasTag("release");
	}
}

function releases(p : Project) : List<Tag> {
	return 
		select t
		from Tag as t
		left join t.tags as tt
		where   t._project=~p	
			and tt._name = ~"release"
		order by t.orderString desc
		limit 5000;
}

function nextRelease(r : Tag) : Tag {
	var next : List<Tag> := 
		select t
		from Tag as t
		left join t.tags as tt
		where   t._project=~r.project 
			and tt._name = ~"release"
			and t.orderString > ~r.orderString
		order by t.orderString asc
		limit 1;
	
	if(next.length != 0) {
		return next.get(0);
	}
	return null;
}

function previousRelease(r : Tag) : Tag {
	var previous : List<Tag> := 
		select t
		from Tag as t
		left join t.tags as tt
		where   t._project=~r.project 
			and tt._name = ~"release"
			and t.orderString < ~r.orderString
		order by t.orderString desc
		limit 1;
	
	if(previous.length != 0) {
		return previous.get(0);
	}
	return null;
}

function releaseIssues(r : Tag) : List<Issue> {
	return
		select i 
		from Issue as i 
		left join i._tags as t 
		where t=~r
		order by i._open desc, i._submitted desc;
}

// Ugly and inefficient implementation, but queries kept failing on HQL syntax errors 
function releaseDone(r : Tag) : Bool {
	var issues := releaseIssues(r);
	return 
		issues.length == 0 ||
		!issues.get(0).open; 
		// No need to check more, cause the result is sorted. 
		// Querying is faster than checking each individually 
		// through hibernate anyway.
}