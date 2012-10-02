module webservices/related-entities/Comment
extend entity Comment {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.author != null )
    {
      set.add(this.author);
    }
    return set;
  }
}