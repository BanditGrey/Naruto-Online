
var $dp = new Object();
$dp.lang = 'zh-cn';		// setting language version

var isdebug =  true;	// open debug

var langList = 
[
	{name:'en',	charset:'UTF-8'},
	{name:'zh-cn',	charset:'UTF-8'},
	{name:'zh-tw',	charset:'UTF-8'}
];

$dp.getLangIndex = function(name){
	var arr = langList;
	for (var i = 0; i < arr.length; i++) {
		if (arr[i].name == name) {
			return i;
		}
	}
	return -1;
}

$dp.getLang = function(name){
	var index = $dp.getLangIndex(name);
	if (index == -1) {
		index = 0;
	}
	return langList[index];
}

$dp.realLang = $dp.getLang($dp.lang);	//langList[0];	


//console.log( $dp.realLang );

document.write("<script src='./Public/script/lang/" + $dp.realLang.name + ".js' charset='" + $dp.realLangcharset + "'><\/script>");





//var resourceObj = new Object();
/**
var tipsObj = new Object();
tipsObj.initGame = "游戏初始化";
tipsObj.fullScreen = "按F11可进入全屏游戏模式，全屏游戏体验更好";
tipsObj.startGame = "即将开始旅程";
tipsObj.comuModule = "通讯模块";
tipsObj.creatModule = "创建角色模块";
tipsObj.mainModule = "主程序";
tipsObj.init = "初始化";
*/ 