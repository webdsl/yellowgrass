module webservices/mappers/IssueGhost
function mapperEditedIssueGhost ( ent : IssueGhost , json : JSONObject ) : Void
{
  ent.title := json.getString("title");
  ent.description := json.getString("description");
  var temp := json.getJSONObject("project") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("Project", temp.getString("id").parseUUID()) as Project ) ;
    if ( localent != null )
    {
      ent.project := localent;
    }
  }
  else
  {
    ent.project := null;
  }
  ent.email := json.getString("email");
  var temp := json.getJSONArray("tags") ;
  if ( temp != null )
  {
    var collection := Set<Tag>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("Tag", obj.getString("id").parseUUID()) as Tag ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.tags := collection;
  }
  else
  {
    ent.tags := null;
  }
  ent.alive := json.getBoolean("alive");
}