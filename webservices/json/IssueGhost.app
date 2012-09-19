module webservices/json/IssueGhost
extend entity IssueGhost {
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
      object.put("title", ( null as JSONObject ));
    }
    else
    {
      object.put("title", this.title);
    }
    if ( this.name == null )
    {
      object.put("description", ( null as JSONObject ));
    }
    else
    {
      object.put("description", this.description.format());
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
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.name == null )
    {
      object.put("tags", ( null as JSONObject ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( h_15401 : Tag in this.tags )
        {
          arraytags.put(makeJSONObjectFromEntityRef(h_15401));
        }
      object.put("tags", arraytags);
    }
    if ( this.name == null )
    {
      object.put("alive", ( null as JSONObject ));
    }
    else
    {
      object.put("alive", this.alive);
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
    if ( this.name == null )
    {
      object.put("name", ( null as JSONObject ));
    }
    else
    {
      object.put("name", this.name);
    }
    return object;
  }
  function toMinimalJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    return object;
  }
}