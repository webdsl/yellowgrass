module webservices/related-entities/Issue
extend entity Issue {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.project != null )
    {
      set.add(this.project);
    }
    if ( this.reporter != null )
    {
      set.add(this.reporter);
    }
    if ( this.log != null )
    {
      set.addAll(this.log);
    }
    if ( this.tags != null )
    {
      set.addAll(this.tags);
    }
    if ( this.attachments != null )
    {
      set.addAll(this.attachments);
    }
    return set;
  }
}