module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( f_47774 : Project in Project.all() )
    {
      result.put(f_47774.toSimpleJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}