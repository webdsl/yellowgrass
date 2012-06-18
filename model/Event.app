module model/Event
entity Event {
  moment :: DateTime
  function toJSON ( ) : JSONObject
  {
    var json := JSONObject() ;
    return null;
  }
}