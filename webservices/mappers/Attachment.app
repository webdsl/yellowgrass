module webservices/mappers/Attachment
function mapperEditedAttachment ( ent : Attachment , json : JSONObject , localerrors : JSONArray ) : Void
{
  if ( ! json.has("date") )
  {
    localerrors.put(makeJSONErrorObject("Entity is missing property date", "warning"));
  }
  else
  {
    if ( json.get("date") == json.NULL )
    {
      ent.date := null;
    }
    else
    {
      if ( ent.date == null )
      {
        ent.date := now();
      }
      ent.date.setTime(json.getLong("date") * 1000L);
    }
  }
}