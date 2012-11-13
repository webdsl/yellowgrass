module webservices/mappers/IssueMoved
function mapperEditedIssueMoved ( ent : IssueMoved , json : JSONObject , localerrors : JSONArray ) : Void
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
  if ( ! json.has("target") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property target", "warning"));
  }
  else
  {
    if ( json.get("target") == json.NULL )
    {
      ent.target := null;
    }
    else
    {
      var temp := json.getJSONObject("target") ;
      var localent := ( loadEntity("Issue", temp.getString("id").parseUUID()) as Issue ) ;
      if ( localent != null )
      {
        ent.target := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: target", "warning"));
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