module model/VersionObject
entity VersionObject {
  function toString2 ( ) : String
  {
    return "{ id:" + id + ", version:" + version + " }";
  }
}