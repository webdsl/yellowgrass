module webservices/mappers/Issue
function mapperEditedIssue ( ent : Issue , json : JSONObject ) : Void
{
  ent.number := json.getInt("number");
  ent.title := json.getString("title");
  ent.description := json.getString("description");
  ent.submitted.setTime(json.getLong("submitted") * 1000L);
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
  var temp := json.getJSONObject("reporter") ;
  if ( temp != null )
  {
    var localent := ( loadEntity("User", temp.getString("id").parseUUID()) as User ) ;
    if ( localent != null )
    {
      ent.reporter := localent;
    }
  }
  else
  {
    ent.reporter := null;
  }
  ent.open := json.getBoolean("open");
  var temp := json.getJSONArray("log") ;
  if ( temp != null )
  {
    var collection := Set<Event>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("Event", obj.getString("id").parseUUID()) as Event ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.log := collection;
  }
  else
  {
    ent.log := null;
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
  ent.email := json.getString("email");
  var temp := json.getJSONArray("attachments") ;
  if ( temp != null )
  {
    var collection := Set<Attachment>() ;
    for ( count : Int from 0 to temp.length() )
      {
        var obj := temp.getJSONObject(count) ;
        if ( obj != null )
        {
          var localent := ( loadEntity("Attachment", obj.getString("id").parseUUID()) as Attachment ) ;
          if ( localent != null )
          {
            collection.add(localent);
          }
        }
      }
    ent.attachments := collection;
  }
  else
  {
    ent.attachments := null;
  }
}