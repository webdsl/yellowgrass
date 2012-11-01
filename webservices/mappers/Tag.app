module webservices/mappers/Tag
function mapperEditedTag ( ent : Tag , json : JSONObject ) : Void
{
  ent.name := json.getString("name");
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
}