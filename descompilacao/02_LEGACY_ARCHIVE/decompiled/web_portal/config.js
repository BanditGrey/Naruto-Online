
var $dp = new Object();
$dp.lang = 'eu-sp';		// setting language version

var isdebug =  true;	// open debug

var langList = 
[
	{name:'eu-sp',	charset:'UTF-8'}
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
