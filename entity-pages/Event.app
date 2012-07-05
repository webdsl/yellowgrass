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
                        "test19"
                        " "
                        "->"
                        " "
                        "List<"
                        navigate
                        showEntityProject()
                        [
                        ]
                        {
                        "Project"
                        }
                        ">"
                      } par {
                          "test17"
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
                            "test16"
                            " "
                            "->"
                            " "
                            navigate
                            showEntityIssue()
                            [
                            ]
                            {
                            "Issue"
                            }
                          } par {
                              "test15"
                              " "
                              "::"
                              " "
                              "Date"
                            } par {
                                "test14"
                                " "
                                "::"
                                " "
                                "Time"
                              } par {
                                  "test13"
                                  " "
                                  "::"
                                  " "
                                  "WikiText"
                                } par {
                                    "test12"
                                    " "
                                    "::"
                                    " "
                                    "Image"
                                  } par {
                                      "test11"
                                      " "
                                      "::"
                                      " "
                                      "File"
                                    } par {
                                        "test10"
                                        " "
                                        "::"
                                        " "
                                        "Secret"
                                      } par {
                                          "test9"
                                          " "
                                          "::"
                                          " "
                                          "Text"
                                        } par {
                                            "test8"
                                            " "
                                            "::"
                                            " "
                                            "Patch"
                                          } par {
                                              "test7"
                                              " "
                                              "::"
                                              " "
                                              "URL"
                                            } par {
                                                "test6"
                                                " "
                                                "::"
                                                " "
                                                "Long"
                                              } par {
                                                  "test5"
                                                  " "
                                                  "::"
                                                  " "
                                                  "Float"
                                                } par {
                                                    "test4"
                                                    " "
                                                    "::"
                                                    " "
                                                    "Email"
                                                  } par {
                                                      "test3"
                                                      " "
                                                      "::"
                                                      " "
                                                      "Int"
                                                    } par {
                                                        "test2"
                                                        " "
                                                        "::"
                                                        " "
                                                        "String"
                                                      } par {
                                                          "test"
                                                          " "
                                                          "::"
                                                          " "
                                                          "Bool"
                                                        } par {
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