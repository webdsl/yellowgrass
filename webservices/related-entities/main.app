module webservices/related-entities/main
imports webservices/related-entities/Attachment
imports webservices/related-entities/Comment
imports webservices/related-entities/Event
imports webservices/related-entities/Issue
imports webservices/related-entities/IssueClose
imports webservices/related-entities/IssueGhost
imports webservices/related-entities/IssueMoved
imports webservices/related-entities/IssueReopen
imports webservices/related-entities/Project
imports webservices/related-entities/Tag
imports webservices/related-entities/TagAddition
imports webservices/related-entities/TagRemoval
imports webservices/related-entities/User
function getSetWhereNotSeen ( set : Set<Entity> , seen : Set<UUID> , add : Set<Entity> ) : Set<Entity>
{
  var newset := Set<Entity>() ;
  for ( ent : Entity in add )
    {
      var inSeen := ent.id in seen ;
      if ( ! inSeen )
      {
        newset.add(ent);
        seen.add(ent.id);
      }
    }
  return newset;
}
function getRelatedEntities ( ent : Entity ) : Set<Entity>
{
  var type := ent.getTypeString() ;
  if ( type == "User" )
  {
    return ( ent as User ).getRelatedEntities();
  }
  if ( type == "TagRemoval" )
  {
    return ( ent as TagRemoval ).getRelatedEntities();
  }
  if ( type == "TagAddition" )
  {
    return ( ent as TagAddition ).getRelatedEntities();
  }
  if ( type == "Tag" )
  {
    return ( ent as Tag ).getRelatedEntities();
  }
  if ( type == "Project" )
  {
    return ( ent as Project ).getRelatedEntities();
  }
  if ( type == "IssueReopen" )
  {
    return ( ent as IssueReopen ).getRelatedEntities();
  }
  if ( type == "IssueMoved" )
  {
    return ( ent as IssueMoved ).getRelatedEntities();
  }
  if ( type == "IssueGhost" )
  {
    return ( ent as IssueGhost ).getRelatedEntities();
  }
  if ( type == "IssueClose" )
  {
    return ( ent as IssueClose ).getRelatedEntities();
  }
  if ( type == "Issue" )
  {
    return ( ent as Issue ).getRelatedEntities();
  }
  if ( type == "Event" )
  {
    return ( ent as Event ).getRelatedEntities();
  }
  if ( type == "Comment" )
  {
    return ( ent as Comment ).getRelatedEntities();
  }
  if ( type == "Attachment" )
  {
    return ( ent as Attachment ).getRelatedEntities();
  }
  return Set<Entity>();
}
function getAllUserForProject ( tl : Project ) : Set<User>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<User>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "User" )
            {
              found.add(( ent as User ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllTagRemovalForProject ( tl : Project ) : Set<TagRemoval>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<TagRemoval>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "TagRemoval" )
            {
              found.add(( ent as TagRemoval ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllTagAdditionForProject ( tl : Project ) : Set<TagAddition>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<TagAddition>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "TagAddition" )
            {
              found.add(( ent as TagAddition ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllTagForProject ( tl : Project ) : Set<Tag>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<Tag>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "Tag" )
            {
              found.add(( ent as Tag ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllProjectForProject ( tl : Project ) : Set<Project>
{
  return {tl};
}
function getAllIssueReopenForProject ( tl : Project ) : Set<IssueReopen>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<IssueReopen>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "IssueReopen" )
            {
              found.add(( ent as IssueReopen ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllIssueMovedForProject ( tl : Project ) : Set<IssueMoved>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<IssueMoved>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "IssueMoved" )
            {
              found.add(( ent as IssueMoved ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllIssueGhostForProject ( tl : Project ) : Set<IssueGhost>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<IssueGhost>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "IssueGhost" )
            {
              found.add(( ent as IssueGhost ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllIssueCloseForProject ( tl : Project ) : Set<IssueClose>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<IssueClose>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "IssueClose" )
            {
              found.add(( ent as IssueClose ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllIssueForProject ( tl : Project ) : Set<Issue>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<Issue>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "Issue" )
            {
              found.add(( ent as Issue ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllEventForProject ( tl : Project ) : Set<Event>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<Event>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "Event" )
            {
              found.add(( ent as Event ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllCommentForProject ( tl : Project ) : Set<Comment>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<Comment>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "Comment" )
            {
              found.add(( ent as Comment ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}
function getAllAttachmentForProject ( tl : Project ) : Set<Attachment>
{
  var todo := Set<Entity>() ;
  var seen := Set<UUID>() ;
  var found := Set<Attachment>() ;
  todo.addAll(getSetWhereNotSeen(todo, seen, tl.getRelatedEntities()));
  while ( todo.length > 0 )
    {
      var newTodo := Set<Entity>() ;
      for ( ent : Entity in todo where ent != null )
        {
          var type := ent.getTypeString() ;
          var isToplevel := type == "Project" ;
          if ( ! isToplevel )
          {
            if ( type == "Attachment" )
            {
              found.add(( ent as Attachment ));
            }
            newTodo.addAll(getSetWhereNotSeen(todo, seen, getRelatedEntities(ent)));
          }
        }
      todo := newTodo;
    }
  return found;
}