module entity-pages/Project
page showEntityProject ( )
{
title {
  "Project"
}
  header {
    "Project"
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
                          "WikiText"
                        } par {
                            "url"
                            " "
                            "::"
                            " "
                            "URL"
                          } par {
                              "issues"
                              " "
                              "->"
                              " "
                              "Set<"
                              navigate
                              showEntityIssue()
                              [
                              ]
                              {
                              "Issue"
                              }
                              ">"
                            } par {
                                "members"
                                " "
                                "->"
                                " "
                                "Set<"
                                navigate
                                showEntityUser()
                                [
                                ]
                                {
                                "User"
                                }
                                ">"
                              } par {
                                  "memberRequests"
                                  " "
                                  "->"
                                  " "
                                  "Set<"
                                  navigate
                                  showEntityUser()
                                  [
                                  ]
                                  {
                                  "User"
                                  }
                                  ">"
                                } par {
                                    "followers"
                                    " "
                                    "->"
                                    " "
                                    "Set<"
                                    navigate
                                    showEntityUser()
                                    [
                                    ]
                                    {
                                    "User"
                                    }
                                    ">"
                                  } par {
                                      "created"
                                      " "
                                      "::"
                                      " "
                                      "DateTime"
                                    } par {
                                        "private"
                                        " "
                                        "::"
                                        " "
                                        "Bool"
                                      } par {
                                          "email"
                                          " "
                                          "::"
                                          " "
                                          "Email"
                                        }}
  group("Functions"){par {
                       "function getCommonTags ("
                       "nr : "
                       "Int"
                       " ) : "
                       "List<"
                       navigate
                       showEntityTag()
                       [
                       ]
                       {
                       "Tag"
                       }
                       ">"
                     } par {
                         "function getIssueTypeTags ("
                         " ) : "
                         "List<"
                         navigate
                         showEntityTag()
                         [
                         ]
                         {
                         "Tag"
                         }
                         ">"
                       } par {
                           "function getOrderedIssues ("
                           "filterOpen : "
                           "Bool"
                           " ) : "
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
                             "function getIssueStatsWeekly ("
                             " ) : "
                             "List<Int>"
                           } par {
                               "function getWeeklyStatsGraph ("
                               " ) : "
                               "String"
                             } par {
                                 "function toJSON ("
                                 "old : "
                                 "JSONObject"
                                 " ) : "
                                 "JSONObject"
                               } par {
                                   "function toSimpleJSON ("
                                   " ) : "
                                   "JSONObject"
                                 } par {
                                     "function toJSONRef ("
                                     " ) : "
                                     "JSONObject"
                                   }}
}