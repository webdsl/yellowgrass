module entity-pages/TagRemoval
page showEntityTagRemoval ( )
{
title {
  "TagRemoval"
}
  header {
    "TagRemoval : "
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