package Processors.Game.Lobby.Discord
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Agent.SParametersCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_GIFTBAG;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorDiscord extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Recharge:uint = 647;
      
      protected static const SIZE_HIGHT_Recharge:uint = 535;
      
      protected static const CDK_LENGTH:uint = 24;
      
      public static const GET_AWARD_SUCCEED:uint = 0;
      
      protected var FMC_Discord:MovieClip;
      
      protected var FTF_Discord:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FBTN_Discord:SimpleButton;
      
      public function TProcessorDiscord(param1:TUIComponent, param2:TLobbyParameters)
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
         this.FMC_Discord = TUtilityReflection.CreateDisplayObjectInstance(CONST_GIFTBAG.RESOURCE_ClassName_Discord) as MovieClip;
         addChild(this.FMC_Discord);
         this.FMC_Discord.x = CONST_COMMON.STAGE_Width - SIZE_WIDTH_Recharge >> 1;
         this.FMC_Discord.y = CONST_COMMON.STAGE_Height - SIZE_HIGHT_Recharge >> 1;
         this.FTF_Discord = this.FMC_Discord[CONST_GIFTBAG.RESOURCE_Link_TF_Discord];
         this.FTF_Discord.restrict = "a-zA-Z0-9\\-";
         this.FTF_Discord.maxChars = CDK_LENGTH;
         this.FBTN_Close = this.FMC_Discord[CONST_GIFTBAG.RESOURCE_Link_BTN_Close];
         this.FBTN_GetReward = this.FMC_Discord[CONST_GIFTBAG.RESOURCE_Link_BTN_Reward];
         this.FBTN_Discord = this.FMC_Discord[CONST_GIFTBAG.RESOURCE_Link_BTN_Discord];
         this.FInitialized = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonOnClose,false,0,true);
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonOnGetReward,false,0,true);
         this.FTF_Discord.addEventListener(Event.CHANGE,this.OnTextInput,false,0,true);
         this.FBTN_Discord.addEventListener(MouseEvent.CLICK,this.OnGotoDiscord,false,0,true);
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
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Discord_CDKAwardRet,this.PerformPacket_SC_CDKAwardRet);
      }
      
      protected function PerformPacket_CS_CDKAwardReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         var _loc3_:String = this.FTF_Discord.text;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Discord_CDKAwardReq);
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
            ProcessorClose();
         }
         else
         {
            EffectGenerateTextByErrorCode(_loc2_);
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
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
         this.FTF_Discord.text = "";
      }
      
      protected function UpdateUI() : void
      {
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
         TGameUtil.setButtonMode(this.FBTN_GetReward,false);
         this.PerformPacket_CS_CDKAwardReq();
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         if(this.FTF_Discord.text.length > 0)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
         }
      }
      
      protected function OnGotoDiscord(param1:MouseEvent) : void
      {
         if(SParametersCore.AgentID == 73 || SParametersCore.AgentID == 76)
         {
            navigateToURL(new URLRequest("https://discord.gg/f6fAGAn"),"_blank");
         }
         else if(SParametersCore.AgentID == 53 || SParametersCore.AgentID == 54 || SParametersCore.AgentID == 65 || SParametersCore.AgentID == 70 || SParametersCore.AgentID == 109)
         {
            navigateToURL(new URLRequest("https://discord.gg/f6fAGAn"),"_blank");
         }
         ProcessorClose();
      }
      
      private function CheckCDK() : Boolean
      {
         var _loc1_:String = this.FTF_Discord.text;
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

