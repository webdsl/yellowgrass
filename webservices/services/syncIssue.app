module webservices/services/syncIssue
service webservice_generated_syncIssue ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("Issue", request.getJSONObject(count).getString("id").parseUUID()) as Issue ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}