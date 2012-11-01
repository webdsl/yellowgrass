module webservices/mappers/IssueMoved
function mapperEditedIssueMoved ( ent : IssueMoved , json : JSONObject ) : Void
{
  var temp := json.getJSONObject("actor") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("User", temp.getString("id").parseUUID()) as User ) ;
    if ( localent != null )
    {
      ent.actor := localent;
    }
  }
  else
  {
    ent.actor := null;
  }
  var temp := json.getJSONObject("target") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("Issue", temp.getString("id").parseUUID()) as Issue ) ;
    if ( localent != null )
    {
      ent.target := localent;
    }
  }
  else
  {
    ent.target := null;
  }
  ent.moment.setTime(json.getLong("moment") * 1000L);
}