module webservices/related-entities/TagAddition
extend entity TagAddition {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.actor);
    set.add(this.tag);
    return set;
  }
}