module webservices/services/syncTagRemoval
service webservice_generated_syncTagRemoval ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("TagRemoval", request.getJSONObject(count).getString("id").parseUUID()) as TagRemoval ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}