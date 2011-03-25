module project/statistics

function obtainPageViewStatisticsGraph(projects : List<Project>) : String {
	var stats : List<ProjectIntTuple>;
	for(p : Project in projects where p.name != "YellowGrass") {
		stats.add(
			ProjectIntTuple(
				p,
				select count(*)
				from RequestLogEntry
				where _requestedURL like ~("%"+p.name+"%")
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
	url.add(	"&chco=4D89F9,C6D9FD"	);
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

define page statistics() {
	var projects : List<Project> := 
		from Project;
	title{"YellowGrass.org - Statistics"}
	main()
	define body(){
		<h1> "Last Month's Page Views" </h1>
		<img src=obtainPageViewStatisticsGraph(projects)/>
	}
}