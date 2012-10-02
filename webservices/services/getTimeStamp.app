module webservices/services/getTimeStamp
service webservice_generated_getTimeStamp ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := now().getTime() ;
  json.put("errors", errors);
  json.put("result", result);
  return json;
}