module webservices/related-entities/IssueClose
extend entity IssueClose {
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