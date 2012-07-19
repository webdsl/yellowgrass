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
      object.put("number", ( null as Object ));
    }
    else
    {
      object.put("number", this.number);
    }
    if ( this.title == null )
    {
      object.put("title", ( null as Object ));
    }
    else
    {
      object.put("title", this.title);
    }
    if ( this.description == null )
    {
      object.put("description", ( null as Object ));
    }
    else
    {
      object.put("description", this.description.format());
    }
    if ( this.submitted == null )
    {
      object.put("submitted", ( null as Object ));
    }
    else
    {
      object.put("submitted", this.submitted.getTime() / 1000L);
    }
    if ( this.project == null )
    {
      object.put("project", ( null as Object ));
    }
    else
    {
      object.put("project", this.project.id);
    }
    if ( this.reporter == null )
    {
      object.put("reporter", ( null as Object ));
    }
    else
    {
      object.put("reporter", this.reporter.id);
    }
    if ( this.open == null )
    {
      object.put("open", ( null as Object ));
    }
    else
    {
      object.put("open", this.open);
    }
    if ( this.log == null )
    {
      object.put("log", ( null as Object ));
    }
    else
    {
      var arraylog := JSONArray() ;
      for ( f_19776 : Event in this.log )
      {
        arraylog.put(f_19776.id);
      }
      object.put("log", arraylog);
    }
    if ( this.tags == null )
    {
      object.put("tags", ( null as Object ));
    }
    else
    {
      var arraytags := JSONArray() ;
      for ( g_19776 : Tag in this.tags )
      {
        arraytags.put(g_19776.id);
      }
      object.put("tags", arraytags);
    }
    if ( this.email == null )
    {
      object.put("email", ( null as Object ));
    }
    else
    {
      object.put("email", this.email);
    }
    if ( this.nrVotes == null )
    {
      object.put("nrVotes", ( null as Object ));
    }
    else
    {
      object.put("nrVotes", this.nrVotes);
    }
    if ( this.attachments == null )
    {
      object.put("attachments", ( null as Object ));
    }
    else
    {
      var arrayattachments := JSONArray() ;
      for ( h_19776 : Attachment in this.attachments )
      {
        arrayattachments.put(h_19776.id);
      }
      object.put("attachments", arrayattachments);
    }
    if ( this.projectName == null )
    {
      object.put("projectName", ( null as Object ));
    }
    else
    {
      object.put("projectName", this.projectName);
    }
    if ( this.reporterName == null )
    {
      object.put("reporterName", ( null as Object ));
    }
    else
    {
      object.put("reporterName", this.reporterName);
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