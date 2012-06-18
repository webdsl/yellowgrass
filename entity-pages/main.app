module entity-pages
imports entity-pages/Attachment
imports entity-pages/AuthenticationKey
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
imports entity-pages/VersionObject
page showEntities ( )
{
title {
  "Entities"
}
  group("Entities"){navigate showEntityAttachment() [ ] { "Attachment" } navigate showEntityAuthenticationKey() [ ] { "AuthenticationKey" } navigate showEntityComment() [ ] { "Comment" } navigate showEntityEvent() [ ] { "Event" } navigate showEntityIssue() [ ] { "Issue" } navigate showEntityIssueClose() [ ] { "IssueClose" } navigate showEntityIssueGhost() [ ] { "IssueGhost" } navigate showEntityIssueMoved() [ ] { "IssueMoved" } navigate showEntityIssueReopen() [ ] { "IssueReopen" } navigate showEntityProject() [ ] { "Project" } navigate showEntityRelease() [ ] { "Release" } navigate showEntityTag() [ ] { "Tag" } navigate showEntityTagAddition() [ ] { "TagAddition" } navigate showEntityTagRemoval() [ ] { "TagRemoval" } navigate showEntityUser() [ ] { "User" } navigate showEntityVersionObject() [ ] { "VersionObject" }}
}