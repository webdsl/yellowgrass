module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( u_40256 : Project in Project.all() )
    {
      result.put(u_40256.toSimpleJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}