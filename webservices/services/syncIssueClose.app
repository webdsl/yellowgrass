module webservices/services/syncIssueClose
service webservice_generated_syncIssueClose ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("IssueClose", request.getJSONObject(count).getString("id").parseUUID()) as IssueClose ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}