module webservices/json/Issue
extend entity Issue {
  function toSimpleJSON ( ) : JSONObject
  {
    var object := JSONObject() ;
    if ( this.number != null )
    {
      object.put("number", number);
    }
    if ( this.title != null )
    {
      object.put("title", title);
    }
    if ( this.description != null )
    {
      object.put("description", description.format());
    }
    if ( this.submitted != null )
    {
      object.put("submitted", submitted.getTime() / 1000L);
    }
    if ( this.open != null )
    {
      object.put("open", open);
    }
    if ( this.email != null )
    {
      object.put("email", email);
    }
    if ( this.nrVotes != null )
    {
      object.put("nrVotes", nrVotes);
    }
    if ( this.projectName != null )
    {
      object.put("projectName", projectName);
    }
    if ( this.reporterName != null )
    {
      object.put("reporterName", reporterName);
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
    if ( this.number == null )
    {
      object.put("number", ( null as JSONObject ));
    }
    else
    {
      object.put("number", this.number);
    }
    if ( this.title == null )
    {
      object.put("title", ( null as JSONObject ));
    }
    else
    {
      object.put("title", this.title);
    }
    if ( this.description == null )
    {
      object.put("description", ( null as JSONObject ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.submitted == null )
    {
      object.put("submitted", ( null as JSONObject ));
    }
    else
    {
      object.put("submitted", this.submitted.getTime() / 1000L);
    }
    if ( this.project == null )
    {
      object.put("project", ( null as JSONObject ));
    }
    else
    {
      object.put("project", makeJSONObjectFromEntityRef(this.project));
    }
    if ( this.reporter == null )
    {
      object.put("reporter", ( null as JSONObject ));
    }
    else
    {
      object.put("reporter", makeJSONObjectFromEntityRef(this.reporter));
    }
    if ( this.open == null )
    {
      object.put("open", ( null as JSONObject ));
    }
    else
    {
      object.put("open", this.open);
    }
    if ( this.log == null )
    {
      object.put("log", ( null as JSONObject ));
    }
    else
    {
      var arraylog := JSONArray() ;
      for ( q_34452 : Event in this.log )
        {
          arraylog.put(makeJSONObjectFromEntityRef(q_34452));
        }
      object.put("log", arraylog);
    }
    if ( this.tags == null )
    {
      object.put("tags", ( null as JSONObject ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( r_34452 : Tag in this.tags )
        {
          arraytags.put(makeJSONObjectFromEntityRef(r_34452));
        }
      object.put("tags", arraytags);
    }
    if ( this.email == null )
    {
      object.put("email", ( null as JSONObject ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.nrVotes == null )
    {
      object.put("nrVotes", ( null as JSONObject ));
    }
    else
    {
      object.put("nrVotes", this.nrVotes);
    }
    if ( this.attachments == null )
    {
      object.put("attachments", ( null as JSONObject ));
    }
    else
    {
      var arrayattachments := JSONArray() ;
      for ( s_34452 : Attachment in this.attachments )
        {
          arrayattachments.put(makeJSONObjectFromEntityRef(s_34452));
        }
      object.put("attachments", arrayattachments);
    }
    if ( this.projectName == null )
    {
      object.put("projectName", ( null as JSONObject ));
    }
    else
    {
      object.put("projectName", this.projectName);
    }
    if ( this.reporterName == null )
    {
      object.put("reporterName", ( null as JSONObject ));
    }
    else
    {
      object.put("reporterName", this.reporterName);
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
    if ( this.nrVotes != null )
    {
      object.put("nrVotes", nrVotes);
    }
    if ( this.projectName != null )
    {
      object.put("projectName", projectName);
    }
    if ( this.reporterName != null )
    {
      object.put("reporterName", reporterName);
    }
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