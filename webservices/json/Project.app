module webservices/json/Project
extend entity Project {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.test11 != null )
    {
      object.put("test11", test11.getTime() / 1000L);
    }
    if ( this.test10 != null )
    {
      object.put("test10", test10.getTime() / 1000L);
    }
    if ( this.test9 != null )
    {
      object.put("test9", test9.getTime() / 1000L);
    }
    if ( this.test8 != null )
    {
      object.put("test8", test8);
    }
    if ( this.test7 != null )
    {
      object.put("test7", test7);
    }
    if ( this.test6 != null )
    {
      object.put("test6", test6);
    }
    if ( this.test4 != null )
    {
      object.put("test4", test4);
    }
    if ( this.test3 != null )
    {
      object.put("test3", test3);
    }
    if ( this.test2 != null )
    {
      object.put("test2", test2.format());
    }
    if ( this.test1 != null )
    {
      object.put("test1", test1);
    }
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
    if ( this.test13 == null )
    {
      object.put("test13", ( null as JSONObject ));
    }
    else
    {
      var arraytest13 := JSONArray() ;
      for ( k_34452 : Project in this.test13 )
        {
          arraytest13.put(makeJSONObjectFromEntityRef(k_34452));
        }
      object.put("test13", arraytest13);
    }
    if ( this.test12 == null )
    {
      object.put("test12", ( null as JSONObject ));
    }
    else
    {
      object.put("test12", makeJSONObjectFromEntityRef(this.test12));
    }
    if ( this.test11 == null )
    {
      object.put("test11", ( null as JSONObject ));
    }
    else
    {
      object.put("test11", this.test11.getTime() / 1000L);
    }
    if ( this.test10 == null )
    {
      object.put("test10", ( null as JSONObject ));
    }
    else
    {
      object.put("test10", this.test10.getTime() / 1000L);
    }
    if ( this.test9 == null )
    {
      object.put("test9", ( null as JSONObject ));
    }
    else
    {
      object.put("test9", this.test9.getTime() / 1000L);
    }
    if ( this.test8 == null )
    {
      object.put("test8", ( null as JSONObject ));
    }
    else
    {
      object.put("test8", this.test8);
    }
    if ( this.test7 == null )
    {
      object.put("test7", ( null as JSONObject ));
    }
    else
    {
      object.put("test7", this.test7);
    }
    if ( this.test6 == null )
    {
      object.put("test6", ( null as JSONObject ));
    }
    else
    {
      object.put("test6", this.test6);
    }
    if ( this.test4 == null )
    {
      object.put("test4", ( null as JSONObject ));
    }
    else
    {
      object.put("test4", this.test4);
    }
    if ( this.test3 == null )
    {
      object.put("test3", ( null as JSONObject ));
    }
    else
    {
      object.put("test3", this.test3);
    }
    if ( this.test2 == null )
    {
      object.put("test2", ( null as JSONObject ));
    }
    else
    {
      object.put("test2", this.test2.format());
    }
    if ( this.test1 == null )
    {
      object.put("test1", ( null as JSONObject ));
    }
    else
    {
      object.put("test1", this.test1);
    }
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
      for ( l_34452 : Issue in this.issues )
        {
          arrayissues.put(makeJSONObjectFromEntityRef(l_34452));
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
      for ( m_34452 : User in this.members )
        {
          arraymembers.put(makeJSONObjectFromEntityRef(m_34452));
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
      for ( n_34452 : User in this.memberRequests )
        {
          arraymemberRequests.put(makeJSONObjectFromEntityRef(n_34452));
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
      for ( o_34452 : User in this.followers )
        {
          arrayfollowers.put(makeJSONObjectFromEntityRef(o_34452));
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