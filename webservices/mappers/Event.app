module webservices/mappers/Event
function mapperEditedEvent ( ent : Event , json : JSONObject , localerrors : JSONArray ) : Void
{
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