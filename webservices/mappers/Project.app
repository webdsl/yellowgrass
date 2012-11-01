module webservices/mappers/Project
function mapperEditedProject ( ent : Project , json : JSONObject ) : Void
{
  var temp := json.getJSONArray("test13") ;
  if ( temp != null )
  {
    var collection := Set<Project>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("Project", obj.getString("id").parseUUID()) as Project ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.test13 := collection;
  }
  else
  {
    ent.test13 := null;
  }
  var temp := json.getJSONObject("test12") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("Project", temp.getString("id").parseUUID()) as Project ) ;
    if ( localent != null )
    {
      ent.test12 := localent;
    }
  }
  else
  {
    ent.test12 := null;
  }
  ent.test11.setTime(json.getLong("test11") * 1000L);
  ent.test10.setTime(json.getLong("test10") * 1000L);
  ent.test9.setTime(json.getLong("test9") * 1000L);
  ent.test8 := Double(json.getDouble("test8")).floatValue();
  ent.test7 := json.getLong("test7");
  ent.test6 := json.getInt("test6");
  ent.test4 := json.getString("test4");
  ent.test3 := json.getString("test3");
  ent.test2 := json.getString("test2");
  ent.test1 := json.getString("test1");
  ent.name := json.getString("name");
  ent.description := json.getString("description");
  ent.url := json.getString("url");
  var temp := json.getJSONArray("issues") ;
  if ( temp != null )
  {
    var collection := Set<Issue>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("Issue", obj.getString("id").parseUUID()) as Issue ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.issues := collection;
  }
  else
  {
    ent.issues := null;
  }
  var temp := json.getJSONArray("members") ;
  if ( temp != null )
  {
    var collection := Set<User>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("User", obj.getString("id").parseUUID()) as User ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.members := collection;
  }
  else
  {
    ent.members := null;
  }
  var temp := json.getJSONArray("memberRequests") ;
  if ( temp != null )
  {
    var collection := Set<User>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("User", obj.getString("id").parseUUID()) as User ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.memberRequests := collection;
  }
  else
  {
    ent.memberRequests := null;
  }
  var temp := json.getJSONArray("followers") ;
  if ( temp != null )
  {
    var collection := Set<User>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("User", obj.getString("id").parseUUID()) as User ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.followers := collection;
  }
  else
  {
    ent.followers := null;
  }
  ent.private := json.getBoolean("private");
  ent.email := json.getString("email");
}