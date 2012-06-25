module entity-pages/Tag
page showEntityTag ( )
{
title {
  "Tag"
}
  header {
    "Tag"
  }
  group("Properties"){par {
                        "name"
                        " "
                        "::"
                        " "
                        "String"
                      } par {
                          "description"
                          " "
                          "::"
                          " "
                          "String"
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
                          } par {
                              "tags"
                              " "
                              "->"
                              " "
                              "Set<"
                              navigate
                              showEntityTag()
                              [
                              ]
                              {
                              "Tag"
                              }
                              ">"
                            }}
  group("Functions"){par {
                       "function hasTag ("
                       "tagName : "
                       "String"
                       " ) : "
                       "Bool"
                     } par {
                         "function getColor ("
                         " ) : "
                         "String"
                       } par {
                           "function getStylingClass ("
                           " ) : "
                           "String"
                         } par {
                             "function isColored ("
                             " ) : "
                             "Bool"
                           } par {
                               "function isRelease ("
                               " ) : "
                               "Bool"
                             } par {
                                 "function toJSON ("
                                 " ) : "
                                 "JSONObject"
                               } par {
                                   "function toSimpleJSON ("
                                   " ) : "
                                   "JSONObject"
                                 }}
}