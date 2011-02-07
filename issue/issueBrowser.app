module issue/issueBrowser

/*
define template issues(is : List<Issue>, showProjectName : Bool, showTicks : Bool, showNumbers : Bool, titleLength : Int, showTags : Bool) {
	placeholder issueDetails {}
	block [class := "Listing"] {
		table {
			for(i : Issue in is) {
				row [onclick := showIssueDetails(i)] {
					if(showTicks) {
						if(!i.open) { 
							image("/images/tick.png") 
						} else { 
							"" 
						}
					}
					if(showNumbers) {
						output(i.number)
					}
					if(now().format("yyyy") == i.submitted.format("yyyy")) {
						block[class := "DateMD"] { output(i.submitted.format("MMM d")) }
					} else {
						block[class := "DateMDY"] { output(i.submitted.format("MMM d yyyy")) }
					}
					if(showProjectName) {
						output(abbreviate(i.project.name, 20))
					}
					block[class := "AbbreviatedIssueTitle"] {
						navigate(issue(i.project, i.number)) {
							output(abbreviate(i.getTitle(), titleLength))
						}
					}
					if(showTags) { 
						tags(i, false, true)
					}
				}
			}
		}
	}
	action showIssueDetails(i : Issue){
		replace(issueDetails, issueDetails(i));
	}
}

define ajax issueDetails(i : Issue){
	row {
		output(i.reporter)
		output(i.description)
	}
}*/
