/* 
*	统计接口代码
*
 */
function gameRolePost(level)
{
	/* if(channel == 104){	
		$.post('./gameRolePost.php', {'level':level,'suid':suid,'svr_id':server_id});		
	} */
		
} 

/* 
*	创号接口调用
 */
function role(userip)
{	
	/* if(channel == 104){	
		$.post('./gameRolePost.php', {'level':1,'suid':suid,'svr_id':server_id});
	} */
		
	//$.post('./inform.php',{'server_id':server_id,'sUserId':suid,'userip':userip}); 
		
	$.post("./rabbit.php",{"server_id":server_id,"userip":userip,"suid":suid,"agentid":channel,"typ":2}); 	
}

function login(userip) { 
	$.post("./rabbit.php",{"server_id":server_id,"userip":userip,"suid":suid,"agentid":channel,"typ":1}); 	
} 

function  guide (step,userip) {
		
	$.post("./rabbit.php", {"server_id":server_id,"userip":userip,"suid":suid,"step":step,"agentid":channel,"typ":3}); 	
		
} 

/*
*	发送统计代码
*	1 创建角色
	2 20级
	3 40级
	4 70级
**/
function statistics(x,s)
{
	console.log("statistics : " + x);
	__game.collect(x,s);
} 

