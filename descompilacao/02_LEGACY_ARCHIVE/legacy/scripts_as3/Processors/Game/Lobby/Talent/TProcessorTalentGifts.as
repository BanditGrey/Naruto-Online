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
   import Logics.Streamization.Talent.TUnstreamizerRefreshTalent;
   import Logics.Talent.TTalentGifts;
   import Logics.Talent.TTalentGiftsData;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Talent.Component.TUITalentGifts;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorTalentGifts extends TProcessorLobbyWindows
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected var FResPanel:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FUIListGifts:Vector.<TUITalentGifts>;
      
      protected var FUnstreamizerRefreshTalent:TUnstreamizerRefreshTalent;
      
      protected var FTalentGiftsData:TTalentGiftsData;
      
      public function TProcessorTalentGifts(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerRefreshTalent = new TUnstreamizerRefreshTalent();
         this.FTalentGiftsData = new TTalentGiftsData();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4026531848);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FResPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_TalentGifts") as MovieClip;
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
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RefreshTalent_Info,this.PerformPacket_SC_RefreshTalent_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RefreshTalent_Reward,this.PerformPacket_SC_RefreshTalent_Reward);
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUITalentGifts = null;
         var _loc4_:TTalentGifts = null;
         this.FScrollBar.Clear();
         this.FUIListGifts = new Vector.<TUITalentGifts>();
         _loc1_ = 0;
         while(_loc1_ < this.FTalentGiftsData.TalentGifts.length)
         {
            _loc3_ = new TUITalentGifts(this);
            _loc3_.OnRewardTalentGift = this.PerformPacket_CS_RefreshTalent_Reward;
            _loc3_.OnHintOver = UIComponentsHintOnOver;
            _loc3_.OnHintOut = UIComponentsHintOnOut;
            _loc4_ = this.FTalentGiftsData.TalentGifts[_loc1_] as TTalentGifts;
            this.FScrollBar.AddItem(_loc3_);
            _loc3_.SetDate(_loc4_);
            this.FUIListGifts.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function PerformPacket_SC_RefreshTalent_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerRefreshTalent.Unstreamize(_loc2_,this.FTalentGiftsData,null);
         this.ConstructScroolBar();
         this.FResPanel.label_num.text = _loc2_.readUnsignedInt();
      }
      
      protected function PerformPacket_CS_RefreshTalent_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RefreshTalent_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_RefreshTalent_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc6_:TTalentGifts = null;
         var _loc7_:TUITalentGifts = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         _loc6_ = this.FTalentGiftsData.GetTLevelGiftsByIdentifier(_loc4_);
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
            _loc7_ = this.FUIListGifts[_loc8_] as TUITalentGifts;
            if(_loc7_.TalentGifts.Identifier == _loc4_)
            {
               _loc7_.SetDate(_loc6_);
               break;
            }
            _loc8_++;
         }
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_CS_RefreshTalent_Reward(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RefreshTalent_Reward);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_TalentGifts);
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
         this.PerformPacket_CS_RefreshTalent_Info();
      }
   }
}

