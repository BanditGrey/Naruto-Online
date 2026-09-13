package Externals
{
   import Foundation.Utilities.*;
   import Logics.Agent.SParametersCore;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_PLATE;
   import flash.external.*;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class TExternalCore
   {
      
      protected static const LOGINSTRING_Token:String = "";
      
      protected static const LOGINSTRING_Nickname:String = "";
      
      protected static const SEND_SUCCESS:int = 1;
      
      protected var FCallBackSendFeed:Function;
      
      protected var FCallBackInviteFriend:Function;
      
      protected var FCallBackRegister:Function;
      
      public var ChangeScreenSize:Function;
      
      public function TExternalCore()
      {
         super();
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("getWindowCloseData",this.SendObligatoryCoursesFormatToString);
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("RegisterSuccessCallBack",this.RegisterSuccessCallBack);
         }
      }
      
      protected function FetchParameterInt(param1:String) : int
      {
         var Result:int = 0;
         var ParameterFunction:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               Result = ExternalInterface.call(ParameterFunction);
            }
            catch(CurrentError:Error)
            {
               Result = 0;
            }
         }
         else
         {
            Result = 0;
         }
         return Result;
      }
      
      protected function FetchParameterUInt(param1:String) : uint
      {
         var Result:uint = 0;
         var ParameterFunction:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               Result = ExternalInterface.call(ParameterFunction);
            }
            catch(CurrentError:Error)
            {
               Result = 0;
            }
         }
         else
         {
            Result = 0;
         }
         return Result;
      }
      
      protected function FetchParameterString(param1:String) : String
      {
         var Result:String = null;
         var ParameterFunction:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               Result = ExternalInterface.call(ParameterFunction);
               if(TUtilityString.Empty(Result))
               {
                  Result = null;
               }
            }
            catch(CurrentError:Error)
            {
               Result = null;
            }
         }
         else
         {
            Result = null;
         }
         return Result;
      }
      
      public function get DirectoryHost() : String
      {
         return this.FetchParameterString("ClientDirectoryHost");
      }
      
      public function get DirectoryPort() : int
      {
         return this.FetchParameterInt("ClientDirectoryPort");
      }
      
      public function get CallBackSendFeed() : Function
      {
         return this.FCallBackSendFeed;
      }
      
      public function set CallBackSendFeed(param1:Function) : void
      {
         this.FCallBackSendFeed = param1;
      }
      
      public function get CallBackInviteFriend() : Function
      {
         return this.FCallBackInviteFriend;
      }
      
      public function set CallBackInviteFriend(param1:Function) : void
      {
         this.FCallBackInviteFriend = param1;
      }
      
      public function get CallBackRegister() : Function
      {
         return this.FCallBackRegister;
      }
      
      public function set CallBackRegister(param1:Function) : void
      {
         this.FCallBackRegister = param1;
      }
      
      public function NavigateToUrl(param1:String, param2:String = "_blank") : void
      {
         var _loc3_:URLRequest = null;
         if(TUtilityString.Empty(param1))
         {
            return;
         }
         _loc3_ = new URLRequest(param1);
         navigateToURL(_loc3_,param2);
      }
      
      public function NavigateToFightReport(param1:String) : void
      {
         this.NavigateToUrl(SParametersCore.BattleReportUrl + "?rid=" + param1 + "&aid=" + SParametersCore.AgentID + "&t=1");
      }
      
      public function NavigateToRecharge() : void
      {
         if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_US || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_JOYGAME || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_RU_WIKI || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_DE || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_ESP || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_RU_OTHER || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_RU_GN)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("openBox");
            }
            if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_DE || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_ESP)
            {
               if(this.ChangeScreenSize != null)
               {
                  this.ChangeScreenSize();
               }
            }
         }
         else if(SParametersCore.AgentID == CONST_PLATE.ID_PLATE_USFB || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_TH_FACEBOOK || SParametersCore.AgentID == CONST_PLATE.ID_PLATE_FB_OTHER)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("showPop");
            }
         }
         else if(SParametersCore.AgentID == 75 || SParametersCore.AgentID == 120 || SParametersCore.AgentID == 121)
         {
            ExternalInterface.call("clickdo");
         }
         else
         {
            this.NavigateToUrl(SParametersCore.PayUrl);
         }
      }
      
      public function BrazilLog(param1:uint) : void
      {
         if(SParametersCore.IsNewUser)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("guide",param1,SParametersCore.UserIP);
            }
         }
      }
      
      public function JoyFunLog(param1:uint) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("statistics",param1,SParametersCore.ServerID);
         }
      }
      
      public function GameURLNavigate(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("ClientURLNavigate",param1);
         }
      }
      
      public function GameStatistical(param1:uint) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("analyUser",SParametersCore.AgentID,param1,int(SParametersCore.IsNewUser),SParametersCore.OperatorUserID,SParametersCore.ServerID);
         }
      }
      
      public function GameDropLog(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("flash_log",param1);
         }
      }
      
      public function ReloadGame() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("reloadgame");
         }
      }
      
      public function AddCloseHandler() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("windowCloseHandler",this.externalWindowCloseHandler);
         }
      }
      
      public function CreateChar(param1:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("createRole",param1);
         }
      }
      
      public function SendUserIp() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("role",SParametersCore.UserIP);
         }
      }
      
      public function LoginIn() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("login",SParametersCore.UserIP);
         }
      }
      
      public function externalWindowCloseHandler() : void
      {
      }
      
      public function InviteFriend() : Object
      {
         var _loc1_:Object = null;
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("InviteFriendCallBack",this.InviteFriendCallBack);
            _loc1_ = ExternalInterface.call("invite",SLogicsCore.Character.ServerId);
         }
         return _loc1_;
      }
      
      public function SendFeed() : Object
      {
         var _loc1_:Object = null;
         var _loc2_:int = 1;
         if(ExternalInterface.available)
         {
            ExternalInterface.addCallback("SendFeedCallBack",this.SendFeedCallBack);
            _loc1_ = ExternalInterface.call("feed",SLogicsCore.Character.ServerId,_loc2_);
         }
         return _loc1_;
      }
      
      public function BrazilLogQuestLog(param1:uint, param2:uint) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("task",param1,param2,SParametersCore.UserIP);
         }
      }
      
      public function GameRolePostLog(param1:uint) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("gameRolePost",param1);
         }
      }
      
      public function SendFeedCallBack(param1:Object) : void
      {
         if(param1 == SEND_SUCCESS && this.FCallBackSendFeed != null)
         {
            this.FCallBackSendFeed();
         }
      }
      
      public function InviteFriendCallBack(param1:Object) : void
      {
         if(this.FCallBackInviteFriend != null)
         {
            this.FCallBackInviteFriend(param1);
         }
      }
      
      public function AddCollect() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("AddFavorite");
         }
      }
      
      public function TotalClicks(param1:uint) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("member_icon",param1);
         }
      }
      
      public function LoadFinish() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("load_finish");
         }
      }
      
      public function SendObligatoryCoursesFormatToString() : String
      {
         return SLogicsCore.NarutoRoadData.ObligatoryCoursesFormatToString();
      }
      
      public function AccountSecure() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("accountBound");
         }
      }
      
      public function VkCallJs(param1:uint) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("btnclick",param1);
         }
      }
      
      public function AccountTransfer(param1:String, param2:String) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("register",param1,param2);
         }
      }
      
      public function RegisterSuccessCallBack(param1:Object) : void
      {
         if(this.FCallBackRegister != null)
         {
            this.FCallBackRegister(param1);
         }
      }
   }
}

