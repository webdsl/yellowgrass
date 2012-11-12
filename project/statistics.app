module project/statistics

function obtainPageViewStatisticsGraph(projects : List<Project>) : String {
	var stats : List<ProjectIntTuple>;
	var bound : DateTime := now().addMonths(-1);
	var r : RequestLogEntry;
	
	for(p : Project in projects where p.name != "YellowGrass") {
		stats.add(
			ProjectIntTuple(
				p,
				select count(*)
				from RequestLogEntry
				where	_start > ~bound and 
						(
							_requestedURL like ~("http://yellowgrass.org/issue/"+p.name+"/%") or 
							_requestedURL = ~("http://yellowgrass.org/project/"+p.name)
						) and
						_userAgent not like ~"%bot%"
			)
		);
	}
	var oStats := [pi | pi : ProjectIntTuple in stats order by pi.i desc limit 8];

	var url : List<String>;
	url.add(	"http://chart.apis.google.com/chart"	);
	url.add(	"?chxl=1:"	);
	for(pi : ProjectIntTuple in oStats) {
		url.add("|"+pi.p.name);
	}
	url.add(	"&chxr=0,0,"+oStats[0].i	);
	url.add(	"&chxt=x,y"	);
	url.add(	"&chbh=a"	);
	url.add(	"&chs=400x300"	);
	url.add(	"&cht=bhs"	);
	url.add(	"&chco=bbcebb"	);
	url.add(	"&chds=0,"+oStats[0].i	);
	url.add(	"&chd=t:");
	for(nr : Int from 0 to oStats.length - 2) {
		url.add(oStats.get(nr).i + ",");
	}
	url.add(oStats.get(oStats.length - 1).i+"");
	return url.concat();
}

  native class org.yellowgrass.utils.ProjectIntTuple as ProjectIntTuple {
	  p : Project
	  i : Int
	  constructor(Project, Int)
  }

  page statistics() {
	  var projects : List<Project> := from Project;
	  var url := obtainPageViewStatisticsGraph(projects);
	  title{"YellowGrass.org - Statistics"}
	  bmain{
		  pageHeader2{ "Last Month's Page Views" }
		  <img src=url/>
	  }
  }
  