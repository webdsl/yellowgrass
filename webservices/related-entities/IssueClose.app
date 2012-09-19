module webservices/related-entities/IssueClose
extend entity IssueClose {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.actor);
    return set;
  }
}