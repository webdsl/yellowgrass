module user/gcaptcha

entity CaptchaKeyConfig {
  gcaptchaSite   : String (default="6LdY2L4UAAAAAOLcDURpETXuC7pl0WQLHdeHhbwP")  // requested through webdslorg@gmail.com
  gcaptchaSecret : String (default="") //set in DB
  cache
}

var captchaKeyConfig := CaptchaKeyConfig{}

template gcaptchaIncludes(optionalElemId : String){
  head{
    <script>
      var onloadCallback = function() { if('~optionalElemId'.length){ loadCaptcha('~optionalElemId'); } captchaInitialized = true};
    </script>
  }
  head{
    <script>
      function loadCaptcha(elemid){
        grecaptcha.render(elemid, {
          'sitekey' : '~(captchaKeyConfig.gcaptchaSite)'
        });
      }
      var captchaInitialized = false;
    </script>
    <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async=true defer=true></script>
  }
}

template gcaptcha(){
  gcaptchaIncludes(id)
  <div id=id class="g-recaptcha"></div>
  
  //In case of ajax replace of a form (e.g. validation errors), load a new captcha.  
  <script> if(captchaInitialized){ loadCaptcha('~id') }</script>
  
}

function checkCaptcha(): Bool {
  var response := getRequestParameter( "g-recaptcha-response" );
  var data := "secret=" + captchaKeyConfig.gcaptchaSecret + "&response=" + response + "remoteip=" + remoteAddress();
  var result := Verify.verify( response, remoteAddress(), captchaKeyConfig.gcaptchaSecret );
  var json := JSONObject( result );
  return json.getBoolean( "success" );
}

native class request.VerifyCaptcha as Verify{
  static verify( String, String, String ): String
}
