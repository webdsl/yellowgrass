module webservices/mappers/TagAddition
function mapperEditedTagAddition ( ent : TagAddition , json : JSONObject ) : Void
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
  var temp := json.getJSONObject("tag") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("Tag", temp.getString("id").parseUUID()) as Tag ) ;
    if ( localent != null )
    {
      ent.tag := localent;
    }
  }
  else
  {
    ent.tag := null;
  }
  ent.moment.setTime(json.getLong("moment") * 1000L);
}