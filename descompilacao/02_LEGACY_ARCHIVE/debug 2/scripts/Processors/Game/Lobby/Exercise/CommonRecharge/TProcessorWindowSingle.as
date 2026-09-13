package Processors.Game.Lobby.Exercise.CommonRecharge
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Logics.Exercise.CommonRecharge.TCommonRecharge;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.CommonRecharge.Compoents.TUICommonReward;
   import Resources.Strings.STRING_COMMONRECHARGE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TProcessorWindowSingle extends TProcessorLobbyWindow
   {
      
      protected static const MAX_COUNT:int = 10;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 265;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 60;
      
      protected static const ITEM_HEIGHT:Number = 60;
      
      protected static const INIT_X:Number = 0;
      
      protected static const INIT_Y:Number = 2;
      
      public static const TAB_TYPE_SINGLE:int = TProcessorCommonRecharge.TAB_TYPE_SINGLE;
      
      public static const TAB_TYPE_ACCUMULATE:int = TProcessorCommonRecharge.TAB_TYPE_ACCUMULATE;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_RewardList:Sprite;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Gold:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FCommonRecharge:TCommonRecharge;
      
      protected var FSingleRewardList:Vector.<TUICommonReward>;
      
      protected var FAccumulateRewardList:Vector.<TUICommonReward>;
      
      protected var FType:int;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      public function TProcessorWindowSingle(param1:TUIComponent)
      {
         super(param1);
         this.FCommonRecharge = SLogicsCore.CommonRecharge;
         this.FSingleRewardList = new Vector.<TUICommonReward>();
         this.FAccumulateRewardList = new Vector.<TUICommonReward>();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Sprite = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FMC_RewardList = this.FMC_Scene["MC_RewardList"];
         this.FScrollBar = new TScrollBar(this.FMC_RewardList["mc_list"],MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.ResourcesPerform_UIDispatchText();
      }
      
      protected function ResourcesPerform_UIDispatchText() : void
      {
         this.FTF_Time = this.FMC_Scene.TF_Time;
         this.FTF_Gold = this.FMC_Scene.TF_Gold;
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUICommonReward = null;
         if(this.FCommonRecharge.ChangeTabIndex == TAB_TYPE_SINGLE)
         {
            if(!this.FSingleRewardList || this.FSingleRewardList.length == 0)
            {
               this.FScrollBar.Clear();
               _loc2_ = this.FCommonRecharge.SingleInventories.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = new TUICommonReward(this);
                  _loc3_.OnOverlay = this.SlotsOnOver;
                  _loc3_.OnOut = this.SlotsOnOut;
                  _loc3_.Init();
                  _loc3_.x = INIT_X;
                  _loc3_.y = INIT_Y + _loc1_ * ITEM_HEIGHT;
                  _loc3_.Type = this.FType;
                  _loc3_.RewardList = this.FCommonRecharge.SingleInventories;
                  _loc3_.SetItemInfo(_loc1_);
                  this.FSingleRewardList.push(_loc3_);
                  this.FScrollBar.AddItem(_loc3_);
                  _loc1_++;
               }
            }
            else
            {
               this.FScrollBar.Clear();
               _loc2_ = this.FSingleRewardList.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = this.FSingleRewardList[_loc1_];
                  _loc3_.RewardList = this.FCommonRecharge.SingleInventories;
                  _loc3_.SetItemInfo(_loc1_);
                  this.FScrollBar.AddItem(this.FSingleRewardList[_loc1_]);
                  _loc1_++;
               }
            }
         }
         else if(this.FCommonRecharge.ChangeTabIndex == TAB_TYPE_ACCUMULATE)
         {
            if(!this.FAccumulateRewardList || this.FAccumulateRewardList.length == 0)
            {
               this.FScrollBar.Clear();
               _loc2_ = this.FCommonRecharge.AccumulateInventories.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = new TUICommonReward(this);
                  _loc3_.OnOverlay = this.SlotsOnOver;
                  _loc3_.OnOut = this.SlotsOnOut;
                  _loc3_.Init();
                  _loc3_.x = INIT_X;
                  _loc3_.y = INIT_Y + _loc1_ * ITEM_HEIGHT;
                  _loc3_.Type = this.FType;
                  _loc3_.RewardList = this.FCommonRecharge.AccumulateInventories;
                  _loc3_.SetItemInfo(_loc1_);
                  this.FAccumulateRewardList.push(_loc3_);
                  this.FScrollBar.AddItem(_loc3_);
                  _loc1_++;
               }
            }
            else
            {
               this.FScrollBar.Clear();
               _loc2_ = this.FAccumulateRewardList.length;
               _loc1_ = 0;
               while(_loc1_ < _loc2_)
               {
                  _loc3_ = this.FAccumulateRewardList[_loc1_];
                  _loc3_.RewardList = this.FCommonRecharge.AccumulateInventories;
                  _loc3_.SetItemInfo(_loc1_);
                  this.FScrollBar.AddItem(this.FAccumulateRewardList[_loc1_]);
                  _loc1_++;
               }
            }
         }
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Gold.text = this.FCommonRecharge.Gold + STRING_COMMONRECHARGE.FORMAT_GOLD_TEXT;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FInitialized && this.visible)
         {
            _loc2_ = int(this.FSingleRewardList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FSingleRewardList[_loc1_].UpdateSlot();
               _loc1_++;
            }
            _loc2_ = int(this.FAccumulateRewardList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FAccumulateRewardList[_loc1_].UpdateSlot();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
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
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateReward();
         this.UpdateText();
      }
      
      public function Unmount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = int(this.FSingleRewardList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FSingleRewardList[_loc1_].Unmount();
            _loc1_++;
         }
         _loc2_ = int(this.FAccumulateRewardList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FAccumulateRewardList[_loc1_].Unmount();
            _loc1_++;
         }
      }
   }
}

