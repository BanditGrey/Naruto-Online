package Processors.Game.Lobby.Exercise.PersiaTrader
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.PersiaTrader.TPersiaTrader;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   
   public class TUIPersiaTrader4 extends TUIBaseWindow
   {
      
      protected static const LOG_COUNT:int = 20;
      
      protected var FPersiaTrader:TPersiaTrader;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FOpenIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      public function TUIPersiaTrader4(param1:TUIComponent)
      {
         super(param1);
         this.FPersiaTrader = SLogicsCore.PersiaTrader;
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
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = LOG_COUNT;
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
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TLotteryNews = null;
         this.FUIPage.TotalQuantity = this.FPersiaTrader.LuckyList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage * LOG_COUNT;
            if(_loc3_ < this.FPersiaTrader.LuckyList.length)
            {
               _loc5_ = this.FPersiaTrader.LuckyList[_loc3_];
               _loc4_ = this.FPersiaTrader.DescListNew[5];
               FMC_Scene["TF_Log" + _loc1_].text = TUtilityString.Format(this.FPersiaTrader.DescListNew[5],TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc5_.GetTime) * 1000)),_loc5_.PlayerNick,_loc5_.Count,_loc5_.Inventory.Name);
            }
            else
            {
               FMC_Scene["TF_Log" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateLog();
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
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateLog();
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

