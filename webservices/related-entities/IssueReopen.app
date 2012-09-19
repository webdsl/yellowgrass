module webservices/related-entities/IssueReopen
extend entity IssueReopen {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.actor);
    return set;
  }
}