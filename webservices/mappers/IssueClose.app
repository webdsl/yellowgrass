module webservices/mappers/IssueClose
function mapperEditedIssueClose ( ent : IssueClose , json : JSONObject , localerrors : JSONArray ) : Void
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