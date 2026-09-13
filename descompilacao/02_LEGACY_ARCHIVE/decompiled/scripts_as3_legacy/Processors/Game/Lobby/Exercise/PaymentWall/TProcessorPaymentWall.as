package Processors.Game.Lobby.Exercise.PaymentWall
{
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   
   public class TProcessorPaymentWall extends TProcessorBaseActivity
   {
      
      protected var FURLStr:String;
      
      protected var FActivityBeginTime:int;
      
      protected var FActivityEndTime:int;
      
      public function TProcessorPaymentWall(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Goto,true);
         FMC_Scene.BTN_Goto.addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoURL);
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityBeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FActivityEndTime - 1) * 1000)));
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnGotoURL(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = null;
         if(TUtilityString.Empty(this.FURLStr))
         {
            return;
         }
         _loc2_ = new URLRequest(this.FURLStr);
         navigateToURL(_loc2_,"_blank");
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FActivityBeginTime = _loc2_.readInt();
         this.FActivityEndTime = _loc2_.readInt();
         _loc4_ = _loc2_.readShort();
         this.FURLStr = TUtilityString.FetchUTF(_loc2_);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
   }
}

