module webservices/json/Comment
extend entity Comment {
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
      object.put("text", ( null as JSONObject ));
    }
    else
    {
      object.put("text", this.text.format());
    }
    if ( this.name == null )
    {
      object.put("author", ( null as JSONObject ));
    }
    else
    {
      object.put("author", makeJSONObjectFromEntityRef(this.author));
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