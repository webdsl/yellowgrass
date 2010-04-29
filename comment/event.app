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

define template eventDescription(e : Event) {}