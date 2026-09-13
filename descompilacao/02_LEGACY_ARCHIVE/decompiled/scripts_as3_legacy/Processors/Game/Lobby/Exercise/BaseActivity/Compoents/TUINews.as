package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import flash.display.MovieClip;
   
   public class TUINews extends TUIComponent
   {
      
      protected static const MIN_SCROLL_HEIGHT:Number = 18;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 18;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_TaskItemVect:Array;
      
      protected var FNewsList:Vector.<TUIBaseNews>;
      
      protected var FNewsDate:Vector.<TLotteryNews>;
      
      protected var FInitialized:Boolean;
      
      protected var FIsDelay:Boolean;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      public function TUINews(param1:TUIComponent)
      {
         super(param1);
         this.FNewsList = new Vector.<TUIBaseNews>();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.Resources_UIDispatchScrollBar();
      }
      
      protected function Resources_UIDispatchScrollBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_List = this.FMC_Scene;
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
      }
      
      protected function UpdateNews() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIBaseNews = null;
         if(this.FNewsDate == null)
         {
            return;
         }
         _loc2_ = int(this.FNewsList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FNewsList[_loc1_];
            _loc3_.StubReferences.Dereference(this);
            _loc1_++;
         }
         this.FNewsList.length = 0;
         this.FScrollBar.Clear();
         _loc2_ = int(this.FNewsDate.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = SLogicsCore.PoolUINews.AcquireUITaskItem(this.Parent);
            _loc3_.StubReferences.Reference(this);
            _loc3_.y = _loc1_ * SINGLE_ITEM_STAMP;
            _loc3_.NewsData = this.FNewsDate[_loc2_ - _loc1_ - 1];
            _loc3_.Index = _loc2_ - _loc1_ - 1;
            _loc3_.Update();
            _loc3_.OnItemOver = this.ProcessorOnItemOver;
            _loc3_.OnItemOut = this.ProcessorOnItemOut;
            _loc3_.OnNameUp = this.ProcessorOnNameUp;
            this.FScrollBar.AddItem(_loc3_);
            this.FNewsList.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(param1,param2);
         }
      }
      
      protected function ProcessorOnNameUp(param1:uint, param2:uint) : void
      {
         if(this.FOnShowHeroInfo != null)
         {
            this.FOnShowHeroInfo(param1,param2);
         }
      }
      
      public function get IsDelay() : Boolean
      {
         return this.FIsDelay;
      }
      
      public function set IsDelay(param1:Boolean) : void
      {
         this.FIsDelay = param1;
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
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get NewsDate() : Vector.<TLotteryNews>
      {
         return this.FNewsDate;
      }
      
      public function set NewsDate(param1:Vector.<TLotteryNews>) : void
      {
         this.FNewsDate = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.visible)
         {
         }
      }
      
      public function UpdateUI() : void
      {
         this.UpdateNews();
      }
   }
}

