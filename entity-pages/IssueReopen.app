module entity-pages/IssueReopen
page showEntityIssueReopen ( )
{
title {
  "IssueReopen"
}
  header {
    "IssueReopen : "
    navigate
    showEntityEvent()
    [
    ]
    {
    "Event"
    }
  }
  group("Properties"){par {
                        "actor"
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