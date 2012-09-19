module webservices/related-entities/Attachment
extend entity Attachment {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    return set;
  }
}