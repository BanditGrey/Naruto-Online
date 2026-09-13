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
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_NINJIAVILLAGE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowNinjiaVillageFund extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 709;
      
      protected static const SIZE_Window_Height:uint = 466;
      
      public static const FUND_COUNT:int = 5;
      
      protected static const BASE_ID:uint = 51001;
      
      protected static const BIG_TYPE:uint = 2;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_BuyFund:MovieClip;
      
      protected var FMC_GetFund:MovieClip;
      
      protected var FTF_Desc:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FInitialized:Boolean;
      
      protected var FNinjiaVillageData:TNinjiaVillageData;
      
      protected var FIndex:int;
      
      protected var FBeClicked:Boolean;
      
      protected var FCost:int;
      
      protected var FOnCloseUp:Function;
      
      protected var FOnFundOverlay:Function;
      
      protected var FOnFundOut:Function;
      
      protected var FOnBoxOverlay:Function;
      
      protected var FOnBoxOut:Function;
      
      protected var FOnGetBox:Function;
      
      public function TProcessorWindowNinjiaVillageFund(param1:TUIComponent)
      {
         super(param1);
         this.FNinjiaVillageData = SLogicsCore.NinjiaVillageData;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjiaVillageFund") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBTN_Close = this.FMC_Scene["BTN_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         this.FTF_Desc = this.FMC_Scene["TF_Desc"];
         this.FMC_BuyFund = this.FMC_Scene.MC_BuyFund;
         this.FMC_GetFund = this.FMC_Scene.MC_GetFund;
         this.FMC_GetFund.visible = false;
         _loc1_ = 0;
         while(_loc1_ < FUND_COUNT)
         {
            _loc2_ = this.FMC_BuyFund["MC_Tree" + _loc1_];
            _loc2_.TXT_MASK.visible = false;
            _loc2_.TXT_MASK.mouseEnabled = false;
            _loc2_.BTN_MASK_BG.visible = false;
            _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFundOver);
            _loc2_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnFundOut);
            _loc2_.MC_BoxPic.buttonMode = true;
            _loc2_.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc2_.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            TGameUtil.setButtonMode(_loc2_.BTN_Buy,true);
            _loc2_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBox);
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
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TNinjiaVillageBaseData = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < FUND_COUNT)
         {
            _loc4_ = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID + _loc1_);
            _loc3_ = this.FMC_BuyFund["MC_Tree" + _loc1_];
            _loc3_.TF_Rate.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_GET_RATE,_loc4_.Discount);
            _loc3_.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ALL_COUNT,_loc4_.Count);
            _loc5_ = new ConsumeFrameCopy(STRING_NINJIAVILLAGE.STRING_002).DescribeString;
            if(_loc4_.ReturnType == 1)
            {
               _loc5_ = TUtilityString.Format(_loc5_,_loc4_.ReturnGold + STRING_COMMON.ITEMNAME_Gold);
            }
            else
            {
               _loc5_ = TUtilityString.Format(_loc5_,_loc4_.ReturnGold + STRING_COMMON.ITEMNAME_Vouchers);
            }
            _loc3_.TF_Gold.text = _loc5_;
            if(_loc4_.Desc4 != null && _loc4_.CZ != 0)
            {
               _loc3_.TXT_MASK.text = _loc4_.Desc4.split("%n").join(_loc4_.CZ.toString());
               _loc3_.BTN_MASK_BG.height = _loc3_.TXT_MASK.textHeight > 0 ? _loc3_.TXT_MASK.textHeight + 8 : _loc3_.BTN_MASK_BG.height;
               _loc3_.TXT_MASK.visible = _loc4_.Status == TBaseActivity.STATUS_CANNOTGET ? true : false;
               _loc3_.BTN_MASK_BG.visible = _loc4_.Status == TBaseActivity.STATUS_CANNOTGET ? true : false;
               _loc3_.BTN_Buy.visible = _loc4_.Status == TBaseActivity.STATUS_CANNOTGET ? false : true;
            }
            else
            {
               _loc3_.TXT_MASK.visible = _loc4_.Status == TBaseActivity.STATUS_CANNOTGET ? true : false;
               _loc3_.BTN_MASK_BG.visible = _loc4_.Status == TBaseActivity.STATUS_CANNOTGET ? true : false;
               _loc3_.BTN_Buy.visible = true;
            }
            _loc1_++;
         }
         _loc4_ = this.FNinjiaVillageData.GetDataByIdentify(BASE_ID);
         _loc5_ = _loc4_.Desc1.split("%n").join("\n");
         _loc5_ = TUtilityString.Format(_loc5_,_loc4_.MaxTime);
         this.FMC_BuyFund.TF_Desc.text = _loc5_;
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:String = null;
         var _loc2_:TNinjiaVillageBaseData = null;
         _loc2_ = this.FNinjiaVillageData.GetDataByIdentify(this.FNinjiaVillageData.FundID);
         if(_loc2_)
         {
            this.FMC_GetFund.TF_Tree.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_HAVE_TREE,_loc2_.Title,_loc2_.Discount);
            _loc1_ = new ConsumeFrameCopy(STRING_NINJIAVILLAGE.STRING_002).DescribeString;
            if(_loc2_.ReturnType == 1)
            {
               this.FMC_GetFund.TF_Gold.text = TUtilityString.Format(_loc1_,_loc2_.ReturnGold + STRING_COMMON.ITEMNAME_Gold);
            }
            else
            {
               this.FMC_GetFund.TF_Gold.text = TUtilityString.Format(_loc1_,_loc2_.ReturnGold + STRING_COMMON.ITEMNAME_Vouchers);
            }
            this.FMC_GetFund.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LEFT_COUNT,_loc2_.Count - _loc2_.BuyCount);
            this.FMC_GetFund.MC_TreePic.gotoAndStop(this.FNinjiaVillageData.FundID - BASE_ID + 1);
         }
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
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         this.FIndex = int(String(param1.currentTarget.parent.name).slice(7));
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
      
      protected function ProcessorOnFundOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnFundOverlay != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnFundOverlay(_loc2_);
         }
      }
      
      protected function ProcessorOnFundOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnFundOut != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnFundOut(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnBoxOverlay != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnBoxOverlay(_loc2_);
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this.FOnBoxOut != null)
         {
            _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
            this.FOnBoxOut(_loc2_);
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
      
      public function get OnFundOverlay() : Function
      {
         return this.FOnFundOverlay;
      }
      
      public function set OnFundOverlay(param1:Function) : void
      {
         this.FOnFundOverlay = param1;
      }
      
      public function get OnFundOut() : Function
      {
         return this.FOnFundOut;
      }
      
      public function set OnFundOut(param1:Function) : void
      {
         this.FOnFundOut = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get OnBoxOverlay() : Function
      {
         return this.FOnBoxOverlay;
      }
      
      public function set OnBoxOverlay(param1:Function) : void
      {
         this.FOnBoxOverlay = param1;
      }
      
      public function get OnBoxOut() : Function
      {
         return this.FOnBoxOut;
      }
      
      public function set OnBoxOut(param1:Function) : void
      {
         this.FOnBoxOut = param1;
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
         if(this.FNinjiaVillageData.FundID == 0)
         {
            this.UpdateBox();
            this.FMC_BuyFund.visible = true;
            this.FMC_GetFund.visible = false;
         }
         else
         {
            this.UpdateTree();
            this.FMC_BuyFund.visible = false;
            this.FMC_GetFund.visible = true;
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
   }
}

