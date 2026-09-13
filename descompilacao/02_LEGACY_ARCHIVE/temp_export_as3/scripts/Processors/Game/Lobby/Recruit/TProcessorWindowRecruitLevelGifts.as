package Processors.Game.Lobby.Recruit
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Recruit.TRecruitLevelGifts;
   import Logics.Recruit.TRecruitLevelGiftsData;
   import Logics.Streamization.LevelGifts.TUnstreamizerLevelGifts;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Recruit.Component.TUIRecruitLevelGifts;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowRecruitLevelGifts extends TProcessorLobbyWindow
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected var FResPanel:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FUIListGifts:Vector.<TUIRecruitLevelGifts>;
      
      protected var FUnstreamizerLevelGifts:TUnstreamizerLevelGifts;
      
      protected var FLevelGiftData:TRecruitLevelGiftsData;
      
      public var UpdateEffectGlow:Function;
      
      public var OnHelpHintOver:Function;
      
      public var OnHelpHintOut:Function;
      
      public var OnHintOver:Function;
      
      public var OnHintOut:Function;
      
      public function TProcessorWindowRecruitLevelGifts(param1:TUIComponent)
      {
         super(param1);
         this.FUnstreamizerLevelGifts = new TUnstreamizerLevelGifts();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FResPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_RecruitLevelGifts") as MovieClip;
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
      
      public function UpdateUI(param1:TRecruitLevelGiftsData) : void
      {
         this.FLevelGiftData = param1;
         this.ConstructScroolBar();
         this.FResPanel.TF_score.text = this.FLevelGiftData.Score;
         this.UpRewardState();
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIRecruitLevelGifts = null;
         var _loc4_:TRecruitLevelGifts = null;
         this.FScrollBar.Clear();
         this.FUIListGifts = new Vector.<TUIRecruitLevelGifts>();
         _loc1_ = 0;
         while(_loc1_ < this.FLevelGiftData.LevelGifts.length)
         {
            _loc3_ = new TUIRecruitLevelGifts(this);
            _loc3_.OnRewardLevelGift = this.PerformPacket_CS_WarOrder_Reward;
            _loc3_.OnHintOver = this.OnHintOver;
            _loc3_.OnHintOut = this.OnHintOut;
            _loc4_ = this.FLevelGiftData.LevelGifts[_loc1_] as TRecruitLevelGifts;
            this.FScrollBar.AddItem(_loc3_);
            _loc3_.SetDate(_loc4_);
            this.FUIListGifts.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function UpRewardState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TRecruitLevelGifts = null;
         var _loc3_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < this.FLevelGiftData.LevelGifts.length)
         {
            _loc2_ = this.FLevelGiftData.LevelGifts[_loc1_] as TRecruitLevelGifts;
            if(_loc2_.Reward == 0 || _loc2_.TopReward == 0)
            {
               _loc3_ = true;
               break;
            }
            _loc1_++;
         }
         this.UpdateEffectGlow(_loc3_);
      }
      
      public function ProcessorUpReward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc5_:TRecruitLevelGifts = null;
         var _loc6_:TUIRecruitLevelGifts = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:int = _loc2_.readInt();
         _loc5_ = this.FLevelGiftData.GetTLevelGiftsByIdentifier(_loc3_);
         if(_loc4_ == GIFTS_NORMAL)
         {
            _loc5_.Reward = 1;
         }
         else if(_loc4_ == GIFTS_TOPUP)
         {
            _loc5_.TopReward = 1;
         }
         this.UpRewardState();
         var _loc7_:int = 0;
         while(_loc7_ < this.FUIListGifts.length)
         {
            _loc6_ = this.FUIListGifts[_loc7_] as TUIRecruitLevelGifts;
            if(_loc6_.LevelGifts.Identifier == _loc3_)
            {
               _loc6_.SetDate(_loc5_);
               break;
            }
            _loc7_++;
         }
      }
      
      protected function PerformPacket_CS_WarOrder_Reward(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Recruit_WarOrder_Reward_Req);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(this.OnHelpHintOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_DrawNinjaWarOrder);
            this.OnHelpHintOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(this.OnHelpHintOut != null)
         {
            this.OnHelpHintOut(this);
         }
      }
      
      protected function OnCloseHandle(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
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
   }
}

