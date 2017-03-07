// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var facebookSetup = function(){
  $.ajaxSetup({ cache: true });
    $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
      FB.init({
        appId: '1929445010619471',
        version: 'v2.7'
      });     
      FB.getLoginStatus(updateStatusCallback);
  })
};

var ajaxFacebookLogin = function(fbUID){
    var uID    = fbUID;
    var url    =  '/sessions' + "?&authenticity_token=" + encodeURIComponent(RAILS_AUTH_TOKEN);

    var method =  'POST';

    $.ajax({
      url: url,
      type: method,
      data: {id: uID},
      success: function() {
        $(".wrapper").append("<a href='/restaurants'>"+"----------->"+"</a>")
        console.log('Success!')
        },
      // error: function() {
      //   console.log('Error!');
      // }
    })
}

var updateStatusCallback = function(){
  var uID = FB.getUserID();
  // debugger
  console.log(uID);
  if(uID != ""){
    ajaxFacebookLogin(uID);
  }else{
    $('#login-button').removeClass('hidden')
    startLoginListener();
  }
};

var startLoginListener = function(){
  $('#login-button').on('click', function(){
    FB.login(function(response){
      if(response.authResponse){
        console.log('welcome in!');
        ajaxFacebookLogin(response.authResponse.userID);
      }else{
        console.log('sorry bad response');
      }
    });
  })
};
