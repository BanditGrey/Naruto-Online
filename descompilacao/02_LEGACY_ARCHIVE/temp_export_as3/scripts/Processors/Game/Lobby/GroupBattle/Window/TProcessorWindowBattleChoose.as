package Processors.Game.Lobby.GroupBattle.Window
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.GroupBattle.TGroupBattleData;
   import Logics.GroupBattle.TGroupBattleLevel;
   import Logics.GroupBattle.TGroupBattleLevels;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.GroupBattle.Component.TUIBattleSelect;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_GROUPBATTLE;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowBattleChoose extends TProcessorWindowTemplate
   {
      
      protected const CAPACITY_BATTLESELECT:uint = 5;
      
      protected const CAPACITY_SLOTS:uint = 4;
      
      protected const LABEL_SELECT:uint = 1;
      
      protected const LABEL_UNSELECT:uint = 2;
      
      protected const LABEL_DISABLED:uint = 3;
      
      protected var FMC_BattleUILeft:MovieClip;
      
      protected var FMC_BattleUIRight:MovieClip;
      
      protected var FMC_Slots:Sprite;
      
      protected var FMC_SlotLeft:MovieClip;
      
      protected var FMC_SlotRight:MovieClip;
      
      protected var FMC_Common:MovieClip;
      
      protected var FMC_Difficulty:MovieClip;
      
      protected var FTF_RecommendPopulation:TextField;
      
      protected var FTF_Proceeds:TextField;
      
      protected var FMC_Confirm:MovieClip;
      
      protected var FMC_Background:MovieClip;
      
      protected var FUIBattleSelects:Vector.<TUIBattleSelect>;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FPageSlotIndex:int;
      
      protected var FCurrentClickBattleUI:TUIBattleSelect;
      
      protected var FCurrentGroupBattleLevel:TGroupBattleLevel;
      
      protected var FBattleSelectIndex:int;
      
      protected var FBattleSelectMaxPages:uint;
      
      protected var FSlotIndex:int;
      
      protected var FSlotMaxPages:uint;
      
      protected var FGroupBattleData:TGroupBattleData;
      
      protected var FFilterGroupBattleLevels:TGroupBattleLevels;
      
      protected var FChallengeMissionID:uint;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FBackGroundBitmap:Bitmap;
      
      protected var FBackGroundID:uint;
      
      protected var FSlotOnOver:Function;
      
      protected var FSlotOnOut:Function;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FConfirmOnClick:Function;
      
      public function TProcessorWindowBattleChoose(param1:TUIComponent)
      {
         super(param1);
         this.InitParameter();
      }
      
      protected function InitParameter() : void
      {
         this.FUIBattleSelects = new Vector.<TUIBattleSelect>(this.CAPACITY_BATTLESELECT);
         this.FUISlots = new Vector.<TUISlot>();
         this.FGroupBattleData = SLogicsCore.GroupBattleData;
         this.FFilterGroupBattleLevels = new TGroupBattleLevels();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FBackGroundBitmap = new Bitmap();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_GROUPBATTLE.RESOURCESID_Swf_GroupBattle);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TUIBattleSelect = null;
         TGameUtil.AddWindowMask(this);
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_GROUPBATTLE.RESOURCE_ClassName_MC_BattleChoose) as Sprite;
         UIDispatch();
         this.FMC_BattleUILeft = FMainUI["MC_BattleUILeft"];
         TGameUtil.setButtonMode(this.FMC_BattleUILeft,true);
         this.FMC_BattleUIRight = FMainUI["MC_BattleUIRight"];
         TGameUtil.setButtonMode(this.FMC_BattleUIRight,true);
         this.FMC_Common = FMainUI["MC_Common"];
         this.FMC_Difficulty = FMainUI["MC_Difficulty"];
         this.FMC_Common.mouseEnabled = false;
         this.FMC_Difficulty.mouseEnabled = false;
         this.FTF_RecommendPopulation = FMainUI["TF_RecommendPopulation"];
         this.FTF_RecommendPopulation.text = STRING_GROUPBATTLE.STRING_RecommendPopulation;
         this.FTF_Proceeds = FMainUI["TF_Proceeds"];
         this.FMC_Slots = FMainUI["MC_Slots"];
         this.FMC_SlotLeft = this.FMC_Slots["MC_SlotLeft"];
         TGameUtil.setButtonMode(this.FMC_SlotLeft,true);
         this.FMC_SlotRight = this.FMC_Slots["MC_SlotRight"];
         TGameUtil.setButtonMode(this.FMC_SlotRight,true);
         this.FMC_Confirm = FMainUI["MC_Confirm"];
         TGameUtil.setButtonMode(this.FMC_Confirm,true);
         this.FMC_Background = FMainUI["MC_Background"];
         this.FMC_Background.addChild(this.FBackGroundBitmap);
         _loc2_ = this.CAPACITY_BATTLESELECT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = new TUIBattleSelect(this);
            _loc4_.Tag = _loc1_;
            _loc4_.Resource = FMainUI["MC_BattleUI_" + _loc1_] as MovieClip;
            _loc4_.BattleUIOnClick = this.ProcessorBattleUIOnClick;
            _loc4_.Init();
            this.FUIBattleSelects[_loc1_] = _loc4_;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Slots["MC_Slot_" + _loc1_] as MovieClip;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FUISlots[_loc1_] = _loc3_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         UILocations();
         this.FMC_Confirm.addEventListener(MouseEvent.CLICK,this.MCConfirmOnClick,false,0,true);
         this.FMC_Common.addEventListener(MouseEvent.CLICK,this.MCCommonOnClick,false,0,true);
         this.FMC_Difficulty.addEventListener(MouseEvent.CLICK,this.MCDifficultyOnClick,false,0,true);
         this.FMC_BattleUILeft.addEventListener(MouseEvent.CLICK,this.MCBattleUILeftOnClick,false,0,true);
         this.FMC_BattleUIRight.addEventListener(MouseEvent.CLICK,this.MCBattleUIRightOnClick,false,0,true);
         this.FMC_SlotLeft.addEventListener(MouseEvent.CLICK,this.MCSlotLeftOnClick,false,0,true);
         this.FMC_SlotRight.addEventListener(MouseEvent.CLICK,this.MCSlotRightOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         super.LogicsPerform();
         if(!Visible)
         {
            return;
         }
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc3_.Update();
            _loc1_++;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_BackgroundIcon,this.FBackGroundBitmap,CONST_MODULES.MODULE_GroupBattle,this.FBackGroundID);
      }
      
      protected function UpdateUIBattleSelect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:TGroupBattleLevels = null;
         var _loc5_:TUIBattleSelect = null;
         var _loc6_:int = 0;
         this.FFilterGroupBattleLevels.Clear();
         this.CreateFilterGroupBattleLevels();
         _loc4_ = this.FGroupBattleData.GroupBattleLevels;
         _loc2_ = this.CAPACITY_BATTLESELECT;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FUIBattleSelects[_loc1_];
            _loc6_ = _loc1_ + this.CAPACITY_BATTLESELECT * this.FBattleSelectIndex;
            _loc3_ = this.FFilterGroupBattleLevels.GetGroupBattleLevelByIndex(_loc6_);
            _loc5_.Context = _loc3_;
            _loc5_.Update();
            _loc5_.Resource.visible = _loc3_ != null;
            _loc1_++;
         }
      }
      
      protected function CheckGroupBattleLevel(param1:TGroupBattleLevel) : Boolean
      {
         var _loc2_:TGroupBattleLevel = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc4_ = this.FFilterGroupBattleLevels.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.FFilterGroupBattleLevels.GetGroupBattleLevelByIndex(_loc3_);
            if(uint(param1.LevelID / 10) == uint(_loc2_.LevelID / 10))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      protected function UpdateRewardSlots() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         var _loc6_:TInventories = null;
         var _loc7_:TGroupBattleLevel = null;
         var _loc8_:uint = 0;
         var _loc9_:TLeagueMapPve = null;
         if(this.FCurrentGroupBattleLevel == null)
         {
            return;
         }
         if(this.FMC_Common.currentFrame == 1 && this.FCurrentGroupBattleLevel.PreLevel != 0)
         {
            _loc8_ = this.FCurrentGroupBattleLevel.PreLevel;
            _loc9_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc8_) as TLeagueMapPve;
            _loc7_ = new TGroupBattleLevel();
            _loc7_.AwardInventories.Clear();
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc7_.AwardInventories,_loc9_.RewardsVect);
            _loc6_ = _loc7_.AwardInventories;
         }
         else
         {
            _loc6_ = this.FCurrentGroupBattleLevel.AwardInventories;
         }
         _loc2_ = this.CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            _loc4_ = _loc1_ + this.FSlotIndex;
            if(_loc4_ >= _loc6_.Count)
            {
               _loc5_ = null;
            }
            else
            {
               _loc5_ = _loc6_.GetInventoryByIndex(_loc4_);
            }
            _loc3_.Context = _loc5_;
            _loc3_.Resource.visible = _loc5_ != null;
            _loc1_++;
         }
      }
      
      protected function UpdateDifficultyDetailInfo() : void
      {
         var _loc1_:TLeagueMapPve = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(this.FMC_Common.currentFrame == 1 && this.FCurrentGroupBattleLevel.PreLevel != 0)
         {
            _loc3_ = this.FCurrentGroupBattleLevel.PreLevel;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc3_) as TLeagueMapPve;
            _loc2_ = _loc1_.Recommendlevel;
            _loc5_ = _loc1_.ExpAward;
            _loc6_ = _loc1_.MoneyAward;
            _loc4_ = _loc1_.BigImage;
         }
         else
         {
            _loc2_ = this.FCurrentGroupBattleLevel.RecommendLevel;
            _loc3_ = this.FCurrentGroupBattleLevel.LevelID;
            _loc5_ = this.FCurrentGroupBattleLevel.ExpAward;
            _loc6_ = this.FCurrentGroupBattleLevel.MoneyAward;
            _loc4_ = this.FCurrentGroupBattleLevel.BigImage;
         }
         this.FChallengeMissionID = _loc3_;
         this.FBackGroundID = _loc4_;
         this.FTF_Proceeds.text = TUtilityString.Format(STRING_GROUPBATTLE.STRING_BattleProceeds,_loc5_,_loc6_);
      }
      
      protected function UpdateBattleDetailInfo() : void
      {
         if(this.FCurrentGroupBattleLevel == null)
         {
            return;
         }
         if(this.FCurrentGroupBattleLevel.IsOpenLevel)
         {
            if(this.FCurrentGroupBattleLevel.PreLevel != 0)
            {
               this.MCDifficultyOnClick(null);
               this.FMC_Difficulty.mouseEnabled = true;
               this.FMC_Common.mouseEnabled = true;
            }
            else
            {
               this.FMC_Difficulty.gotoAndStop(this.LABEL_DISABLED);
               this.FMC_Common.gotoAndStop(this.LABEL_SELECT);
               this.FMC_Difficulty.mouseEnabled = false;
               this.FMC_Common.mouseEnabled = false;
            }
         }
         else
         {
            this.FMC_Difficulty.mouseEnabled = false;
            this.FMC_Common.mouseEnabled = false;
            this.FMC_Common.gotoAndStop(this.LABEL_DISABLED);
            this.FMC_Difficulty.gotoAndStop(this.LABEL_DISABLED);
         }
      }
      
      protected function CreateFilterGroupBattleLevels() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TGroupBattleLevel = null;
         var _loc4_:TGroupBattleLevels = null;
         _loc4_ = this.FGroupBattleData.GroupBattleLevels;
         _loc2_ = _loc4_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc4_.GetGroupBattleLevelByIndex(_loc1_);
            if(_loc3_.IsServerData || !_loc3_.IsOpenLevel)
            {
               if(this.FFilterGroupBattleLevels.Count == 0)
               {
                  this.FFilterGroupBattleLevels.Add(_loc3_);
               }
               else if(this.CheckGroupBattleLevel(_loc3_))
               {
                  this.FFilterGroupBattleLevels.Add(_loc3_);
               }
            }
            _loc1_++;
         }
      }
      
      protected function CheckSlotPageUI() : void
      {
         this.FMC_SlotLeft.visible = this.FSlotIndex > 0;
         this.FMC_SlotRight.visible = this.FSlotIndex != this.FSlotMaxPages;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateUIBattleSelect();
         this.ProcessorBattleUIOnClick(this.FUIBattleSelects[0],this.FUIBattleSelects[0].Context);
      }
      
      protected function ProcessorBattleUIOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TUIBattleSelect = null;
         var _loc4_:TGroupBattleLevel = null;
         var _loc5_:Boolean = false;
         _loc3_ = param1 as TUIBattleSelect;
         _loc4_ = param2 as TGroupBattleLevel;
         if(_loc4_ == null || !_loc4_.IsServerData)
         {
            return;
         }
         this.FCurrentGroupBattleLevel = _loc4_;
         this.UpdateBattleDetailInfo();
         if(this.FCurrentClickBattleUI != null)
         {
            this.FCurrentClickBattleUI.ShowSelectBox = false;
         }
         this.FCurrentClickBattleUI = _loc3_;
         this.FCurrentClickBattleUI.ShowSelectBox = true;
         this.UpdateDifficultyDetailInfo();
         this.FSlotMaxPages = this.FCurrentGroupBattleLevel.AwardInventories.Count - 4;
         this.FSlotIndex = 0;
         this.CheckSlotPageUI();
         this.UpdateRewardSlots();
      }
      
      protected function MCCommonOnClick(param1:MouseEvent) : void
      {
         this.FMC_Common.gotoAndStop(this.LABEL_SELECT);
         this.FMC_Difficulty.gotoAndStop(this.LABEL_UNSELECT);
         this.UpdateDifficultyDetailInfo();
         this.UpdateRewardSlots();
      }
      
      protected function MCDifficultyOnClick(param1:MouseEvent) : void
      {
         if(!this.FCurrentGroupBattleLevel.IsOpenLevel)
         {
            return;
         }
         if(this.FCurrentGroupBattleLevel.PreLevel == 0)
         {
            return;
         }
         this.FMC_Common.gotoAndStop(this.LABEL_UNSELECT);
         this.FMC_Difficulty.gotoAndStop(this.LABEL_SELECT);
         this.UpdateDifficultyDetailInfo();
         this.UpdateRewardSlots();
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FOnQuerySequenceContext != null)
         {
            this.FOnQuerySequenceContext(this,param2,param3);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FSlotOnOver != null)
         {
            this.FSlotOnOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FSlotOnOut != null)
         {
            this.FSlotOnOut(this,param2);
         }
      }
      
      protected function MCConfirmOnClick(param1:MouseEvent) : void
      {
         if(this.FConfirmOnClick != null)
         {
            this.FConfirmOnClick(this,this.FCurrentGroupBattleLevel,this.FMC_Common.currentFrame);
         }
      }
      
      protected function MCBattleUILeftOnClick(param1:MouseEvent) : void
      {
         --this.FBattleSelectIndex;
         if(this.FBattleSelectIndex <= 0)
         {
            this.FBattleSelectIndex = 0;
         }
         this.UpdateUIBattleSelect();
      }
      
      protected function MCBattleUIRightOnClick(param1:MouseEvent) : void
      {
         ++this.FBattleSelectIndex;
         if(this.FBattleSelectIndex >= this.FBattleSelectMaxPages)
         {
            this.FBattleSelectIndex = this.FBattleSelectMaxPages;
         }
         this.UpdateUIBattleSelect();
      }
      
      protected function MCSlotLeftOnClick(param1:MouseEvent) : void
      {
         --this.FSlotIndex;
         if(this.FSlotIndex <= 0)
         {
            this.FSlotIndex = 0;
         }
         this.UpdateRewardSlots();
         this.CheckSlotPageUI();
      }
      
      protected function MCSlotRightOnClick(param1:MouseEvent) : void
      {
         ++this.FSlotIndex;
         if(this.FSlotIndex >= this.FSlotMaxPages)
         {
            this.FSlotIndex = this.FSlotMaxPages;
         }
         this.UpdateRewardSlots();
         this.CheckSlotPageUI();
      }
      
      public function set SlotOnOver(param1:Function) : void
      {
         this.FSlotOnOver = param1;
      }
      
      public function set SlotOnOut(param1:Function) : void
      {
         this.FSlotOnOut = param1;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function set OnQuerySubscript(param1:Function) : void
      {
         this.FOnQuerySubscript = param1;
      }
      
      public function set ConfirmOnClick(param1:Function) : void
      {
         this.FConfirmOnClick = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
         this.FBattleSelectMaxPages = Math.ceil(this.FGroupBattleData.GroupBattleLevels.Count / 2 / this.CAPACITY_BATTLESELECT) - 1;
      }
      
      public function Reset() : void
      {
         this.FChallengeMissionID = 0;
         this.FBattleSelectIndex = 0;
         this.FSlotIndex = 0;
      }
   }
}

