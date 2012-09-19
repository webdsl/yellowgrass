module entity-pages/TagAddition
page showEntityTagAddition ( )
{
title {
  "TagAddition"
}
  header {
    "TagAddition : "
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
      "tag"
      " "
      "->"
      " "
      navigate showEntityTag() [ ] { "Tag" }
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