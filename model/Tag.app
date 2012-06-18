module entities_generated/Tag
entity Tag {
  tags -> Set<Tag>
  project -> Project
  description :: String
  name :: String ( validate(name.length()>1,"Tags need to have at least 2 characters"), validate ( /[a-z0-9\.\-_@!]*/.match(name) , "Tags may consist of: a-z 0-9 . _ @ ! -" ) )
  function isRelease ( ) : Bool
  {
    return hasTag("release");
  }
  function isColored ( ) : Bool
  {
    return hasTag("red") || hasTag("green") || hasTag("grey");
  }
  function getStylingClass ( ) : String
  {
    if ( hasTag("release") )
    {
      return "ReleaseTag Tag";
    }
    if ( hasTag("red") )
    {
      return "RedTag Tag";
    }
    if ( hasTag("green") )
    {
      return "GreenTag Tag";
    }
    if ( hasTag("grey") )
    {
      return "GreyTag Tag";
    }
    if ( hasTag("purple") )
    {
      return "PurpleTag Tag";
    }
    if ( hasTag(ISSUE_TYPE_TAG()) )
    {
      return "IssuetypeTag Tag";
    }
    else
    {
      return "Tag";
    }
  }
  function getColor ( ) : String
  {
    if ( hasTag("release") )
    {
      return "blue";
    }
    if ( hasTag("red") )
    {
      return "red";
    }
    if ( hasTag("green") )
    {
      return "green";
    }
    if ( hasTag("grey") || hasTag(ISSUE_TYPE_TAG()) )
    {
      return "black";
    }
    if ( hasTag("purple") )
    {
      return "purple";
    }
    else
    {
      return "yellow";
    }
  }
  function toJSON ( ) : JSONObject
  {
    var json := JSONObject() ;
    json.put("id", id);
    json.put("name", name);
    json.put("color", getColor());
    return json;
  }
  function hasTag ( tagName : String ) : Bool
  {
    for ( t : Tag in tags )
    {
      if ( t.name == tagName )
      {
        return true;
      }
    }
    return false;
  }
}