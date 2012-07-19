module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( h_19776 : Project in Project.all() )
  {
    result.put(h_19776.toSimpleJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}