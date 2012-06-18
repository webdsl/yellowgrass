module entity-pages/User
page showEntityUser ( )
{
title {
  "User"
}
  header {
    "User"
  }
  group("Properties"){par {
                        "name"
                        " "
                        "::"
                        " "
                        "String"
                      } par {
                          "email"
                          " "
                          "::"
                          " "
                          "Email"
                        } par {
                            "notifications"
                            " "
                            "::"
                            " "
                            "Bool"
                          } par {
                              "password"
                              " "
                              "::"
                              " "
                              "Secret"
                            } par {
                                "projects"
                                " "
                                "->"
                                " "
                                "Set<"
                                navigate
                                showEntityProject()
                                [
                                ]
                                {
                                "Project"
                                }
                                ">"
                              } par {
                                  "url"
                                  " "
                                  "::"
                                  " "
                                  "URL"
                                } par {
                                    "tag"
                                    " "
                                    "::"
                                    " "
                                    "String"
                                  } par {
                                      "deviceKeySet"
                                      " "
                                      "->"
                                      " "
                                      "Set<"
                                      navigate
                                      showEntityAuthenticationKey()
                                      [
                                      ]
                                      {
                                      "AuthenticationKey"
                                      }
                                      ">"
                                    }}
  group("Functions"){par {
                       "function userEmailTaken ("
                       " ) : "
                       "Bool"
                     } par {
                         "function userTagTaken ("
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
                           } par {
                               "function generateAuthenticationKey ("
                               "deviceDescription : "
                               "String"
                               " ) : "
                               "UUID"
                             } par {
                                 "function getDeviceKey ("
                                 "deviceDescription : "
                                 "String"
                                 " ) : "
                                 "UUID"
                               }}
}