// dr.library.js
(function($){
	//dr.common.js
	/*
	*@name:dr()
	*@Based on jQuery library
	*/
	var dr;
	if (typeof window.dr === "undefined")	window.dr = {};
	dr = window.dr;

	dr.namespace = function(ns){
		if (!ns || !ns.length) { 
			return null; 
		}
		var nsHandle = dr;
		var levels = ns.split('.');
		var levelsLen = levels.length;
			for(var i=(levels[0]=='dr') ? 1 : 0; i<levelsLen; ++i){
				nsHandle[levels[i]] = nsHandle[levels[i]] || {};
				nsHandle = nsHandle[levels[i]];
				
			}//end for
		return nsHandle;
	};
	dr.namespace('ui');
	dr.namespace('proto');
	//dr.ui.js
	/*
	*@name:Validator
	*@usage:
		var $v = dr.ui.verify;
		
		var fm = $('.fm-layout');
		var fmReq = fm.find('.fm-req');
		fmReq.each(function(){
			var me = $(this);
			me.find(':input').bind('blur', function(){
				$v.init({
					o:$(this),
					remind:{o:me, className:['error','ok','remind'],errKey:'error'}
				});
			});
		});//end
		
		----OR----
		
		var fm = $(this);
		var fmReq = fm.find('.fm-req') ;
		var result = [];
	
		fmReq.each(function(idx){
			var me = $(this);
			result[idx] = $v.init({
				o:me.find(':input'),
				remind:{o:me, className:['error','ok','remind'],errKey:'error'}
			});
		});//end
		if( $.inArray(false,result)!=-1 ) return result[$.inArray(false,result)] ;
	*/
	var V = window.Validator = function(){};
	//验证规则
	/**
	* @method V.prototype.rule
	* @return true | false
	*/
	V.prototype.rule = function(){
		var arrT = {};
		arrT['Int'] = /^-?[1-9]\d*$/;
		arrT['Float'] = /^(-?\d*)\.?\d+$/;
		arrT['Number'] = /^\d+$/;
		arrT['Key'] = /^[A-Za-z][A-Za-z0-9]+$/;
		arrT['Email'] = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
		arrT['Url'] = /^[a-zA-z]+:\/\/(\w+(-\w+)*)(\.(\w+(-\w+)*))*(\?\S*)?$/;
		arrT['Phone'] = /^(0\d{2,3})?[ -\/]?\d{7,8}[ -\/]?\d*$/;
		arrT['AreaCode'] = /^0\d{2,3}$/;
		arrT['TelNo'] = /^\d{7,8}$/;
		arrT['ExtNo'] = /^\d+$/;
		arrT['Mobile'] = /^1[358]\d{9}$/;
		arrT['QQ'] = /^[1-9]\d{4,8}$/;
		arrT['Zip'] = /^\d{6}$/;
		arrT['Date'] = /^(([1-2]\d{3})|(\d{2}))(-|\/| )(0|1)?\d(-|\/| )[0-3]?\d$/;
		arrT['IP'] = /^(\d{1,3}\.){3}\d{1,3}$/;
		arrT['Chinese'] = /[\u4e00-\u9fa5]+/;
		arrT['Image'] = /^.*\.(jpg|png|jpeg|gif|bmp)$/;
		
		return {
			isInt: function(value){
				if(!arrT['Int'].test(value)){
					return false;
				}
				return true;
			},
			isFloat: function(value){
				if(!arrT['Float'].test(value)){
					return false;
				}
				return true;
			},
			isNumber: function(value){
				if(!arrT['Number'].test(value)){
					return false;
				}
				return true;
			},
			isKey: function(value){
				if(!arrT['Key'].test(value)){
					return false;
				}
				return true;
			},
			isPhone: function(value){
				if(!arrT['Phone'].test(value)){
					return false;
				}
				return true;
			},
			isAreaCode: function(value){
				if(!arrT['AreaCode'].test(value)){
					return false;
				}
				return true;
			},
			isTelNo: function(value){
				if(!arrT['TelNo'].test(value)){
					return false;
				}
				return true;
			},
			isExtNo: function(value){
				if(!arrT['ExtNo'].test(value)){
					return false;
				}
				return true;
			},
			isMobile: function(value){
				if(!arrT['Mobile'].test(value)){
					return false;
				}
				return true;
			},
			isUrl: function(value){
				if(!arrT['Url'].test(value)){
					return false;
				}
				return true;
			},
			isEmail: function(value){
				if(!arrT['Email'].test(value)){
					return false;
				}
				return true;
			},
			isQQ: function(value){
				if(!arrT['QQ'].test(value)){
					return false;
				}
				return true;
			},
			isZip: function(value){
				if(!arrT['Zip'].test(value)){
					return false;
				}
				return true;
			},
			isDate: function(value){
				if(!arrT['Date'].test(value)){
					return false;
				}
				return true;
			},
			isIP: function(value){
				if(!arrT['IP'].test(value)){
					return false;
				}
				return true;
			},
			isChinese: function(value){
				if(!arrT['Chinese'].test(value)){
					return false;
				}
				return true;
			},
			isImage: function(value){
				if(!arrT['Image'].test(value.toLowerCase())){
					return false;
				}
				return true;
			},
			isEmpty: function(value){
				value = value.replace( /^\s+|\s+$/g, "" );
				if(value && value.length>0){
					return false;
				}
				return true;
			},
			isEqual: function(value1,value2){
				if(value1 != value2){
					return false;
				}
				return true;
			},
			limit: function(value){
				var args = arguments;
				value = value.replace( /^\s+|\s+$/g, "" );
				var len = args.length;
				switch (len) {
					case 2:
						if (value.length != args[1]) {
							return false;
						}
						return true;
					case 3:
						if( args[1] > args[2] ){
							var t = args[1];
							args[1] = args[2];
							args[2] = t;
						}
						if (value.length > args[2] || value.length < args[1]) {
							return false;
						}
						return true;
					default:
						return false;
				}
			}
		}//end return
		
	};//end rule()
	//控件<===>规则 匹配
	//即使传入多个验证要求，也会被分解为单一条件进行逐个验证并返回
	V.prototype.ruleMatch = function(){
	/*
		className:{
			int:v-int,
			float:v-float,
			number:v-number,
			key:v-key,
			email:v-email,
			url:v-url,
			phone:v-phone,
			area-code:v-area-code,
			tel-no:v-tel-no,
			ext-no:v-ext-no,
			mobile:v-mobile,
			qq:v-qq,
			zip:v-zip,
			date:v-date,
			ip:v-ip,
			chinese:v-chinese,
			image:v-image,
			empty:v-empty,
			equal:v-equal-#id,
			limit:v-limit-min-max,
			checked:v-checked,
			checked:v-checked-index,
			selected:v-selected-not[value],
			relevancy:v-relevancy-#id
			custom:v-custom	//自定义规则
		}			
	*/
		var result = false;
		for(var i=0,l=this.className.length;i<l;i++){
			result = this.ruleSplit(this.className[i],this.o.val());
			this.setRemind(result);
			if(result){
				continue;
			}else{
				break;
			}
		}//end for
		return result ;
	};//end ruleMatch
	//规则分解
	V.prototype.ruleSplit = function(classRule,val){
		var classRule = classRule.split('-');

		switch(classRule[1]){
			case 'int':
				return this.rule().isInt(val);
			break;
			case 'float':
				return this.rule().isFloat(val);
			break;
			case 'number':
				return this.rule().isNumber(val);
			break;
			case 'key':
				return this.rule().isKey(val);
			break;
			case 'email':
				return this.rule().isEmail(val);
			break;
			case 'url':
				return this.rule().isUrl(val);
			break;
			case 'phone':
				return this.rule().isPhone(val);
			break;
			case 'areacode':
				return this.rule().isAreaCode(val);
			break;
			case 'telno':
				return this.rule().isTelNo(val);
			break;
			case 'subno':
				return this.rule().isSubNo(val);
			break;
			case 'mobile':
				return this.rule().isMobile(val);
			break;
			case 'qq':
				return this.rule().isQQ(val);
			break;
			case 'zip':
				return this.rule().isZip(val);
			break;
			case 'date':
				return this.rule().isDate(val);
			break;
			case 'ip':
				return this.rule().isIP(val);
			break;
			case 'chinese':
				return this.rule().isChinese(val);
			break;
			case 'image':
				return this.rule().isImage(val);
			break;
			case 'empty':
				return !this.rule().isEmpty(val);
			break;
			case 'equal':
				return this.rule().isEqual( val, $(classRule[2]).val() );
			break;
			case 'limit':
				if(classRule.length > 3){
					return this.rule().limit( val, parseInt(classRule[2]), parseInt(classRule[3]) );
				}else{
					return this.rule().limit( val, parseInt(classRule[2]) );
				}
			break;
			case 'relevancy' :
				return !this.rule().isEmpty( $(classRule[2]).val() );
			break;
			case 'selected' :
				if( val == classRule[2]){
					return false;	
				}else{
					return true;	
				}
			break;
			case 'checked' :
				var type = (this.o).attr('type').toLowerCase();
				if(classRule.length > 2){
					if( (this.remind.o).find(':'+type).eq(classRule[2]).is(':checked') ){
						return true;
					}else{
						return false;
					}
				}else{
					if( (this.remind.o).find(':'+type).is(':checked') ){
						return true;
					}else{
						return false;
					}
				}
			break;
			case 'custom' :
				var condition = (this.o).attr('pattern');
				var reg = new RegExp(condition);
				if(!reg.test(val)){
					return false;
				}
				return true;
			break;
		}//end switch
		
		
	};//end ruleSplit
	//按控件类型分组控件，以对应不同的验证规则
	V.prototype.group = function(){
		//get input type
		var o = this.o;
		var getType = null;
		var tagName = o.attr('tagName') || o.prop('tagName') || o[0].tagName;
		tagName = tagName.toLowerCase();
		var type = o.attr('type').toLowerCase();
		if( tagName == 'select' ){
			getType = 'select';
		}else if( tagName == 'textarea' || type == 'text' || type == 'password' ){
			getType = 'text';
		}else{
			getType = type;
		}
			
		switch(getType){
			case 'text' : case 'select' :
				return this.ruleMatch();
			break;
			case 'radio' : case 'checkbox' :
				var getFirstChild = (this.remind.o).find(':'+getType).eq(0);
				this.className =  this.attrValFilter( getFirstChild, 'class' , '^v-' ) ;
				return this.ruleMatch();
			break;
		}//end switch
		
	};//end group
	//设置提示状态
	V.prototype.setRemind = function(classIndex){
		var o = this.remind.o;
		var l = this.remind.className.length;
		for(i in this.remind.className){

			o.removeClass(this.remind.className[i]);
		}
		classIndex = Number(classIndex);
		switch(classIndex){
			case 0 :case 1 :case 2 :
				o.addClass(this.remind.className[classIndex]);
			break;
			default:
				if( isNaN( parseInt(this.errKey) ) && this.remind.className.indexOf(this.errKey)!= -1 ){
					o.addClass(this.errKey);
				}else if( parseInt(this.errKey) < l ){
					o.addClass(this.remind.className[this.errKey]);
				}else{
					o.addClass(this.remind.className[0]);
				}
			break;
		}//end switch
		
	};//end setRemind
	V.prototype.clearRemind = function(d){
		var o = d.o||this.errmsg(3);
		var className = d.className || ['error','ok','remind'];
		for(i in className){
			o.removeClass(className[i]);
		}
	};
	//过滤出符合Validator类内置验证规则的htmlClass
	V.prototype.attrValFilter = function(o,attr,condition){
		/*
			o:当前要处理的DOM
			attr:当前DOM要处理的属性名称
			condition:以什么规则来过滤属性值，可以是字符串直接量或者是正则（正则不用加//）
		*/
		var tmpVal = '' ;
		concatAttr:for(var i=0,l=o.length;i<l;i++){
			tmpVal += o.eq(i).attr(attr)+' ';
		}
		
		tmpVal = $.trim(tmpVal).split(' ');
		
		var result = [];
		var reg = new RegExp(condition);
		
		pushAttr:for(var i=0,l=tmpVal.length;i<l;i++){
			if( reg.test(tmpVal[i]) ){
				result.push(tmpVal[i]);
			}
		}//end for
		result.join('');
		if(result.length > 0){
			return result;
		}else{
			return false;
		}
	};
	//verify错误消息通知
	V.prototype.errmsg = function(err,callback){
		/*
			err:可选值为错误编码（内部指定）；直接的消息提示
			callback:回调，各种回调
			这个方法目前仅在类的内部使用
		*/
		var msg = ['没有指定对象','意外的错误类型','必须指定要进行验证的对象','必须指定要清除样式的对象'];
		if( typeof(err) === 'number' ){
			alert(msg[err]);	
		}else{
			alert(err);
		}
		if( callback!=null ) callback;
	};
	//收集verify需要的各种数据以进行初始化，同时，init()在验证完成后会返回结果
	V.prototype.init = function(d){
		/*
			data : {
				o:,//要进行验证的对象
				remind:{
					o:,//要应用提示样式的对象 
					className:['error','ok','remind'],//提示样式的类名，必须按这个顺序书写
					errKey:'remind'//出现意外错误时要应用的提示样式
				}
			}
		*/
		this.o = d.o||this.errmsg(2);
		this.className = this.attrValFilter( this.o, 'class' , '^v-' );
		this.remind = d.remind || {o:d.o, className:['error','ok','remind'], errKey:'remind'};
		this.errKey = this.remind.errKey;
		return this.group();
		
	};//end init()

	//实例化Validator
	dr.ui.validator = dr.ui.verify = new Validator();
	
	/*
	*@name:ShadeLayer
	*@usage:shadeLayer.init('msgBox')
			shadeLayer.init('msgBox',{
				id:'shadeBox',
				opacity: 50,
				bgColor: '#000',
				zIndex: 1000
			})
			shadeLayer.closed() or
			shadeLayer.closed(function(){
				alert('Hello !');
			})
	*/
	function ShadeLayer(){};

	ShadeLayer.prototype.init = function(id,option){
		this.options = option || {
			id:'shadeBox',
			opacity: 90,
			bgColor: '#000',
			zIndex: 1000
		};
								
		//browser type and brower version
		var userAgent = navigator.userAgent.toLowerCase();
		this.browser = {
			version: (userAgent.match( /.(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [])[1],
			safari: /webkit/.test( userAgent ),
			opera: /opera/.test( userAgent ),
			msie: /msie/.test( userAgent ) && !/opera/.test( userAgent ),
			mozilla: /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent )
		};
								
		this.isIE6 = this.browser.msie && (this.browser.version == 6.0);
		//document.getElementById
		var $$ = function(id){
			return ("string" == typeof(id))?document.getElementById(id):id;	
		};
		//hidden select
		this.selects = document.getElementsByTagName('select');
		//if(this.selects.length!=0) this.setSelects(this.selects,true);
		
		this.fillBox = $$(id) ;
		
		if($$(this.options.id)==null){
			this.create();
			this.show();
		}else{
			this.show();
		}
	};
	//create shadeBox
	ShadeLayer.prototype.create = function(){
		//this.shadeBox = document.body.insertBefore(document.createElement("div"), document.body.childNodes[0]);
		this.shadeBox = document.body.insertBefore(document.createElement("ifrema"), document.body.childNodes[0])
		this.shadeBox.id = this.options.id;
		with(this.shadeBox.style){
			position = this.isIE6 ? 'absolute' : 'fixed';	
			left = '0';
			top = '0';
			width = '100%';
			height = '100%';
			backgroundColor = this.options.bgColor;
			
			this.browser.msie ? filter = 'alpha(opacity='+parseInt(this.options.opacity)+')' : opacity = parseInt(this.options.opacity) / 100;
			zIndex = this.options.zIndex;
		}
		
		if(this.isIE6) this.resize();	//init width & height in ie for shadeBox
	};
	//show fillBox & shadeBox
	ShadeLayer.prototype.show = function(){
		with(this.fillBox.style){
			display = this.shadeBox.style.display = 'block';
			zIndex = this.options.zIndex + 1;
			position = this.isIE6 ? 'absolute' : 'fixed';
			
			top = left = '50%';
			marginTop = - this.fillBox.offsetHeight / 2 + "px";
			marginLeft = - this.fillBox.offsetWidth / 2 + "px";
		}
		
		if(this.isIE6){
			
			var _this = this;
			/*
				var fn = function(sender){  
					return funtion(){sender.myfun();}
				}(this);
			*/
			
			
			this.resize();
			var _resize = function(){ _this.resize(); };
			window.attachEvent("onresize", _resize);
			
			this.setScroll();
			var _scroll = function(){ _this.setScroll(); };
			window.attachEvent("onscroll", _scroll);
			
			
			//window.addEventListener('scroll', this.setScroll, false);
		}
	};
	//close fillBox & shadeBox
	ShadeLayer.prototype.closed = function(callback){
		//hidden fillBox & shadeBox
		this.fillBox.style.display = this.shadeBox.style.display = 'none';
		//show the select
		this.setSelects(this.selects,false);
		//callback
		if(callback){
			callback();
		}
	};
	//hidden select
	ShadeLayer.prototype.setSelects = function(selects,flag){
		for(var i=0,l=selects.length;i<l;i++){
			selects[i].style.visibility = flag?'hidden':'visible';
		}
	};
	//fix ie6 scroll
	ShadeLayer.prototype.setScroll = function(){
		this.fillBox.style.marginTop = document.documentElement.scrollTop - this.fillBox.offsetHeight / 2 + "px";
		this.fillBox.style.marginLeft = document.documentElement.scrollLeft - this.fillBox.offsetWidth / 2 + "px";
		with(this.shadeBox.style){
			height = Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight) + 'px';
			width = Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth) + 'px';
		}
	};
	//fix ie6 resize
	ShadeLayer.prototype.resize = function(){
		with(this.shadeBox.style){
			height = Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight) + 'px';
			width = Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth) + 'px';
		}
	};
	
	dr.ui.shadeLayer = new ShadeLayer();
	
	/*
	* @method iMsgbox
	* @usage iMsgbox.show({
				boxId:'msgbox',
				theme:'the theme class name',
				title:'Any Title...',
				msg:'say something here.',
				//btnAttr
				buttons:[{
					type:'go to uedemo',
					btnLink:'http://uedemo.com',
					target:'_blank'
				},
				{
					type:1,
					fn:'msgbox.closed(function(){alert("i am is callback");})'
				}]
			});
	*/
	var Msgbox = function(){};
	Msgbox.prototype.show = function(data){
	/*
	buttons.type = [
		0 => confirm,
		1 => cancel,
		2 => abort,
		3 => retry,
		4 => ignore,
		5 => yes,
		6 => no]
	data:{
		boxId:'msgbox',
		title:'Any Title...',
		msg:'say something here.',
		//btnAttr
		buttons:[{
			type:0,
			btnLink:'',
			target:'',
			fn:'msgbox.closed(function(){alert("xxx");})'
		},
		{
			type:1,
			btnLink:'',
			target:'',
			fn:'msgbox.closed(function(){alert("xxx");})'
		}]
	}
	*/
	
		this.d = data || {
				boxId:'msgbox',
				theme:'',
				title:'dr.ui.iMsgbox',
				msg:'hello',
				//btnAttr
				buttons:[{
					type:0,
					fn:'msgbox.closed()'
				}]
			};
		
		this.btnType = ['confirm','cancel','abort','retry','ignore','Yes','No'];
		this.defaultTheme = 'msgbox';
		this.create();
	
	};
	Msgbox.prototype.create = function(){
		var sHtml = [];
		//sHtml.push('<div class="msgbox" id="msgbox">');
		sHtml.push('	<h4>'+(this.d.title||'Call of Gods'));
		sHtml.push('	</h4>');
		sHtml.push('	<div class="msg-content-skin">');
		sHtml.push('		<div class="msg-content">');
		sHtml.push(this.d.msg||'Hello!');
		sHtml.push('		</div>');
		sHtml.push('	</div>');

		if(this.d.buttons && this.d.buttons.length > 0){
			sHtml.push('		<div class="msg-action">');
			var btnEvent = '';
			var target = '';
	
			for(var i=0,len=this.d.buttons.length;i<len;i++){
				
				if(this.d.buttons[i].btnLink && this.d.buttons[i].btnLink != ''){
					btnEvent = this.d.buttons[i].btnLink;
				}else if(this.d.buttons[i].fn && this.d.buttons[i].fn != ''){
					btnEvent = 'javascript:' + this.d.buttons[i].fn.replace(/\"/gi, "'");
				}else{
					btnEvent = 'javascript://';
				}
				
				target =  this.d.buttons[i].target||'_self';
				
				if( this.d.buttons[i].type !=undefined && "number" == typeof( this.d.buttons[i].type ) ){
					sHtml.push('<a href="'+ btnEvent +'" class="btn '+ this.btnType[this.d.buttons[i].type] +'" target="'+ target +'"><span>'+this.btnType[this.d.buttons[i].type]+'</span></a>');
				}else if( this.d.buttons[i].type !=undefined && "string" == typeof( this.d.buttons[i].type)){
					sHtml.push('<a href="'+ btnEvent +'" class="btn general" target="'+ target +'" id="btn-'+(this.d.buttons[i].type).toLowerCase()+'"><span>'+this.d.buttons[i].type+'</span></a>');
				}else{
					sHtml.push('<a href="'+ btnEvent +'" class="btn '+ this.btnType[0] +'" target="'+ target +'"><span>'+this.btnType[0]+'</span></a>');
				}
				
				
			}//end for
			
			
			sHtml.push('		</div>');
		}else{
			sHtml.push('<a href="javascript:dr.ui.shadeLayer.closed();" class="btn closed" title="close">close</a>');
			this.defaultTheme += ' msgbox-action-null ';
		}
		
		//sHtml.push('</div>');
		//get object
		var _ = function(id){
			return ("string" == typeof(id))?document.getElementById(id):id;	
		};
		var o;
		this.d.boxId = this.d.boxId || 'msgbox';
		if(_(this.d.boxId)){
			o = _(this.d.boxId);
			o.innerHTML = sHtml.join('');
		}else{
			o = document.createElement("div");
			o.id = this.d.boxId;
			o.className = this.defaultTheme + ' ' ;
			o.className += this.d.theme || ' ';
			o.innerHTML = sHtml.join('');
			document.body.appendChild(o);
		}
		
	};
	dr.ui.iMsgbox = new Msgbox();
	
	
	/*
	*@name:SimpleTab()
	*@usage:dr.ui.simpleTab.decorate('simple-tabs',{eventType:'mouseover'});
	*		dr.ui.simpleTab.decorate('simple-tabs',{eventType:'mouseover'},function(){alert('simpleTab')});
	*@return:null
	*/
	var SimpleTab = function(){};
	SimpleTab.prototype.init = SimpleTab.prototype.decorate = function(id,data,callback){
		
		var o = $('#'+id);
		//data = {eventType:'click',index:0,currentClass:'current'};
		data = data||{};
		this.eventType = data.eventType||'click';
		this.currentClass = data.currentClass||'current';
		this.index = data.index||0;
		
		this.tabs = o.children('.minitabs');
		this.len = this.tabs.children('li').length;
		this.tabSection = o.children('div');
		this.sectLen = this.tabSection.length;
		this.callback = callback;
		
		
		this.tabSection.not($(this.tabSection[this.index])).hide();
		$(this.tabs.children('li')[this.index]).addClass( this.currentClass ).siblings('li').removeClass(this.currentClass);
		
		var $this = this;
		this.tabs.children('li').bind(this.eventType,function(){
			var currentIdx = $this.tabs.children('li').index( this );
			$this.switchTab( currentIdx , $this.callback );
		});
	};
	SimpleTab.prototype.switchTab = function( index , callback ){
		this.tabSection.hide();
		$( this.tabSection[index] ).show();
		$(this.tabs.children('li')[index]).addClass( this.currentClass ).siblings('li').removeClass(this.currentClass);
		
		if(callback) callback() ;
	};
		
	dr.ui.simpleTab = new SimpleTab();
	dr.proto.simpleTab = SimpleTab;
	
	
	/*
	@name:Cookie
	@usage:dr.ui.cookie( {name:'',value:'',days:,tunit:''} , method );
	*/
	var Cookie = function( data , method ){
		//data:{name:'',value:,days:,tunit:'',flag:''}
		if(!data) return;
		this.name = data.name||'';
		this.value = data.value||'';
		this.days = data.days||'';
		this.tunit = data.tunit||'';
	};
	Cookie.prototype.create = function(){
 		if(days){
			tunit?tunit=tunit:tunit='d';
			var date = new Date();
			switch(tunit){
				case 'd':
					date.setTime(date.getTime()+(days*24*60*60*1000));
				break;
				case 'h':
					date.setTime(date.getTime()+(days*60*60*1000));
				break;
				case 'm':
					date.setTime(date.getTime()+(days*60*1000));
				break;
				case 's':
					date.setTime(date.getTime()+(days*1000));
				break;
			}
			var expires = "; expires="+date.toGMTString();
		}
		else var expires = "";
		document.cookie = name+"="+value+expires+"; path=/";
	};
	Cookie.prototype.read = function(){
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++){
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	};
	Cookie.prototype.erase = function(){
		createCookie(name,"",-1);
	};
	//var dr.ui.cookie = new Cookie();

	//return dr.library
	return (dr)


})(jQuery)