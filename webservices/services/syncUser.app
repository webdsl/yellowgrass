module webservices/services/syncUser
service webservice_generated_syncUser ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("User", request.getJSONObject(count).getString("id").parseUUID()) as User ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}