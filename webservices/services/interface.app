module webservices/services/interface
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
function getAvialableServices ( ) : List<String>
{
  return ["test"];
}
service webservices ( service : String )
{
  if ( getAvialableServices().indexOf(service) >= 0 )
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
service webservice_generated_test ( )
{
  var json := JSONObject() ;
  var errors := JSONArray() ;
  var message := "This is a test service" ;
  json.put("errors", errors);
  json.put("result", message);
  return json;
}