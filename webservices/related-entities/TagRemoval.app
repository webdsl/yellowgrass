module webservices/related-entities/TagRemoval
extend entity TagRemoval {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.actor);
    set.add(this.tag);
    return set;
  }
}