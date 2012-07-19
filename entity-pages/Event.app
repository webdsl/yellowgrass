module entity-pages/Event
page showEntityEvent ( )
{
title {
  "Event"
}
  header {
    "Event"
  }
  group("Properties"){par {
                        "moment"
                        " "
                        "::"
                        " "
                        "DateTime"
                      }}
  group("Functions"){par {
                       "function toJSON ("
                       " ) : "
                       "JSONObject"
                     } par {
                         "function toSimpleJSON ("
                         " ) : "
                         "JSONObject"
                       }}
}