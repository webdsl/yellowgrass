module entity-pages
imports entity-pages/Attachment
imports entity-pages/Comment
imports entity-pages/Event
imports entity-pages/Issue
imports entity-pages/IssueClose
imports entity-pages/IssueGhost
imports entity-pages/IssueMoved
imports entity-pages/IssueReopen
imports entity-pages/Project
imports entity-pages/Release
imports entity-pages/Tag
imports entity-pages/TagAddition
imports entity-pages/TagRemoval
imports entity-pages/User
page showEntities ( )
{
title {
  "Entities"
}
  group("Entities"){par {
                      navigate
                      showEntityAttachment()
                      [
                      ]
                      {
                      "Attachment"
                      }
                    } par {
                        navigate
                        showEntityComment()
                        [
                        ]
                        {
                        "Comment"
                        }
                      } par {
                          navigate
                          showEntityEvent()
                          [
                          ]
                          {
                          "Event"
                          }
                        } par {
                            navigate
                            showEntityIssue()
                            [
                            ]
                            {
                            "Issue"
                            }
                          } par {
                              navigate
                              showEntityIssueClose()
                              [
                              ]
                              {
                              "IssueClose"
                              }
                            } par {
                                navigate
                                showEntityIssueGhost()
                                [
                                ]
                                {
                                "IssueGhost"
                                }
                              } par {
                                  navigate
                                  showEntityIssueMoved()
                                  [
                                  ]
                                  {
                                  "IssueMoved"
                                  }
                                } par {
                                    navigate
                                    showEntityIssueReopen()
                                    [
                                    ]
                                    {
                                    "IssueReopen"
                                    }
                                  } par {
                                      navigate
                                      showEntityProject()
                                      [
                                      ]
                                      {
                                      "Project"
                                      }
                                    } par {
                                        navigate
                                        showEntityRelease()
                                        [
                                        ]
                                        {
                                        "Release"
                                        }
                                      } par {
                                          navigate
                                          showEntityTag()
                                          [
                                          ]
                                          {
                                          "Tag"
                                          }
                                        } par {
                                            navigate
                                            showEntityTagAddition()
                                            [
                                            ]
                                            {
                                            "TagAddition"
                                            }
                                          } par {
                                              navigate
                                              showEntityTagRemoval()
                                              [
                                              ]
                                              {
                                              "TagRemoval"
                                              }
                                            } par {
                                                navigate
                                                showEntityUser()
                                                [
                                                ]
                                                {
                                                "User"
                                                }
                                              }}
}