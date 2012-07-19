module webservices/services/interface
imports webservices/services/getTopLevelEntities
imports webservices/services/test
native class DispatchServletHelper as DispatchServletHelper : DispatchServlet
{
getResponse ( ) : HttpServletResponse
  forwardRequest ( String )
  static get ( ) : DispatchServlet
}
function getDispatchServletHelper ( ) : DispatchServletHelper
{
  var servlet := DispatchServletHelper.get() ;
  if ( servlet is a DispatchServletHelper )
  {
    return ( servlet as DispatchServletHelper );
  }
  else
  {
    return null;
  }
}
function getAvialableServices ( ) : Set<String>
{
  return {"test", "getTopLevelEntities", "syncProjects"};
}
service webservice ( service : String )
{
  if ( service in getAvialableServices() )
  {
    getDispatchServletHelper().forwardRequest("/webservice_generated_" + service + "/");
  }
  else
  {
    var json := JSONObject() ;
    var errors := JSONArray() ;
    errors.put("service " + service + " does not exist");
    json.put("errors", errors);
    return json;
  }
}

service webservice_generated_syncProjects ( ) //todo generation
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  // var result := "This is a test service" ;
  var request := JSONArray(readRequestBody());
  var result := JSONArray();
  for(count : Int from 0 to request.length() ){ 
  		result.put((loadEntity("Project", request.getJSONObject(count).getString("id").parseUUID()) as Project).toJSON());
  }
  json.put("result", result);
  return json;
}