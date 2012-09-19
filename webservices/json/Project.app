module webservices/json/Project
extend entity Project {
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
      object.put("name", ( null as JSONObject ));
    }
    else
    {
      object.put("name", this.name);
    }
    if ( this.name == null )
    {
      object.put("description", ( null as JSONObject ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.name == null )
    {
      object.put("url", ( null as JSONObject ));
    }
    else
    {
      object.put("url", this.url);
    }
    if ( this.name == null )
    {
      object.put("issues", ( null as JSONObject ));
    }
    else
    {
      var arrayissues := JSONArray() ;
      for ( d_15401 : Issue in this.issues )
        {
          arrayissues.put(makeJSONObjectFromEntityRef(d_15401));
        }
      object.put("issues", arrayissues);
    }
    if ( this.name == null )
    {
      object.put("members", ( null as JSONObject ));
    }
    else
    {
      var arraymembers := JSONArray() ;
      for ( e_15401 : User in this.members )
        {
          arraymembers.put(makeJSONObjectFromEntityRef(e_15401));
        }
      object.put("members", arraymembers);
    }
    if ( this.name == null )
    {
      object.put("memberRequests", ( null as JSONObject ));
    }
    else
    {
      var arraymemberRequests := JSONArray() ;
      for ( f_15401 : User in this.memberRequests )
        {
          arraymemberRequests.put(makeJSONObjectFromEntityRef(f_15401));
        }
      object.put("memberRequests", arraymemberRequests);
    }
    if ( this.name == null )
    {
      object.put("followers", ( null as JSONObject ));
    }
    else
    {
      var arrayfollowers := JSONArray() ;
      for ( g_15401 : User in this.followers )
        {
          arrayfollowers.put(makeJSONObjectFromEntityRef(g_15401));
        }
      object.put("followers", arrayfollowers);
    }
    if ( this.name == null )
    {
      object.put("private", ( null as JSONObject ));
    }
    else
    {
      object.put("private", this.private);
    }
    if ( this.name == null )
    {
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
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
    return object;
  }
  function toMinimalJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    return object;
  }
}