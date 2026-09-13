package Processors.Game.Lobby.Recharge.Components
{
   import Components.Slots.TUISlot;
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_RECHARGE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TUIRewardItem extends TUIComponent
   {
      
      protected static const CAPACITY_SLOTS:uint = 6;
      
      protected static const Size_Width:uint = 118;
      
      protected static const Size_Height:uint = 62;
      
      protected var FMC_RewardItem:MovieClip;
      
      protected var FTF_Text:TextField;
      
      protected var FBTN_GetReward:MovieClip;
      
      protected var FMC_HasRecieved:MovieClip;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      protected var FOnGetReward:Function;
      
      protected var FIdentifier:uint;
      
      public function TUIRewardItem(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>(CAPACITY_SLOTS);
         this.Initialization();
         this.FStubReferences = new TStubReferences(this);
      }
      
      protected function Initialization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FMC_RewardItem = TUtilityReflection.CreateDisplayObjectInstance(CONST_RECHARGE.RESOURCE_ClassName_MC_RewardItem) as MovieClip;
         addChild(this.FMC_RewardItem);
         this.FTF_Text = this.FMC_RewardItem[CONST_RECHARGE.RESOURCE_Link_TF_Text];
         this.FTF_Text.mouseEnabled = false;
         this.FTF_Text.autoSize = "center";
         this.FBTN_GetReward = this.FMC_RewardItem[CONST_RECHARGE.RESOURCE_Link_BTN_GetReward];
         this.FMC_HasRecieved = this.FMC_RewardItem[CONST_RECHARGE.RESOURCE_Link_MC_HasRecieved];
         if(this.FBTN_GetReward != null)
         {
            this.FBTN_GetReward.mouseEnabled = true;
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
         }
         _loc2_ = CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_RewardItem[CONST_RECHARGE.RESOURCE_Link_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.ProcessorOnQuerySequenceContext;
            _loc3_.OnOverlay = this.ProcessorOnOverlay;
            _loc3_.OnOut = this.ProcessorOnOut;
            _loc3_.OnQuerySubscript = this.ProcessorOnQuerySubscript;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
         this.FBTN_GetReward.addEventListener(MouseEvent.CLICK,this.ButtonGetRewardOnClick,false,0,true);
      }
      
      protected function SetTextLocatian() : void
      {
         this.FTF_Text.x = 15 + (Size_Width - this.FTF_Text.width) / 2;
         this.FTF_Text.y = 4 + (Size_Height - this.FTF_Text.height) / 2;
      }
      
      protected function ButtonGetRewardOnClick(param1:MouseEvent) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(this,this.FIdentifier);
         }
      }
      
      protected function ProcessorOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         if(this.FOnQuerySequenceContext != null)
         {
            this.FOnQuerySequenceContext(this,param2,param3,param4);
         }
      }
      
      protected function ProcessorOnOverlay(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function ProcessorOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FOnQuerySubscript != null)
         {
            this.FOnQuerySubscript(this,param2,param3);
         }
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
      
      public function get Identifier() : uint
      {
         return this.FIdentifier;
      }
      
      public function set Identifier(param1:uint) : void
      {
         this.FIdentifier = param1;
      }
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function Init() : void
      {
         this.Initialization();
      }
      
      public function SetItemInfo(param1:String, param2:TInventories, param3:int = 0, param4:uint = 18) : void
      {
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:TextFormat = null;
         _loc7_ = new TextFormat();
         _loc7_.size = param4;
         this.FTF_Text.defaultTextFormat = _loc7_;
         this.FTF_Text.text = param1;
         this.SetTextLocatian();
         _loc6_ = uint(param2.Count);
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            this.FSlotList[_loc5_].Context = param2.GetInventoryByIndex(_loc5_);
            this.FSlotList[_loc5_].Resource.visible = true;
            _loc5_++;
         }
         if(param3 == -1)
         {
            this.FMC_HasRecieved.visible = true;
            this.FMC_HasRecieved.play();
            this.FBTN_GetReward.visible = false;
         }
         else if(param3 == 0)
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,false);
            this.FBTN_GetReward.mouseEnabled = false;
            this.FBTN_GetReward.visible = true;
            this.FMC_HasRecieved.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_GetReward,true);
            this.FBTN_GetReward.mouseEnabled = true;
            this.FBTN_GetReward.visible = true;
            this.FMC_HasRecieved.visible = false;
         }
      }
      
      public function Release() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = CAPACITY_SLOTS;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSlotList[_loc1_].Resource.visible = false;
            this.FSlotList[_loc1_].Context = null;
            _loc1_++;
         }
         this.FTF_Text.text = "";
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
   }
}

