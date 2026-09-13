package Processors.Game.Lobby.Wing
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TWingBattleConfig;
   import Logics.DatebaseVO.VO.TWingConfig;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Logics.Wing.TWing;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Wing.Component.TUIStage;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIWingBattleStage extends TUIBaseWindow
   {
      
      protected static const MAX_STAGE_COUNT:uint = 5;
      
      protected static const MAX_SLOT_COUNT:uint = 8;
      
      protected var FWing:TWing;
      
      protected var FUIStageVect:Vector.<TUIStage>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FShowIndex:uint;
      
      protected var FMaxStage:uint;
      
      protected var FTrialCampaign:TTrialCampaign;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FWingConfig:TWingConfig;
      
      protected var FWingBattleConfig:TWingBattleConfig;
      
      protected var FIsInit:Boolean;
      
      public function TUIWingBattleStage(param1:TUIComponent)
      {
         super(param1);
         this.FWing = SLogicsCore.Character.Wing;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIStageVect = new Vector.<TUIStage>();
         this.FShowIndex = 0;
         this.FIsInit = false;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIStage = null;
         super.Resources_UIDispatch(param1);
         this.FShowItem = new TUIShowItem(this,MAX_SLOT_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         _loc2_ = 0;
         while(_loc2_ < MAX_STAGE_COUNT)
         {
            _loc5_ = new TUIStage(FMC_Scene["mc_Stage" + _loc2_]);
            this.FUIStageVect.push(_loc5_);
            _loc2_++;
         }
         FMC_Scene["btn_left"].addEventListener(MouseEvent.CLICK,this.OnLeftClick,false,0,true);
         FMC_Scene["btn_right"].addEventListener(MouseEvent.CLICK,this.OnRightClick,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene["btn_Back"],true);
         FMC_Scene["btn_Back"].addEventListener(MouseEvent.CLICK,this.OnBackClick,false,0,true);
         TGameUtil.setButtonMode(FMC_Scene["btn_Fight"],true);
         FMC_Scene["btn_Fight"].addEventListener(MouseEvent.CLICK,this.OnFightClick,false,0,true);
         this.FIsInit = true;
      }
      
      protected function UpdateStage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIStage = null;
         var _loc4_:TWingBattleConfig = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_STAGE_COUNT)
         {
            _loc3_ = this.FUIStageVect[_loc1_];
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingBattleConfig,this.FWingConfig.StageStartId + this.FShowIndex + _loc1_) as TWingBattleConfig;
            _loc3_.SetData(this.FTrialCampaign,this.FWingConfig,_loc4_);
            _loc1_++;
         }
         this.CheckBtn();
      }
      
      protected function CheckBtn() : void
      {
         FMC_Scene["btn_left"].visible = Boolean(this.FShowIndex > 0);
         FMC_Scene["btn_right"].visible = Boolean(this.FShowIndex < this.FMaxStage - MAX_STAGE_COUNT);
      }
      
      protected function UpdateItems() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:Vector.<uint> = null;
         var _loc8_:TInventory = null;
         var _loc9_:TInventories = null;
         _loc6_ = new Vector.<uint>();
         _loc7_ = new Vector.<uint>();
         _loc9_ = new TInventories();
         if(!this.FWingBattleConfig)
         {
            this.FShowItem.UpdateUI(null);
            return;
         }
         _loc2_ = int(this.FWingBattleConfig.BaseAwardItem[0].length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = uint(this.FWingBattleConfig.BaseAwardItem[0][_loc1_]["type"]);
            _loc3_ = uint(this.FWingBattleConfig.BaseAwardItem[0][_loc1_]["code"]);
            _loc5_ = uint(this.FWingBattleConfig.BaseAwardItem[0][_loc1_]["amount"]);
            _loc6_.push(_loc3_);
            _loc7_.push(_loc5_);
            _loc1_++;
         }
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc9_,_loc6_);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc8_ = _loc9_.GetInventoryByIndex(_loc1_);
            _loc8_.Quantity = _loc7_[_loc1_];
            _loc1_++;
         }
         this.FShowItem.UpdateUI(_loc9_);
      }
      
      protected function UpdateText() : void
      {
         if(this.FWingBattleConfig)
         {
            FMC_Scene["tf_Step"].text = this.FWingBattleConfig.SStageID - 1 + "/" + this.FWingConfig.CampaignCount;
            FMC_Scene["btn_Fight"].visible = true;
         }
         else
         {
            FMC_Scene["tf_Step"].text = this.FWingConfig.CampaignCount + "/" + this.FWingConfig.CampaignCount;
            FMC_Scene["btn_Fight"].visible = false;
         }
         FMC_Scene["tf_RewardScore"].text = this.FWing.ColorfulFeather.toString();
         FMC_Scene["tf_Score"].text = this.FWing.Stone.toString();
      }
      
      protected function ProcessorOnFreeUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FWing))
         {
            FOnGetBox(TProcessorWing.COIN_STRENGTHEN);
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
      }
      
      protected function OnRightClick(param1:MouseEvent) : void
      {
         ++this.FShowIndex;
         if(this.FShowIndex >= this.FMaxStage - MAX_STAGE_COUNT)
         {
            this.FShowIndex = this.FMaxStage - MAX_STAGE_COUNT;
         }
         this.UpdateStage();
      }
      
      protected function OnBackClick(param1:MouseEvent) : void
      {
         if(FOnGoto != null)
         {
            FOnGoto(TProcessorWing.TAB_CAMPAIGN);
         }
      }
      
      protected function OnFightClick(param1:MouseEvent) : void
      {
         if(FOnGetBox != null)
         {
            FOnGetBox(TProcessorWing.FIGHT,this.FTrialCampaign.CampaignId);
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUIStage = null;
         if(this.FIsInit && this.visible && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < this.FUIStageVect.length)
            {
               _loc2_ = this.FUIStageVect[_loc1_];
               _loc2_.UpdateImage();
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FWingBattleConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingBattleConfig,this.FTrialCampaign.CurStageId == 0 ? this.FWingConfig.StageStartId : uint(this.FTrialCampaign.CurStageId + 1)) as TWingBattleConfig;
         if(this.FWingBattleConfig)
         {
            this.FShowIndex = Math.max(this.FWingBattleConfig.SStageID - 3,0);
            if(this.FShowIndex >= this.FMaxStage - MAX_STAGE_COUNT)
            {
               this.FShowIndex = this.FMaxStage - MAX_STAGE_COUNT;
            }
         }
         this.UpdateStage();
         this.UpdateItems();
         this.UpdateText();
      }
      
      override public function Unmount() : void
      {
      }
      
      public function SetData(param1:TTrialCampaign) : void
      {
         this.FTrialCampaign = param1;
         this.FWingConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_WingConfig,this.FTrialCampaign.CampaignId) as TWingConfig;
         this.FMaxStage = this.FWingConfig.CampaignCount;
         this.UpdateUI();
      }
   }
}

