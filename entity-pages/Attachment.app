module entity-pages/Attachment
page showEntityAttachment ( )
{
title {
  "Attachment"
}
  header {
    "Attachment"
  }
  group ( "Properties" ) {
    par {
      "date"
      " "
      "::"
      " "
      "DateTime"
    }
    par {
      "file"
      " "
      "::"
      " "
      "File"
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