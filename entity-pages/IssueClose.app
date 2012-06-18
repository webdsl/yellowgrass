module entity-pages/IssueClose
page showEntityIssueClose ( )
{
title {
  "IssueClose"
}
  header {
    "IssueClose : "
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
  group("Functions"){}
}