module webservices/json/User
extend entity User {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.name != null )
    {
      object.put("name", name);
    }
    if ( this.email != null )
    {
      object.put("email", email);
    }
    if ( this.notifications != null )
    {
      object.put("notifications", notifications);
    }
    if ( this.url != null )
    {
      object.put("url", url);
    }
    if ( this.tag != null )
    {
      object.put("tag", tag);
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
      object.put("name", ( null as JSONObject ));
    }
    else
    {
      object.put("name", this.name);
    }
    if ( this.email == null )
    {
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.notifications == null )
    {
      object.put("notifications", ( null as JSONObject ));
    }
    else
    {
      object.put("notifications", this.notifications);
    }
    if ( this.projects == null )
    {
      object.put("projects", ( null as JSONObject ));
    }
    else
    {
      var arrayprojects := JSONArray() ;
      for ( i_34452 : Project in this.projects )
        {
          arrayprojects.put(makeJSONObjectFromEntityRef(i_34452));
        }
      object.put("projects", arrayprojects);
    }
    if ( this.url == null )
    {
      object.put("url", ( null as JSONObject ));
    }
    else
    {
      object.put("url", this.url);
    }
    if ( this.tag == null )
    {
      object.put("tag", ( null as JSONObject ));
    }
    else
    {
      object.put("tag", this.tag);
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