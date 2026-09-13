package Processors.Game.Lobby.Exercise.OrangeEquipment
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipment;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowOrangeEquipmentExchange extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 669;
      
      protected static const SIZE_Window_Height:uint = 435;
      
      protected static const SUIT_COUNT:int = 5;
      
      protected static const BOX_COUNT:int = 8;
      
      protected static const CHIP_COUNT:int = 5;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurPage:int;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FTF_Context:TextField;
      
      protected var FMC_ChipVect:Vector.<MovieClip>;
      
      protected var FInitialized:Boolean;
      
      protected var FOrangeEquipment:TOrangeEquipment;
      
      protected var FSelectIndex:int;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FIndex:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessorWindowOrangeEquipmentExchange(param1:TUIComponent)
      {
         super(param1);
         this.FOrangeEquipment = SLogicsCore.OrangeEquipment;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIPage = new TUIPage(this);
         this.FUIBoxVect = new Vector.<TUIBaseBox>(BOX_COUNT);
         this.FMC_ChipVect = new Vector.<MovieClip>(CHIP_COUNT);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(1929379840);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIBaseBox = null;
         var _loc4_:MovieClip = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_OrangeEquipmentExchange") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FTF_Context = this.FMC_Scene["TF_Context"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene["Btn_Left"];
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene["Btn_Right"];
         this.FUIPage.PageSize = SUIT_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = new TUIBaseBox(this,1);
            _loc3_.Perform_UIDispatch(this.FMC_Scene["MC_Item" + _loc1_]);
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnGetBox = this.ProcessorOnGetBox;
            this.FUIBoxVect[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < CHIP_COUNT)
         {
            _loc4_ = this.FMC_Scene["MC_Chip" + _loc1_];
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnChipOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnChipOut);
            this.FMC_ChipVect[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIWindowConfirmation.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         _loc1_ = 0;
         while(_loc1_ < SUIT_COUNT)
         {
            _loc3_ = this.FMC_Scene["MC_Suit" + _loc1_];
            _loc3_.buttonMode = true;
            _loc3_.TF_Title.mouseEnabled = false;
            _loc3_.addEventListener(MouseEvent.CLICK,this.ProcessorChangeSuit);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorSuitOver);
            _loc3_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorSuitOut);
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CHIP_COUNT)
         {
            if(_loc1_ < this.FOrangeEquipment.ChipVect.length)
            {
               this.FMC_ChipVect[_loc1_].visible = true;
               this.FMC_ChipVect[_loc1_].TF_Count.text = this.FOrangeEquipment.ChipVect[_loc1_].toString();
               this.FMC_ChipVect[_loc1_].MC_Tag.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               this.FMC_ChipVect[_loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FMC_Scene["TF_Desc"].text = this.FOrangeEquipment.ActivityName;
      }
      
      protected function UpdateSuit() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SUIT_COUNT)
         {
            _loc3_ = this.FMC_Scene["MC_Suit" + _loc1_];
            _loc4_ = _loc1_ + this.FCurPage * SUIT_COUNT;
            if(_loc4_ < this.FOrangeEquipment.SuitBoxes.length)
            {
               _loc3_.gotoAndStop(1);
               _loc3_.MC_SuitPic.gotoAndStop(_loc4_ + 1);
               _loc3_.TF_Title.text = this.FOrangeEquipment.SuitBoxes[_loc4_].Title;
               _loc3_.MC_Mask.visible = false;
               if(_loc4_ == this.FSelectIndex)
               {
                  _loc3_.MC_Select.visible = true;
                  _loc3_.MC_Select.gotoAndPlay(1);
                  _loc3_.filters = [TGameUtil.highLightFilters];
               }
               else
               {
                  _loc3_.MC_Select.visible = false;
                  _loc3_.MC_Select.stop();
                  _loc3_.filters = [];
               }
            }
            else
            {
               _loc3_.gotoAndStop(2);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:TBaseBox = null;
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            _loc6_ = this.FOrangeEquipment.SuitBoxes[this.FSelectIndex].SuitVect[_loc2_];
            _loc1_ = _loc6_.Inventories;
            this.FUIBoxVect[_loc2_].UpdateUI(_loc1_);
            _loc5_ = _loc6_.Price.toString();
            this.FUIBoxVect[_loc2_].SetPriceText(_loc5_);
            this.FUIBoxVect[_loc2_].UpdateTag(this.FSelectIndex);
            _loc5_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COUNT,_loc6_.Count - _loc6_.BuyCount,_loc6_.Count);
            this.FUIBoxVect[_loc2_].SetCountText(_loc5_);
            if(_loc6_.BuyCount >= _loc6_.Count)
            {
               this.FUIBoxVect[_loc2_].IsBoxGot(true);
            }
            else
            {
               this.FUIBoxVect[_loc2_].IsBoxGot(false);
            }
            _loc2_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TInventories = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.LogicsPerform();
         if(this.visible && Boolean(this.FUIBoxVect[0]))
         {
            _loc2_ = 0;
            while(_loc2_ < BOX_COUNT)
            {
               this.FUIBoxVect[_loc2_].LogicsPerform();
               _loc2_++;
            }
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.FSelectIndex = this.FCurPage * SUIT_COUNT;
         this.UpdateUI();
      }
      
      protected function ProcessorChangeSuit(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FSelectIndex = int(String(param1.currentTarget.name).slice(7));
         _loc2_ = this.FSelectIndex + this.FCurPage * SUIT_COUNT;
         if(_loc2_ >= this.FOrangeEquipment.SuitBoxes.length)
         {
            return;
         }
         this.UpdateUI();
      }
      
      protected function ProcessorSuitOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7)) + this.FCurPage * SUIT_COUNT;
         if(_loc2_ >= this.FOrangeEquipment.SuitBoxes.length || _loc2_ == this.FSelectIndex)
         {
            return;
         }
         (param1.currentTarget as MovieClip).MC_Mask.visible = true;
      }
      
      protected function ProcessorSuitOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7)) + this.FCurPage * SUIT_COUNT;
         if(_loc2_ >= this.FOrangeEquipment.SuitBoxes.length || _loc2_ == this.FSelectIndex)
         {
            return;
         }
         (param1.currentTarget as MovieClip).MC_Mask.visible = false;
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
      
      protected function ProcessorOnChipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.FTipOnOver != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(7));
            _loc3_ = this.FOrangeEquipment.SuitBoxes[_loc2_].ExchangeInventory.Name;
            this.FTipOnOver(_loc3_);
         }
      }
      
      protected function ProcessorOnChipOut(param1:MouseEvent) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut();
         }
      }
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:uint = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            this.FIndex = int(String(param1.currentTarget.parent.name).slice(7));
            _loc4_ = this.FOrangeEquipment.SuitBoxes[this.FSelectIndex].SuitVect[this.FIndex];
            if(this.FOrangeEquipment.GetChipCountByID(this.FOrangeEquipment.SuitBoxes[this.FSelectIndex].ExchangeItemID) >= _loc4_.Price)
            {
               this.FOnGetBox(this.FSelectIndex,this.FIndex);
            }
            else if(!this.FUIWindowConfirmation.IsSelected)
            {
               this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmChipGold,this.FOrangeEquipment.GetNeedGold(this.FSelectIndex,this.FIndex));
               this.FUIWindowConfirmation.SetCheckBox(true);
               this.FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.WindowConfirmationOnOK();
            }
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FOrangeEquipment.IsGoldEnough(this.FOrangeEquipment.GetNeedGold(this.FSelectIndex,this.FIndex)))
         {
            this.FOnGetBox(this.FSelectIndex,this.FIndex);
         }
         else
         {
            this.FUIWindowRecharge.Visible = true;
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
      
      public function UpdateUI() : void
      {
         this.FUIPage.TotalQuantity = this.FOrangeEquipment.SuitBoxes.length;
         this.FUIPage.Update();
         this.UpdateText();
         this.UpdateSuit();
         this.UpdateBox();
      }
   }
}

