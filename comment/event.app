module comment/event

imports comment/ac
imports comment/comment
imports comment/tagControl


entity Event {
	moment			:: DateTime
	
	function toJSON():JSONObject{
		var json := JSONObject();
		return null;
		
	}
}


template events(es : Set<Event>) {
	for(e : Event in es order by e.moment asc) {
		eventDescription(e)
	}separated-by{ hrule }
}

template eventDescription(e : Event) {
	if(e is a Comment)		{ comment(e as Comment) }
	if(e is a IssueReopen) 	{ issueReopen(e as IssueReopen) }
	if(e is a IssueClose) 	{ issueClose(e as IssueClose) }
	if(e is a TagAddition) 	{ tagAddition(e as TagAddition) }
	if(e is a TagRemoval) 	{ tagRemoval(e as TagRemoval) }
	if(e is a IssueMoved)	{ issueMoved(e as IssueMoved) }
}