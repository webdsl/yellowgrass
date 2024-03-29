module user/user

imports user/user-model
imports user/ac
imports user/home
imports user/register
imports user/access
imports user/gcaptcha

section user page

  page user(usertag : String) {
    var u : User := getUser(usertag)
    var reportedIssues : List<Issue> := u.reportedIssues();
    var projects : List<Project> := u.projects();
   
    action proxy(usr : User){
      usr.proxy();
    }
    
    action abandonUser(){
      abandonUser( u, true, true );
      return user(u.tag);
    }
   
    title{output(u.name) " on YellowGrass.org" }
    bmain{
      pageHeader2 {
        output(u.name)
        " " submit proxy(u){ "Proxy" }
      }
      
      if(isAdministrator()){
        warnAction(
          "spam account - abandon user (dialog)",
          "This action is destructive and will remove most traces from a spam account, it will:  \n\n- rename the user to 'deleteduser%timestamp%'  \n- change its password, email and homepage  \n- logout all sessions\n  - make own projects private  \n\n- delete comment texts.  \n\nDo you want to abandon this user?"
          , false
        )[class="pull-right small"]{
          submit abandonUser(){
            "Yesj, abandon user"
          }
        }
      }
      
      if(u.url != null && u.url != "") {
        par { "Home Page: " output(u.url) }
      }
      if(projects.length > 0) {
        pageHeader2{ "Projects" }
        projects(projects)
      }
      pageHeader3{ "Recently Reported Issues" }
      par { issues(reportedIssues.set(), true, true, true, 50, true, true) }
    }
  }
  
  template nav(u: User) {
    navigate user(u.tag) { output(u.name) } 
  }

  template users(us : Set<User>) {
    for(u : User in us) {
      navigate user(u.tag) { output(u.name) }
    } separated-by { ", " }
  }
  
section edit user profile

  page editUser(u : User) {
    title{output(u.name) " on YellowGrass.org [Editing]"}  
    action save(){
      u.save();
      return home();
    }
    bmain{
      buttonToolbar{ homeToolbar(u) }       
      pageHeader2{ "Edit Profile" }
      horizontalForm {
        controlGroup("Name") { input(u.name) }
        controlGroup("Email") { input(u.email)}
        controlGroup("Receive notifications on issue changes via email?") { input(u.notifications) }
        controlGroup("Home Page") { input(u.url)}
        formActions{
          submitlink save() [ignore default class, class="btn btn-primary"]{ "Save" } " "
          navigate home() [submit attributes] { "Cancel" }
        }
      }
    }
  }

  page manageDevices(u : User) {
    title{output(u.name) " on YellowGrass.org [Editing]"}
    bmain{
      buttonToolbar{ homeToolbar(u) } 
      pageHeader2{ "Manage Devices" }
      form {
        par {
          block [class := "Listing"] {
            table {
              row {
                column{ <b> "Device Description" </b> }
                column{ <b> "Key" </b> }
                column{ empty() }
              }
              for(device : AuthenticationKey in u.deviceKeySet ) {
                row { 
                  column{ output(device.deviceDescription) } 
                  column{ output(device.id) }
                  column{ submit action{u.deviceKeySet.remove(device);} { "x" } }
                }
              }              
            }
          }
        }
      }
    }
    action save(){
      message("Profile saved");
      return home();
    }
  }
