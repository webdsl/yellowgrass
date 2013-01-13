module questions/question-ac

imports questions/question-model 

access control rules

  rule page questions(p: Project) {
    true
  }
  
  rule page question(p: Project, number: Int) {
    true
  }

  rule page newQuestion(p: Project) {
    true
  }

 
 