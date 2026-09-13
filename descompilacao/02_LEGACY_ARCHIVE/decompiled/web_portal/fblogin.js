window.fbAsyncInit = function() {
    FB.init({
        // edit by liujx 修改fb appId 533851910126096 start:
        appId      : '270563740131808',
        // appId      : '533851910126096',
        // end;
        cookie     : true,  // enable cookies to allow the server to access
                                                // the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v3.2' // use version 2.1
    });
}
function fblogin(referer,params){
    //console.log(window.location);
  if (window.location.protocol == 'http:') {
    window.location.href = window.location.href.replace('http','https');
    return;
  }
    FB.login(function(response) {
        if(response.authResponse){
            //ajax请求后台/user/facebookv2?accessToken=response.authResponse.accessToken
            $.ajax({
                url:'/user/facebookv2?accessToken='+response.authResponse.accessToken+"&"+params,
                type:'post',
                dataType:"json",
                success:function(data){
                    console.log(data);
                    if(data.error_code && data.error_code==1){
                        //window.location="";
                    }else{
                        if(referer){
                            window.location.href=referer;
                        }else{
                            if(window.location.pathname == '/user/login'){
                                window.location.href = "https://"+window.location.host;
                            }else{
                                // window.location.reload();
                              window.location.href = "https://"+window.location.host;

                            }
                        }
                    }
                },
                error:function(data1){
                    console.log(data1);
                }
            });
        }else{
            console.log(response);
        }
    }, {scope: 'public_profile,email'});
}
// Load the SDK asynchronously
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
