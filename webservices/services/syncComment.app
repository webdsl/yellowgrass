module webservices/services/syncComment
service webservice_generated_syncComment ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
    {
      var entity := ( loadEntity("Comment", request.getJSONObject(count).getString("id").parseUUID()) as Comment ) ;
      if ( entity.version > request.getJSONObject(count).getString("version").parseInt() )
      {
        result.put(entity.toJSON());
      }
      else
      {
        result.put(entity.toMinimalJSON());
      }
    }
  json.put("errors", errors);
  json.put("result", result);
  return json;
}