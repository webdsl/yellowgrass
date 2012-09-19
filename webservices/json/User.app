module webservices/json/User
extend entity User {
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
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.name == null )
    {
      object.put("notifications", ( null as JSONObject ));
    }
    else
    {
      object.put("notifications", this.notifications);
    }
    if ( this.name == null )
    {
      object.put("projects", ( null as JSONObject ));
    }
    else
    {
      var arrayprojects := JSONArray() ;
      for ( b_15401 : Project in this.projects )
        {
          arrayprojects.put(makeJSONObjectFromEntityRef(b_15401));
        }
      object.put("projects", arrayprojects);
    }
    if ( this.name == null )
    {
      object.put("url", ( null as JSONObject ));
    }
    else
    {
      object.put("url", this.url);
    }
    if ( this.name == null )
    {
      object.put("tag", ( null as JSONObject ));
    }
    else
    {
      object.put("tag", this.tag);
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