package Processors.Game.Lobby.Exercise.RechargeRank
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Logics.Exercise.RechargeRank.TRechargeRank;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.RechargeRank.Compoents.TUIPerReward;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TProcessorWindowPointReward extends TProcessorLobbyWindow
   {
      
      protected static const MIN_SCROLL_HEIGHT:Number = 262;
      
      protected static const ITEM_STAMP:Number = 1;
      
      protected static const SINGLE_ITEM_STAMP:Number = 66;
      
      protected static const ITEM_HEIGHT:Number = 66;
      
      protected static const INIT_X:Number = 0;
      
      protected static const INIT_Y:Number = 0;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FTF_Desc:TextField;
      
      protected var FMC_CurRank:MovieClip;
      
      protected var FTF_Rank:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FRechargeRank:TRechargeRank;
      
      protected var FRewardList:Vector.<TUIPerReward>;
      
      protected var FOnGetReward:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      public function TProcessorWindowPointReward(param1:TUIComponent)
      {
         super(param1);
         this.FRewardList = new Vector.<TUIPerReward>();
         this.FRechargeRank = SLogicsCore.RechargeRank;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = this.FMC_Scene["MC_RewardList"];
         this.FScrollBar = new TScrollBar(_loc2_.mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.ResourcesPerform_UIDispatchText();
      }
      
      protected function ResourcesPerform_UIDispatchText() : void
      {
         this.FTF_Desc = this.FMC_Scene.TF_Desc;
         this.FTF_Rank = this.FMC_Scene.TF_Rank;
      }
      
      protected function UpdateReward() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIPerReward = null;
         if(!this.FRewardList || this.FRewardList.length == 0)
         {
            _loc2_ = this.FRechargeRank.PerRewardList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = new TUIPerReward(this);
               _loc3_.OnOverlay = this.SlotsOnOver;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnGetReward = this.ProcessorGetReward;
               _loc3_.Init();
               _loc3_.x = INIT_X;
               _loc3_.y = INIT_Y + _loc1_ * ITEM_HEIGHT;
               _loc3_.SetItemInfo(_loc1_);
               this.FRewardList.push(_loc3_);
               this.FScrollBar.AddItem(_loc3_);
               _loc1_++;
            }
         }
         else
         {
            _loc2_ = this.FRewardList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FRewardList[_loc1_];
               _loc3_.UpdateUI();
               _loc1_++;
            }
         }
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Desc.text = this.FRechargeRank.Desc2;
         this.FTF_Rank.text = this.FRechargeRank.PerScore.toString();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FInitialized && this.Visible)
         {
            _loc2_ = int(this.FRewardList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FRewardList[_loc1_].UpdateSlot();
               _loc1_++;
            }
         }
         super.LogicsPerform();
      }
      
      protected function ProcessorGetReward(param1:int) : void
      {
         if(this.FOnGetReward != null)
         {
            this.FOnGetReward(param1);
         }
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
      
      public function get OnGetReward() : Function
      {
         return this.FOnGetReward;
      }
      
      public function set OnGetReward(param1:Function) : void
      {
         this.FOnGetReward = param1;
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
   }
}

