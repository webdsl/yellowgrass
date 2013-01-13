module questions/question-view

imports questions/question-model
imports questions/question-ac
 
sections questions

  page questions(p: Project) {
    bmain(p) {
      pageHeader{ "Questions about " output(p.name) }
      list{
        for(q: Question in p.questions) {
          listitem{ 
            navigate question(p, q.number) { output(q.title) }
          }
        }
      }
      navigate newQuestion(p) [class="btn"] { iPlus " New Question"}
    }
  }

section question page

  page question(p: Project, number: Int) {
    var question := p.getQuestion(number);
    bmain(p) {
      pageHeader2{ output(question.title) }
      blockquote{ output(question.description) }
      for(a: Answer in question.answers order by a.created asc) {
        blockquote{ 
          output(a.text) 
          par{ 
            "By " output(a.answeredBy)
            "on" output(a.created)
          }
        }
      }
      answerQuestion(question)
    }
  }
  
  page newQuestion(p: Project) {
    var q := Question{ };
    action save() { 
      q.number := p.newQuestionNumber();
      q.project := p;
      q.save(); 
      return question(p, q.number);
    } 
    bmain(p) {
      pageHeader{ "Ask Question about " output(p.name) }
      horizontalForm{ 
        controlGroup("Title") { input(q.title)[class="span8"] }
        controlGroup("Description") { input(q.description) }
        formActions{
          submitlink save() [class="btn btn-primary"]{ "Post" } " "
          navigate project(p) [class="btn"] { "Cancel" }
        }
      }
    }
  }
  
section answering questions

  template answerQuestion(q: Question) {
    var a := Answer{}
    action save() {
      a.answeredBy := securityContext.principal;
      q.answers.add(a);
    } 
    horizontalForm{
      input(a.text) [placeholder="Answer"]
      formActions{
        submitlink save() [class="btn btn-primary"] { "Save" }
      }
    }
  }
  
  