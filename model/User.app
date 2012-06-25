module model/User
entity User {
  // deviceKeySet -> Set<AuthenticationKey>
  tag :: String ( validate(tag.length()>=3&&/[a-z0-9]*/.match(tag),"User names consist of lowercase characters and numbers. Their minimum length is 3 characters."), validate ( ! userTagTaken() , "Another user already registered this user name" ) )
  url :: URL
  projects -> Set<Project> ( inverse = Project . members )
  password :: Secret ( validate ( password.length() >= 8 , "Password needs to be at least 8 characters" ) )
  notifications :: Bool
  email :: Email ( validate(!userEmailTaken(),"Another user already registered using this email address"), validate ( email != "" , "Enter a valid email address" ) )
  name :: String ( validate ( name.length() >= 3 , "Names need to be at least 3 characters" ) )
  function getDeviceKey ( deviceDescription : String ) : UUID
  {
    // var filteredList := [ key | key : AuthenticationKey in deviceKeySet where deviceDescription == key.deviceDescription ] ;
    // if ( filteredList.length == 1 )
    // {
    //   return filteredList[0].id;
    // }
    // else
    {
      return null;
    }
  }
  function generateAuthenticationKey ( deviceDescription : String ) : UUID
  {
    var key := getDeviceKey(deviceDescription) ;
    if ( key == null )
    {
      // var newKey := AuthenticationKey{deviceDescription := deviceDescription} ;
      // newKey.save();
      // deviceKeySet.add(newKey);
      // key := newKey.id;
    }
    return key;
  }
  // function toSimpleJSON ( ) : JSONObject
  // {
  //   var jsonobject := JSONObject() ;
  //   jsonobject.put("id", id);
  //   jsonobject.put("name", name);
  //   jsonobject.put("version", version);
  //   return jsonobject;
  // }
  // function toJSON ( ) : JSONObject
  // {
  //   var jsonobject := JSONObject() ;
  //   jsonobject.put("id", id);
  //   jsonobject.put("name", name);
  //   jsonobject.put("tag", tag);
  //   jsonobject.put("url", url);
  //   jsonobject.put("version", version);
  //   var jsonarray := JSONArray() ;
  //   for ( project : Project in projects )
  //   {
  //     if ( project.toSimpleJSON() != null )
  //     {
  //       jsonarray.put(project.toJSONRef());
  //     }
  //   }
  //   jsonobject.put("projects", jsonarray);
  //   return jsonobject;
  // }
  function userTagTaken ( ) : Bool
  {
    var users := findUserByTag(tag) ;
    return users.length > 1;
  }
  function userEmailTaken ( ) : Bool
  {
    var users := findUserByEmail(email) ;
    return users.length > 1 || users.length == 1 && users [ 0 ] != this;
  }
}