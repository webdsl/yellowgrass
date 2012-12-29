module issue/issue-model

section data model

  entity Issue {
    number      :: Int    (searchable)
    title       :: String (searchable, validate(title.length() >= 5, "Use a longer and more descriptive title"))
    description :: WikiText (searchable)
    submitted   :: DateTime
    project     -> Project  (searchable, inverse = Project.issues)
    reporter    -> User
    open        :: Bool
    log         -> Set<Event>
    tags        -> Set<Tag>(searchable)
    email       :: Email // Only when reporter == null
    nrVotes     :: Int := [ t | t : Tag in tags where /!.*/.match(t.name)].length
    attachments -> Set<Attachment>
    // comments -> Set<Comment>(searchable) := getComments()
  
    projectName  :: String (searchable) := project.name
    reporterName :: String (searchable) := 
      if (reporter != null && reporter.name != null)
        reporter.name
      else
        ""
    }
    
section operations

  extend entity Issue {    
    function vote() {
      var tag := tag("!" + securityContext.principal.tag, project);
      addTag(tag);       
    }
    function close() {
      open := false;
      log.add(
        IssueClose{ 
          moment := now()
          actor := securityContext.principal
        }
      );
      notifyClose();  
    }
    function reopen() { 
      open := true;
      log.add(
        IssueReopen{ 
          moment := now()
          actor := securityContext.principal
        }
      );
      notifyReopen();
    }
    function notifyRegister() {
      for(e : Email in mailinglist()){
        email(issueNotification(this, e));
      }
    }
  
    function notifyClose() {
      for(e : Email in mailinglist()){
        email(issueCloseNotification(this, e));
      }
    }
    function notifyReopen() {
      for(e : Email in mailinglist()){
        email(issueReopenNotification(this, e));
      }
    }
    
    function moveTo(p: Project): Issue {
      var new := Issue { // todo: define clone method on Issue
        title := this.title
        description := this.description
        submitted := now()
        project := p
        number := newIssueNumber(p)
        open := true
        reporter := this.reporter
        email := this.email
      };
      new.assign();
      new.save();
    
      this.log.add(
        IssueMoved {
          moment := now()
          actor := securityContext.principal
          target := new 
        }
      );
      this.close();
      flush();
      new.notifyRegister();
      return new;  
    }
  }
  
section queries

  extend entity Issue {
    
  
  function getReporterName() : String {
    if (reporter != null && reporter.name != null) {
      return reporter.name;
    } else {
      return "";
    }
  }
  function getComments():Set<Comment>{
    var set : Set<Comment>;
    log("getComments");
    for(e:Event in log where e is a Comment){
      set.add(e as Comment);
    }
    return set;
  }
  
  function getTitle() : String {
    if( title == null || title =="" || title == " ") { // TODO Improve this test by using a regexp
      return "<< no title >>";
    } else {
      return title;
    }
  }
  

  function addComment(c : Comment) {
    log.add(c);
    this.save();
    for(e : Email in mailinglist()){
      email(issueCommentNotification(this, e, c));
    }
  }
  function commentClose(c : Comment) {
    log.add(c);
    close();
    this.save();
    for(e : Email in mailinglist()){
      email(issueCommentCloseNotification(this, e, c));
    }
  }
  
  function isAssigned() : Bool {
    for(tag : Tag in tags) {
      if(/@.+/.match(tag.name)) {
        return true;
      }
    }
    return false;
  }
  
  function assign() {
    if (project.members.length == 1) {
      tags.add(tag("@"+project.members.list().get(0).tag, project));
    }
  }
  
  function toJSON() : JSONObject {
    
    var json := JSONObject();
    json.put("id", id);
    json.put("number", number);
    json.put("title", title);
    // json.put("description",description.format());
    json.put("submitted", submitted.getTime()/1000L);

    json.put("nrVotes", nrVotes);
    json.put("project", project.toSimpleJSON());
    if(reporter != null) { 
      json.put("reporter", reporter.toSimpleJSON()); 
    }
    json.put("open", open);
    // var jsonArray := JSONArray();
    // for(event: Event in log){
    //  if(event.toJSON()!=null){
    //    jsonArray.put(event.toJSON());
    //    }
    //  
    // } 
    // json.put("comments",jsonArray);
    // var jsonArrayTags := JSONArray();
    // for(tag: Tag in tags){
    //  jsonArrayTags.put(tag.toJSON());
    // }
    // json.put("tags",jsonArrayTags);
    return json;
  }
  function toSimpleJSON() : JSONObject {
    var json := JSONObject();
    json.put("id", id);
    json.put("version", version); 
    return json;
  }
  
  function toExtendedJSON() : JSONObject{
    var json := JSONObject();
    json.put("id", id);
    json.put("number", number);
    json.put("title", title);
    json.put("description", description.format());
    json.put("submitted", submitted.getTime()/1000L);
    json.put("nrVotes", nrVotes);
    json.put("project", project.toSimpleJSON());
    if(reporter != null) {
      json.put("reporter", reporter.toJSON());
    }
    json.put("open", open);
    var jsonArray := JSONArray();
    for(event : Event in log) {
      if(event.toJSON()!= null) {
        jsonArray.put(event.toJSON());
      }
    } 
    json.put("comments", jsonArray);
    var jsonArrayTags := JSONArray();
    for(tag : Tag in tags) {
      jsonArrayTags.put(tag.toJSON());
    }
    json.put("tags", jsonArrayTags);
    json.put("version", version);
    return json;
  }
  
}

