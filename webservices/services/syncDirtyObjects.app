module webservices/services/syncDirtyObjects
service webservice_generated_syncDirtyObjects ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
    {
      var jsontemp := request.getJSONObject(count) ;
      var kind := jsontemp.getString("name") ;
      var entities := jsontemp.getJSONArray("value") ;
      if ( kind == "User" )
      {
        for ( count : Int from 0 to entities.length() )
          {
            var entity := ( loadEntity("User", entities.getJSONObject(count).getString("id").parseUUID()) as User ) ;
            if ( entity.version <= entities.getJSONObject(count).getInt("version") )
            {
              mapperEditedUser(entity, entities.getJSONObject(count));
            }
            else
            {
              errors.put(makeJSONErrorObject("already has newer version", "warning", "User", entity.id));
            }
          }
      }
      else
      {
        if ( kind == "TagRemoval" )
        {
          for ( count : Int from 0 to entities.length() )
            {
              var entity := ( loadEntity("TagRemoval", entities.getJSONObject(count).getString("id").parseUUID()) as TagRemoval ) ;
              if ( entity.version <= entities.getJSONObject(count).getInt("version") )
              {
                mapperEditedTagRemoval(entity, entities.getJSONObject(count));
              }
              else
              {
                errors.put(makeJSONErrorObject("already has newer version", "warning", "TagRemoval", entity.id));
              }
            }
        }
        else
        {
          if ( kind == "TagAddition" )
          {
            for ( count : Int from 0 to entities.length() )
              {
                var entity := ( loadEntity("TagAddition", entities.getJSONObject(count).getString("id").parseUUID()) as TagAddition ) ;
                if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                {
                  mapperEditedTagAddition(entity, entities.getJSONObject(count));
                }
                else
                {
                  errors.put(makeJSONErrorObject("already has newer version", "warning", "TagAddition", entity.id));
                }
              }
          }
          else
          {
            if ( kind == "Tag" )
            {
              for ( count : Int from 0 to entities.length() )
                {
                  var entity := ( loadEntity("Tag", entities.getJSONObject(count).getString("id").parseUUID()) as Tag ) ;
                  if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                  {
                    mapperEditedTag(entity, entities.getJSONObject(count));
                  }
                  else
                  {
                    errors.put(makeJSONErrorObject("already has newer version", "warning", "Tag", entity.id));
                  }
                }
            }
            else
            {
              if ( kind == "Project" )
              {
                for ( count : Int from 0 to entities.length() )
                  {
                    var entity := ( loadEntity("Project", entities.getJSONObject(count).getString("id").parseUUID()) as Project ) ;
                    if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                    {
                      mapperEditedProject(entity, entities.getJSONObject(count));
                    }
                    else
                    {
                      errors.put(makeJSONErrorObject("already has newer version", "warning", "Project", entity.id));
                    }
                  }
              }
              else
              {
                if ( kind == "IssueReopen" )
                {
                  for ( count : Int from 0 to entities.length() )
                    {
                      var entity := ( loadEntity("IssueReopen", entities.getJSONObject(count).getString("id").parseUUID()) as IssueReopen ) ;
                      if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                      {
                        mapperEditedIssueReopen(entity, entities.getJSONObject(count));
                      }
                      else
                      {
                        errors.put(makeJSONErrorObject("already has newer version", "warning", "IssueReopen", entity.id));
                      }
                    }
                }
                else
                {
                  if ( kind == "IssueMoved" )
                  {
                    for ( count : Int from 0 to entities.length() )
                      {
                        var entity := ( loadEntity("IssueMoved", entities.getJSONObject(count).getString("id").parseUUID()) as IssueMoved ) ;
                        if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                        {
                          mapperEditedIssueMoved(entity, entities.getJSONObject(count));
                        }
                        else
                        {
                          errors.put(makeJSONErrorObject("already has newer version", "warning", "IssueMoved", entity.id));
                        }
                      }
                  }
                  else
                  {
                    if ( kind == "IssueGhost" )
                    {
                      for ( count : Int from 0 to entities.length() )
                        {
                          var entity := ( loadEntity("IssueGhost", entities.getJSONObject(count).getString("id").parseUUID()) as IssueGhost ) ;
                          if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                          {
                            mapperEditedIssueGhost(entity, entities.getJSONObject(count));
                          }
                          else
                          {
                            errors.put(makeJSONErrorObject("already has newer version", "warning", "IssueGhost", entity.id));
                          }
                        }
                    }
                    else
                    {
                      if ( kind == "IssueClose" )
                      {
                        for ( count : Int from 0 to entities.length() )
                          {
                            var entity := ( loadEntity("IssueClose", entities.getJSONObject(count).getString("id").parseUUID()) as IssueClose ) ;
                            if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                            {
                              mapperEditedIssueClose(entity, entities.getJSONObject(count));
                            }
                            else
                            {
                              errors.put(makeJSONErrorObject("already has newer version", "warning", "IssueClose", entity.id));
                            }
                          }
                      }
                      else
                      {
                        if ( kind == "Issue" )
                        {
                          for ( count : Int from 0 to entities.length() )
                            {
                              var entity := ( loadEntity("Issue", entities.getJSONObject(count).getString("id").parseUUID()) as Issue ) ;
                              if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                              {
                                mapperEditedIssue(entity, entities.getJSONObject(count));
                              }
                              else
                              {
                                errors.put(makeJSONErrorObject("already has newer version", "warning", "Issue", entity.id));
                              }
                            }
                        }
                        else
                        {
                          if ( kind == "Event" )
                          {
                            for ( count : Int from 0 to entities.length() )
                              {
                                var entity := ( loadEntity("Event", entities.getJSONObject(count).getString("id").parseUUID()) as Event ) ;
                                if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                                {
                                  mapperEditedEvent(entity, entities.getJSONObject(count));
                                }
                                else
                                {
                                  errors.put(makeJSONErrorObject("already has newer version", "warning", "Event", entity.id));
                                }
                              }
                          }
                          else
                          {
                            if ( kind == "Comment" )
                            {
                              for ( count : Int from 0 to entities.length() )
                                {
                                  var entity := ( loadEntity("Comment", entities.getJSONObject(count).getString("id").parseUUID()) as Comment ) ;
                                  if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                                  {
                                    mapperEditedComment(entity, entities.getJSONObject(count));
                                  }
                                  else
                                  {
                                    errors.put(makeJSONErrorObject("already has newer version", "warning", "Comment", entity.id));
                                  }
                                }
                            }
                            else
                            {
                              if ( kind == "Attachment" )
                              {
                                for ( count : Int from 0 to entities.length() )
                                  {
                                    var entity := ( loadEntity("Attachment", entities.getJSONObject(count).getString("id").parseUUID()) as Attachment ) ;
                                    if ( entity.version <= entities.getJSONObject(count).getInt("version") )
                                    {
                                      mapperEditedAttachment(entity, entities.getJSONObject(count));
                                    }
                                    else
                                    {
                                      errors.put(makeJSONErrorObject("already has newer version", "warning", "Attachment", entity.id));
                                    }
                                  }
                              }
                              else
                              {
                                errors.put("type is undefined: " + kind);
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}