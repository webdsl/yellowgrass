module webservices/mappers/User
function mapperEditedUser ( ent : User , json : JSONObject ) : Void
{
  ent.name := json.getString("name");
  ent.email := json.getString("email");
  ent.notifications := json.getBoolean("notifications");
  var temp := json.getJSONArray("projects") ;
  if ( temp != null )
  {
    var collection := Set<Project>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("Project", obj.getString("id").parseUUID()) as Project ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.projects := collection;
  }
  else
  {
    ent.projects := null;
  }
  ent.url := json.getString("url");
  ent.tag := json.getString("tag");
}