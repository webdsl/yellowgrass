module webservices/services/syncProject
service webservice_generated_syncProject ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
    {
      var tl := ( loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project ) ;
      var timestamp := request.getJSONObject(count).getLong("lastSynced") ;
      for ( ent : Project in getAllProjectForProject(tl) where timestamp == 0 || ent.modified != null && ent.modified.getTime() > timestamp )
        {
          result.put(ent.toJSON());
        }
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}