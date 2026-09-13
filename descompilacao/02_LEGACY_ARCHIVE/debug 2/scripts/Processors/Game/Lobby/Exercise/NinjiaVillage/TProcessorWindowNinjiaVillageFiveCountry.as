package Processors.Game.Lobby.Exercise.NinjiaVillage
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageBaseData;
   import Logics.Exercise.NinjiaVillage.TNinjiaVillageData;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TProcessorWindowNinjiaVillageFiveCountry extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 687;
      
      protected static const SIZE_Window_Height:uint = 466;
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const BASE_ID:uint = 52001;
      
      protected static const BIG_TYPE:uint = 3;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTF_Desc:TextField;
      
      protected var FBoxVect:Vector.<MovieClip>;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FInitialized:Boolean;
      
      protected var FNinjiaVillageData:TNinjiaVillageData;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FIndex:int;
      
      protected var FBeClicked:Boolean;
      
      protected var FCost:int;
      
      protected var FTF_Gold:TextField;
      
      protected var FTextFormat:TextFormat;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnBtnOver:Function;
      
      protected var FOnBtnOut:Function;
      
      public function TProcessorWindowNinjiaVillageFiveCountry(param1:TUIComponent)
      {
         super(param1);
         this.FNinjiaVillageData = SLogicsCore.NinjiaVillageData;
         this.FBoxVect = new Vector.<MovieClip>(BOX_COUNT);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FTextFormat = new TextFormat();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2164260864);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjiaVillageFiveCountry") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = this.FMC_Scene["MC_Box" + _loc1_];
            _loc2_.TXT_MASK.visible = false;
            _loc2_.TXT_MASK.mouseEnabled = false;
            _loc2_.BTN_MASK_BG.visible = false;
            _loc2_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            _loc2_.BTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBtnOver);
            _loc2_.BTN_Buy.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBtnOut);
            TGameUtil.setButtonMode(_loc2_.BTN_Buy,true);
            this.FBoxVect[_loc1_] = _loc2_;
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
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:TNinjiaVillageBaseData = null;
         _loc3_ = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID);
         _loc2_ = _loc3_.ReturnType == 1 ? STRING_COMMON.ITEMNAME_Gold : STRING_COMMON.ITEMNAME_Vouchers;
         _loc1_ = _loc3_.Desc1.split("%n").join("\n");
         _loc1_ = TUtilityString.Format(_loc1_,_loc2_);
         this.FTF_Desc.text = _loc1_;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:TNinjiaVillageBaseData = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc5_ = this.FBoxVect[_loc1_];
            _loc7_ = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID + _loc1_);
            _loc5_.TF_Title.text = _loc7_.Title;
            _loc5_.MC_Country.gotoAndStop(_loc1_ + 1);
            if(_loc7_.Status == TBaseActivity.STATUS_GETED)
            {
               if(this.FNinjiaVillageData.FiveCountryReturnType == 1)
               {
                  _loc5_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_GET_GIFT,_loc7_.ReturnGift) + STRING_COMMON.ITEMNAME_Gold;
               }
               else
               {
                  _loc5_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_GET_GIFT,_loc7_.ReturnGift) + STRING_COMMON.ITEMNAME_Vouchers;
               }
               this.FTextFormat.color = 4288282419;
               _loc5_.TF_Gold.setTextFormat(this.FTextFormat);
               _loc5_.BTN_Buy.visible = false;
            }
            else if(_loc7_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               if(this.FNinjiaVillageData.FiveCountryReturnType == 1)
               {
                  _loc5_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RETURN_GIFT,_loc7_.Min,_loc7_.Max) + STRING_COMMON.ITEMNAME_Gold;
               }
               else
               {
                  _loc5_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RETURN_GIFT,_loc7_.Min,_loc7_.Max) + STRING_COMMON.ITEMNAME_Vouchers;
               }
               TGameUtil.setButtonMode(_loc5_.BTN_Buy,false);
               this.FTextFormat.color = 4294967193;
               _loc5_.TF_Gold.setTextFormat(this.FTextFormat);
               _loc5_.BTN_Buy.visible = true;
            }
            else
            {
               if(this.FNinjiaVillageData.FiveCountryReturnType == 1)
               {
                  _loc5_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RETURN_GIFT,_loc7_.Min,_loc7_.Max) + STRING_COMMON.ITEMNAME_Gold;
               }
               else
               {
                  _loc5_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_RETURN_GIFT,_loc7_.Min,_loc7_.Max) + STRING_COMMON.ITEMNAME_Vouchers;
               }
               TGameUtil.setButtonMode(_loc5_.BTN_Buy,true);
               this.FTextFormat.color = 4294967193;
               _loc5_.TF_Gold.setTextFormat(this.FTextFormat);
               _loc5_.BTN_Buy.visible = true;
            }
            if(_loc7_.CZ != 0 && this.FNinjiaVillageData.rechargeGoldNum < _loc7_.CZ)
            {
               _loc5_.TXT_MASK.text = _loc7_.Desc4.split("%n").join(_loc7_.CZ.toString());
               _loc5_.BTN_MASK_BG.height = _loc5_.TXT_MASK.textHeight > 0 ? _loc5_.TXT_MASK.textHeight + 8 : _loc5_.BTN_MASK_BG.height;
               _loc5_.TXT_MASK.visible = true;
               _loc5_.BTN_MASK_BG.visible = true;
               _loc5_.BTN_Buy.visible = false;
            }
            else
            {
               _loc5_.TXT_MASK.visible = false;
               _loc5_.BTN_MASK_BG.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         this.FIndex = int(String(param1.currentTarget.parent.name).slice(6));
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
      
      protected function ProcessorOnBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(this.FOnBtnOver != null)
         {
            this.FIndex = int(String(param1.currentTarget.parent.name).slice(6));
            this.FCost = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID + this.FIndex).Price;
            _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GOLD,this.FCost);
            this.FOnBtnOver(_loc2_);
         }
      }
      
      protected function ProcessorOnBtnOut(param1:MouseEvent) : void
      {
         if(this.FOnBtnOut != null)
         {
            this.FOnBtnOut();
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
      
      public function get BeClicked() : Boolean
      {
         return this.FBeClicked;
      }
      
      public function set BeClicked(param1:Boolean) : void
      {
         this.FBeClicked = param1;
      }
      
      public function get OnBtnOver() : Function
      {
         return this.FOnBtnOver;
      }
      
      public function set OnBtnOver(param1:Function) : void
      {
         this.FOnBtnOver = param1;
      }
      
      public function get OnBtnOut() : Function
      {
         return this.FOnBtnOut;
      }
      
      public function set OnBtnOut(param1:Function) : void
      {
         this.FOnBtnOut = param1;
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

