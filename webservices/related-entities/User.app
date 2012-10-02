module webservices/related-entities/User
extend entity User {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.projects != null )
    {
      set.addAll(this.projects);
    }
    return set;
  }
}