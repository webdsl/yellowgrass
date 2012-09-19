module webservices/services/syncTag
service webservice_generated_syncTag ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var request := JSONArray(readRequestBody()) ;
  var result := JSONArray() ;
  for ( count : Int from 0 to request.length() )
    {
      var entity := ( loadEntity("Tag", request.getJSONObject(count).getString("id").parseUUID()) as Tag ) ;
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