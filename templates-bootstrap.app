module templates-bootstrap

imports elib/elib-utils/lib
imports elib/elib-bootstrap/lib
imports elib/elib-tablesorter/lib

override attributes submitlink{ submit attributes }

  define mainResponsiveStyle() {
  	includeCSS("tags.css?1")
    includeCSS("bootstrap/css/bootstrap.min.css?2") 
    includeCSS("bootstrap/css/bootstrap-adapt.css?1")
    includeCSS("yellowgrass.css?2")
    includeJS(IncludePaths.jQueryJS())
    includeJS("bootstrap/js/bootstrap.min.js?1")
    tooltipsBS
    // includeHead("<meta name='viewport' content='width=device-width, initial-scale=1.0'>")   
    //includeHead(rendertemplate(rssLink()))
    //includeHead(rendertemplate(analytics))
    //includeHead(rendertemplate(bitterfont))
    //<link href="http://fonts.googleapis.com/css?family=Bitter" rel="stylesheet" type="text/css">
	div[class="frame"]{
		elements
	}
  }
  
  override template brand() { 
    navigate root() [class="navbar-brand"]{ "YellowGrass" }
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
      ygnavbar{  
        navItems{
          aboutMenu
        }
        pullRight{ signInOut } 
      }
      gridContainer[id="content"]{  
        messages
        elements 
      }
      ygfooter
    }
    //analytics
  }
  
  define mainResponsive(p: Project) { 
    mainResponsiveStyle{ 
      ygnavbar{ 
        navItems{
          aboutMenu
        }
        pullRight{ signInOut } 
      }
      gridContainer[id="content"]{  
        messages
        elements 
      }
      ygfooter
    }
    //analytics
  }
  
  template ygnavbar() {
    div[class="navbar navbar-default navbar-fixed-top", style="background-color: #CFD67E !important;"]{
      gridContainer{
        div[class="navbar-header"]{
        	brand
        	navCollapseButton
        }
        div[class="navbar-collapse collapse", style="height: 0px;"]{
          elements
        }
      }
    }
  }
  
  template ygfooter() {
    footer{
      gridContainer[id="content"]{     
        gridRow{ 
          gridCol(12){
            "YellowGrass.org - the tag-based issue tracker"
          }
        }
      }
    }
  }
  
  template progressBar(now : Int, max : Int){
	var percent := if(max == 0) 0 else (now * 100) / max;
	<div class="progress progress-striped">
	  <div class="progress-bar" role="progressbar" aria-valuenow=""+now aria-valuemin="0" aria-valuemax=""+max style="width: "+ percent + "%;">
	    elements
	  </div>
	</div>
  }