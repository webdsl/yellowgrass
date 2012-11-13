module webservices/mappers/User
function mapperEditedUser ( ent : User , json : JSONObject , localerrors : JSONArray ) : Void
{
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
  if ( ! json.has("notifications") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property notifications", "warning"));
  }
  else
  {
    if ( json.get("notifications") == json.NULL )
    {
      ent.notifications := null;
    }
    else
    {
      ent.notifications := json.getBoolean("notifications");
    }
  }
  if ( ! json.has("projects") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property projects", "warning"));
  }
  else
  {
    if ( json.get("projects") == json.NULL )
    {
      ent.projects := null;
    }
    else
    {
      var temp := json.getJSONArray("projects") ;
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
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: projects", "warning"));
            }
          }
        }
      ent.projects := collection;
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
  if ( ! json.has("tag") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property tag", "warning"));
  }
  else
  {
    if ( json.get("tag") == json.NULL )
    {
      ent.tag := null;
    }
    else
    {
      ent.tag := json.getString("tag");
    }
  }
}