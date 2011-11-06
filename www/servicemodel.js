mobl.provides('servicemodel');
mobl.provides('mobl');
mobl.provides('servicemodel');
servicemodel.projectsMapper = function(json) {
   var __this = this;
  return json;
};

servicemodel.projectMapper = function(json) {
   var __this = this;
  return json;
};


servicemodel.Project = persistence.define('servicemodel__Project', {
  'name': 'VARCHAR(255)',
  'description': 'VARCHAR(255)',
  'url': 'VARCHAR(255)',
  'weeklyStatsGraph': 'VARCHAR(255)'
});



servicemodel.User = persistence.define('servicemodel__User', {
  'name': 'VARCHAR(255)',
  'tag': 'VARCHAR(255)',
  'url': 'VARCHAR(255)'
});



servicemodel.Issue = persistence.define('servicemodel__Issue', {
  'number': 'INT',
  'title': 'VARCHAR(255)',
  'description': 'VARCHAR(255)',
  'submitted': 'DATE',
  'nrVotes': 'INT',
  'open': 'BOOL'
});



servicemodel.Comment = persistence.define('servicemodel__Comment', {
  'text': 'VARCHAR(255)'
});



servicemodel.Event = persistence.define('servicemodel__Event', {
  'submitted': 'DATE'
});


servicemodel.Comment.hasOne('author', servicemodel.User);
servicemodel.Issue.hasOne('reporter', servicemodel.User);
servicemodel.Issue.hasOne('project', servicemodel.Project);
