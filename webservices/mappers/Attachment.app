module webservices/mappers/Attachment
function mapperEditedAttachment ( ent : Attachment , json : JSONObject ) : Void
{
  ent.date.setTime(json.getLong("date") * 1000L);
}