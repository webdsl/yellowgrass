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
      object.put("text", ( null as Object ));
    }
    else
    {
      object.put("text", this.text.format());
    }
    if ( this.author == null )
    {
      object.put("author", ( null as Object ));
    }
    else
    {
      object.put("author", this.author.id);
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
}