module model/Issue
entity Issue {
  reporterName :: String ( searchable ) := if ( reporter != null && reporter.name != null ) reporter.name else ""
  projectName :: String ( searchable ) := project.name
  attachments -> Set<Attachment>
  nrVotes :: Int := [ t | t : Tag in tags where /!.*/.match(t.name) ].length
  email :: Email
  tags -> Set<Tag> ( searchable )
  log -> Set<Event>
  open :: Bool
  reporter -> User
  project -> Project ( searchable, inverse = Project . issues )
  submitted :: DateTime
  description :: WikiText ( searchable )
  title :: String ( searchable, validate ( title.length() >= 5 , "Use a longer and more descriptive title" ) )
  number :: Int ( searchable )
  function hasTag ( tagName : String ) : Bool
  {
    for ( t : Tag in tags )
    {
      if ( t.name == tagName )
      {
        return true;
      }
    }
    return false;
  }
  function deleteTag ( t : Tag ) : Void
  {
    tags.remove(t);
    log.add(TagRemoval{moment := now()
                       actor := securityContext.principal
                       tag := t});
  }
  function addTag ( t : Tag ) : Void
  {
    tags.add(t);
    log.add(TagAddition{moment := now()
                        actor := securityContext.principal
                        tag := t});
  }
  function mailSubject ( ) : String
  {
    return project.name + " - Issue " + number;
  }
  function mailinglist ( ) : Set<Email>
  {
    var mailinglist := Set<Email>() ;
    if ( project.email != null && project.email != "" )
    {
      mailinglist.add(project.email);
    }
    else
    {
      for ( u : User in this.project.members )
      {
        if ( u.notifications )
        {
          mailinglist.add(u.email);
        }
      }
    }
    if ( reporter != null && reporter.notifications )
    {
      mailinglist.add(reporter.email);
    }
    if ( reporter == null && email != "" )
    {
      mailinglist.add(email);
    }
    var commenters := [ ( e as Comment ).author | e : Event in log where e is a Comment ] ;
    var commenterEmails := [ u.email | u : User in commenters where u.notifications ] ;
    mailinglist.addAll(commenterEmails);
    var issueFollowers : Set<User> := getFollowers(tags) ;
    mailinglist.addAll([ u.email | u : User in issueFollowers where u.notifications ]);
    var projectFollowers : Set<User> := project.followers ;
    mailinglist.addAll([ u.email | u : User in projectFollowers where u.notifications ]);
    if ( securityContext.principal != null )
    {
      mailinglist.remove(securityContext.principal.email);
    }
    return mailinglist;
  }
  function toExtendedJSON ( ) : JSONObject
  {
    var json := JSONObject() ;
    json.put("id", id);
    json.put("number", number);
    json.put("title", title);
    json.put("description", description.format());
    json.put("submitted", submitted.getTime() / 1000L);
    json.put("nrVotes", nrVotes);
    json.put("project", project.toSimpleJSON());
    if ( reporter != null )
    {
      json.put("reporter", reporter.toJSON());
    }
    json.put("open", open);
    var jsonArray := JSONArray() ;
    for ( event : Event in log )
    {
      if ( event.toJSON() != null )
      {
        jsonArray.put(event.toJSON());
      }
    }
    json.put("comments", jsonArray);
    var jsonArrayTags := JSONArray() ;
    for ( tag : Tag in tags )
    {
      jsonArrayTags.put(tag.toJSON());
    }
    json.put("tags", jsonArrayTags);
    json.put("version", version);
    return json;
  }
  function toSimpleJSON ( ) : JSONObject
  {
    var json := JSONObject() ;
    json.put("id", id);
    json.put("version", version);
    return json;
  }
  function toJSON ( ) : JSONObject
  {
    var json := JSONObject() ;
    json.put("id", id);
    json.put("number", number);
    json.put("title", title);
    json.put("submitted", submitted.getTime() / 1000L);
    json.put("nrVotes", nrVotes);
    json.put("project", project.toSimpleJSON());
    if ( reporter != null )
    {
      json.put("reporter", reporter.toSimpleJSON());
    }
    json.put("open", open);
    return json;
  }
  function assign ( ) : Void
  {
    if ( project.members.length == 1 )
    {
      tags.add(tag("@"+project.members.list().get(0).tag, project));
    }
  }
  function isAssigned ( ) : Bool
  {
    for ( tag : Tag in tags )
    {
      if ( /@.+/.match(tag.name) )
      {
        return true;
      }
    }
    return false;
  }
  function commentClose ( c : Comment ) : Void
  {
    log.add(c);
    close();
    this.save();
    for ( e : Email in mailinglist() )
    {
      email ( issueCommentCloseNotification ( this, e, c ) );
    }
  }
  function addComment ( c : Comment ) : Void
  {
    log.add(c);
    this.save();
    for ( e : Email in mailinglist() )
    {
      email ( issueCommentNotification ( this, e, c ) );
    }
  }
  function notifyReopen ( ) : Void
  {
    for ( e : Email in mailinglist() )
    {
      email ( issueReopenNotification ( this, e ) );
    }
  }
  function notifyClose ( ) : Void
  {
    for ( e : Email in mailinglist() )
    {
      email ( issueCloseNotification ( this, e ) );
    }
  }
  function notifyRegister ( ) : Void
  {
    for ( e : Email in mailinglist() )
    {
      email ( issueNotification ( this, e ) );
    }
  }
  function reopen ( ) : Void
  {
    open := true;
    log.add(IssueReopen{moment := now()
                        actor := securityContext.principal});
  }
  function close ( ) : Void
  {
    open := false;
    log.add(IssueClose{moment := now()
                       actor := securityContext.principal});
  }
  function getTitle ( ) : String
  {
    if ( title == null || title == "" || title == " " )
    {
      return "<< no title >>";
    }
    else
    {
      return title;
    }
  }
  function getComments ( ) : Set<Comment>
  {
    var set : Set<Comment> ;
    log("getComments");
    for ( e : Event in log where e is a Comment )
    {
      set.add(( e as Comment ));
    }
    return set;
  }
  function test ( ) : Void
  {
    var x := Issue{open := true
                   title := "asdsa"} ;
  }
  function getReporterName ( ) : String
  {
    if ( reporter != null && reporter.name != null )
    {
      return reporter.name;
    }
    else
    {
      return "";
    }
  }
}