module .webservices/json/TagRemoval
extend entity TagRemoval {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.test15 != null )
    {
      object.put("test15", test15.format(DateType.getDefaultDateFormat()));
    }
    if ( this.test14 != null )
    {
      object.put("test14", test14.format(DateType.getDefaultTimeFormat()));
    }
    if ( this.test13 != null )
    {
      object.put("test13", test13.format());
    }
    if ( this.test9 != null )
    {
      object.put("test9", test9);
    }
    if ( this.test7 != null )
    {
      object.put("test7", test7);
    }
    if ( this.test6 != null )
    {
      object.put("test6", test6);
    }
    if ( this.test5 != null )
    {
      object.put("test5", test5);
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
      object.put("test2", test2);
    }
    if ( this.test != null )
    {
      object.put("test", test);
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
    if ( this.test19 == null )
    {
      object.put("test19", ( null as Object ));
    }
    else
    {
      var arraytest19 := JSONArray() ;
      for ( Project : Project in this.test19 )
      {
        arraytest19.put(Project.id);
      }
      object.put("test19", arraytest19);
    }
    if ( this.test18 == null )
    {
      object.put("test18", ( null as Object ));
    }
    else
    {
      var arraytest18 := JSONArray() ;
      for ( Issue : Issue in this.test18 )
      {
        arraytest18.put(Issue.id);
      }
      object.put("test18", arraytest18);
    }
    if ( this.test17 == null )
    {
      object.put("test17", ( null as Object ));
    }
    else
    {
      object.put("test17", this.test17.id);
    }
    if ( this.test16 == null )
    {
      object.put("test16", ( null as Object ));
    }
    else
    {
      object.put("test16", this.test16.id);
    }
    if ( this.test15 == null )
    {
      object.put("test15", ( null as Object ));
    }
    else
    {
      object.put("test15", this.test15.format(DateType.getDefaultDateFormat()));
    }
    if ( this.test14 == null )
    {
      object.put("test14", ( null as Object ));
    }
    else
    {
      object.put("test14", this.test14.format(DateType.getDefaultTimeFormat()));
    }
    if ( this.test13 == null )
    {
      object.put("test13", ( null as Object ));
    }
    else
    {
      object.put("test13", this.test13.format());
    }
    if ( this.test9 == null )
    {
      object.put("test9", ( null as Object ));
    }
    else
    {
      object.put("test9", this.test9);
    }
    if ( this.test7 == null )
    {
      object.put("test7", ( null as Object ));
    }
    else
    {
      object.put("test7", this.test7);
    }
    if ( this.test6 == null )
    {
      object.put("test6", ( null as Object ));
    }
    else
    {
      object.put("test6", this.test6);
    }
    if ( this.test5 == null )
    {
      object.put("test5", ( null as Object ));
    }
    else
    {
      object.put("test5", this.test5);
    }
    if ( this.test4 == null )
    {
      object.put("test4", ( null as Object ));
    }
    else
    {
      object.put("test4", this.test4);
    }
    if ( this.test3 == null )
    {
      object.put("test3", ( null as Object ));
    }
    else
    {
      object.put("test3", this.test3);
    }
    if ( this.test2 == null )
    {
      object.put("test2", ( null as Object ));
    }
    else
    {
      object.put("test2", this.test2);
    }
    if ( this.test == null )
    {
      object.put("test", ( null as Object ));
    }
    else
    {
      object.put("test", this.test);
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