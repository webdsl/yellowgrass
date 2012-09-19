module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( t_254148 : Project in Project.all() )
    {
      result.put(t_254148.toSimpleJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}