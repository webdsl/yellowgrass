module templates-bootstrap

imports elib/lib 

  define mainResponsiveStyle() {    
    includeCSS("bootstrap/css/bootstrap.css") 
    includeCSS("bootstrap/css/bootstrap-responsive.css")   
    includeCSS("bootstrap/css/bootstrap-adapt.css")
    includeCSS("bootstrap-extension.css")
    includeJS(IncludePaths.jQueryJS())
    includeJS("bootstrap/js/bootstrap.js")
    includeHead("<meta name='viewport' content='width=device-width, initial-scale=1.0'>")   
    //includeHead(rendertemplate(rssLink()))
    //includeHead(rendertemplate(analytics))
    //includeHead(rendertemplate(bitterfont))
    //<link href="http://fonts.googleapis.com/css?family=Bitter" rel="stylesheet" type="text/css">
    elements
  }
  
  override template brand() { 
    navigate root() [class="brand"]{ "YellowGrass" }
  }
  
  template aboutMenu() {
    dropdownInNavbar("About"){ 
      dropdownMenu{              
        dropdownMenuItem{ navigate about() { "About YellowGrass" } }
        dropdownMenuItem{ navigate features() { "Features" } }
        dropdownMenuItem{ navigate tagManual() { "Tag Manual" } }
        dropdownMenuDivider
        dropdownMenuItem{
          navigate projectList() { "Browse Public Projects"}
        }
      }
    }    
  }
  
  template mainResponsive() { 
    mainResponsiveStyle{ 
      navbarResponsive{  
        navItems{
          aboutMenu
        }
        pullRight{ signInOut } 
      }
      gridContainer{  
        messages
        elements 
      }
      ygfooter
    }
    //analytics
  }
  
  define mainResponsive(p: Project) { 
    mainResponsiveStyle{ 
      navbarResponsive{ 
        navItems{
          aboutMenu
        }
        pullRight{ signInOut } 
      }
      gridContainer{  
        messages
        elements 
      }
      ygfooter
    }
    //analytics
  }
  
  template ygfooter() {
    footer{
      gridContainer{     
        gridRow{ 
          gridSpan(12){
            "YellowGrass.org - for all your project management"
          }
        }
      }
    }
  }
  