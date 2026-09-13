package Processors.Game.Lobby.TransmigrationAccessory
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TNewornament_battle;
   import Logics.DatebaseVO.VO.TNewornament_config;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Logics.TransmigrationAccessory.TTransmigrationAccessoryData;
   import Processors.Game.Lobby.TransmigrationAccessory.Component.TUIStage;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTransmigrationAccessoryStage extends TProcessorGame
   {
      
      protected static const MAX_STAGE_COUNT:uint = 5;
      
      protected static const MAX_SLOT_COUNT:uint = 8;
      
      protected var FScene:MovieClip;
      
      protected var FUIStageVect:Vector.<TUIStage>;
      
      protected var FBaseSlot:TUISlot;
      
      protected var FSlotVect:Vector.<TUISlot>;
      
      protected var FBaseInventoriesIds:Vector.<uint>;
      
      protected var FBaseInventoriesCounts:Vector.<uint>;
      
      protected var FBaseInventories:TInventories;
      
      protected var FSlotInventoriesIds:Vector.<uint>;
      
      protected var FSlotInventoriesCounts:Vector.<uint>;
      
      protected var FSlotInventories:TInventories;
      
      protected var FShowIndex:uint;
      
      protected var FMaxStage:uint;
      
      protected var FAccessoryCampaign:TAccessoryCampaign;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FNewornament_config:TNewornament_config;
      
      protected var FNewornament_battle:TNewornament_battle;
      
      protected var FTransmigrationAccessoryData:TTransmigrationAccessoryData;
      
      protected var FIsInit:Boolean;
      
      protected var FGotoCampaign:Function;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnQuerySubscript:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      public function TProcessorWindowTransmigrationAccessoryStage(param1:TUIComponent)
      {
         super(param1);
         this.FTransmigrationAccessoryData = SLogicsCore.TransmigrationAccessoryData;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIStageVect = new Vector.<TUIStage>();
         this.FShowIndex = 0;
         this.FBaseInventoriesIds = new Vector.<uint>();
         this.FBaseInventoriesCounts = new Vector.<uint>();
         this.FBaseInventories = new TInventories();
         this.FSlotInventoriesIds = new Vector.<uint>();
         this.FSlotInventoriesCounts = new Vector.<uint>();
         this.FSlotInventories = new TInventories();
         this.FIsInit = false;
      }
      
      protected function UpdateStage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIStage = null;
         var _loc4_:TNewornament_battle = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_STAGE_COUNT)
         {
            _loc3_ = this.FUIStageVect[_loc1_];
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_battle,this.FNewornament_config.StageStartId + this.FShowIndex + _loc1_) as TNewornament_battle;
            _loc3_.SetData(this.FAccessoryCampaign,this.FNewornament_config,_loc4_);
            _loc1_++;
         }
         this.CheckBtn();
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FBaseInventoriesIds.length = 0;
         this.FBaseInventoriesCounts.length = 0;
         this.FBaseInventories.Clear();
         if(this.FNewornament_battle)
         {
            this.FBaseInventoriesIds.push(this.FNewornament_battle.BaseAwardItem[0]["code"]);
            this.FBaseInventoriesCounts.push(this.FNewornament_battle.BaseAwardItem[0]["amount"]);
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FBaseInventories,this.FBaseInventoriesIds);
         if(this.FBaseInventoriesCounts.length > 0)
         {
            this.FBaseInventories.GetInventoryByIndex(0).Quantity = this.FBaseInventoriesCounts[0];
            this.FBaseSlot.Context = this.FBaseInventories.GetInventoryByIndex(0);
            this.FBaseSlot.Visible = true;
         }
         else
         {
            this.FBaseSlot.Visible = false;
         }
         this.FSlotInventoriesIds.length = 0;
         this.FSlotInventoriesCounts.length = 0;
         this.FSlotInventories.Clear();
         if(this.FNewornament_battle)
         {
            _loc2_ = this.FNewornament_battle.GoldAwardItem.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FSlotInventoriesIds.push(this.FNewornament_battle.GoldAwardItem[_loc1_]["value"][0]["code"]);
               this.FSlotInventoriesCounts.push(this.FNewornament_battle.GoldAwardItem[_loc1_]["value"][0]["amount"]);
               _loc1_++;
            }
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSlotInventories,this.FSlotInventoriesIds);
         _loc2_ = uint(this.FSlotInventories.Count);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSlotInventories.GetInventoryByIndex(_loc1_).Quantity = this.FSlotInventoriesCounts[_loc1_];
            _loc1_++;
         }
         _loc2_ = uint(this.FSlotInventories.Count);
         _loc1_ = 0;
         while(_loc1_ < MAX_SLOT_COUNT)
         {
            _loc3_ = this.FSlotVect[_loc1_];
            if(_loc1_ < _loc2_)
            {
               _loc3_.Context = this.FSlotInventories.GetInventoryByIndex(_loc1_);
               _loc3_.Visible = true;
            }
            else
            {
               _loc3_.Visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         if(this.FNewornament_battle)
         {
            this.FScene["tf_Step"].text = this.FNewornament_battle.SStageID - 1 + "/" + this.FNewornament_config.CampaignCount;
            this.FScene["btn_Fight"].visible = true;
         }
         else
         {
            this.FScene["tf_Step"].text = this.FNewornament_config.CampaignCount + "/" + this.FNewornament_config.CampaignCount;
            this.FScene["btn_Fight"].visible = false;
         }
         this.FScene["tf_Exp"].text = "" + this.FNewornament_config.ExpAward;
         this.FScene["tf_Money"].text = "" + this.FNewornament_config.MoneyAward;
      }
      
      protected function CheckBtn() : void
      {
         this.FScene["btn_left"].visible = Boolean(this.FShowIndex > 0);
         this.FScene["btn_right"].visible = Boolean(this.FShowIndex < this.FMaxStage - MAX_STAGE_COUNT);
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
      
      protected function OnLeftClick(param1:MouseEvent) : void
      {
         --this.FShowIndex;
         if(this.FShowIndex < 0)
         {
            this.FShowIndex = 0;
         }
         this.UpdateStage();
         this.CheckBtn();
      }
      
      protected function OnRightClick(param1:MouseEvent) : void
      {
         ++this.FShowIndex;
         if(this.FShowIndex >= this.FMaxStage - MAX_STAGE_COUNT)
         {
            this.FShowIndex = this.FMaxStage - MAX_STAGE_COUNT;
         }
         this.UpdateStage();
         this.CheckBtn();
      }
      
      protected function OnBackClick(param1:MouseEvent) : void
      {
         if(this.FGotoCampaign != null)
         {
            this.FGotoCampaign(this);
         }
      }
      
      protected function OnFightClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationAccessory_Challenge_Req);
         _loc2_.Data.writeUnsignedInt(this.FAccessoryCampaign.CurStageId == 0 ? this.FNewornament_config.StageStartId : uint(this.FAccessoryCampaign.CurStageId + 1));
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function get GotoCampaign() : Function
      {
         return this.FGotoCampaign;
      }
      
      public function set GotoCampaign(param1:Function) : void
      {
         this.FGotoCampaign = param1;
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
      
      public function SetScene(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TUIStage = null;
         var _loc5_:TUISlot = null;
         this.FScene = param1;
         addChild(this.FScene);
         _loc2_ = 0;
         while(_loc2_ < MAX_STAGE_COUNT)
         {
            _loc4_ = new TUIStage(this.FScene["mc_Stage" + _loc2_]);
            this.FUIStageVect.push(_loc4_);
            _loc2_++;
         }
         this.FScene["btn_left"].addEventListener(MouseEvent.CLICK,this.OnLeftClick);
         this.FScene["btn_right"].addEventListener(MouseEvent.CLICK,this.OnRightClick);
         TGameUtil.setButtonMode(this.FScene["btn_Back"],true);
         TGameUtil.setButtonMode(this.FScene["btn_Fight"],true);
         this.FScene["btn_Back"].addEventListener(MouseEvent.CLICK,this.OnBackClick);
         this.FScene["btn_Fight"].addEventListener(MouseEvent.CLICK,this.OnFightClick);
         this.FBaseSlot = new TUISlot(this);
         this.FBaseSlot.Resource = this.FScene["mc_BaseSlot"] as Sprite;
         this.FBaseSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FBaseSlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FBaseSlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FBaseSlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FBaseSlot.OnQuerySubscript = this.OnSlotsOnQuerySubscript;
         this.FBaseSlot.Init();
         this.FSlotVect = new Vector.<TUISlot>();
         _loc2_ = 0;
         while(_loc2_ < MAX_SLOT_COUNT)
         {
            _loc5_ = new TUISlot(this);
            _loc5_.Resource = this.FScene["mc_Slot" + _loc2_] as Sprite;
            _loc5_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc5_.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
            _loc5_.OnOverlay = this.OnUIComponentsHintOnOver;
            _loc5_.OnOut = this.OnUIComponentsHintOnOut;
            _loc5_.OnQuerySubscript = this.OnSlotsOnQuerySubscript;
            _loc5_.Init();
            this.FSlotVect.push(_loc5_);
            _loc2_++;
         }
         this.FIsInit = true;
      }
      
      public function Update() : void
      {
         this.FNewornament_battle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_battle,this.FAccessoryCampaign.CurStageId == 0 ? this.FNewornament_config.StageStartId : uint(this.FAccessoryCampaign.CurStageId + 1)) as TNewornament_battle;
         if(this.FNewornament_battle)
         {
            this.FShowIndex = Math.max(this.FNewornament_battle.SStageID - 3,0);
            if(this.FShowIndex >= this.FMaxStage - MAX_STAGE_COUNT)
            {
               this.FShowIndex = this.FMaxStage - MAX_STAGE_COUNT;
            }
         }
         this.UpdateStage();
         this.UpdateSlot();
         this.UpdateText();
      }
      
      public function SetData(param1:TAccessoryCampaign) : void
      {
         this.FAccessoryCampaign = param1;
         this.FNewornament_config = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Newornament_config,param1.CampaignId) as TNewornament_config;
         this.FMaxStage = this.FNewornament_config.CampaignCount;
         this.Update();
         this.CheckBtn();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIStage = null;
         var _loc3_:TUISlot = null;
         if(!this.FIsInit)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_STAGE_COUNT)
         {
            _loc2_ = this.FUIStageVect[_loc1_];
            _loc2_.UpdateImage();
            _loc1_++;
         }
         this.FBaseSlot.Update();
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

