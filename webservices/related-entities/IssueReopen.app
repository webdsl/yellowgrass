module webservices/related-entities/IssueReopen
extend entity IssueReopen {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.actor != null )
    {
      set.add(this.actor);
    }
    return set;
  }
}