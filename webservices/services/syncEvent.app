module webservices/services/syncEvent
service webservice_generated_syncEvent ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("Event", request.getJSONObject(count).getString("id").parseUUID()) as Event ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}