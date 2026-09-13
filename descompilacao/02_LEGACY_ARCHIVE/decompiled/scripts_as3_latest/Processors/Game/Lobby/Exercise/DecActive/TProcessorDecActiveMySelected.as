package Processors.Game.Lobby.Exercise.DecActive
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DecActive.TDecActive2;
   import Logics.Exercise.DecActive.TTicketData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorDecActiveMySelected extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const SIZE_Window_Width:uint = 463;
      
      public static const SIZE_Window_Height:uint = 374;
      
      public static const PAGE_COUNT:int = 9;
      
      protected var FDecActive2:TDecActive2;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBuyBoxDate:Object;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnExchange:Function;
      
      public function TProcessorDecActiveMySelected(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137110);
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_DecActiveMySelected") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = PAGE_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FCurPage = 0;
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
         var _loc3_:MovieClip = null;
         var _loc4_:TTicketData = null;
         var _loc5_:String = null;
         this.FUIPage.TotalQuantity = this.FDecActive2.AllTickets.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < PAGE_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * PAGE_COUNT;
            _loc3_ = this.FMC_Scene["MC_Log" + _loc1_];
            if(_loc2_ < this.FDecActive2.AllTickets.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FDecActive2.AllTickets[_loc2_];
               _loc3_.TF_Date.text = TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc4_.Time) * 1000));
               _loc5_ = String(Number(_loc4_.Num / 10000).toFixed(4)).slice(-3);
               _loc3_.TF_Num.text = TUtilityString.Format(this.FDecActive2.DescListNew[10],_loc5_,_loc4_.Count);
               if(_loc4_.Status == TTicketData.STATUS_NOT_OPEN)
               {
                  _loc3_.TF_Result.text = this.FDecActive2.DescListNew[8];
               }
               else if(_loc4_.Status == TTicketData.STATUS_NOT_WON)
               {
                  _loc3_.TF_Result.text = this.FDecActive2.DescListNew[9];
               }
               else
               {
                  _loc3_.TF_Result.text = this.FDecActive2.DescListNew[3 + _loc4_.Status] + ":" + _loc4_.Gold + STRING_COMMON.ITEMNAME_Gold;
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdatePage();
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(TProcessorDecActive.WINDOW_MY_SELECTED);
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
         this.FDecActive2 = SLogicsCore.DecActiveDatas.GetActivityByIdentify(2) as TDecActive2;
         this.UpdatePage();
      }
   }
}

