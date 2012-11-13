module webservices/mappers/IssueGhost
function mapperEditedIssueGhost ( ent : IssueGhost , json : JSONObject , localerrors : JSONArray ) : Void
{
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
  if ( ! json.has("alive") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property alive", "warning"));
  }
  else
  {
    if ( json.get("alive") == json.NULL )
    {
      ent.alive := null;
    }
    else
    {
      ent.alive := json.getBoolean("alive");
    }
  }
}