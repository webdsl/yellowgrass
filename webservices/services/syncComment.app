module webservices/services/syncComment
service webservice_generated_syncComment ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("Comment", request.getJSONObject(count).getString("id").parseUUID()) as Comment ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}