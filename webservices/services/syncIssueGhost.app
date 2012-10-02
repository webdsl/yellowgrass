module webservices/services/syncIssueGhost
service webservice_generated_syncIssueGhost ( )
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
  for ( ent : IssueGhost in getAllIssueGhostForProject(tls) )
    {
      result.put(ent.toJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}