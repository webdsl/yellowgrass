module .webservices/json/Release
extend entity Release {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.name != null )
    {
      object.put("name", name);
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
    if ( this.issues == null )
    {
      object.put("issues", ( null as Object ));
    }
    else
    {
      var arrayissues := JSONArray() ;
      for ( Issue : Issue in this.issues )
      {
        arrayissues.put(Issue.id);
      }
      object.put("issues", arrayissues);
    }
    if ( this.project == null )
    {
      object.put("project", ( null as Object ));
    }
    else
    {
      object.put("project", this.project.id);
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