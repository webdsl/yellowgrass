module entity-pages/Comment
page showEntityComment ( )
{
title {
  "Comment"
}
  header {
    "Comment : "
    navigate
    showEntityEvent()
    [
    ]
    {
    "Event"
    }
  }
  group("Properties"){par {
                        "text"
                        " "
                        "::"
                        " "
                        "WikiText"
                      } par {
                          "author"
                          " "
                          "->"
                          " "
                          navigate
                          showEntityUser()
                          [
                          ]
                          {
                          "User"
                          }
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