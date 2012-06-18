module entity-pages/Release
page showEntityRelease ( )
{
title {
  "Release"
}
  header {
    "Release"
  }
  group("Properties"){par {
                        "name"
                        " "
                        "::"
                        " "
                        "String"
                      } par {
                          "issues"
                          " "
                          "->"
                          " "
                          "List<"
                          navigate
                          showEntityIssue()
                          [
                          ]
                          {
                          "Issue"
                          }
                          ">"
                        } par {
                            "project"
                            " "
                            "->"
                            " "
                            navigate
                            showEntityProject()
                            [
                            ]
                            {
                            "Project"
                            }
                          }}
  group("Functions"){par {
                       "function toJSON ("
                       " ) : "
                       "JSONObject"
                     } par {
                         "function toJSONSimple ("
                         " ) : "
                         "JSONObject"
                       }}
}