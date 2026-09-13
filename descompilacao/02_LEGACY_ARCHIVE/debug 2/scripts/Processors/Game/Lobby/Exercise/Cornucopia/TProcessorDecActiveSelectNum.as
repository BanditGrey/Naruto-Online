package Processors.Game.Lobby.Exercise.Cornucopia
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Cornucopia.TCornucopia;
   import Logics.Exercise.DecActive.TTicketData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorDecActiveSelectNum extends TProcessorLobbyWindow
   {
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const SIZE_Window_Width:uint = 398;
      
      public static const SIZE_Window_Height:uint = 496;
      
      public static const PAGE_COUNT:int = 14;
      
      public static const RESULT_COUNT:int = 3;
      
      protected var FCornucopia:TCornucopia;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FIsFirst:Boolean;
      
      protected var FSelectedNum:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnShowFlowText:Function;
      
      public function TProcessorDecActiveSelectNum(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FIsFirst = true;
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_CornucopiaSelectNum") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FMC_Scene.TF_Input.restrict = "0-9";
         this.FMC_Scene.TF_Input.maxChars = 3;
         this.FMC_Scene.TF_Input.addEventListener(Event.CHANGE,this.ProcessorOnTextInput,false,0,true);
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = PAGE_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange0;
         this.FCurPage = 0;
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Buy,false);
         this.FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectNumUp);
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
      
      protected function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < RESULT_COUNT)
         {
            if(_loc1_ < this.FCornucopia.Results.length)
            {
               _loc5_ = "";
               _loc4_ = int(this.FCornucopia.Results[_loc1_].Numbers.length);
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc5_ += String(Number(this.FCornucopia.Results[_loc1_].Numbers[_loc2_] / 10000).toFixed(4)).slice(-3) + " ";
                  _loc2_++;
               }
               this.FMC_Scene.MC_LastNum["TF_Num" + _loc1_].text = _loc5_;
            }
            else
            {
               this.FMC_Scene.MC_LastNum["TF_Num" + _loc1_].text = this.FCornucopia.DescListNew[11];
            }
            _loc1_++;
         }
      }
      
      protected function UpdatePage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextField = null;
         var _loc4_:TTicketData = null;
         var _loc5_:String = null;
         this.FUIPage.TotalQuantity = this.FCornucopia.MyTickets.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < PAGE_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * PAGE_COUNT;
            _loc3_ = this.FMC_Scene["TF_Num" + _loc1_];
            if(_loc2_ < this.FCornucopia.MyTickets.length)
            {
               _loc4_ = this.FCornucopia.MyTickets[_loc2_];
               _loc5_ = String(Number(_loc4_.Num / 10000).toFixed(4)).slice(-3);
               _loc3_.text = TUtilityString.Format(this.FCornucopia.DescListNew[10],_loc5_,_loc4_.Count);
            }
            else
            {
               _loc3_.text = "";
            }
            _loc1_++;
         }
         if(this.FSelectedNum > 0 && this.FCornucopia.SelectedCount < this.FCornucopia.MaxCount)
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Buy,false);
         }
      }
      
      protected function ProcessorPageOnChange0(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdatePage();
      }
      
      protected function ProcessorOnSelectNumUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            this.FSelectedNum = parseInt(this.FMC_Scene.TF_Input.text as String);
            if(this.FCornucopia.CurCount <= 0)
            {
               this.FOnShowFlowText(this.FCornucopia.DescListNew[15]);
            }
            else if(this.FSelectedNum > 0)
            {
               this.FOnGetBox(TProcessorCornucopia.ACTIVITY_2_GET_TICKET,this.FSelectedNum);
            }
         }
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(TProcessorCornucopia.WINDOW_SELECTE_NUM);
         }
      }
      
      protected function ProcessorOnTextInput(param1:Event) : void
      {
         this.FSelectedNum = parseInt(this.FMC_Scene.TF_Input.text as String);
         if(this.FSelectedNum > 0 && this.FCornucopia.SelectedCount < this.FCornucopia.MaxCount)
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Buy,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene.BTN_Buy,false);
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
      
      public function get OnShowFlowText() : Function
      {
         return this.FOnShowFlowText;
      }
      
      public function set OnShowFlowText(param1:Function) : void
      {
         this.FOnShowFlowText = param1;
      }
      
      public function UpdateUI() : void
      {
         if(this.FIsFirst)
         {
            this.FUIWindowConfirmation.Load();
            this.FUIWindowRecharge.Load();
            this.FIsFirst = false;
         }
         this.FCornucopia = SLogicsCore.Cornucopia;
         this.UpdateView();
         this.UpdatePage();
      }
   }
}

