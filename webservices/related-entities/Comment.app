module webservices/related-entities/Comment
extend entity Comment {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.author);
    return set;
  }
}