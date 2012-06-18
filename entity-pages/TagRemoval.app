module entity-pages/TagRemoval
page showEntityTagRemoval ( )
{
title {
  "TagRemoval"
}
  header {
    "TagRemoval : "
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
                      } par {
                          "tag"
                          " "
                          "->"
                          " "
                          navigate
                          showEntityTag()
                          [
                          ]
                          {
                          "Tag"
                          }
                        }}
  group("Functions"){}
}