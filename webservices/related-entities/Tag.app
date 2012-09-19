module webservices/related-entities/Tag
extend entity Tag {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.project);
    set.addAll(this.tags);
    return set;
  }
}