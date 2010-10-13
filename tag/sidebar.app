module tag/sidebar

define template tagSideBar(t : Tag) {
	block [class := "sidebar"] {
		projectCommands(t.project)
		sidebarSeparator()
		tagCommands(t)
	}
}

define template tagCommands(t : Tag) {
	par { <h1> output(t) </h1> }
	par { navigate(createTaggedIssue(t.project, t))	{"New " output(t.name) " Issue"} }
	par { actionLink("Make Release", makeRelease(t, t.project) ) }
	par { actionLink("Make Issue Type", makeIssueType(t, t.project) ) }
	par { actionLink("Color Red", color(t, t.project, "red") ) }
	par { actionLink("Color Green", color(t, t.project, "green") ) }
	par { actionLink("Color Grey", color(t, t.project, "grey") ) }
			
	action makeRelease(t : Tag, p : Project) {
		t.tags.add(tag("release", p));
		return tag(p, t.name);
	}
	action makeIssueType(t : Tag, p : Project) {
		t.tags.add(tag(ISSUE_TYPE_TAG(), p));
		return tag(p, t.name);
	}
	action color(t : Tag, p : Project, color : String) {
		t.tags.add(tag(color, p));
		return tag(p, t.name);
	}
}