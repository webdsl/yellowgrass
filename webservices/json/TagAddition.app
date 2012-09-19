module webservices/json/TagAddition
extend entity TagAddition {
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
      object.put("actor", ( null as JSONObject ));
    }
    else
    {
      object.put("actor", makeJSONObjectFromEntityRef(this.actor));
    }
    if ( this.name == null )
    {
      object.put("tag", ( null as JSONObject ));
    }
    else
    {
      object.put("tag", makeJSONObjectFromEntityRef(this.tag));
    }
    if ( this.name == null )
    {
      object.put("moment", ( null as JSONObject ));
    }
    else
    {
      object.put("moment", this.moment.getTime() / 1000L);
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