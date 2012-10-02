module entity-pages/IssueReopen
page showEntityIssueReopen ( )
{
title {
  "IssueReopen"
}
  header {
    "IssueReopen : "
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