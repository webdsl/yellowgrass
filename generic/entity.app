module generic/entity

imports comment/comment
imports issue/issue-model
imports questions/question-model

  function mayEdit(e: Entity): Bool {
    if(e is a Answer) { return (e as Answer).mayEdit(); }
    if(e is a Question) { return (e as Question).mayEdit(); }
    if(e is a Comment) { return (e as Comment).mayEdit(); }
    if(e is a Issue) { return (e as Issue).mayEdit(); }  
    return false;
  } 
    
  function mayView(e: Entity): Bool {
    if(e is a Answer) { return (e as Answer).mayView(); }
    if(e is a Question) { return (e as Question).mayView(); }
    if(e is a Comment) { return (e as Comment).mayView(); }
    if(e is a Issue) { return (e as Issue).mayView(); }
    return false;
  } 
   
  template byline(e: Entity) {
    if(e is a Answer) { byline(e as Answer) }
    if(e is a Question) { byline(e as Question) }  
    if(e is a Comment) { byline(e as Comment) }  
    if(e is a Issue) { byline(e as Issue) }   
  } 
  
