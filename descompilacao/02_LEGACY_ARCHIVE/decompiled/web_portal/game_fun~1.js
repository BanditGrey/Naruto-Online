
// loading event
$(function (){
    //console.log(" JQuery Page automatically loads is carried out ....");
		
	//console.log("getRequest " + getRequest());	
	//changeHeight();	
		
	// end 	
 });
 
var screenWidth,screenHeight; 
var minSize = { width: 1100, height: 600 },maxSize = { width: 1250, height: 650 };
function changeHeight() {
			
    screenWidth = window.innerWidth|| document.documentElement.clientWidth|| document.body.clientWidth;
    screenHeight = window.innerHeight|| document.documentElement.clientHeight|| document.body.clientHeight;
		
    if(screenWidth >= maxSize.width){
        screenWidth = maxSize.width;
    }else{
		if(screenWidth<=minSize.width){
			screenWidth = minSize.width;	
		} 
	}
		
    if(screenHeight >= maxSize.height){
        screenHeight = maxSize.height;
    }else{
		if(screenHeight < minSize.height){
			screenHeight = minSize.height;
		}
	}
	console.log("setWidth: " + screenWidth + ", setHeight: " + screenHeight);	
		
	$("#loading").width(screenWidth);	
	$("#loading").height(screenHeight);	
		
}   
$(window).resize( function(){
	changeHeight();	
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
//window.onunload = onunload_handler;
//window.onbeforeunload = onbeforeunload_handler;

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
			alert($language.errAlertMsg); 
		}
	}
}

//保存快捷方式
function collectGame(){
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




