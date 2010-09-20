module tag/release


function releases(p : Project) : List<Tag> {
	return 
		select t
		from Tag as t
		left join t.tags as tt
		where   t._project=~p	
			and tt._name = ~"release"
		order by t._name desc
		limit 5000;
}

function nextRelease(p : Project, r : Tag) : Tag {
	var next : List<Tag> := 
		select t
		from Tag as t
		left join t.tags as tt
		where   t._project=~p 
			and tt._name = ~"release"
			and t._name > ~r.name
		order by t._name asc
		limit 1;
	
	if(next.length != 0) {
		return next.get(0);
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

function isRelease(r : Tag) : Bool {
	return r.hasTag("release");
}

// Ugly and inefficient implementation, but queries kept failing on HQL syntax errors 
function releaseDone(p : Project, r : Tag) : Bool {
	var issues := releaseIssues(r);
	return 
		issues.length == 0 ||
		!issues.get(0).open;
}