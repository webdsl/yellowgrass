module user/user-model 

entity User {
  name      :: String   (validate(name.length() >= 3, "Names need to be at least 3 characters"))
  email     :: Email    (validate(!userEmailTaken(), "Another user already registered using this email address"), validate(email != "", "Enter a valid email address"))
  notifications   :: Bool
  password    :: Secret   (validate(password.length() >= 8, "Password needs to be at least 8 characters"))
  projects    -> Set<Project> (inverse = Project.members)
  url       :: URL
  tag       :: String   (validate(
                    tag.length() >= 3 && 
                    /[a-z0-9]*/.match(tag), 
                    "User names consist of lowercase characters and numbers. Their minimum length is 3 characters."),
                   validate(!userTagTaken(), "Another user already registered this user name"))
  
  function userEmailTaken() : Bool {
    var users := findUserByEmail(email);
    return users.length > 1 || (users.length == 1 && users[0] != this); // Database view may be inconsistent, as queries in transaction are take into account
  }
  
  function userTagTaken() : Bool {
    var users := findUserByTag(tag);
    return users.length > 1;  // Database view may be inconsistent, as queries in transaction are take into account
  }
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