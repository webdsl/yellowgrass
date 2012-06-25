module entity-pages/Attachment
page showEntityAttachment ( )
{
title {
  "Attachment"
}
  header {
    "Attachment"
  }
  group("Properties"){par {
                        "date"
                        " "
                        "::"
                        " "
                        "DateTime"
                      } par {
                          "file"
                          " "
                          "::"
                          " "
                          "File"
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