module webservices/services/syncTag
service webservice_generated_syncTag ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("Tag", request.getJSONObject(count).getString("id").parseUUID()) as Tag ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}