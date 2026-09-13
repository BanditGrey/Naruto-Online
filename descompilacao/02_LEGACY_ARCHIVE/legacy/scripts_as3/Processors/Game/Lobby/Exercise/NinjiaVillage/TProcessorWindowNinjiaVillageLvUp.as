package Processors.Game.Lobby.Exercise.NinjiaVillage
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageBaseData;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
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
   
   public class TProcessorWindowNinjiaVillageLvUp extends TProcessorLobbyWindow
   {
      
      protected static const BASE_ID:uint = 50001;
      
      protected static const BIG_TYPE:uint = 1;
      
      protected static const SIZE_Window_Width:uint = 709;
      
      protected static const SIZE_Window_Height:uint = 466;
      
      protected static const ITEM_COUNT:int = 3;
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const ACTIVITY_MAIN_TYPE:int = 1;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FBTN_Get:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FNinjiaVillageData:TNinjiaVillageData;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FIndex:int;
      
      protected var FUIBoxVect:Vector.<TUIBaseBox>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FCost:int;
      
      protected var FBeClicked:Boolean;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessorWindowNinjiaVillageLvUp(param1:TUIComponent)
      {
         super(param1);
         this.FNinjiaVillageData = SLogicsCore.NinjiaVillageData;
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIBoxVect = new Vector.<TUIBaseBox>(ITEM_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2164260864);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUIBaseBox = null;
         var _loc2_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjiaVillageLvUp") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         _loc2_ = 0;
         while(_loc2_ < ITEM_COUNT)
         {
            _loc1_ = new TUIBaseBox(this,BOX_COUNT);
            _loc1_.Perform_UIDispatch(this.FMC_Scene["MC_Item" + _loc2_]);
            _loc1_.OnOverlay = this.SlotsOnOver;
            _loc1_.OnOut = this.SlotsOnOut;
            _loc1_.OnGetBox = this.ProcessorOnBuyUp;
            _loc1_.MC_Tag.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTagOver);
            _loc1_.MC_Tag.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTagOut);
            this.FUIBoxVect[_loc2_] = _loc1_;
            _loc2_++;
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
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Desc.text = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID).Desc1;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TNinjiaVillageBaseData = null;
         var _loc7_:String = null;
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc6_ = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID + _loc1_);
            _loc5_ = _loc6_.Inventories;
            this.FUIBoxVect[_loc1_].UpdateUI(_loc5_);
            this.FUIBoxVect[_loc1_].UpdateTag(_loc1_);
            this.FUIBoxVect[_loc1_].SetNameText(_loc6_.Title);
            this.FUIBoxVect[_loc1_].SetPriceText(_loc6_.Price.toString());
            if(_loc6_.Status == TBaseActivity.STATUS_GETED)
            {
               this.FUIBoxVect[_loc1_].IsBoxGot(true);
            }
            else
            {
               this.FUIBoxVect[_loc1_].IsBoxGot(false);
            }
            _loc2_ = 0;
            while(_loc2_ < BOX_COUNT)
            {
               _loc7_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_LEVEL,_loc6_.LimitLevel[_loc2_]);
               this.FUIBoxVect[_loc1_].SetDescText(_loc2_,_loc7_);
               _loc2_++;
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
            while(_loc1_ < ITEM_COUNT)
            {
               if(this.FUIBoxVect[_loc1_])
               {
                  this.FUIBoxVect[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
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
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         this.FIndex = int(param1.currentTarget.parent.name.slice(7));
         this.FCost = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID + this.FIndex).Price;
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FCost)
         {
            if(this.FOnGetBox != null)
            {
               this.FBeClicked = true;
               this.FOnGetBox(this.FIndex);
            }
         }
         else
         {
            this.FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnTagOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.currentTarget.parent.name.slice(7));
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(_loc2_);
         }
      }
      
      protected function ProcessorOnTagOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(param1.currentTarget.parent.name.slice(7));
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(_loc2_);
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
      
      public function get BeClicked() : Boolean
      {
         return this.FBeClicked;
      }
      
      public function set BeClicked(param1:Boolean) : void
      {
         this.FBeClicked = param1;
      }
      
      public function UpdateUI() : void
      {
         if(this.FNinjiaVillageData.DataVect.length == 0)
         {
            return;
         }
         this.UpdateText();
         this.UpdateBox();
      }
   }
}

