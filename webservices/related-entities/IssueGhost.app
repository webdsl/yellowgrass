module webservices/related-entities/IssueGhost
extend entity IssueGhost {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.project != null )
    {
      set.add(this.project);
    }
    if ( this.tags != null )
    {
      set.addAll(this.tags);
    }
    return set;
  }
}