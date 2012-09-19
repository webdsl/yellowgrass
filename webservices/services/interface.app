module webservices/services/interface
imports webservices/services/getTopLevelEntities
imports webservices/services/syncAttachment
imports webservices/services/syncComment
imports webservices/services/syncEvent
imports webservices/services/syncIssue
imports webservices/services/syncIssueClose
imports webservices/services/syncIssueGhost
imports webservices/services/syncIssueMoved
imports webservices/services/syncIssueReopen
imports webservices/services/syncProject
imports webservices/services/syncTag
imports webservices/services/syncTagAddition
imports webservices/services/syncTagRemoval
imports webservices/services/syncUser
imports webservices/services/test
imports  webservices/related-entities/main
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
function getAvailableServices ( ) : Set<String>
{
  return {"syncAttachment", "syncComment", "syncEvent", "syncIssue", "syncIssueClose", "syncIssueGhost", "syncIssueMoved", "syncIssueReopen", "syncProject", "syncTag", "syncTagAddition", "syncTagRemoval", "syncUser", "test", "getTopLevelEntities"};
}
service webservice ( service : String )
{
  if ( service in getAvailableServices() )
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