package Processors.Game.Lobby.Talent
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.LevelGifts.TLevelGifts;
   import Logics.LevelGifts.TLevelGiftsData;
   import Logics.Streamization.LevelGifts.TUnstreamizerLevelGifts;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Talent.Component.TUITalentLevelGifts;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorTalentLevelGifts extends TProcessorLobbyWindows
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected var FResPanel:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FUIListGifts:Vector.<TUITalentLevelGifts>;
      
      protected var FUnstreamizerLevelGifts:TUnstreamizerLevelGifts;
      
      protected var FLevelGiftData:TLevelGiftsData;
      
      public function TProcessorTalentLevelGifts(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerLevelGifts = new TUnstreamizerLevelGifts();
         this.FLevelGiftData = new TLevelGiftsData();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4026531845);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FResPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TalentLevelGifts") as MovieClip;
         addChild(this.FResPanel);
         this.FScrollBar = new TScrollBar(this.FResPanel.MC_List,348,false,0);
         this.FBtn_Close = this.FResPanel.MC_Close;
         this.FBtn_Help = this.FResPanel.Btn_Help;
         this.FResPanel.x = FUICore.StageWidth - this.FResPanel.width >> 1;
         this.FResPanel.y = FUICore.StageHeight - this.FResPanel.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnCloseHandle);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LevelGifts_TalentInfo,this.PerformPacket_SC_LevelGifts_TalentInfo);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LevelGifts_Reward,this.PerformPacket_SC_LevelGifts_Reward);
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUITalentLevelGifts = null;
         var _loc4_:TLevelGifts = null;
         this.FScrollBar.Clear();
         this.FUIListGifts = new Vector.<TUITalentLevelGifts>();
         _loc1_ = 0;
         while(_loc1_ < this.FLevelGiftData.LevelGifts.length)
         {
            _loc3_ = new TUITalentLevelGifts(this);
            _loc3_.OnRewardLevelGift = this.PerformPacket_CS_LevelGifts_Reward;
            _loc3_.OnHintOver = UIComponentsHintOnOver;
            _loc3_.OnHintOut = UIComponentsHintOnOut;
            _loc4_ = this.FLevelGiftData.LevelGifts[_loc1_] as TLevelGifts;
            this.FScrollBar.AddItem(_loc3_);
            _loc3_.SetDate(_loc4_);
            this.FUIListGifts.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function PerformPacket_SC_LevelGifts_TalentInfo(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerLevelGifts.Unstreamize(_loc2_,this.FLevelGiftData,null);
         this.ConstructScroolBar();
      }
      
      protected function PerformPacket_CS_LevelGifts_TalentInfo() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LevelGifts_TalentInfo);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LevelGifts_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc6_:TLevelGifts = null;
         var _loc7_:TUITalentLevelGifts = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         _loc6_ = this.FLevelGiftData.GetTLevelGiftsByIdentifier(_loc4_);
         if(_loc5_ == GIFTS_NORMAL)
         {
            _loc6_.Reward = 1;
         }
         else if(_loc5_ == GIFTS_TOPUP)
         {
            _loc6_.TopReward = 1;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this.FUIListGifts.length)
         {
            _loc7_ = this.FUIListGifts[_loc8_] as TUITalentLevelGifts;
            if(_loc7_.LevelGifts.Identifier == _loc4_)
            {
               _loc7_.SetDate(_loc6_);
               break;
            }
            _loc8_++;
         }
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_CS_LevelGifts_Reward(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LevelGifts_Reward);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_TalentLevelGifts);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function OnCloseHandle(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this.FUIListGifts)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUIListGifts.length)
            {
               this.FUIListGifts[_loc1_].LogicsPerform();
               _loc1_++;
            }
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_LevelGifts_TalentInfo();
      }
   }
}

