package Processors.Game.Lobby.Lottery
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_LOTTERY;
   import Resources.Strings.STRING_LOTTERY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowLotteryLog extends TProcessorLobbyWindow
   {
      
      protected static const LOG_COUNT:int = 7;
      
      protected static const TYPE_LOTTERY:int = 1;
      
      protected static const TYPE_EXCHARGE:int = 2;
      
      public static const SIZE_Window_Width:int = 422;
      
      public static const SIZE_Window_Height:int = 243;
      
      protected var FMC_Scene:Sprite;
      
      protected var FTF_LogList:Vector.<TextField>;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_MC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int = 10;
      
      protected var FCurPage:int;
      
      protected var FInitialized:Boolean;
      
      protected var FNewsData:Vector.<TLotteryNews>;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorWindowLotteryLog(param1:TUIComponent)
      {
         super(param1);
         this.FTF_LogList = new Vector.<TextField>(LOG_COUNT);
         this.FNewsData = new Vector.<TLotteryNews>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_LOTTERY.RESOURCESID_Swf_Lottery);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0 - 217,0 - 44,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_LOTTERY.RESOURCE_ClassName_MC_LotteryLog) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x += (778 - 422) / 2;
         this.FMC_Scene.y += (556 - 243) / 2;
         this.FBtn_Close = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Close];
         this.ResourcesPerform_UIDispatchChangePage();
         this.ResourcesPerform_UIDispatchLogList();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchChangePage() : void
      {
         this.FUIPage = new TUIPage(this);
         this.FMC_MC_ChangePage = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_ChangePage];
         this.FUI_Left_Btn = this.FMC_MC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_MC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_MC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = LOG_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function ResourcesPerform_UIDispatchLogList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_Log + _loc1_];
            this.FTF_LogList[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         this.FNewsData = SLogicsCore.Lottery.LotteryLog;
         this.FUIPage.TotalQuantity = this.FNewsData.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * LOG_COUNT;
            _loc3_ = this.FTF_LogList[_loc1_];
            if(_loc2_ < this.FNewsData.length)
            {
               _loc3_.visible = true;
               _loc3_.htmlText = this.MakeHtmlTextInfo(this.FNewsData.length - _loc2_ - 1);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function MakeHtmlTextInfo(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         _loc3_ = SLogicsCore.Lottery.getInventoryByIdentify(this.FNewsData[param1].NewsType,this.FNewsData[param1].Identify);
         _loc2_ = STRING_LOTTERY.FORMAT_News_When;
         _loc2_ = _loc2_.split("%when%").join(TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNewsData[param1].GetTime) * 1000)));
         if(this.FNewsData[param1].NewsType == TYPE_LOTTERY)
         {
            _loc2_ += STRING_LOTTERY.FORMAT_News_Type_Lottery;
         }
         else
         {
            _loc2_ += STRING_LOTTERY.FORMAT_News_Type_Exchange;
         }
         if(_loc3_ != null)
         {
            _loc2_ += STRING_LOTTERY.FORMAT_News_Item[_loc3_.Quality];
            _loc2_ = _loc2_.split("%what%").join(_loc3_.Name + " x " + _loc3_.Quantity);
         }
         else
         {
            _loc2_ = "";
         }
         return _loc2_;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(false);
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FUIPage.Update();
         this.UpdateLog();
      }
   }
}

