module webservices/mappers/Project
function mapperEditedProject ( ent : Project , json : JSONObject , localerrors : JSONArray ) : Void
{
  if ( ! json.has("test13") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test13", "warning"));
  }
  else
  {
    if ( json.get("test13") == json.NULL )
    {
      ent.test13 := null;
    }
    else
    {
      var temp := json.getJSONArray("test13") ;
      var collection := Set<Project>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("Project", obj.getString("id").parseUUID()) as Project ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: test13", "warning"));
            }
          }
        }
      ent.test13 := collection;
    }
  }
  if ( ! json.has("test12") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test12", "warning"));
  }
  else
  {
    if ( json.get("test12") == json.NULL )
    {
      ent.test12 := null;
    }
    else
    {
      var temp := json.getJSONObject("test12") ;
      var localent := ( loadEntity("Project", temp.getString("id").parseUUID()) as Project ) ;
      if ( localent != null )
      {
        ent.test12 := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: test12", "warning"));
      }
    }
  }
  if ( ! json.has("test11") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test11", "warning"));
  }
  else
  {
    if ( json.get("test11") == json.NULL )
    {
      ent.test11 := null;
    }
    else
    {
      if ( ent.test11 == null )
      {
        ent.test11 := now();
      }
      ent.test11.setTime(json.getLong("test11") * 1000L);
    }
  }
  if ( ! json.has("test10") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test10", "warning"));
  }
  else
  {
    if ( json.get("test10") == json.NULL )
    {
      ent.test10 := null;
    }
    else
    {
      if ( ent.test10 == null )
      {
        ent.test10 := now();
      }
      ent.test10.setTime(json.getLong("test10") * 1000L);
    }
  }
  if ( ! json.has("test9") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test9", "warning"));
  }
  else
  {
    if ( json.get("test9") == json.NULL )
    {
      ent.test9 := null;
    }
    else
    {
      if ( ent.test9 == null )
      {
        ent.test9 := now();
      }
      ent.test9.setTime(json.getLong("test9") * 1000L);
    }
  }
  if ( ! json.has("test8") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test8", "warning"));
  }
  else
  {
    if ( json.get("test8") == json.NULL )
    {
      ent.test8 := null;
    }
    else
    {
      ent.test8 := Double(json.getDouble("test8")).floatValue();
    }
  }
  if ( ! json.has("test7") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test7", "warning"));
  }
  else
  {
    if ( json.get("test7") == json.NULL )
    {
      ent.test7 := null;
    }
    else
    {
      ent.test7 := json.getLong("test7");
    }
  }
  if ( ! json.has("test6") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test6", "warning"));
  }
  else
  {
    if ( json.get("test6") == json.NULL )
    {
      ent.test6 := null;
    }
    else
    {
      ent.test6 := json.getInt("test6");
    }
  }
  if ( ! json.has("test4") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test4", "warning"));
  }
  else
  {
    if ( json.get("test4") == json.NULL )
    {
      ent.test4 := null;
    }
    else
    {
      ent.test4 := json.getString("test4");
    }
  }
  if ( ! json.has("test3") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test3", "warning"));
  }
  else
  {
    if ( json.get("test3") == json.NULL )
    {
      ent.test3 := null;
    }
    else
    {
      ent.test3 := json.getString("test3");
    }
  }
  if ( ! json.has("test2") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test2", "warning"));
  }
  else
  {
    if ( json.get("test2") == json.NULL )
    {
      ent.test2 := null;
    }
    else
    {
      ent.test2 := json.getString("test2");
    }
  }
  if ( ! json.has("test1") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property test1", "warning"));
  }
  else
  {
    if ( json.get("test1") == json.NULL )
    {
      ent.test1 := null;
    }
    else
    {
      ent.test1 := json.getString("test1");
    }
  }
  if ( ! json.has("name") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property name", "warning"));
  }
  else
  {
    if ( json.get("name") == json.NULL )
    {
      ent.name := null;
    }
    else
    {
      ent.name := json.getString("name");
    }
  }
  if ( ! json.has("description") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property description", "warning"));
  }
  else
  {
    if ( json.get("description") == json.NULL )
    {
      ent.description := null;
    }
    else
    {
      ent.description := json.getString("description");
    }
  }
  if ( ! json.has("url") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property url", "warning"));
  }
  else
  {
    if ( json.get("url") == json.NULL )
    {
      ent.url := null;
    }
    else
    {
      ent.url := json.getString("url");
    }
  }
  if ( ! json.has("issues") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property issues", "warning"));
  }
  else
  {
    if ( json.get("issues") == json.NULL )
    {
      ent.issues := null;
    }
    else
    {
      var temp := json.getJSONArray("issues") ;
      var collection := Set<Issue>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("Issue", obj.getString("id").parseUUID()) as Issue ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: issues", "warning"));
            }
          }
        }
      ent.issues := collection;
    }
  }
  if ( ! json.has("members") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property members", "warning"));
  }
  else
  {
    if ( json.get("members") == json.NULL )
    {
      ent.members := null;
    }
    else
    {
      var temp := json.getJSONArray("members") ;
      var collection := Set<User>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("User", obj.getString("id").parseUUID()) as User ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: members", "warning"));
            }
          }
        }
      ent.members := collection;
    }
  }
  if ( ! json.has("memberRequests") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property memberRequests", "warning"));
  }
  else
  {
    if ( json.get("memberRequests") == json.NULL )
    {
      ent.memberRequests := null;
    }
    else
    {
      var temp := json.getJSONArray("memberRequests") ;
      var collection := Set<User>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("User", obj.getString("id").parseUUID()) as User ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: memberRequests", "warning"));
            }
          }
        }
      ent.memberRequests := collection;
    }
  }
  if ( ! json.has("followers") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property followers", "warning"));
  }
  else
  {
    if ( json.get("followers") == json.NULL )
    {
      ent.followers := null;
    }
    else
    {
      var temp := json.getJSONArray("followers") ;
      var collection := Set<User>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("User", obj.getString("id").parseUUID()) as User ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: followers", "warning"));
            }
          }
        }
      ent.followers := collection;
    }
  }
  if ( ! json.has("private") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property private", "warning"));
  }
  else
  {
    if ( json.get("private") == json.NULL )
    {
      ent.private := null;
    }
    else
    {
      ent.private := json.getBoolean("private");
    }
  }
  if ( ! json.has("email") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property email", "warning"));
  }
  else
  {
    if ( json.get("email") == json.NULL )
    {
      ent.email := null;
    }
    else
    {
      ent.email := json.getString("email");
    }
  }
}