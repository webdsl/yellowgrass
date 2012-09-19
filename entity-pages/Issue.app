module entity-pages/Issue
page showEntityIssue ( )
{
title {
  "Issue"
}
  header {
    "Issue"
  }
  group ( "Properties" ) {
    par {
      "number"
      " "
      "::"
      " "
      "Int"
    }
    par {
      "title"
      " "
      "::"
      " "
      "String"
    }
    par {
      "description"
      " "
      "::"
      " "
      "WikiText"
    }
    par {
      "submitted"
      " "
      "::"
      " "
      "DateTime"
    }
    par {
      "project"
      " "
      "->"
      " "
      navigate showEntityProject() [ ] { "Project" }
    }
    par {
      "reporter"
      " "
      "->"
      " "
      navigate showEntityUser() [ ] { "User" }
    }
    par {
      "open"
      " "
      "::"
      " "
      "Bool"
    }
    par {
      "log"
      " "
      "->"
      " "
      "Set<"
      navigate showEntityEvent() [ ] { "Event" }
      ">"
    }
    par {
      "tags"
      " "
      "->"
      " "
      "Set<"
      navigate showEntityTag() [ ] { "Tag" }
      ">"
    }
    par {
      "email"
      " "
      "::"
      " "
      "Email"
    }
    par {
      "nrVotes"
      " "
      "::"
      " "
      "Int"
    }
    par {
      "attachments"
      " "
      "->"
      " "
      "Set<"
      navigate showEntityAttachment() [ ] { "Attachment" }
      ">"
    }
    par {
      "projectName"
      " "
      "::"
      " "
      "String"
    }
    par {
      "reporterName"
      " "
      "::"
      " "
      "String"
    }
  }
  group ( "Functions" ) {
    par {
      "function getReporterName ("
      " ) : "
      "String"
    }
    par {
      "function test ("
      " ) : "
      "Void"
    }
    par {
      "function getComments ("
      " ) : "
      "Set<"
      navigate showEntityComment() [ ] { "Comment" }
      ">"
    }
    par {
      "function getTitle ("
      " ) : "
      "String"
    }
    par {
      "function close ("
      " ) : "
      "Void"
    }
    par {
      "function reopen ("
      " ) : "
      "Void"
    }
    par {
      "function notifyRegister ("
      " ) : "
      "Void"
    }
    par {
      "function notifyClose ("
      " ) : "
      "Void"
    }
    par {
      "function notifyReopen ("
      " ) : "
      "Void"
    }
    par {
      "function addComment ("
      "c : "
      navigate showEntityComment() [ ] { "Comment" }
      " ) : "
      "Void"
    }
    par {
      "function commentClose ("
      "c : "
      navigate showEntityComment() [ ] { "Comment" }
      " ) : "
      "Void"
    }
    par {
      "function isAssigned ("
      " ) : "
      "Bool"
    }
    par {
      "function assign ("
      " ) : "
      "Void"
    }
    par {
      "function toExtendedJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function mailinglist ("
      " ) : "
      "Set<Email>"
    }
    par {
      "function mailSubject ("
      " ) : "
      "String"
    }
    par {
      "function addTag ("
      "t : "
      navigate showEntityTag() [ ] { "Tag" }
      " ) : "
      "Void"
    }
    par {
      "function deleteTag ("
      "t : "
      navigate showEntityTag() [ ] { "Tag" }
      " ) : "
      "Void"
    }
    par {
      "function hasTag ("
      "tagName : "
      "String"
      " ) : "
      "Bool"
    }
    par {
      "function toMinimalJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function toJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function toSimpleJSON ("
      " ) : "
      "JSONObject"
    }
    par {
      "function getRelatedEntities ("
      " ) : "
      "Set<Entity>"
    }
  }
}