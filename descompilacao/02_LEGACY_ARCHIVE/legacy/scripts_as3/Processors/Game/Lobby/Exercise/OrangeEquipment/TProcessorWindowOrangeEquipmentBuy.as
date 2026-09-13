package Processors.Game.Lobby.Exercise.OrangeEquipment
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.OrangeEquipment.TOrangeEquipment;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
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
   
   public class TProcessorWindowOrangeEquipmentBuy extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 713;
      
      protected static const SIZE_Window_Height:uint = 401;
      
      protected static const CHIP_COUNT:int = 5;
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const SUIT_COUNT:int = 4;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FMC_FreeBox:MovieClip;
      
      protected var FBTN_Get:MovieClip;
      
      protected var FTF_FreeTimes:TextField;
      
      protected var FMC_ChipVect:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FCurPage:int;
      
      protected var FInitialized:Boolean;
      
      protected var FOrangeEquipment:TOrangeEquipment;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FIndex1:int;
      
      protected var FIndex2:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessorWindowOrangeEquipmentBuy(param1:TUIComponent)
      {
         super(param1);
         this.FOrangeEquipment = SLogicsCore.OrangeEquipment;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIPage = new TUIPage(this);
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
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_OrangeEquipmentBuy") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         this.FMC_FreeBox = this.FMC_Scene["MC_FreeBox"];
         this.FBTN_Get = this.FMC_Scene["BTN_Get"];
         this.FTF_FreeTimes = this.FMC_Scene["TF_FreeTimes"];
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene["Btn_Left"];
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene["Btn_Right"];
         this.FUIPage.PageSize = SUIT_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
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
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         this.FBTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
         this.FMC_FreeBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         this.FMC_FreeBox.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
         _loc1_ = 0;
         while(_loc1_ < SUIT_COUNT)
         {
            _loc5_ = this.FMC_Scene["MC_Box" + _loc1_];
            _loc2_ = 0;
            while(_loc2_ < BOX_COUNT)
            {
               TGameUtil.setButtonMode(_loc5_["MC_Item" + _loc2_].BTN_Buy,true);
               _loc5_["MC_Item" + _loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
               _loc5_["MC_Item" + _loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
               _loc5_["MC_Item" + _loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBoxOut);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < CHIP_COUNT)
         {
            _loc5_ = this.FMC_Scene["MC_Chip" + _loc1_];
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnChipOver);
            _loc5_.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnChipOut);
            this.FMC_ChipVect[_loc1_] = _loc5_;
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         _loc2_ = 0;
         while(_loc2_ < CHIP_COUNT)
         {
            if(_loc2_ < this.FOrangeEquipment.ChipVect.length)
            {
               this.FMC_ChipVect[_loc2_].visible = true;
               this.FMC_ChipVect[_loc2_].TF_Count.text = this.FOrangeEquipment.ChipVect[_loc2_].toString();
               this.FMC_ChipVect[_loc2_].MC_Tag.gotoAndStop(_loc2_ + 1);
            }
            else
            {
               this.FMC_ChipVect[_loc2_].visible = false;
            }
            _loc2_++;
         }
         this.FTF_Desc.text = this.FOrangeEquipment.ActiveDesc2;
         this.FTF_FreeTimes.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FREE_TIMES,this.FOrangeEquipment.FreeTimes);
      }
      
      protected function UpdateFreeBox() : void
      {
         if(this.FOrangeEquipment.FreeTimes > 0)
         {
            TGameUtil.setButtonMode(this.FBTN_Get,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Get,false);
         }
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SUIT_COUNT)
         {
            _loc5_ = this.FMC_Scene["MC_Box" + _loc1_];
            _loc6_ = _loc1_ + this.FCurPage * SUIT_COUNT;
            if(_loc6_ < this.FOrangeEquipment.ChipBoxes.length)
            {
               _loc5_.MC_ComingSoon.visible = false;
               _loc5_.TF_Title.text = this.FOrangeEquipment.ChipBoxes[_loc6_].Title;
               _loc2_ = 0;
               while(_loc2_ < BOX_COUNT)
               {
                  _loc5_["MC_Item" + _loc2_].MC_BoxPic.gotoAndStop(_loc6_ * BOX_COUNT + _loc2_ + 1);
                  _loc5_["MC_Item" + _loc2_].TF_Price.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BUY_PRICE,this.FOrangeEquipment.ChipBoxes[_loc6_].PriceVect[_loc2_]);
                  _loc2_++;
               }
            }
            else
            {
               _loc5_.MC_ComingSoon.visible = true;
            }
            _loc1_++;
         }
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
            this.FOnCloseUp();
         }
      }
      
      protected function ProcessorOnGetBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FOnGetBox != null)
         {
            if(param1.currentTarget.name == "BTN_Get")
            {
               this.FOnGetBox(-1,-1);
            }
            else
            {
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(6));
               this.FIndex2 = int(String(param1.currentTarget.parent.name).slice(7));
               this.FIndex1 = _loc2_ + this.FCurPage * SUIT_COUNT;
               if(!this.FUIWindowConfirmation.IsSelected)
               {
                  this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FOrangeEquipment.ChipBoxes[this.FIndex1].PriceVect[this.FIndex2]);
                  this.FUIWindowConfirmation.SetCheckBox(true);
                  this.FUIWindowConfirmation.Visible = true;
               }
               else
               {
                  this.WindowConfirmationOnOK();
               }
            }
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FOrangeEquipment.IsGoldEnough(this.FOrangeEquipment.ChipBoxes[this.FIndex1].PriceVect[this.FIndex2]))
         {
            this.FOnGetBox(this.FIndex1,this.FIndex2);
         }
         else
         {
            this.FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         if(this.FOnOverlay != null)
         {
            if(param1.currentTarget.name == "MC_FreeBox")
            {
               this.FOnOverlay(this,this.FOrangeEquipment.FreeInventory);
            }
            else
            {
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(6));
               _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
               _loc4_ = _loc2_ + this.FCurPage * SUIT_COUNT;
               _loc5_ = this.FOrangeEquipment.ChipBoxes[_loc4_].Inventories.GetInventoryByIndex(_loc3_);
               this.FOnOverlay(this,_loc5_);
            }
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         if(this.FOnOut != null)
         {
            if(param1.currentTarget.name == "MC_FreeBox")
            {
               this.FOnOut(this,this.FOrangeEquipment.FreeInventory);
            }
            else
            {
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(6));
               _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
               _loc4_ = _loc2_ + this.FCurPage * SUIT_COUNT;
               _loc5_ = this.FOrangeEquipment.ChipBoxes[_loc4_].Inventories.GetInventoryByIndex(_loc3_);
               this.FOnOut(this,_loc5_);
            }
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
         this.FUIPage.TotalQuantity = this.FOrangeEquipment.ChipBoxes.length;
         this.FUIPage.Update();
         this.UpdateText();
         this.UpdateBox();
         this.UpdateFreeBox();
      }
   }
}

