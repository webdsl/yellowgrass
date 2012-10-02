module webservices/related-entities/Tag
extend entity Tag {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.project != null )
    {
      set.add(this.project);
    }
    if ( this.tags != null )
    {
      set.addAll(this.tags);
    }
    return set;
  }
}