module webservices/json/Comment
extend entity Comment {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.text != null )
    {
      object.put("text", text.format());
    }
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
    if ( this.text == null )
    {
      object.put("text", ( null as JSONObject ));
    }
    else
    {
      object.put("text", this.text.format());
    }
    if ( this.author == null )
    {
      object.put("author", ( null as JSONObject ));
    }
    else
    {
      object.put("author", makeJSONObjectFromEntityRef(this.author));
    }
    if ( this.moment == null )
    {
      object.put("moment", ( null as JSONObject ));
    }
    else
    {
      object.put("moment", this.moment.getTime() / 1000L);
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
  function toJSONFromSuperEvent ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.moment == null )
    {
      object.put("moment", ( null as JSONObject ));
    }
    else
    {
      object.put("moment", this.moment.getTime() / 1000L);
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
}