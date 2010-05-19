module comment/event

imports comment/ac
imports comment/comment


entity Event {
	moment			:: DateTime
}

define template events(es : Set<Event>) {
	for(e : Event in es order by e.moment asc) {
		eventDescription(e)
	}
}

define template eventDescription(e : Event) {
	if(e is a Comment)		{ comment(e as Comment) }
	if(e is a IssueReopen) 	{ issueReopen(e as IssueReopen) }
	if(e is a IssueClose) 	{ issueClose(e as IssueClose) }
}