module webservices/services/syncProject
service webservice_generated_syncProject ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}