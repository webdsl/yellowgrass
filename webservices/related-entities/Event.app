module webservices/related-entities/Event
extend entity Event {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    return set;
  }
}