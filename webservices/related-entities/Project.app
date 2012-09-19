module webservices/related-entities/Project
extend entity Project {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.addAll(this.issues);
    set.addAll(this.members);
    set.addAll(this.memberRequests);
    set.addAll(this.followers);
    return set;
  }
}