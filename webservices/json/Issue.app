module webservices/json/Issue
extend entity Issue {
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
      object.put("number", ( null as JSONObject ));
    }
    else
    {
      object.put("number", this.number);
    }
    if ( this.name == null )
    {
      object.put("title", ( null as JSONObject ));
    }
    else
    {
      object.put("title", this.title);
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
      object.put("submitted", ( null as JSONObject ));
    }
    else
    {
      object.put("submitted", this.submitted.getTime() / 1000L);
    }
    if ( this.name == null )
    {
      object.put("project", ( null as JSONObject ));
    }
    else
    {
      object.put("project", makeJSONObjectFromEntityRef(this.project));
    }
    if ( this.name == null )
    {
      object.put("reporter", ( null as JSONObject ));
    }
    else
    {
      object.put("reporter", makeJSONObjectFromEntityRef(this.reporter));
    }
    if ( this.name == null )
    {
      object.put("open", ( null as JSONObject ));
    }
    else
    {
      object.put("open", this.open);
    }
    if ( this.name == null )
    {
      object.put("log", ( null as JSONObject ));
    }
    else
    {
      var arraylog := JSONArray() ;
      for ( h_15401 : Event in this.log )
        {
          arraylog.put(makeJSONObjectFromEntityRef(h_15401));
        }
      object.put("log", arraylog);
    }
    if ( this.name == null )
    {
      object.put("tags", ( null as JSONObject ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( i_15401 : Tag in this.tags )
        {
          arraytags.put(makeJSONObjectFromEntityRef(i_15401));
        }
      object.put("tags", arraytags);
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
      object.put("nrVotes", ( null as JSONObject ));
    }
    else
    {
      object.put("nrVotes", this.nrVotes);
    }
    if ( this.name == null )
    {
      object.put("attachments", ( null as JSONObject ));
    }
    else
    {
      var arrayattachments := JSONArray() ;
      for ( j_15401 : Attachment in this.attachments )
        {
          arrayattachments.put(makeJSONObjectFromEntityRef(j_15401));
        }
      object.put("attachments", arrayattachments);
    }
    if ( this.name == null )
    {
      object.put("projectName", ( null as JSONObject ));
    }
    else
    {
      object.put("projectName", this.projectName);
    }
    if ( this.name == null )
    {
      object.put("reporterName", ( null as JSONObject ));
    }
    else
    {
      object.put("reporterName", this.reporterName);
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