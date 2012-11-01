module webservices/services/interface
imports webservices/services/getTimeStamp
imports webservices/services/getTopLevelEntities
imports webservices/services/syncAttachment
imports webservices/services/syncComment
imports webservices/services/syncDirtyObjects
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
imports webservices/related-entities/main
imports webservices/mappers/main
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
  return {"syncDirtyObjects", "syncAttachment", "syncComment", "syncEvent", "syncIssue", "syncIssueClose", "syncIssueGhost", "syncIssueMoved", "syncIssueReopen", "syncProject", "syncTag", "syncTagAddition", "syncTagRemoval", "syncUser", "getTimeStamp", "test", "getTopLevelEntities"};
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
function addDirtyFalse ( json : JSONObject ) : JSONObject
{
  json.put("dirty", "false");
  return json;
}
function makeJSONErrorObject ( message : String , type : String , ent : String , id : UUID ) : JSONObject
{
  var json := JSONObject() ;
  json.put("message", message);
  json.put("type", type);
  json.put("id", id);
  json.put("ent", ent);
  return json;
}