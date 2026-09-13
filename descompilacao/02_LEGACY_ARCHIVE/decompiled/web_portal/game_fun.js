
// loading event
$(function (){
    //console.log(" JQuery Page automatically loads is carried out ....");
		
	//console.log("getRequest " + getRequest());	
		
		
	// end 	
 });

function getRequest() {
	var url = location.search; //获取url中"?"符后的字串
	return url;
	var theRequest = new Object();
	if (url.indexOf("?") != -1) {
		var str = url.substr(1);	
		strs = str.split("&");
		for(var i = 0; i < strs.length; i ++) {
			theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
		}
	}
	return theRequest;
} 

// exit events
// window.onunload = onunload_handler;
// window.onbeforeunload = onbeforeunload_handler;

// 	资源是否加载完成
var loadFinish = 0;
function load_finish(){
   loadFinish = 1;
}

// exit events
function onbeforeunload_handler(){
	var browser = navigator.appName;
	var closeInfo;
	if(loadFinish){
		try{
			var swf;
			if(navigator.appName.indexOf("Microsoft") != -1){
				swf = window['loading'];
			}else{
				swf = document['loading'];
			}
			if(swf){
				closeInfo = swf.getWindowCloseData();
			}
			if(!closeInfo){
				closeInfo =  $language.closeInfo;
			}
		}catch(e){
			closeInfo = $language.closeInfo;
		}
		if(browser == "Netscape"){
			return closeInfo;
		}else{
			window.event.returnValue = closeInfo;
		}
	}else{
		closeInfo = $language.closeInfo;
		if(browser == "Netscape"){
			return closeInfo;
		}else{
			window.event.returnValue = closeInfo;
		}
	}
}

function onunload_handler(){ 
	console.log("谢谢光临 ....." );
    //var warning="谢谢光临";     
    //alert(warning); 
	//AddFavorite();   
}     


// 自定义flash尺寸
/* var resizeTimer = null; 
$(window).resize(function() {
		
	if(resizeTimer == null) {
			
		resizeTimer = 0;	
			
		setTimeout("changeHeight()",30); 	
			
	}	
});  */

function changeHeight()
{
    var screenWidth = $(this).width();
	var screenHeight = $(this).height();	
		
    if(screenWidth > 1250){
        screenWidth = 1250;
    }else if(screenWidth <= 1100){
        screenWidth = 1100;
    }
		
    if(screenHeight > 650){
        screenHeight = 650;
    }else if(screenHeight < 600){
        screenHeight = 600;
    }
		
	//console.log("JQuery width : " + screenWidth );
	//console.log("JQuery height : " + screenHeight );		
		
	$("#loading").width(screenWidth);	
	$("#loading").height(screenHeight);	
		
    resizeTimer=null ;
}

/* 
*	flash loading sucess callbck
 */
function callbackFunc() {
	//console.log("flash callbackFunc ....." );
} 

/* 
*	收藏事件
 */
function AddFavorite() {
	try {
		window.external.addFavorite(app.url, app.title);
	}catch (e) {
		try {
			window.sidebar.addPanel(app.title, app.url, "");
		}catch (err) {
			//alert("加入收藏失败，请使用Ctrl+D进行添加");
			alert($language.closeInfo); 
			//trace("Error name: " + err.name + "");
			//trace("Error message: " + err.message); */
		}
	}
}

//保存快捷方式
function collectGame(){
	//var warning="收藏《龙将》到收藏夹，以便下次登录游戏"; 
	var warning = $language.collectGame;
	return "shortcut.php" + "?filename=" + agents().webTitle + "&URL=" + agents().loginWebSite ;
}

/* 
*	异步请求
 */
function app_ajax(url,params,dataType,callback,async) {
	$.ajax({
		type:"POST",
		url:url,
		async:async, //异步请求
		data:jQuery.extend({}, params),
		dataType:dataType?dataType:'html',
		success:callback,
		error:function(errobj) {
			var errmsg = '!!!<ERROR> error code: ' + errobj.error + '; error description: ' + errobj.error_message;
			trace(errmsg);
		}
	});
}
	
function reloadgame()
{
	location.reload();
}

/* 
*	输出信息
 */
function trace(str){
	if(typeof(console)!="undefined" && console.log){
		console.log(str);
	}
}

/* 
*	JS调用AS方法
*	
*	@params	data 		{}
*	@params	callback 	函数名称
*	
 */
function callExternal(data,callback) {
		
	console.log("callExternal : " + data + "  callback : " + callback);	
		
}

/* 
*	AS调用JS的方法
*
*	@params	data 		{}
*	@params	callback 	函数名称
*
 */
function external(data,callback) {
		
	console.log("external : " + data + "  callback : " + callback);		
		
}


