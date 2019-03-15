window.fbAsyncInit = function() {
  FB.init({
    appId      : '398594637619962',
    cookie     : true,
    xfbml      : true,
    version    : 'v3.2'
  });
  FB.AppEvents.logPageView();
  FB.getLoginStatus(function(response) {
    console.log(response);
    insertAccessToken(response);
    statusChangeCallback(response);
  });
};

(function(d, s, id){
 var js, fjs = d.getElementsByTagName(s)[0];
 if (d.getElementById(id)) {return;}
 js = d.createElement(s); js.id = id;
 js.src = "https://connect.facebook.net/en_US/sdk.js";
 fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function statusChangeCallback(response) {
  if(response.status === 'connected') {
    console.log("Dang nhap roi nhe!");
  }
  else {
    console.log("Deo dang nhap duoc!");
  }
}

function insertAccessToken(response){
  a = document.getElementsByClassName('access_token');
  for (var i = a.length - 1; i >= 0; i--) {
    a[i].value = response.authResponse.accessToken;
  }
}

function RequestLoginFB(){
  quyen = document.getElementById('quyen').value;
  FB.login(function(response) {
   console.log(response);
  }, {scope: quyen});
}
