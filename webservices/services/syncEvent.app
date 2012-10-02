module webservices/services/syncEvent
service webservice_generated_syncEvent ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  var tls := Set<Project>() ;
  for ( count : Int from 0 to request.length() )
    {
      var entity := ( loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project ) ;
      tls.add(entity);
    }
  for ( ent : Event in getAllEventForProject(tls) )
    {
      result.put(ent.toJSON());
    }
  for ( ent : Comment in getAllCommentForProject(tls) )
    {
      result.put(ent.toJSONFromSuperEvent());
    }
  for ( ent : IssueClose in getAllIssueCloseForProject(tls) )
    {
      result.put(ent.toJSONFromSuperEvent());
    }
  for ( ent : IssueMoved in getAllIssueMovedForProject(tls) )
    {
      result.put(ent.toJSONFromSuperEvent());
    }
  for ( ent : IssueReopen in getAllIssueReopenForProject(tls) )
    {
      result.put(ent.toJSONFromSuperEvent());
    }
  for ( ent : TagAddition in getAllTagAdditionForProject(tls) )
    {
      result.put(ent.toJSONFromSuperEvent());
    }
  for ( ent : TagRemoval in getAllTagRemovalForProject(tls) )
    {
      result.put(ent.toJSONFromSuperEvent());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}