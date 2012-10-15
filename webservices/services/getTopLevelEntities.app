module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( o_1150 : Project in Project.all() )
    {
      result.put(o_1150.toSimpleJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}