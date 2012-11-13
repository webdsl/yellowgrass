module webservices/mappers/TagAddition
function mapperEditedTagAddition ( ent : TagAddition , json : JSONObject , localerrors : JSONArray ) : Void
{
  if ( ! json.has("actor") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property actor", "warning"));
  }
  else
  {
    if ( json.get("actor") == json.NULL )
    {
      ent.actor := null;
    }
    else
    {
      var temp := json.getJSONObject("actor") ;
      var localent := ( loadEntity("User", temp.getString("id").parseUUID()) as User ) ;
      if ( localent != null )
      {
        ent.actor := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: actor", "warning"));
      }
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
      var temp := json.getJSONObject("tag") ;
      var localent := ( loadEntity("Tag", temp.getString("id").parseUUID()) as Tag ) ;
      if ( localent != null )
      {
        ent.tag := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: tag", "warning"));
      }
    }
  }
  if ( ! json.has("moment") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property moment", "warning"));
  }
  else
  {
    if ( json.get("moment") == json.NULL )
    {
      ent.moment := null;
    }
    else
    {
      if ( ent.moment == null )
      {
        ent.moment := now();
      }
      ent.moment.setTime(json.getLong("moment") * 1000L);
    }
  }
}