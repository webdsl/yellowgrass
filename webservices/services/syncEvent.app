module webservices/services/syncEvent
service webservice_generated_syncEvent ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
    {
      var tl := ( loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project ) ;
      var timestamp := request.getJSONObject(count).getLong("lastSynced") ;
      for ( ent : Event in getAllEventForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSON());
        }
      for ( ent : Comment in getAllCommentForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSONFromSuperEvent());
        }
      for ( ent : IssueClose in getAllIssueCloseForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSONFromSuperEvent());
        }
      for ( ent : IssueMoved in getAllIssueMovedForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSONFromSuperEvent());
        }
      for ( ent : IssueReopen in getAllIssueReopenForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSONFromSuperEvent());
        }
      for ( ent : TagAddition in getAllTagAdditionForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSONFromSuperEvent());
        }
      for ( ent : TagRemoval in getAllTagRemovalForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSONFromSuperEvent());
        }
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}