module webservices/services/syncTag
service webservice_generated_syncTag ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  var tls := Set<Project>() ;
  for ( count : Int from 0 to request.length() )
    {
      var entity := ( loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project ) ;
      tls.add(entity);
    }
  for ( ent : Tag in getAllTagForProject(tls) )
    {
      result.put(ent.toJSON());
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}