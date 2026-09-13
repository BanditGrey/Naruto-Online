package Processors.Game.Lobby.TransmigrationTrial
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
   import Logics.DatebaseVO.VO.TEpicConfig;
   import Logics.DatebaseVO.VO.TEpicEquip_battle;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TransmigrationTrial.TTransmigrationTrialData;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Processors.Game.Lobby.TransmigrationTrial.Component.TUIStage;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_TRANSMIGRATIONTRIAL;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowTransmigrationTrialStage extends TProcessorGame
   {
      
      protected static const MAX_STAGE_COUNT:uint = 5;
      
      protected static const MAX_SLOT_COUNT:uint = 8;
      
      protected var FScene:MovieClip;
      
      protected var FUIStageVect:Vector.<TUIStage>;
      
      protected var FBaseSlot:TUISlot;
      
      protected var FGoldSlot:TUISlot;
      
      protected var FSlotVect:Vector.<TUISlot>;
      
      protected var FBaseInventoriesIds:Vector.<uint>;
      
      protected var FBaseInventoriesCounts:Vector.<uint>;
      
      protected var FBaseInventories:TInventories;
      
      protected var FGoldInventoriesIds:Vector.<uint>;
      
      protected var FGoldInventoriesCounts:Vector.<uint>;
      
      protected var FGoldInventories:TInventories;
      
      protected var FSlotInventoriesIds:Vector.<uint>;
      
      protected var FSlotInventoriesCounts:Vector.<uint>;
      
      protected var FSlotInventories:TInventories;
      
      protected var FShowIndex:uint;
      
      protected var FMaxStage:uint;
      
      protected var FTrialCampaign:TTrialCampaign;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FEpicConfig:TEpicConfig;
      
      protected var FEpicEquip_battle:TEpicEquip_battle;
      
      protected var FTransmigrationTrialData:TTransmigrationTrialData;
      
      protected var FIsInit:Boolean;
      
      protected var FGotoCampaign:Function;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnQuerySubscript:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      protected var FShowChangeView:Function;
      
      public function TProcessorWindowTransmigrationTrialStage(param1:TUIComponent)
      {
         super(param1);
         this.FTransmigrationTrialData = SLogicsCore.TransmigrationTrialData;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIStageVect = new Vector.<TUIStage>();
         this.FShowIndex = 0;
         this.FBaseInventoriesIds = new Vector.<uint>();
         this.FBaseInventoriesCounts = new Vector.<uint>();
         this.FBaseInventories = new TInventories();
         this.FGoldInventoriesIds = new Vector.<uint>();
         this.FGoldInventoriesCounts = new Vector.<uint>();
         this.FGoldInventories = new TInventories();
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
         var _loc4_:TEpicEquip_battle = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_STAGE_COUNT)
         {
            _loc3_ = this.FUIStageVect[_loc1_];
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EpicEquip_battle,this.FEpicConfig.StageStartId + this.FShowIndex + _loc1_) as TEpicEquip_battle;
            _loc3_.SetData(this.FTrialCampaign,this.FEpicConfig,_loc4_);
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
         if(this.FEpicEquip_battle)
         {
            this.FBaseInventoriesIds.push(this.FEpicEquip_battle.BaseAwardItem[0]["code"]);
            this.FBaseInventoriesCounts.push(this.FEpicEquip_battle.BaseAwardItem[0]["amount"]);
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
         this.FGoldInventoriesIds.length = 0;
         this.FGoldInventoriesCounts.length = 0;
         this.FGoldInventories.Clear();
         if(Boolean(this.FEpicEquip_battle) && this.FEpicEquip_battle.GoldAwardItem.length > 0)
         {
            this.FGoldInventoriesIds.push(this.FEpicEquip_battle.GoldAwardItem[0]["value"][0]["code"]);
            this.FGoldInventoriesCounts.push(this.FEpicEquip_battle.GoldAwardItem[0]["value"][0]["amount"]);
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FGoldInventories,this.FGoldInventoriesIds);
            this.FGoldInventories.GetInventoryByIndex(0).Quantity = this.FGoldInventoriesCounts[0];
            this.FGoldSlot.Context = this.FGoldInventories.GetInventoryByIndex(0);
            this.FGoldSlot.Visible = true;
         }
         else
         {
            this.FGoldSlot.Visible = false;
         }
         this.FSlotInventoriesIds.length = 0;
         this.FSlotInventoriesCounts.length = 0;
         this.FSlotInventories.Clear();
         if(this.FEpicEquip_battle)
         {
            _loc2_ = this.FEpicEquip_battle.PieceAwardItem.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FSlotInventoriesIds.push(this.FEpicEquip_battle.PieceAwardItem[_loc1_]["value"][0]["code"]);
               this.FSlotInventoriesCounts.push(this.FEpicEquip_battle.PieceAwardItem[_loc1_]["value"][0]["amount"]);
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
         if(this.FEpicEquip_battle)
         {
            this.FScene["tf_Step"].text = this.FEpicEquip_battle.SStageID - 1 + "/" + this.FEpicConfig.CampaignCount;
            this.FScene["tf_RewardScore"].text = "" + this.FEpicEquip_battle.PiecepoitAwardItem[0]["amount"];
            this.FScene["btn_Fight"].visible = true;
         }
         else
         {
            this.FScene["tf_Step"].text = this.FEpicConfig.CampaignCount + "/" + this.FEpicConfig.CampaignCount;
            this.FScene["tf_RewardScore"].text = "0";
            this.FScene["btn_Fight"].visible = false;
         }
         this.FScene["tf_Score"].text = "" + this.FTransmigrationTrialData.ScoreList[this.FEpicConfig.PointType];
         this.FScene["tf_ScoreType"].text = STRING_TRANSMIGRATIONTRIAL.STRING_Reward + STRING_TRANSMIGRATIONTRIAL.STRING_ReincarnatonScore[this.FEpicConfig.PointType - 32] + ":";
         this.FScene["tf_CurScoreType"].text = STRING_TRANSMIGRATIONTRIAL.STRING_CurScoreType + STRING_TRANSMIGRATIONTRIAL.STRING_ReincarnatonScore[this.FEpicConfig.PointType - 32] + ":";
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
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TransmigrationTrial_Challenge_Req);
         _loc2_.Data.writeUnsignedInt(this.FTrialCampaign.CurStageId == 0 ? this.FEpicConfig.StageStartId : uint(this.FTrialCampaign.CurStageId + 1));
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function OnChangeClick(param1:MouseEvent) : void
      {
         if(this.FShowChangeView != null)
         {
            this.FShowChangeView(this);
         }
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
      
      public function get ShowChangeView() : Function
      {
         return this.FShowChangeView;
      }
      
      public function set ShowChangeView(param1:Function) : void
      {
         this.FShowChangeView = param1;
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
         TGameUtil.setButtonMode(this.FScene["btn_change"],true);
         this.FScene["btn_Back"].addEventListener(MouseEvent.CLICK,this.OnBackClick);
         this.FScene["btn_Fight"].addEventListener(MouseEvent.CLICK,this.OnFightClick);
         this.FScene["btn_change"].addEventListener(MouseEvent.CLICK,this.OnChangeClick);
         this.FBaseSlot = new TUISlot(this);
         this.FBaseSlot.Resource = this.FScene["mc_BaseSlot"] as Sprite;
         this.FBaseSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FBaseSlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FBaseSlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FBaseSlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FBaseSlot.OnQuerySubscript = this.OnSlotsOnQuerySubscript;
         this.FBaseSlot.Init();
         this.FGoldSlot = new TUISlot(this);
         this.FGoldSlot.Resource = this.FScene["mc_GoldSlot"] as Sprite;
         this.FGoldSlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FGoldSlot.OnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FGoldSlot.OnOverlay = this.OnUIComponentsHintOnOver;
         this.FGoldSlot.OnOut = this.OnUIComponentsHintOnOut;
         this.FGoldSlot.OnQuerySubscript = this.OnSlotsOnQuerySubscript;
         this.FGoldSlot.Init();
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
         this.FEpicEquip_battle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EpicEquip_battle,this.FTrialCampaign.CurStageId == 0 ? this.FEpicConfig.StageStartId : uint(this.FTrialCampaign.CurStageId + 1)) as TEpicEquip_battle;
         if(this.FEpicEquip_battle)
         {
            this.FShowIndex = Math.max(this.FEpicEquip_battle.SStageID - 3,0);
            if(this.FShowIndex >= this.FMaxStage - MAX_STAGE_COUNT)
            {
               this.FShowIndex = this.FMaxStage - MAX_STAGE_COUNT;
            }
         }
         this.UpdateStage();
         this.UpdateSlot();
         this.UpdateText();
      }
      
      public function SetData(param1:TTrialCampaign) : void
      {
         this.FTrialCampaign = param1;
         this.FEpicConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EpicConfig,this.FTrialCampaign.CampaignId) as TEpicConfig;
         this.FMaxStage = this.FEpicConfig.CampaignCount;
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
         this.FGoldSlot.Update();
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

