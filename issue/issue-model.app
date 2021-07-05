module issue/issue-model

imports built-in
imports comment/-
imports issue/-
imports project/project-model
imports tag/tag-model
imports user/user-model

imports elib/elib-utils/datetime

section data model

  entity Issue {
    number      :: Int
    title       :: String (validate(title.length() >= 5, "Use a longer and more descriptive title"))
    description :: WikiText
    // preview     :: WikiText  
    submitted   :: DateTime
    project     -> Project  (inverse = Project.issues)
    reporter    -> User
    open        :: Bool
    log         -> Set<Event>
    email       :: Email // Only when reporter == null
    nrVotes     :: Int := [ t | t : Tag in tags where /!.*/.match(t.name)].length
    attachments -> Set<Attachment>
    comments    -> Set<Comment> := getComments()
     
    reporterName :: String := 
      if (reporter != null && reporter.name != null)
        reporter.name
      else
        ""
                
    search mapping {
      + number
      + title
      + description
        project
      + tags
      + reporterName
      + comments
        due
    }

  }
  
section due date

  extend entity Issue {
    hasDueDate  :: Bool (default=false)
    due         :: Date (default=null)
    
    function timeLeft(): Long {
      return if(hasDueDate!=null && hasDueDate && due != null) diffDays(due, now()) else 1000L;
    } 
    
    function dueWarning(): String {
      var left := timeLeft();
      if(!open) { return ""; } else {       
        if(left < 0L) { return "btn-danger"; }
        if(left <= 2L) { return "btn-warning"; }
        if(left <= 14L) { return "btn-primary"; }
        if(left >= 1000L) { return ""; }
        return "btn-info";
      } 
    }
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
      if(project.notifications){
        for(e : Email in mailinglist()){
          email(issueNotification(this, e));
        }
      }
    }  
    function notifyClose() {
      if(project.notifications){
        for(e : Email in mailinglist()){
          email(issueCloseNotification(this, e));
        }
      }
    }
    function notifyReopen() {
      if(project.notifications){
        for(e : Email in mailinglist()){
          email(issueReopenNotification(this, e));
        }
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
  function getComments(): Set<Comment>{
    var set : Set<Comment>;
    //log("getComments");
    for(e: Event in log where e is a Comment){
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
    IndexManager.reindex(this); //comments are a derived property, which are not checked for changes
    if(project.notifications){
      for(e : Email in mailinglist()){
        email(issueCommentNotification(this, e, c));
      }
    }
  }
  function commentClose(c : Comment) {
    log.add(c);
    close();
    this.save();
    IndexManager.reindex(this); //comments are a derived property, which are not checked for changes
    if(project.notifications){
      for(e : Email in mailinglist()){
        email(issueCommentCloseNotification(this, e, c));
      }
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
    // json.put("description",description.format(""));
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
    json.put("description", description.format(""));
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
        for(j : Int from 0 to tags.length()) {
          newObject.tags.add(loadTag(tags.getJSONObject(j).getString("id").parseUUID()));
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
    where i.project = ~p and i.number = ~issueNumber
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
    //Use 2 separate queries to obtain the issues, because selecting the whole issue (including wikitext props)
    //in this order-by query causes a temp disk table to be created.
    var ids := select i.id from Issue as i
          where i.project.private = false
       order by _submitted desc
          limit 27;
    if(ids.length > 0){
      return [i | i in (from Issue where id in ~(ids)) order by i.submitted desc];
    } else {
      return List<Issue>();
    }
  } 

section completed

  function completed(issues: List<Issue>): List<Int> {
    var done: Int := 0;
    var total: Int := 0; 
    for(i: Issue in issues) { 
      if(!i.open) { done := done + 1; }
      total := total + 1;
    } 
    var completed := if(total > 0) ((done * 100) / total) else 0;
    return  [done, total, completed];  
  }

    