module webservices/related-entities/Project
extend entity Project {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    if ( this.test13 != null )
    {
      set.addAll(this.test13);
    }
    if ( this.test12 != null )
    {
      set.add(this.test12);
    }
    if ( this.issues != null )
    {
      set.addAll(this.issues);
    }
    if ( this.members != null )
    {
      set.addAll(this.members);
    }
    if ( this.memberRequests != null )
    {
      set.addAll(this.memberRequests);
    }
    if ( this.followers != null )
    {
      set.addAll(this.followers);
    }
    return set;
  }
}