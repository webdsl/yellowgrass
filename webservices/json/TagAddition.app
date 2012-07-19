module webservices/json/TagAddition
extend entity TagAddition {
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
      object.put("actor", this.actor.id);
    }
    if ( this.tag == null )
    {
      object.put("tag", ( null as Object ));
    }
    else
    {
      object.put("tag", this.tag.id);
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