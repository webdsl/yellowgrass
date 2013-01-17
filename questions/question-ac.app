module questions/question-ac

imports questions/question-model 
  
  extend entity Question {
    
    function mayView(): Bool {
      return mayAccess(project);
    }
    
    function mayEdit(): Bool {
      return principal() in project.members || 
             (loggedIn() && principal() == author);
    }
    
  }
  
  extend entity Answer {
    
    function mayView(): Bool {
      return mayAccess(question.project);
    } 
    
    function mayEdit(): Bool {
      return principal() in question.project.members || 
             (loggedIn() && principal() == author);
    }
    
  }

access control rules

  rule page questions(p: Project) {
    mayAccess(p)
  }
  
  rule page question(p: Project, number: Int) {
    mayAccess(p)
  }

  rule page newQuestion(p: Project) {
    mayAccess(p) && loggedIn
  } 

  // rule page editQuestion(q: Question) {
  //   q.mayEdit()
  // } 
  
  rule template answerQuestion(q: Question) { 
    loggedIn
  }
  
