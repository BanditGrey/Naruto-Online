package Processors.Game.Lobby.TransmigrationTrial.Component
{
   import Components.Slots.TUISlot;
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TEpicExchange;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TRANSMIGRATIONTRIAL;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUIChange extends TProcessorGame
   {
      
      protected static const CONST_TAB_MAX:uint = 3;
      
      protected static const MAX_SLOT_COUNT:uint = 8;
      
      protected var FScene:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FSlotVect:Vector.<TUISlot>;
      
      protected var FEpicId:Vector.<uint>;
      
      protected var FInventoriesIds:Vector.<uint>;
      
      protected var FInventoriesCosts:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectItemIndex:uint;
      
      protected var FSelectIndex:uint;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnQuerySubscript:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      public function TUIChange(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_TRANSMIGRATIONTRIAL.RESOURCE_ClassName_ChangeFragment) as MovieClip;
         addChild(this.FScene);
         this.FScene.x = (FUICore.StageWidth - this.FScene.width) / 2;
         this.FScene.y = (FUICore.StageHeight - this.FScene.height) / 2;
         this.graphics.beginFill(0,0.2);
         this.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.graphics.endFill();
         this.InitView();
         this.Update();
      }
      
      protected function InitView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TBins = null;
         var _loc5_:TEpicExchange = null;
         this.FUITab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < CONST_TAB_MAX)
         {
            this.FUITab.SetTabByIndex(this.FScene["mc_tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FSlotVect = new Vector.<TUISlot>();
         _loc1_ = 0;
         while(_loc1_ < MAX_SLOT_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FScene["mc_Slot" + _loc1_] as Sprite;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.OnUIComponentsHintOnOver;
            _loc3_.OnOut = this.OnUIComponentsHintOnOut;
            _loc3_.OnQuerySubscript = this.OnSlotsOnQuerySubscript;
            _loc3_.OnClick = this.OnSlotClick;
            _loc3_.Init();
            this.FSlotVect.push(_loc3_);
            _loc1_++;
         }
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FEpicId = new Vector.<uint>();
         this.FInventoriesIds = new Vector.<uint>();
         this.FInventoriesCosts = new Vector.<uint>();
         this.FInventories = new TInventories();
         _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EpicExchange);
         _loc2_ = uint(_loc4_.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = _loc4_.GetDatebaseByIndex(_loc1_) as TEpicExchange;
            this.FEpicId.push(_loc5_.Identifier);
            this.FInventoriesIds.push(_loc5_.PieceId);
            this.FInventoriesCosts.push(_loc5_.ExchangeCost);
            _loc1_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FInventoriesIds);
         TGameUtil.setButtonMode(this.FScene["btn_Change"],true);
         this.FScene["btn_Close"].addEventListener(MouseEvent.CLICK,this.OnCloseClick);
         this.FScene["btn_Change"].addEventListener(MouseEvent.CLICK,this.OnChangeClick);
      }
      
      protected function OnSlotClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TAppliance = null;
         var _loc4_:uint = 0;
         _loc3_ = param2 as TAppliance;
         _loc4_ = this.FInventoriesIds.indexOf(_loc3_.IDTemplate);
         if(_loc4_ >= 0)
         {
            this.FSelectItemIndex = _loc4_ % MAX_SLOT_COUNT;
         }
         this.Update();
      }
      
      protected function OnSlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence) : void
      {
         if(this.FSlotsOnQuerySequenceContext != null)
         {
            this.FSlotsOnQuerySequenceContext(param1,param2,param3);
         }
      }
      
      protected function OnSlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FSlotsOnQuerySubscript != null)
         {
            this.FSlotsOnQuerySubscript(param1,param2,param3);
         }
      }
      
      protected function OnUIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function OnUIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FSelectIndex = param1 as int;
         this.Update();
      }
      
      protected function OnCloseClick(param1:MouseEvent) : void
      {
         Visible = false;
      }
      
      protected function OnChangeClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationTrial_ChangeFragment_Req);
         _loc2_.Data.writeUnsignedInt(this.FEpicId[this.FSelectItemIndex + MAX_SLOT_COUNT * this.FSelectIndex]);
         _loc2_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function get SlotsOnQuerySequenceContext() : Function
      {
         return this.FSlotsOnQuerySequenceContext;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function get SlotsOnQuerySubscript() : Function
      {
         return this.FSlotsOnQuerySubscript;
      }
      
      public function set SlotsOnQuerySubscript(param1:Function) : void
      {
         this.FSlotsOnQuerySubscript = param1;
      }
      
      public function get UIComponentsHintOnOver() : Function
      {
         return this.FUIComponentsHintOnOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function get UIComponentsHintOnOut() : Function
      {
         return this.FUIComponentsHintOnOut;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_SLOT_COUNT)
         {
            _loc3_ = this.FSlotVect[_loc1_];
            _loc3_.Context = this.FInventories.GetInventoryByIndex(_loc1_ + MAX_SLOT_COUNT * this.FSelectIndex);
            this.FScene["tf_need" + _loc1_].text = "" + this.FInventoriesCosts[_loc1_ + MAX_SLOT_COUNT * this.FSelectIndex];
            this.FScene["tf_ScoreName" + _loc1_].text = "" + STRING_TRANSMIGRATIONTRIAL.STRING_ReincarnatonScore[this.FSelectIndex];
            this.FScene["mc_Slot" + _loc1_]["MC_Selected"].visible = Boolean(_loc1_ == this.FSelectItemIndex);
            _loc1_++;
         }
         this.FScene["tf_Score0"].text = "" + SLogicsCore.TransmigrationTrialData.ScoreList[32];
         this.FScene["tf_Score1"].text = "" + SLogicsCore.TransmigrationTrialData.ScoreList[33];
         this.FScene["tf_Score2"].text = "" + SLogicsCore.TransmigrationTrialData.ScoreList[36];
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_SLOT_COUNT)
         {
            _loc3_ = this.FSlotVect[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
      }
   }
}

