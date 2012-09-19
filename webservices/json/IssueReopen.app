module webservices/json/IssueReopen
extend entity IssueReopen {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.moment != null )
    {
      object.put("moment", moment.getTime() / 1000L);
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
    if ( this.actor == null )
    {
      object.put("actor", ( null as Object ));
    }
    else
    {
      object.put("actor", makeJSONObjectFromEntityRef(this.actor));
    }
    if ( this.moment == null )
    {
      object.put("moment", ( null as Object ));
    }
    else
    {
      object.put("moment", this.moment.getTime() / 1000L);
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