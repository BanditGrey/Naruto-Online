package Processors.Game.Lobby.CDK
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_GIFTBAG;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SIGNAL;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorCDK extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Recharge:uint = 487;
      
      protected static const SIZE_HIGHT_Recharge:uint = 381;
      
      protected static const CDK_LENGTH:uint = 24;
      
      public static const SIGNALDESTINATION_ACTIVE_CDK_Ret:uint = CONST_SIGNAL.SIGNALDESTINATION_ACTIVE_CDK_Ret;
      
      public static const GET_AWARD_SUCCEED:uint = 0;
      
      protected var FMC_CDK:MovieClip;
      
      protected var FMC_IsMatch:MovieClip;
      
      protected var FTF_CDK:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FInitialized:Boolean;
      
      public function TProcessorCDK(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FInitialized = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GIFTBAG.RESOURCESID_SWF_GIFTBAG);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_CDK = TUtilityReflection.CreateDisplayObjectInstance(CONST_GIFTBAG.RESOURCE_ClassName_MC_CDK) as MovieClip;
         addChild(this.FMC_CDK);
         this.FMC_CDK.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH_Recharge >> 1;
         this.FMC_CDK.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT_Recharge >> 1;
         this.FMC_IsMatch = this.FMC_CDK[CONST_GIFTBAG.RESOURCE_Link_MC_IsMatch];
         this.FMC_IsMatch.visible = false;
         this.FTF_CDK = this.FMC_CDK[CONST_GIFTBAG.RESOURCE_Link_TF_CDK];
         this.FTF_CDK.restrict = "a-zA-Z0-9\\-";
         this.FTF_CDK.maxChars = CDK_LENGTH;
         this.FBTN_Close = this.FMC_CDK[CONST_GIFTBAG.RESOURCE_Link_BTN_Close];
         this.FBTN_GetReward = this.FMC_CDK[CONST_GIFTBAG.RESOURCE_Link_BTN_Reward];
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonOnGetReward,false,0,true);
         this.FTF_CDK.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialized)
         {
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CDK_CDKAwardRet,this.PerformPacket_SC_CDKAwardRet);
      }
      
      protected function PerformPacket_CS_CDKAwardReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:String = this.FTF_CDK.text;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CDK_CDKAwardReq);
         _loc2_ = _loc1_.Data;
         TUtilityString.FlushUTF(_loc2_,_loc3_);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_CDKAwardRet(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         _loc2_ = param1.Data.readInt();
         if(_loc2_ == GET_AWARD_SUCCEED)
         {
            EffectGenerateText(STRING_ACTIVITYINNER.STREING_REWARD_SUCCEED);
            this.Init();
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc2_);
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
         }
      }
      
      protected function Init() : void
      {
         if(!this.FInitialized)
         {
            return;
         }
         this.UpdateText();
         this.UpdateUI();
      }
      
      protected function UpdateText() : void
      {
         this.FTF_CDK.text = "";
      }
      
      protected function UpdateUI() : void
      {
         this.FMC_IsMatch.visible = false;
         TGameUtil.setButtonMode(this.FBTN_GetReward,false);
      }
      
      protected function ButtonOnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonOnGetReward(param1:MouseEvent) : void
      {
         if(param1.currentTarget.buttonMode == false)
         {
            return;
         }
         var _loc2_:Boolean = this.CheckCDK();
         if(_loc2_)
         {
            this.FMC_IsMatch.visible = false;
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            this.PerformPacket_CS_CDKAwardReq();
         }
         else
         {
            this.FMC_IsMatch.visible = true;
         }
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         if(this.FTF_CDK.text.length > 0)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
         }
      }
      
      private function CheckCDK() : Boolean
      {
         var _loc1_:String = this.FTF_CDK.text;
         var _loc2_:int = _loc1_.length;
         if(_loc2_ != CDK_LENGTH)
         {
            return false;
         }
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_.charAt(_loc4_);
            if((_loc4_ + 1) % 5 == 0)
            {
               if(_loc3_ != "-")
               {
                  return false;
               }
            }
            else if(_loc3_ == "-")
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.Init();
      }
   }
}

