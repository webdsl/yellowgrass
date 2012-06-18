module entity-pages/Issue
page showEntityIssue ( )
{
title {
  "Issue"
}
  header {
    "Issue"
  }
  group("Properties"){par {
                        "number"
                        " "
                        "::"
                        " "
                        "Int"
                      } par {
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
                              "submitted"
                              " "
                              "::"
                              " "
                              "DateTime"
                            } par {
                                "project"
                                " "
                                "->"
                                " "
                                "Project"
                              } par {
                                  "reporter"
                                  " "
                                  "->"
                                  " "
                                  "User"
                                } par {
                                    "open"
                                    " "
                                    "::"
                                    " "
                                    "Bool"
                                  } par {
                                      "log"
                                      " "
                                      "->"
                                      " "
                                      "Set<Event>"
                                    } par {
                                        "tags"
                                        " "
                                        "->"
                                        " "
                                        "Set<Tag>"
                                      } par {
                                          "email"
                                          " "
                                          "::"
                                          " "
                                          "Email"
                                        } par {
                                            "nrVotes"
                                            " "
                                            "::"
                                            " "
                                            "Int"
                                          } par {
                                              "attachments"
                                              " "
                                              "->"
                                              " "
                                              "Set<Attachment>"
                                            } par {
                                                "projectName"
                                                " "
                                                "::"
                                                " "
                                                "String"
                                              } par {
                                                  "reporterName"
                                                  " "
                                                  "::"
                                                  " "
                                                  "String"
                                                }}
  group("Functions"){par {
                       "function getReporterName ("
                       " ) : "
                       "String"
                     } par {
                         "function test ("
                         " ) : "
                         "Void"
                       } par {
                           "function getComments ("
                           " ) : "
                           "Set<Comment>"
                         } par {
                             "function getTitle ("
                             " ) : "
                             "String"
                           } par {
                               "function close ("
                               " ) : "
                               "Void"
                             } par {
                                 "function reopen ("
                                 " ) : "
                                 "Void"
                               } par {
                                   "function notifyRegister ("
                                   " ) : "
                                   "Void"
                                 } par {
                                     "function notifyClose ("
                                     " ) : "
                                     "Void"
                                   } par {
                                       "function notifyReopen ("
                                       " ) : "
                                       "Void"
                                     } par {
                                         "function addComment ("
                                         "c : "
                                         "Comment"
                                         " ) : "
                                         "Void"
                                       } par {
                                           "function commentClose ("
                                           "c : "
                                           "Comment"
                                           " ) : "
                                           "Void"
                                         } par {
                                             "function isAssigned ("
                                             " ) : "
                                             "Bool"
                                           } par {
                                               "function assign ("
                                               " ) : "
                                               "Void"
                                             } par {
                                                 "function toJSON ("
                                                 " ) : "
                                                 "JSONObject"
                                               } par {
                                                   "function toSimpleJSON ("
                                                   " ) : "
                                                   "JSONObject"
                                                 } par {
                                                     "function toExtendedJSON ("
                                                     " ) : "
                                                     "JSONObject"
                                                   } par {
                                                       "function mailinglist ("
                                                       " ) : "
                                                       "Set<Email>"
                                                     } par {
                                                         "function mailSubject ("
                                                         " ) : "
                                                         "String"
                                                       } par {
                                                           "function addTag ("
                                                           "t : "
                                                           "Tag"
                                                           " ) : "
                                                           "Void"
                                                         } par {
                                                             "function deleteTag ("
                                                             "t : "
                                                             "Tag"
                                                             " ) : "
                                                             "Void"
                                                           } par {
                                                               "function hasTag ("
                                                               "tagName : "
                                                               "String"
                                                               " ) : "
                                                               "Bool"
                                                             }}
}