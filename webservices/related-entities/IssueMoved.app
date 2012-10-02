module webservices/related-entities/IssueMoved
extend entity IssueMoved {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.actor != null )
    {
      set.add(this.actor);
    }
    if ( this.target != null )
    {
      set.add(this.target);
    }
    return set;
  }
}