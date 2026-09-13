package Processors.Game.Lobby.Exercise.BlackMarket.Compoents
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Logics.Exercise.BlackMarket.TBlackMarket;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BlackMarket.TProcessorBlackMarket;
   import flash.display.MovieClip;
   
   public class TUIBlackMarketGift extends TUIBaseWindow
   {
      
      protected static const MIN_SCROLL_HEIGHT:Number = 322;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 65;
      
      protected static const ITEM_HEIGHT:Number = 65;
      
      protected var FBlackMarket:TBlackMarket;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FGiftList:Vector.<TUIGift>;
      
      public function TUIBlackMarketGift(param1:TUIComponent)
      {
         super(param1);
         this.FBlackMarket = SLogicsCore.BlackMarket;
         this.FGiftList = new Vector.<TUIGift>();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         this.FScrollBar = new TScrollBar(FMC_Scene["MC_List"],MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIGift = null;
         if(this.FGiftList.length == 0)
         {
            this.FScrollBar.Clear();
            _loc2_ = this.FBlackMarket.GiftList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = new TUIGift(this);
               _loc3_.OnOverlay = this.ProcessorOnItemOver;
               _loc3_.OnOut = this.ProcessorOnItemOut;
               _loc3_.OnGetReward = this.ProcessorOnGetBox;
               _loc3_.Init();
               _loc3_.y = _loc1_ * ITEM_HEIGHT;
               _loc3_.SetItemInfo(_loc1_);
               this.FGiftList.push(_loc3_);
               this.FScrollBar.AddItem(_loc3_);
               _loc1_++;
            }
         }
         else
         {
            _loc2_ = this.FGiftList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FGiftList[_loc1_].UpdateBtn();
               _loc1_++;
            }
         }
      }
      
      protected function ProcessorOnGetBox(param1:int) : void
      {
         if(FOnGetBox != null && this.FBlackMarket.GiftList[param1].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(TProcessorBlackMarket.TYPE_GET_GIFT,param1 + 1);
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
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(FInitialized && this.visible)
         {
            _loc2_ = int(this.FGiftList.length);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FGiftList[_loc1_].UpdateSlot();
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateGift();
      }
   }
}

