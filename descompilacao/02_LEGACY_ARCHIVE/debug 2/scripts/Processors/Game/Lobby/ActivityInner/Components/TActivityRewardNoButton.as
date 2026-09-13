package Processors.Game.Lobby.ActivityInner.Components
{
   import Components.Slots.TUISlot;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventories;
   import Processors.Game.Lobby.Jade.TJadeCommon;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TActivityRewardNoButton extends TUIComponent
   {
      
      protected static const SlotNum:int = 6;
      
      protected var FMainScene:MovieClip;
      
      protected var FTF_Lable:TextField;
      
      protected var FSlots:Vector.<TUISlot>;
      
      protected var FOnSlotOver:Function;
      
      protected var FOnSlotOut:Function;
      
      public function TActivityRewardNoButton(param1:TUIComponent)
      {
         super(param1);
         this.UIDispatch();
      }
      
      protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TUISlot = null;
         this.FMainScene = TUtilityReflection.CreateDisplayObjectInstance("MC_RewardItemWonderful") as MovieClip;
         addChild(this.FMainScene);
         this.FSlots = new Vector.<TUISlot>();
         _loc1_ = 0;
         while(_loc1_ < SlotNum)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FMainScene["MC_Slot_" + _loc1_];
            TJadeCommon.InitSlot(_loc2_,CONST_MODULES.MODULE_ActivityInner);
            _loc2_.OnOverlay = this.MouseSlotOver;
            _loc2_.OnOut = this.MouseSlotOut;
            _loc2_.Init();
            this.FSlots.push(_loc2_);
            _loc1_++;
         }
         this.FTF_Lable = this.FMainScene["TF_Text"];
      }
      
      protected function MouseSlotOver(param1:Object, param2:Object) : void
      {
         if(this.FOnSlotOver != null)
         {
            this.FOnSlotOver(param1,param2);
         }
      }
      
      protected function MouseSlotOut(param1:Object, param2:Object) : void
      {
         if(this.FOnSlotOut != null)
         {
            this.FOnSlotOut(param1,param2);
         }
      }
      
      public function set OnSlotOver(param1:Function) : void
      {
         this.FOnSlotOver = param1;
      }
      
      public function set OnSlotOut(param1:Function) : void
      {
         this.FOnSlotOut = param1;
      }
      
      public function FlushData(param1:String, param2:TInventories) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FTF_Lable.text = param1;
         _loc4_ = param2.Count;
         _loc3_ = 0;
         while(_loc3_ < this.FSlots.length)
         {
            if(_loc3_ < _loc4_)
            {
               this.FSlots[_loc3_].Context = param2.GetInventoryByIndex(_loc3_);
            }
            else
            {
               this.FSlots[_loc3_].Resource.visible = false;
            }
            _loc3_++;
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FSlots.length)
         {
            this.FSlots[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

