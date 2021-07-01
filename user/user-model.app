module user/user-model 

imports built-in
imports issue/issue-model
imports project/project-model

  entity User {
    name          :: String   (searchable, validate(name.length() >= 3, "Names need to be at least 3 characters"))
    email         :: Email    (validate(!userEmailTaken(), "Another user already registered using this email address"), validate(email != "", "Enter a valid email address"))
    notifications :: Bool
    password      :: Secret   (validate(password.length() >= 8, "Password needs to be at least 8 characters"))
    projects      -> Set<Project> (inverse = Project.members)
    url           :: URL
    tag           :: String   (searchable, validate(
                               tag.length() >= 3 && /[a-z0-9]*/.match(tag), 
                               "User names consist of lowercase characters and numbers. Their minimum length is 3 characters."),
                               validate(!userTagTaken(), "Another user already registered this user name"))
                               
    isAdmin       :: Bool (default=false)
    
    function isAdmin() : Bool {
      return isAdmin != null && isAdmin;
    }
  }
  
section queries

  extend entity User {
    
    function reportedIssues() : List<Issue> {
      var ids := select i.id
        from Issue as i
        where _reporter = ~this and _project._private=false //not( project.private)
        order by _submitted desc
        limit 15;
      if(ids.length > 0){
        return [i | i in (from Issue where id in ~ids) order by i.submitted desc ];
      } else {
        return List<Issue>();
      }
    }
     
    function projects() : List<Project> {
      return 
        select p  
        from Project as p 
        left join p.members as m 
        where _private=false and m = ~this
        limit 30;
    } 
    
    function recentIssues(): List<Issue> {
      //Use 2 separate queries to obtain the entities, because selecting the whole ent (including wikitext props)
      //in this group-by query causes a temp disk table to be created.
      var ids := select i.id from Issue as i
        left join i._project as p
        where (~this in elements(i._project._members)) or 
          ((i._reporter != null) and (i._reporter._name = ~this.name)) or
          (i._email = ~this.email)
        order by i._submitted desc
        limit 15;
        
      if(ids.length > 0){
        return from Issue where id in ~ids;
      } else {
        return List<Issue>();
      }
    }
    
    function recentProjects(): List<Project> {
      //Use 2 separate queries to obtain the entities, because selecting the whole ent (including wikitext props)
      //in this group-by query causes a temp disk table to be created.
      var ids := select p.id from Issue as i
	          left join i._project as p
	         where i._reporter=~this
	         group by p
	         order by max(i._submitted) desc
	         limit 25;
        
      if(ids.length > 0){
        return [p | p in (from Project where id in ~ids) order by p.modified];
      } else {
        return List<Project>();
      }
    } 
    
    function userEmailTaken() : Bool {
      var users := findUserByEmail(email);
      return users.length > 1 || (users.length == 1 && users[0] != this); // Database view may be inconsistent, as queries in transaction are take into account
    }
  
    function userTagTaken() : Bool {
      var users := findUserByTag(tag);
      return users.length > 1;  // Database view may be inconsistent, as queries in transaction are take into account
    }
  }
  
  function getUser(u : String) : User {
  var users : List<User> := 
    from User
    where _tag = ~u;
  if(users.length == 0) {
    return User {}; 
  } else {
    return users.get(0);
  }
}
  
section queries

  extend entity User {

  function toJSON() : JSONObject {
    var jsonobject := JSONObject();
    jsonobject.put("id", id);
    jsonobject.put("name", name);
    jsonobject.put("tag", tag);
    jsonobject.put("url", url);
    jsonobject.put("version", version);
    var jsonarray:= JSONArray();
    for (project : Project in projects) {
      if(project.toSimpleJSON() != null) {
        jsonarray.put(project.toJSONRef());
      }
    } 
    jsonobject.put("projects", jsonarray);
    return jsonobject;
  }
  function toSimpleJSON() : JSONObject{
    var jsonobject := JSONObject();
    jsonobject.put("id", id);
    jsonobject.put("name", name);
    jsonobject.put("version", version); 
    return jsonobject;
  }
}

