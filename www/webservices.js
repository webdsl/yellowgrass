mobl.provides('webservices');
mobl.provides('mobl.ui');
mobl.provides('webservices');
mobl.provides('mobl');
mobl.provides('servicemodel');

webservices.Service = {
  getProjects: function(callback) {
    var url = "" + (this.root ? this.root : "") + "getProjects?";
    $.ajax({
       url: url,
       dataType: "json",
       type: "PUT",
       data: mobl.JSON.stringify(new mobl.Dynamic({})),
       error: function(_, message, error) {
         console.error(message);
         console.error(error);
         callback(null);
       },
       success: function(data) {
          var result = servicemodel.projectsMapper(data, callback);
          if(result !== undefined) {
            callback(result);
          }
       }
    });
  }
  ,
  getPopularProjects: function(number, callback) {
    var url = "" + (this.root ? this.root : "") + "getPopularProjects?";
    $.ajax({
       url: url,
       dataType: "json",
       type: "PUT",
       data: mobl.JSON.stringify(new mobl.Dynamic({'number': number})),
       error: function(_, message, error) {
         console.error(message);
         console.error(error);
         callback(null);
       },
       success: function(data) {
          var result = servicemodel.projectsMapper(data, callback);
          if(result !== undefined) {
            callback(result);
          }
       }
    });
  }
  ,
  getProject: function(name, callback) {
    var url = "" + (this.root ? this.root : "") + "getProject?";
    $.ajax({
       url: url,
       dataType: "json",
       type: "PUT",
       data: mobl.JSON.stringify(new mobl.Dynamic({'name': name})),
       error: function(_, message, error) {
         console.error(message);
         console.error(error);
         callback(null);
       },
       success: function(data) {
          var result = servicemodel.projectMapper(data, callback);
          if(result !== undefined) {
            callback(result);
          }
       }
    });
  }
  
};
servicemodel.Comment.hasOne('author', servicemodel.User);
servicemodel.Issue.hasOne('reporter', servicemodel.User);
servicemodel.Issue.hasOne('project', servicemodel.Project);
