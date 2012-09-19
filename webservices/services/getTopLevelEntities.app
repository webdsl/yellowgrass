module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( j_39207 : Project in Project.all() )
  {
    result.put(j_39207.toSimpleJSON());
  }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}