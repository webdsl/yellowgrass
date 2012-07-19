module webservices/services/syncAttachment
service webservice_generated_syncAttachment ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
  {
    result.put(( loadEntity("Attachment", request.getJSONObject(count).getString("id").parseUUID()) as Attachment ).toJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}