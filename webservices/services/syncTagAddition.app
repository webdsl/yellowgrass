module webservices/services/syncTagAddition
service webservice_generated_syncTagAddition ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("TagAddition", request.getJSONObject(count).getString("id").parseUUID()) as TagAddition ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}