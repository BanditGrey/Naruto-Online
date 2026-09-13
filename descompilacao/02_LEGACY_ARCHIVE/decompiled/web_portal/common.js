// Common JS
//(function($){
	var showFlashObject = function(objID,objSource,objWidth,objHeight,objQuality,objWmode,objBgcolor,objXML){
			if(objXML){
			var chkMovie=0;
			if(objSource.match(/=/))objSource=objSource+"&server="+objXML+"&chkMovie="+chkMovie;
			else objSource=objSource+"?server="+objXML+"&chkMovie="+chkMovie;
			}
			var pageUrl=self.window.location.href;
			if(pageUrl.substring(0,5)=="https") swfUrl="https";
			else swfUrl="http";
			if(!objID)objID="ShockwaveFlash1";
			if(!objWidth)objWidth="0";
			if(!objHeight)objHeight="0";
			if(!objQuality)objQuality="high";
			if(!objWmode)objWmode="transparent";
			var strFlv = [];
			strFlv.push('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="'+swfUrl+'://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,124,0" width="'+objWidth+'" height="'+objHeight+'" id="'+objID+'" align="middle">');
			strFlv.push('<param name="allowFullScreen" value="false" />');
			strFlv.push('<param name="scale" value="noscale" />');
			strFlv.push('<param name="movie" value="'+objSource+'" />');
			strFlv.push('<param name="allowScriptAccess" value="always" />');
			strFlv.push('<param name="menu" value="false" />');
			strFlv.push('<param name="quality" value="high" />');
			strFlv.push('<param name="bgcolor" value="'+objBgcolor+'" />');
			strFlv.push('<param name="wmode" value="'+objWmode+'" />');
			strFlv.push('<embed src="'+objSource+'" allowScriptAccess="always" menu="false" quality="high" bgcolor="'+objBgcolor+'" wmode="'+objWmode+'" width="'+objWidth+'" height="'+objHeight+'" name="'+objID+'" align="middle" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
			strFlv.push('</object>');
			return strFlv.join('');
			
		}//showFlashObject end
	var customInputChedked = function(){

		$('input:radio , input:checkbox').each(function(){
			var setChecked = function(o){
				if( o.is(':checked') ){
					if( o.is(':radio') ){
						$( 'input[name="' + o.attr('name') + '"]' ).siblings('label').removeClass('checked');
					}
					o.siblings('label[for="'+ o.attr('id') +'"]').addClass('checked');
				}else{
					if( o.is(':checkbox') ){
						o.siblings('label[for="'+ o.attr('id') +'"]').removeClass('checked');
					}
				}
			};
			//init
			$(this).parents('.fm-multi').addClass('fm-custom-multi');
			$(this+':checkbox').parents('.fm-multi').addClass('fm-custom-checkbox');
			setChecked( $(this) );
			
			$(this).click(function(){ setChecked( $(this) ) });
			$(this).focus(function(){ setChecked( $(this) ) });
		});
	};//end customInputRadio
	
	$(window).scroll(function(){
		var _main = $('#main');
		if(_main.length>0){
            var docScrollTop = $(this).scrollTop();
            var mainOffsetLeft = $('#main').offset().left;
            var clientHeight = window.innerHeight || document.documentElement.clientHeight ;

            if( docScrollTop >= clientHeight/3 ){
                $('.back-to-top').css({
                    right:mainOffsetLeft - $('.back-to-top').outerWidth(true)
                }).fadeIn().text( docScrollTop );
            }else{
                $('.back-to-top').fadeOut();
            }
		}

	});
	
	var setHeaderHeight = {
		options : {
			header : $('#header'),
			headerH : $('#header').height(),
			miniHeight : $('#header #switch-bar').outerHeight(true)
		},
		setUp:function(){
				$('#switch-bar a:first-child').removeClass('unexpand').addClass('expand');
				setHeaderHeight.options.header.animate({'margin-top':setHeaderHeight.options.miniHeight - setHeaderHeight.options.headerH},{duration:500,complete:function(){
					$(this).addClass('unexpand');
				}});
			},
		setDown:function(){
				$('#switch-bar a:first-child').removeClass('expand').addClass('unexpand');
				setHeaderHeight.options.header.animate({'margin-top':0},{duration:500,complete:function(){
					$(this).removeClass('unexpand');
				}});
			}	
	};
	//setFrameHeight
	var setFrameHeight = function(type){
		var type = false;
		var miniHeight = $('#header .simple-tabs').outerHeight(true);
		var viewHeight = document.documentElement.clientHeight || document.body.clientHeight;
		var oFrame = $('#game-frame')
		if( (viewHeight - miniHeight) < 600 ){
			oFrame.height( 600 );
		}else{
			oFrame.height( viewHeight - miniHeight );
		}
	};	
	
	//setFrameHeight
	
	$('#switch-bar a').click(function(){
		if( !setHeaderHeight.options.header.hasClass('unexpand') ){
		setHeaderHeight.setUp();
		} else {
		setHeaderHeight.setDown();
		}
	}); 
	

		//Show recharge Window	
	
	var showRechargeWindow = function(resize){
		
		var resize = resize || false;
		var oRechargeWindow = $('.recharge-window');
		if( resize ){
			if( !oRechargeWindow.hasClass( 'has-open' ) ) return ;
			oRechargeWindow.css({
				'margin-left':"50%" ,
				'left':- (oRechargeWindow.width() / 2 )	
			});
		}else{
			oRechargeWindow.overlay({
				top: 'center',
				mask: {
					color: '#fff',
					loadSpeed: 200,
					opacity: 0.5
				},
				fixed:false,
				closeOnClick: false,
				load: true
			}).load();
			
			oRechargeWindow.overlay().onLoad(function(){
				oRechargeWindow.addClass('has-open');		
			})
			oRechargeWindow.overlay().onClose(function(){
				oRechargeWindow.removeAttr('style').removeClass('has-open');
			});
			/*
			.onLoad(function(){
				$(this).addClass('has-open');		
			}).onClose(function(){
				$(this).removeAttr('style').removeClass('has-open');
			});
			*/
		}
	};
	$(window).resize(function(){
		showRechargeWindow(true);
	});

	//overlay config
	var overlayCfg = {
		top: 'center',
		mask: {
			color: '#000',
			loadSpeed: 200,
			opacity: 0.5
		},
		closeOnClick: false,
		load: true
	};
	
	//recharge-window raido
	$('.recharge-window table tr').click(function(){
		$(this).each(function(){
			$(this).find(':radio').attr('checked','checked');
		});
	});
		$('.payment a').click(function(){
		$(this).parent('.payment-grid').siblings('li').removeClass('current');
		$(this).parent('.payment-grid').addClass('current');
	}); 
	$('.main-content table tr').click(function(){
		if($(this).find('input').is(':checked')){
			$(this).addClass('current').siblings('tr').removeClass('current');
		}
	});

	
	
//})(jQuery)