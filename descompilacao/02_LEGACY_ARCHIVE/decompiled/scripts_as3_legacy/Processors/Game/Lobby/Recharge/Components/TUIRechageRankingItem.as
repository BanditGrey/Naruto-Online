package Processors.Game.Lobby.Recharge.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.ActivityMode.TActivityAtom;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_ACTIVITYINNER;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_RECHARGE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class TUIRechageRankingItem extends TUIComponent
   {
      
      protected var FMC_RewardItem:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FActivityAtom:TActivityAtom;
      
      protected var FResource:MovieClip;
      
      protected var FMC_Rank:MovieClip;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FStubReferences:TStubReferences;
      
      protected var BoxIndex:int;
      
      public function TUIRechageRankingItem(param1:TUIComponent, param2:int)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(5);
         this.FStubReferences = new TStubReferences(this);
         this.BoxIndex = param2;
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_RewardItem = TUtilityReflection.CreateDisplayObjectInstance(CONST_RECHARGE.RESOURCE_Link_MC_RechargeRankItem) as MovieClip;
         addChild(this.FMC_RewardItem);
         this.FMC_Rank = this.FMC_RewardItem["MC_Rank"];
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_RewardItem[CONST_ACTIVITYINNER.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.FOnQuerySequenceContext;
            _loc3_.OnOverlay = this.FOnOverlay;
            _loc3_.OnOut = this.FOnOut;
            _loc3_.OnQuerySubscript = this.FOnQuerySubscript;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FMC_Rank.gotoAndStop(1);
         if(this.BoxIndex <= 3)
         {
            this.FMC_Rank.visible = true;
            this.FMC_Rank.gotoAndStop(this.BoxIndex);
            this.FMC_RewardItem["TF_Text_0"].visible = false;
         }
         else
         {
            this.FMC_Rank.visible = false;
            this.FMC_RewardItem["TF_Text_0"].visible = true;
         }
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnQuerySubscript() : Function
      {
         return this.FOnQuerySubscript;
      }
      
      public function set OnQuerySubscript(param1:Function) : void
      {
         this.FOnQuerySubscript = param1;
      }
      
      public function get RewardItem() : MovieClip
      {
         return this.FMC_RewardItem;
      }
      
      public function set RewardItem(param1:MovieClip) : void
      {
         this.FMC_RewardItem = param1;
      }
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:uint, param2:TInventory) : void
      {
         this.FSlotList[param1].Context = param2;
         this.FSlotList[param1].Resource.visible = true;
      }
      
      public function SetText(param1:String, param2:String, param3:String) : void
      {
         this.FMC_RewardItem["TF_Text_0"].text = param1;
         this.FMC_RewardItem["TF_Text_1"].text = param2;
         this.FMC_RewardItem["TF_Text_2"].text = param3;
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FSlotList[_loc1_];
            this.FSlotList[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
   }
}

