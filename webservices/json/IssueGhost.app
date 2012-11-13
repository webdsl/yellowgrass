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
      object.put("title", ( null as JSONObject ));
    }
    else
    {
      object.put("title", this.title);
    }
    if ( this.description == null )
    {
      object.put("description", ( null as JSONObject ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.project == null )
    {
      object.put("project", ( null as JSONObject ));
    }
    else
    {
      object.put("project", makeJSONObjectFromEntityRef(this.project));
    }
    if ( this.email == null )
    {
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.tags == null )
    {
      object.put("tags", ( null as JSONObject ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( p_34452 : Tag in this.tags )
        {
          arraytags.put(makeJSONObjectFromEntityRef(p_34452));
        }
      object.put("tags", arraytags);
    }
    if ( this.alive == null )
    {
      object.put("alive", ( null as JSONObject ));
    }
    else
    {
      object.put("alive", this.alive);
    }
    if ( this.version == null )
    {
      object.put("version", ( null as JSONObject ));
    }
    else
    {
      object.put("version", this.version);
    }
    if ( this.id == null )
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
    if ( this.version != null )
    {
      object.put("version", version);
    }
    if ( this.id != null )
    {
      object.put("id", id);
    }
    return object;
  }
}