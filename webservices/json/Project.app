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
    if ( this.created != null )
    {
      object.put("created", created.getTime() / 1000L);
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
      object.put("name", ( null as Object ));
    }
    else
    {
      object.put("name", this.name);
    }
    if ( this.description == null )
    {
      object.put("description", ( null as Object ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.url == null )
    {
      object.put("url", ( null as Object ));
    }
    else
    {
      object.put("url", this.url);
    }
    if ( this.issues == null )
    {
      object.put("issues", ( null as Object ));
    }
    else
    {
      var arrayissues := JSONArray() ;
      for ( z_94145 : Issue in this.issues )
      {
        arrayissues.put(makeJSONObjectFromEntityRef(z_94145));
      }
      object.put("issues", arrayissues);
    }
    if ( this.members == null )
    {
      object.put("members", ( null as Object ));
    }
    else
    {
      var arraymembers := JSONArray() ;
      for ( a_94146 : User in this.members )
      {
        arraymembers.put(makeJSONObjectFromEntityRef(a_94146));
      }
      object.put("members", arraymembers);
    }
    if ( this.memberRequests == null )
    {
      object.put("memberRequests", ( null as Object ));
    }
    else
    {
      var arraymemberRequests := JSONArray() ;
      for ( b_94146 : User in this.memberRequests )
      {
        arraymemberRequests.put(makeJSONObjectFromEntityRef(b_94146));
      }
      object.put("memberRequests", arraymemberRequests);
    }
    if ( this.followers == null )
    {
      object.put("followers", ( null as Object ));
    }
    else
    {
      var arrayfollowers := JSONArray() ;
      for ( c_94146 : User in this.followers )
      {
        arrayfollowers.put(makeJSONObjectFromEntityRef(c_94146));
      }
      object.put("followers", arrayfollowers);
    }
    if ( this.created == null )
    {
      object.put("created", ( null as Object ));
    }
    else
    {
      object.put("created", this.created.getTime() / 1000L);
    }
    if ( this.private == null )
    {
      object.put("private", ( null as Object ));
    }
    else
    {
      object.put("private", this.private);
    }
    if ( this.email == null )
    {
      object.put("email", ( null as Object ));
    }
    else
    {
      object.put("email", this.email);
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