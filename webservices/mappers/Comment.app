module webservices/mappers/Comment
function mapperEditedComment ( ent : Comment , json : JSONObject , localerrors : JSONArray ) : Void
{
  if ( ! json.has("text") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property text", "warning"));
  }
  else
  {
    if ( json.get("text") == json.NULL )
    {
      ent.text := null;
    }
    else
    {
      ent.text := json.getString("text");
    }
  }
  if ( ! json.has("author") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property author", "warning"));
  }
  else
  {
    if ( json.get("author") == json.NULL )
    {
      ent.author := null;
    }
    else
    {
      var temp := json.getJSONObject("author") ;
      var localent := ( loadEntity("User", temp.getString("id").parseUUID()) as User ) ;
      if ( localent != null )
      {
        ent.author := localent;
      }
      else
      {
        localerrors.put(makeJSONErrorObject("Trying to set non existing object for property: author", "warning"));
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