package Processors.Game.Lobby.Exercise.CloudBuy
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Exercise.CloudBuy.TCloudBuy;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowPetDesc;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorCloudBuyLog extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 456;
      
      protected static const SIZE_Window_Height:uint = 486;
      
      protected static const MAX_COUNT:int = 4;
      
      protected static const RANK_BOX_COUNT:int = 1;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FCloudBuy:TCloudBuy;
      
      protected var FIndex:int;
      
      protected var FUIRankBoxVect:Vector.<TUIShowItem>;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FProcessorWindowPetDesc:TProcessorWindowPetDesc;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FIsLoadCompleted:Boolean;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FTitleHintOnOver:Function;
      
      protected var FTitleHintOnOut:Function;
      
      protected var FOnShowRecruit:Function;
      
      public function TProcessorCloudBuyLog(param1:TUIComponent)
      {
         super(param1);
         this.FUIRankBoxVect = new Vector.<TUIShowItem>(MAX_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137107);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIShowItem = null;
         var _loc2_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_CloudBuyLog") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc1_ = new TUIShowItem(this,RANK_BOX_COUNT);
            _loc1_.Perform_UIDispatch(this.FMC_Scene["MC_Log" + _loc2_]);
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIRankBoxVect[_loc2_] = _loc1_;
            _loc2_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FMC_ChangePage = this.FMC_Scene["MC_ChangePage"];
         this.FUI_Left_Btn = this.FMC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = MAX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FProcessorWindowPetDesc = new TProcessorWindowPetDesc(this.Parent);
         this.FProcessorWindowPetDesc.Visible = false;
         this.FProcessorWindowPetDesc.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowPetDesc.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FCloudBuy.LastItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * MAX_COUNT;
            _loc3_ = this.FMC_Scene["MC_Log" + _loc1_];
            if(_loc2_ < this.FCloudBuy.LastItems.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FCloudBuy.LastItems[_loc2_];
               _loc3_.TF_Date.text = TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.Time) * 1000));
               if(_loc4_.Desc1)
               {
                  _loc3_.TF_Name.text = _loc4_.Desc1;
               }
               else
               {
                  _loc3_.TF_Name.text = "";
               }
               this.FUIRankBoxVect[_loc1_].UpdateUI(_loc4_.Inventories);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         super.LogicsPerform();
         if(this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < MAX_COUNT)
            {
               if(this.FUIRankBoxVect[_loc1_])
               {
                  this.FUIRankBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
            if(this.FProcessorWindowPetDesc != null && this.FProcessorWindowPetDesc.Visible == true)
            {
               this.FProcessorWindowPetDesc.UpdataBitmap();
            }
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRank();
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
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
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            this.FProcessorWindowPetDesc.SetPetData(param1);
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
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get CurPage() : int
      {
         return this.FCurPage;
      }
      
      public function set CurPage(param1:int) : void
      {
         this.FCurPage = param1;
      }
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function UpdateUI() : void
      {
         if(!this.FIsLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FProcessorWindowPetDesc.Load();
            this.FIsLoadCompleted = true;
         }
         this.FCloudBuy = SLogicsCore.CloudBuy;
         this.UpdateRank();
      }
   }
}

