// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks

 $(document).ready(function(){
    $("#menu1").click(function(){
        $(".menu_btn2").slideToggle();
    });

    $("#search-form").submit(function(event) {
              var msg = "";
              var error = "";
              var Search = document.getElementById('search').value;

              if (Search == "" || Search == null) {
                msg += "Please input a valid keyword.\n";
                event.preventDefault();
              }
              validateSpecialChars(Search);

              function validateSpecialChars(myStringID) {
                  var illegalChars = "!#$%^&*()+=-[]\\\;/{}|\"\':<>?";
                  var strToSearch = myStringID;

                  for (var i = 0; i < strToSearch.length; i++) {
                      if (illegalChars.indexOf(strToSearch.charAt(i)) != -1) {
                          error += "Please remove the special characters and try again.";
                          event.preventDefault();
                      }
                      return;
                  }
              }
              if (error != "") {
                  alert(error);
                  return false;
              } else if (msg != "") {
                  alert("Please correct the following:\n" + msg);
                  return false;
              }
    });

	$('ul.nav li.dropdown').hover(function() {
        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn();
    }, function() {
    	$(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut();
    });

    $(".youtube_list_div span").hide();
    $(".youtube_list_div").on('click',function(e){
          var url = $(this).find("span").text();
          window.frames[0].location = url;
    }); 
});