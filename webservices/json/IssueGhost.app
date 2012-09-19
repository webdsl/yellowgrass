module webservices/json/IssueGhost
extend entity IssueGhost {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.title != null )
    {
      object.put("title", title);
    }
    if ( this.description != null )
    {
      object.put("description", description.format());
    }
    if ( this.email != null )
    {
      object.put("email", email);
    }
    if ( this.alive != null )
    {
      object.put("alive", alive);
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
    if ( this.title == null )
    {
      object.put("title", ( null as Object ));
    }
    else
    {
      object.put("title", this.title);
    }
    if ( this.description == null )
    {
      object.put("description", ( null as Object ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.project == null )
    {
      object.put("project", ( null as Object ));
    }
    else
    {
      object.put("project", makeJSONObjectFromEntityRef(this.project));
    }
    if ( this.email == null )
    {
      object.put("email", ( null as Object ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.tags == null )
    {
      object.put("tags", ( null as Object ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( y_34343 : Tag in this.tags )
      {
        arraytags.put(makeJSONObjectFromEntityRef(y_34343));
      }
      object.put("tags", arraytags);
    }
    if ( this.alive == null )
    {
      object.put("alive", ( null as Object ));
    }
    else
    {
      object.put("alive", this.alive);
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
    if ( this.name == null )
    {
      object.put("name", ( null as Object ));
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
    if ( this.version != null )
    {
      object.put("version", version);
    }
    if ( this.id != null )
    {
      object.put("id", id);
    }
    if ( this.name != null )
    {
      object.put("name", name);
    }
    return object;
  }
}