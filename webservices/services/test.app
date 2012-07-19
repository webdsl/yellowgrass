module webservices/services/test
service webservice_generated_test ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := "This is a test service" ;
  json.put("errors", errors);
  json.put("result", result);
  return json;
}