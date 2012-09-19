module webservices/json/Attachment
extend entity Attachment {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.date != null )
    {
      object.put("date", date.getTime() / 1000L);
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
    if ( this.date == null )
    {
      object.put("date", ( null as Object ));
    }
    else
    {
      object.put("date", this.date.getTime() / 1000L);
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