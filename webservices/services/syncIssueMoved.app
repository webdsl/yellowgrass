module webservices/services/syncIssueMoved
service webservice_generated_syncIssueMoved ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("IssueMoved", request.getJSONObject(count).getString("id").parseUUID()) as IssueMoved ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}