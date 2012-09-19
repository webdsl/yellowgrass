module entity-pages/IssueMoved
page showEntityIssueMoved ( )
{
title {
  "IssueMoved"
}
  header {
    "IssueMoved : "
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
    par {
      "target"
      " "
      "->"
      " "
      navigate showEntityIssue() [ ] { "Issue" }
    }
  }
  group ( "Functions" ) {
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