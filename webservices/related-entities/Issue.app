module webservices/related-entities/Issue
extend entity Issue {
  function getRelatedEntities ( ) : Set<Entity>
  {
    var set := Set<Entity>() ;
    set.add(this.project);
    set.add(this.reporter);
    set.addAll(this.log);
    set.addAll(this.tags);
    set.addAll(this.attachments);
    return set;
  }
}