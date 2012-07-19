module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( j_2039 : Project in Project.all() )
  {
    result.put(j_2039.toSimpleJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}