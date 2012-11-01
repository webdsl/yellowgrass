module webservices/mappers/Comment
function mapperEditedComment ( ent : Comment , json : JSONObject ) : Void
{
  ent.text := json.getString("text");
  var temp := json.getJSONObject("author") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("User", temp.getString("id").parseUUID()) as User ) ;
    if ( localent != null )
    {
      ent.author := localent;
    }
  }
  else
  {
    ent.author := null;
  }
  ent.moment.setTime(json.getLong("moment") * 1000L);
}