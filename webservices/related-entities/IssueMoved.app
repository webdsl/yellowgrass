module webservices/related-entities/IssueMoved
extend entity IssueMoved {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.actor);
    set.add(this.target);
    return set;
  }
}