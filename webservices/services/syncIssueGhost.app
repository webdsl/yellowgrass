module webservices/services/syncIssueGhost
service webservice_generated_syncIssueGhost ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("IssueGhost", request.getJSONObject(count).getString("id").parseUUID()) as IssueGhost ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}