function checkNewIssueObjects(json : JSONArray) {
    for(i : Int from 0 to json.length()) {
      var object := json.getJSONObject(i);
      if(object.has("new") && object.getBoolean("new")) {
        var project := loadEntity("Project", object.getJSONObject("project").getString("id").parseUUID()) as Project;
        var newObject :=  Issue {

          title := object.getString("title")
          
          description := object.getString("description")
          open := object.getBoolean("open")
          project := project
          reporter := loadUser(object.getJSONObject("reporter").getString("id").parseUUID())
          
          //special cases
          submitted := now()
          number := newIssueNumber(project)
        };
        var tags := object.getJSONArray("tags");
        for(i : Int from 0 to tags.length()) {
          newObject.tags.add(loadTag(tags.getJSONObject(i).getString("id").parseUUID()));
        }
        var newComments := checkNewCommentObjects(object.getJSONArray("comments"));
        for(comment : Comment in newComments) {
          newObject.log.add(comment);
        }
        newObject.save();
      }
    }
  }
  
function checkDirtyIssueObjects(json : JSONArray) {
    for(i : Int from 0 to json.length()) {
      var object := json.getJSONObject(i);
      if(!(object.has("new") && object.getBoolean("new")) && object.has("dirty") && object.getBoolean("dirty")) {
        var issue := loadIssue(object.getString("id").parseUUID());
        var newComments := checkNewCommentObjects(object.getJSONArray("comments"));
        for(comment : Comment in newComments) {
          issue.log.add(comment);
        }
        
      }
    }
    flush();
  }


function getIssue(p : Project, issueNumber : Int) : Issue {
  var issuesWithNumber : List<Issue> := 
    from Issue as i
    where i._project = ~p and i._number = ~issueNumber
    limit 1;
  
  if(issuesWithNumber.length != 0) {
    return issuesWithNumber.get(0);
  } else {
    return Issue {};
  }
}

function newIssueNumber(p: Project) : Int {
  var lastProjectIssues : List<Issue> := 
    from Issue
    where _project = ~p
    order by _number desc
    limit 1;
  if(lastProjectIssues.length == 0) {
    return 1;
  } else {
    return lastProjectIssues.get(0).number + 1;
  }
}

function recentIssues(): List<Issue> {
  return from Issue as i
      where i._project._private=false
      order by _submitted desc
      limit 27;
} 
