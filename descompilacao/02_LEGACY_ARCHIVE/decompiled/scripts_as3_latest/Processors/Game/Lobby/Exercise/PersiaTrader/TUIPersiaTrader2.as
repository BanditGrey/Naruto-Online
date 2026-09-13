package Processors.Game.Lobby.Exercise.PersiaTrader
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIPersiaTrader2 extends TUIBaseWindow
   {
      
      protected static const EXCHANGE_BOX_COUNT:int = 10;
      
      protected var FPersiaTrader:TPersiaTrader;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FOpenIndex:int;
      
      protected var FExchangeList:Vector.<TUIShowItem>;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TUIPersiaTrader2(param1:TUIComponent)
      {
         super(param1);
         this.FPersiaTrader = SLogicsCore.PersiaTrader;
         this.FExchangeList = new Vector.<TUIShowItem>(EXCHANGE_BOX_COUNT);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FExchangeList[_loc2_] = _loc4_;
            FMC_Scene["MC_Item" + _loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            _loc2_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FPersiaTrader.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FPersiaTrader.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FPersiaTrader.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FPersiaTrader.Score.toString();
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FPersiaTrader.ExchangeItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FPersiaTrader.ExchangeItems.length)
            {
               FMC_Scene["MC_Item" + _loc1_].visible = true;
               _loc5_ = this.FPersiaTrader.ExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetDescText(0,_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetDescText(1,_loc4_);
               if(this.FPersiaTrader.Score < _loc5_.Price || _loc5_.LimitCount <= 0)
               {
                  TGameUtil.setButtonMode(FMC_Scene["MC_Item" + _loc1_].BTN_Exchange,false);
               }
               else
               {
                  TGameUtil.setButtonMode(FMC_Scene["MC_Item" + _loc1_].BTN_Exchange,true);
               }
               if(_loc5_.LimitCount == 0)
               {
                  this.FExchangeList[_loc1_].SetMCVisible("MC_Got",true);
                  this.FExchangeList[_loc1_].SetMCVisible("BTN_Exchange",false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetMCVisible("MC_Got",false);
                  this.FExchangeList[_loc1_].SetMCVisible("BTN_Exchange",true);
               }
            }
            else
            {
               FMC_Scene["MC_Item" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FPersiaTrader && _loc3_ < this.FPersiaTrader.ExchangeItems.length) && Boolean(this.FPersiaTrader.ExchangeItems[_loc3_].LimitCount > 0) && this.FPersiaTrader.Score >= this.FPersiaTrader.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(TProcessorPersiaTrader.ACTIVITY_2_EXCHANGE_ITEM,_loc3_ + 1);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_BOX_COUNT)
            {
               if(this.FExchangeList[_loc1_])
               {
                  this.FExchangeList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateExchange();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
   }
}

