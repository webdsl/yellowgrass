module model/Release
entity Release {
  project -> Project
  issues -> List<Issue>
  name :: String
  function toJSONSimple ( ) : JSONObject
  {
    var jsonObject := JSONObject() ;
    jsonObject.put("id", project.name.substring(0, 20) + name);
    jsonObject.put("name", name);
    return jsonObject;
  }
  // function toJSON ( ) : JSONObject
  // {
  //   var jsonObject := JSONObject() ;
  //   jsonObject.put("id", project.name.substring(0, 20) + name);
  //   jsonObject.put("name", name);
  //   var jsonArray := JSONArray() ;
  //   for ( issue : Issue in issues )
  //   {
  //     var jsonobject := issue.toJSON() ;
  //     jsonArray.put(jsonobject);
  //   }
  //   jsonObject.put("issues", jsonArray);
  //   return jsonObject;
  // }
}