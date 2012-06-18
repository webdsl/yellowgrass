module entity-pages
imports entity-pages/Issue
page showEntities ( )
{
title {
  "Entities"
}
  group("Entities"){navigate showEntityIssue() [ ] { "Issue" }}
}