module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( l_70515 : Project in Project.all() )
  {
    result.put(l_70515.toSimpleJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}