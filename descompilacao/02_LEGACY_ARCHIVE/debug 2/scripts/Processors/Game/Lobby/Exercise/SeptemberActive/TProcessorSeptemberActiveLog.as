package Processors.Game.Lobby.Exercise.SeptemberActive
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.SeptemberActive.TSeptemberActive3;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_SEVENTHEVENING;
   import Resources.Strings.STRING_SEVENTHEVENING;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorSeptemberActiveLog extends TProcessorLobbyWindow
   {
      
      protected static const LOG_COUNT:int = 5;
      
      protected static const NEWS_COUNT:int = 7;
      
      protected static const TYPE_LOTTERY:int = 1;
      
      protected static const TYPE_EXCHARGE:int = 2;
      
      protected static const SIZE_Window_Width:uint = 422;
      
      protected static const SIZE_Window_Height:uint = 456;
      
      protected static const QUALITYCOLOR_None:uint = 16777215;
      
      protected static const QUALITYCOLOR_White:uint = 16777215;
      
      protected static const QUALITYCOLOR_Green:uint = 6881026;
      
      protected static const QUALITYCOLOR_Blue:uint = 38655;
      
      protected static const QUALITYCOLOR_Purple:uint = 10027215;
      
      protected static const QUALITYCOLOR_Yellow:uint = 16776960;
      
      protected static const QUALITYCOLOR_Red:uint = 16646144;
      
      protected static const QUALITYCOLOR_Orange:uint = 16711808;
      
      public static const QUALITYCOLOR_INDEX:Vector.<uint> = Vector.<uint>([QUALITYCOLOR_None,QUALITYCOLOR_White,QUALITYCOLOR_Green,QUALITYCOLOR_Blue,QUALITYCOLOR_Purple,QUALITYCOLOR_Yellow,QUALITYCOLOR_Red,QUALITYCOLOR_Orange]);
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FMC_Scene:Sprite;
      
      protected var FTF_LogList:Vector.<TextField>;
      
      protected var FTF_NewsList:Vector.<TextField>;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_MC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage_News:TUIPage;
      
      protected var FTotalPage_News:int;
      
      protected var FCurPage_News:int;
      
      protected var FInitialized:Boolean;
      
      protected var FBaseActivity:TBaseActivity;
      
      protected var FSeptemberActive3:TSeptemberActive3;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorSeptemberActiveLog(param1:TUIComponent)
      {
         super(param1);
         this.FTF_LogList = new Vector.<TextField>(LOG_COUNT);
         this.FTF_NewsList = new Vector.<TextField>(NEWS_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137104);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_SeptemberActiveLog") as Sprite;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.ResourcesPerform_UIDispatchChangePage();
         this.ResourcesPerform_UIDispatchLogList();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function ResourcesPerform_UIDispatchChangePage() : void
      {
         this.FUIPage = new TUIPage(this);
         this.FMC_MC_ChangePage = this.FMC_Scene[CONST_SEVENTHEVENING.RESOURCE_Link_MC_ChangePage];
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
         this.FUIPage_News = new TUIPage(this);
         this.FUIPage_News.ButtonPrevious.Substrate = this.FMC_Scene["MC_ChangePage_News"]["MC_PageLeft"];
         this.FUIPage_News.ButtonNext.Substrate = this.FMC_Scene["MC_ChangePage_News"]["MC_PageRight"];
         this.FUIPage_News.LabelPage = this.FMC_Scene["MC_ChangePage_News"]["TF_Page"];
         this.FUIPage_News.TotalQuantity = this.FTotalPage_News;
         this.FUIPage_News.PageSize = NEWS_COUNT;
         this.FUIPage_News.PageIndex = 0;
         this.FCurPage_News = 0;
         this.FUIPage_News.OnChangePage = this.ProcessorPageOnChange_News;
      }
      
      protected function ResourcesPerform_UIDispatchLogList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc3_ = this.FMC_Scene["TF_Log" + _loc1_];
            this.FTF_LogList[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < NEWS_COUNT)
         {
            _loc3_ = this.FMC_Scene["TF_New" + _loc1_];
            this.FTF_NewsList[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         this.FUIPage.TotalQuantity = this.FSeptemberActive3.LogList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * LOG_COUNT;
            _loc3_ = this.FTF_LogList[_loc1_];
            if(_loc2_ < this.FSeptemberActive3.LogList.length)
            {
               _loc3_.visible = true;
               _loc3_.htmlText = this.MakeHtmlTextInfo(this.FSeptemberActive3.LogList.length - _loc2_ - 1);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateNews() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         this.FUIPage_News.TotalQuantity = this.FSeptemberActive3.ServerNews.length;
         this.FUIPage_News.Update();
         _loc1_ = 0;
         while(_loc1_ < NEWS_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_News * NEWS_COUNT;
            _loc3_ = this.FTF_NewsList[_loc1_];
            if(_loc2_ < this.FSeptemberActive3.ServerNews.length)
            {
               _loc3_.visible = true;
               _loc3_.htmlText = this.MakeNewsTextInfo(this.FSeptemberActive3.ServerNews.length - _loc2_ - 1);
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
         var _loc4_:TLotteryNews = null;
         _loc4_ = this.FSeptemberActive3.LogList[param1];
         if(!_loc4_.Inventories || _loc4_.Inventories.Count == 0)
         {
            return "";
         }
         _loc3_ = _loc4_.Inventories.GetInventoryByIndex(0);
         _loc2_ = STRING_SEVENTHEVENING.FORMAT_News_When1;
         _loc2_ = _loc2_.split("%when%").join(TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.GetTime) * 1000)));
         _loc2_ += STRING_SEVENTHEVENING.FORMAT_News_Where;
         _loc2_ = _loc2_.split("%where%").join(_loc4_.GetSource);
         _loc2_ += STRING_SEVENTHEVENING.FORMAT_News_Item[_loc3_.Quality];
         return _loc2_.split("%what%").join(_loc3_.Name + " x " + _loc3_.Quantity);
      }
      
      protected function MakeNewsTextInfo(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:TInventory = null;
         var _loc4_:TLotteryNews = null;
         _loc4_ = this.FSeptemberActive3.ServerNews[param1];
         if(!_loc4_.Inventories || _loc4_.Inventories.Count == 0)
         {
            return "";
         }
         _loc3_ = _loc4_.Inventories.GetInventoryByIndex(0);
         _loc2_ = STRING_SEVENTHEVENING.FORMAT_News_When1;
         _loc2_ = _loc2_.split("%when%").join(TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.GetTime) * 1000)));
         _loc2_ += "<font color=\"#ffffff\">" + _loc4_.PlayerNick + "</font>";
         _loc2_ += STRING_SEVENTHEVENING.FORMAT_News_Where;
         _loc2_ = _loc2_.split("%where%").join(_loc4_.GetSource);
         _loc2_ += STRING_SEVENTHEVENING.FORMAT_News_Item[_loc3_.Quality];
         return _loc2_.split("%what%").join(_loc3_.Name + " x " + _loc3_.Quantity);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateLog();
      }
      
      protected function ProcessorPageOnChange_News(param1:Object, param2:int) : void
      {
         this.FCurPage_News = param2;
         this.UpdateNews();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
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
      
      public function get BaseActivity() : TBaseActivity
      {
         return this.FBaseActivity;
      }
      
      public function set BaseActivity(param1:TBaseActivity) : void
      {
         this.FBaseActivity = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FSeptemberActive3 = SLogicsCore.SeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TSeptemberActive3;
         this.UpdateLog();
         this.UpdateNews();
      }
   }
}

