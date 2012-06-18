module model/IssueGhost
entity IssueGhost {
  alive :: Bool
  tags -> Set<Tag>
  email :: Email ( validate ( email != null && email != "" , "Please enter an email address" ) )
  project -> Project
  description :: WikiText
  title :: String ( validate ( title.length() >= 5 , "Use a longer and more descriptive title" ) )
  function realize ( ) : Issue
  {
    var i := Issue{//number := newIssueNumber(this.project) random
                   title := this.title
                   description := this.description
                   submitted := now()
                   project := this.project
                   open := true
                   email := this.email
                   tags := this.tags
                   // reporter := securityContext.principal
                   } ;
    i.assign();
    i.save();
    alive := true;
    flush();
    i.notifyRegister();
    return i;
  }
  function tryRealize ( ) : Issue
  {
    if ( ! alive )
    {
      return realize();
    }
    else
    {
      return null;
    }
  }
}