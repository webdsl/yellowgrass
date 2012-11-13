module webservices/mappers/Issue
function mapperEditedIssue ( ent : Issue , json : JSONObject , localerrors : JSONArray ) : Void
{
  if ( ! json.has("number") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property number", "warning"));
  }
  else
  {
    if ( json.get("number") == json.NULL )
    {
      ent.number := null;
    }
    else
    {
      ent.number := json.getInt("number");
    }
  }
  if ( ! json.has("title") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property title", "warning"));
  }
  else
  {
    if ( json.get("title") == json.NULL )
    {
      ent.title := null;
    }
    else
    {
      ent.title := json.getString("title");
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
  if ( ! json.has("submitted") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property submitted", "warning"));
  }
  else
  {
    if ( json.get("submitted") == json.NULL )
    {
      ent.submitted := null;
    }
    else
    {
      if ( ent.submitted == null )
      {
        ent.submitted := now();
      }
      ent.submitted.setTime(json.getLong("submitted") * 1000L);
    }
  }
  if ( ! json.has("project") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property project", "warning"));
  }
  else
  {
    if ( json.get("project") == json.NULL )
    {
      ent.project := null;
    }
    else
    {
      var temp := json.getJSONObject("project") ;
      var localent := ( loadEntity("Project", temp.getString("id").parseUUID()) as Project ) ;
      if ( localent != null )
      {
        ent.project := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: project", "warning"));
      }
    }
  }
  if ( ! json.has("reporter") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property reporter", "warning"));
  }
  else
  {
    if ( json.get("reporter") == json.NULL )
    {
      ent.reporter := null;
    }
    else
    {
      var temp := json.getJSONObject("reporter") ;
      var localent := ( loadEntity("User", temp.getString("id").parseUUID()) as User ) ;
      if ( localent != null )
      {
        ent.reporter := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: reporter", "warning"));
      }
    }
  }
  if ( ! json.has("open") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property open", "warning"));
  }
  else
  {
    if ( json.get("open") == json.NULL )
    {
      ent.open := null;
    }
    else
    {
      ent.open := json.getBoolean("open");
    }
  }
  if ( ! json.has("log") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property log", "warning"));
  }
  else
  {
    if ( json.get("log") == json.NULL )
    {
      ent.log := null;
    }
    else
    {
      var temp := json.getJSONArray("log") ;
      var collection := Set<Event>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("Event", obj.getString("id").parseUUID()) as Event ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: log", "warning"));
            }
          }
        }
      ent.log := collection;
    }
  }
  if ( ! json.has("tags") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property tags", "warning"));
  }
  else
  {
    if ( json.get("tags") == json.NULL )
    {
      ent.tags := null;
    }
    else
    {
      var temp := json.getJSONArray("tags") ;
      var collection := Set<Tag>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("Tag", obj.getString("id").parseUUID()) as Tag ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: tags", "warning"));
            }
          }
        }
      ent.tags := collection;
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
  if ( ! json.has("attachments") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property attachments", "warning"));
  }
  else
  {
    if ( json.get("attachments") == json.NULL )
    {
      ent.attachments := null;
    }
    else
    {
      var temp := json.getJSONArray("attachments") ;
      var collection := Set<Attachment>() ;
      for ( count : Int from 0 to temp.length() )
        {
          log(count);
          if ( temp.get(count) != json.NULL )
          {
            var obj := temp.getJSONObject(count) ;
            var localent := ( loadEntity("Attachment", obj.getString("id").parseUUID()) as Attachment ) ;
            if ( localent != null )
            {
              collection.add(localent);
            }
            else
            {
              localerrors.put(makeJSONErrorObject("Trying to add non existing object for property: attachments", "warning"));
            }
          }
        }
      ent.attachments := collection;
    }
  }
}