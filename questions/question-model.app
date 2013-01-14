module questions/question-model

imports project/project-model

section data model

  entity Question { 
    number      :: Int
    title       :: String
    urlTitle    :: String
    description :: WikiText
    project     -> Project (inverse=Project.questions)
    closed      :: Bool (default=false)
    askedBy     -> User
    
    tags        -> Set<Tag>
    answers     -> Set<Answer>
    
    search mapping{
      + number
      + title
      + description
        project
      + tags
      + askerName
      + comments
    }
  }
  
  extend entity Project { 
    questions -> Set<Question>

    function getQuestion(questionNumber : Int) : Question {
      var questionsWithNumber : List<Question> := 
        from Question as q
        where q.project = ~this and q.number = ~questionNumber
        limit 1;
   
      if(questionsWithNumber.length != 0) {
        return questionsWithNumber.get(0);
      } else {
        return null;
      }
    }

    function newQuestionNumber() : Int {
      var lastProjectQuestions : List<Question> := 
        from Question
        where project = ~this
        order by number desc
        limit 1;
      if(lastProjectQuestions.length == 0) {
        return 1;
      } else {
        return lastProjectQuestions[0].number + 1;
      }
    }
    
    function newQuestion(title: String, descrition: WikiText): Question {
      var q := Question {
        number := newQuestionNumber()
        project := this 
        title := title
        description := description 
        askedBy := securityContext.principal 
      }; 
      q.save();
      return q;
    }
  } 
  
section answers

  entity Answer {
    answeredBy -> User
    text       :: WikiText
  }
  