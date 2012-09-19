module webservices/json/Tag
extend entity Tag {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    return object;
  }
  function toJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.name == null )
    {
      object.put("name", ( null as JSONObject ));
    }
    else
    {
      object.put("name", this.name);
    }
    if ( this.name == null )
    {
      object.put("description", ( null as JSONObject ));
    }
    else
    {
      object.put("description", this.description);
    }
    if ( this.name == null )
    {
      object.put("project", ( null as JSONObject ));
    }
    else
    {
      object.put("project", makeJSONObjectFromEntityRef(this.project));
    }
    if ( this.name == null )
    {
      object.put("tags", ( null as JSONObject ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( c_15401 : Tag in this.tags )
        {
          arraytags.put(makeJSONObjectFromEntityRef(c_15401));
        }
      object.put("tags", arraytags);
    }
    if ( this.name == null )
    {
      object.put("version", ( null as JSONObject ));
    }
    else
    {
      object.put("version", this.version);
    }
    if ( this.name == null )
    {
      object.put("id", ( null as JSONObject ));
    }
    else
    {
      object.put("id", this.id);
    }
    return object;
  }
  function toMinimalJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    return object;
  }
}