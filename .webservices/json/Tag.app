module .webservices/json/Tag
extend entity Tag {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.name != null )
    {
      object.put("name", name);
    }
    if ( this.description != null )
    {
      object.put("description", description);
    }
    if ( this.id != null )
    {
      object.put("id", id);
    }
    return object;
  }
  function toJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.name == null )
    {
      object.put("name", ( null as Object ));
    }
    else
    {
      object.put("name", this.name);
    }
    if ( this.description == null )
    {
      object.put("description", ( null as Object ));
    }
    else
    {
      object.put("description", this.description);
    }
    if ( this.project == null )
    {
      object.put("project", ( null as Object ));
    }
    else
    {
      object.put("project", this.project.id);
    }
    if ( this.tags == null )
    {
      object.put("tags", ( null as Object ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( Tag : Tag in this.tags )
      {
        arraytags.put(Tag.id);
      }
      object.put("tags", arraytags);
    }
    if ( this.version == null )
    {
      object.put("version", ( null as Object ));
    }
    else
    {
      object.put("version", this.version);
    }
    if ( this.id == null )
    {
      object.put("id", ( null as Object ));
    }
    else
    {
      object.put("id", this.id);
    }
    return object;
  }
}