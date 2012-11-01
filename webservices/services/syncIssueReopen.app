module webservices/services/syncIssueReopen
service webservice_generated_syncIssueReopen ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
    {
      var tl := ( loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project ) ;
      var timestamp := request.getJSONObject(count).getLong("lastSynced") ;
      for ( ent : IssueReopen in getAllIssueReopenForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(addDirtyFalse(ent.toJSON()));
        }
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}