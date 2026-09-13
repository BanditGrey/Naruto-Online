package Processors.Game.Lobby.Exercise.Cornucopia
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.Cornucopia.TCornucopia;
   import Logics.Exercise.DecActive.TLotteryLog;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorDecActiveLotteryLog extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIZE_Window_Width:uint = 455;
      
      public static const SIZE_Window_Height:uint = 458;
      
      public static const TAB_TYPE_SHOP:int = 0;
      
      public static const TAB_TYPE_GIFT:int = 1;
      
      public static const TAB_COUNT:int = 2;
      
      public static const PAGE_COUNT:int = 12;
      
      protected var FCornucopia:TCornucopia;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBuyBoxDate:Object;
      
      protected var FUIPage0:TUIPage;
      
      protected var FTotalPage0:int;
      
      protected var FCurPage0:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnExchange:Function;
      
      public function TProcessorDecActiveLotteryLog(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage0 = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137137);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_CornucopiaLog") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FUIPage0.ButtonPrevious.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage0.ButtonNext.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage0.LabelPage = this.FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage0.TotalQuantity = this.FTotalPage0;
         this.FUIPage0.PageSize = PAGE_COUNT;
         this.FUIPage0.PageIndex = 0;
         this.FUIPage0.OnChangePage = this.ProcessorPageOnChange0;
         this.FCurPage0 = 0;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(Boolean(this.FMC_Scene) && Boolean(this.FMC_Scene.visible) && this.Visible)
         {
         }
      }
      
      protected function UpdatePage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TLotteryLog = null;
         var _loc7_:String = null;
         this.FUIPage0.TotalQuantity = this.FCornucopia.LotteryLogs.length;
         this.FUIPage0.Update();
         _loc1_ = 0;
         while(_loc1_ < PAGE_COUNT)
         {
            _loc4_ = _loc1_ + this.FCurPage0 * PAGE_COUNT;
            _loc5_ = this.FMC_Scene["MC_Log" + _loc1_];
            if(_loc4_ < this.FCornucopia.LotteryLogs.length)
            {
               _loc5_.visible = true;
               _loc6_ = this.FCornucopia.LotteryLogs[_loc4_];
               _loc5_.TF_Date.text = TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc6_.Time) * 1000));
               _loc7_ = "";
               _loc3_ = int(_loc6_.FirstNumbers.length);
               if(_loc3_ > 0)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc3_)
                  {
                     _loc7_ += String(Number(_loc6_.FirstNumbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " ";
                     _loc2_++;
                  }
               }
               else
               {
                  _loc7_ = this.FCornucopia.DescListNew[11];
               }
               _loc5_.TF_Num0.text = _loc7_;
               _loc7_ = "";
               _loc3_ = int(_loc6_.SecondNumbers.length);
               if(_loc3_ > 0)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc3_)
                  {
                     if(_loc2_ < _loc3_ - 1)
                     {
                        _loc7_ += String(Number(_loc6_.SecondNumbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " | ";
                     }
                     else
                     {
                        _loc7_ += String(Number(_loc6_.SecondNumbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " ";
                     }
                     _loc2_++;
                  }
               }
               else
               {
                  _loc7_ = this.FCornucopia.DescListNew[11];
               }
               _loc5_.TF_Num1.text = _loc7_;
               _loc7_ = "";
               _loc3_ = int(_loc6_.ThirdNumbers.length);
               if(_loc3_ > 0)
               {
                  _loc2_ = 0;
                  while(_loc2_ < _loc3_)
                  {
                     if(_loc2_ < _loc3_ - 1)
                     {
                        _loc7_ += String(Number(_loc6_.ThirdNumbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " | ";
                     }
                     else
                     {
                        _loc7_ += String(Number(_loc6_.ThirdNumbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " ";
                     }
                     _loc2_++;
                  }
               }
               else
               {
                  _loc7_ = this.FCornucopia.DescListNew[11];
               }
               _loc5_.TF_Num2.text = _loc7_;
            }
            else
            {
               _loc5_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange0(param1:Object, param2:int) : void
      {
         this.FCurPage0 = param2;
         this.UpdatePage();
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(TProcessorCornucopia.WINDOW_LOTTERY_LOG);
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
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FCornucopia = SLogicsCore.Cornucopia;
         this.UpdatePage();
      }
   }
}

