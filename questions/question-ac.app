module questions/question-ac

imports questions/question-model 

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

  rule page editQuestion(q: Question) {
    principal in q.project.members || 
    (loggedIn && principal == q.author)
  } 
  
  rule template answerQuestion(q: Question) { 
    loggedIn
  } 