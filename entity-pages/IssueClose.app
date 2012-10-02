module entity-pages/IssueClose
page showEntityIssueClose ( )
{
title {
  "IssueClose"
}
  header {
    "IssueClose : "
    navigate showEntityEvent() [ ] { "Event" }
  }
  group ( "Properties" ) {
    par {
      "actor"
      " "
      "->"
      " "
      navigate showEntityUser() [ ] { "User" }
    }
  }
  group ( "Functions" ) {
    par {
      "function toJSONFromSuperEvent ("
      " ) : "
      "JSONObject"
    }
    par {
      "function toMinimalJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function toJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function toSimpleJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function getRelatedEntities ("
      " ) : "
      "Set<Entity>"
    }
  }
}