module webservices/related-entities/IssueGhost
extend entity IssueGhost {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.project);
    set.addAll(this.tags);
    return set;
  }
}