module webservices/related-entities/TagAddition
extend entity TagAddition {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.actor != null )
    {
      set.add(this.actor);
    }
    if ( this.tag != null )
    {
      set.add(this.tag);
    }
    return set;
  }
}