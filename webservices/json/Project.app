module webservices/json/Project
extend entity Project {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.name != null )
    {
      object.put("name", name);
    }
    if ( this.description != null )
    {
      object.put("description", description.format());
    }
    if ( this.url != null )
    {
      object.put("url", url);
    }
    if ( this.private != null )
    {
      object.put("private", private);
    }
    if ( this.email != null )
    {
      object.put("email", email);
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
    if ( this.description == null )
    {
      object.put("description", ( null as JSONObject ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.url == null )
    {
      object.put("url", ( null as JSONObject ));
    }
    else
    {
      object.put("url", this.url);
    }
    if ( this.issues == null )
    {
      object.put("issues", ( null as JSONObject ));
    }
    else
    {
      var arrayissues := JSONArray() ;
      for ( v_1129 : Issue in this.issues )
        {
          arrayissues.put(makeJSONObjectFromEntityRef(v_1129));
        }
      object.put("issues", arrayissues);
    }
    if ( this.members == null )
    {
      object.put("members", ( null as JSONObject ));
    }
    else
    {
      var arraymembers := JSONArray() ;
      for ( w_1129 : User in this.members )
        {
          arraymembers.put(makeJSONObjectFromEntityRef(w_1129));
        }
      object.put("members", arraymembers);
    }
    if ( this.memberRequests == null )
    {
      object.put("memberRequests", ( null as JSONObject ));
    }
    else
    {
      var arraymemberRequests := JSONArray() ;
      for ( x_1129 : User in this.memberRequests )
        {
          arraymemberRequests.put(makeJSONObjectFromEntityRef(x_1129));
        }
      object.put("memberRequests", arraymemberRequests);
    }
    if ( this.followers == null )
    {
      object.put("followers", ( null as JSONObject ));
    }
    else
    {
      var arrayfollowers := JSONArray() ;
      for ( y_1129 : User in this.followers )
        {
          arrayfollowers.put(makeJSONObjectFromEntityRef(y_1129));
        }
      object.put("followers", arrayfollowers);
    }
    if ( this.private == null )
    {
      object.put("private", ( null as JSONObject ));
    }
    else
    {
      object.put("private", this.private);
    }
    if ( this.email == null )
    {
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
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