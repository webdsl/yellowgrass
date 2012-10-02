module webservices/services/syncIssue
service webservice_generated_syncIssue ( )
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
  for ( ent : Issue in getAllIssueForProject(tls) )
    {
      result.put(ent.toJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}