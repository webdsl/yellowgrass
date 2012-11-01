module webservices/mappers/Event
function mapperEditedEvent ( ent : Event , json : JSONObject ) : Void
{
  ent.moment.setTime(json.getLong("moment") * 1000L);
}