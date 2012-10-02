module webservices/services/getTopLevelEntities
service webservice_generated_getTopLevelEntities ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var result := JSONArray() ;
  for ( i_19770 : Project in Project.all() )
    {
      result.put(i_19770.toSimpleJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}