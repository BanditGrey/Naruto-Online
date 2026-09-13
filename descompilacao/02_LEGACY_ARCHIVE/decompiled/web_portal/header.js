(function($) {
$.extend({
urlGet:function()
{
    var aQuery = window.location.href.split("?");  //取得Get参数
    if(aQuery.length==3){
        aQuery[1] = aQuery[1]+"?"+aQuery[2];
    }
    console.log(aQuery);
    var aGET = new Array();
    if(aQuery.length > 1)
    {
        var aBuf = aQuery[1].split("&");
        for(var i=0, iLoop = aBuf.length; i<iLoop; i++)
        {
            var aTmp = aBuf[i].split("=");  //分离key与Value
            aGET[aTmp[0]] = aTmp[1];
            if(aTmp.length>2){
                aGET[aTmp[0]] = aTmp[1]+"="+aTmp[2];
            }
        }
     }
     return aGET;
 }
})
})(jQuery);
var GET = $.urlGet(); //获取URL的Get参数
var referer = GET['referer']; //取得id的值
//console.log(referer);
function headerLogin(){
    var email = $('#email').val();
    var password = $('#password').val();
    if($("#remember").attr("checked")=="checked"){
        var remember = 1;
    }else{
        var remember = 0;
    }
    $.ajax({
      url:'/user/login',
      type:'post',
      data:{email:email,password:password,remember:remember},
      success:function(data){
           //alert(data);return;
           // eval('data='+data);
        var data = JSON.parse(data);

        if (data.error_code == 0){
                if(typeof(referer) != 'undefined' && referer != ""){
                    window.location.href = referer;
                }else{
                    if(window.location.pathname.substr(0,11) == "/user/login"){
                        window.location.href = "/";
                    }else{
                        window.location.reload();
                    }
                }
           }else{
               //alert('Password doesn\'t match.');
               alert(data.error_msg);
           }
      }
    });

}
function register(){

    var email = $('#registeremail').val();
    var password = $('#registerpassword').val();
    var repassword = $('#registerrepassword').val();
    if(password!=repassword){
        alert("The password is not same");
        //alert("Пароль не совпадает.");
        return;
    }
    $.ajax({
       url:'/user/register',
       data:{email:email,password:password},
       type:'post',
       success:function(data){
            //alert(data);return;
            // eval('data='+data);
         var data = JSON.parse(data);

         if (data.error_code==0){
                if(typeof(referer) != 'undefined' && referer != ""){
                    window.location.href = referer;
                }else{
                    if((window.location.pathname.substr(0,11) == "/user/login") || (window.location.pathname.substr(0,14) == "/user/register")){
                        window.location.href = "/";
                    }else{
                        window.location.reload();
                    }
                }
            }else{
                alert(data.error_msg);
            }
       }
     });

}
