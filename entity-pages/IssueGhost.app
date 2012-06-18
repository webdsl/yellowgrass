module entity-pages/IssueGhost
page showEntityIssueGhost ( )
{
title {
  "IssueGhost"
}
  header {
    "IssueGhost"
  }
  group("Properties"){par {
                        "title"
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
                              "email"
                              " "
                              "::"
                              " "
                              "Email"
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
                              } par {
                                  "alive"
                                  " "
                                  "::"
                                  " "
                                  "Bool"
                                }}
  group("Functions"){par {
                       "function tryRealize ("
                       " ) : "
                       navigate
                       showEntityIssue()
                       [
                       ]
                       {
                       "Issue"
                       }
                     } par {
                         "function realize ("
                         " ) : "
                         navigate
                         showEntityIssue()
                         [
                         ]
                         {
                         "Issue"
                         }
                       }}
}