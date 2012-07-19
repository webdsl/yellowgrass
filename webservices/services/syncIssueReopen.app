module webservices/services/syncIssueReopen
service webservice_generated_syncIssueReopen ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("IssueReopen", request.getJSONObject(count).getString("id").parseUUID()) as IssueReopen ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}