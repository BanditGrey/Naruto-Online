package Processors.Game.Lobby.Protagonist
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityStandardBTN;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Military.TMilitaryData;
   import Logics.Military.TMilitaryLocalData;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_PROTAGONIST;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_PROTAGONIST;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TMilitaryInfo extends TProcessorLobbyWindow
   {
      
      protected var FMainUI:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_UpgradeMilitary:MovieClip;
      
      protected var FBTN_MilitaryList:MovieClip;
      
      protected var FTF_MilitaryName:TextField;
      
      protected var FTF_PointMilitaryDayCost:TextField;
      
      protected var FTF_PointMilitarySiliverCoin:TextField;
      
      protected var FTF_PointMilitarySpirit:TextField;
      
      protected var FTF_PointMilitaryMaxHeroNum:TextField;
      
      protected var FTF_PointMilitaryMaxFightHeroNum:TextField;
      
      protected var FTF_PointMilitaryAttributes:TextField;
      
      protected var FLevelupLevel:uint;
      
      protected var FLevelUpConfirmation:TUIWindowConfirmation;
      
      protected var FMilitaryData:TMilitaryData;
      
      protected var FOnUpgradeMilitary:Function;
      
      protected var FOnBack:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnMilitaryListClick:Function;
      
      public function TMilitaryInfo(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Perform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         this.FBTN_Close = this.FMainUI["BTN_Close"]["BTN_Close"];
         this.FTF_MilitaryName = this.FMainUI["TF_MilitaryName"];
         this.FTF_PointMilitaryDayCost = this.FMainUI["TF_NextCostPrestige"];
         this.FTF_PointMilitarySiliverCoin = this.FMainUI["TF_NextSilivercoin_PointMilitary"];
         this.FTF_PointMilitarySpirit = this.FMainUI["TF_NextSpirit_PointMilitary"];
         this.FTF_PointMilitaryMaxHeroNum = this.FMainUI["TF_NextMaxHeroNum_PointMilitary"];
         this.FTF_PointMilitaryMaxFightHeroNum = this.FMainUI["TF_NextFightHeroNum_PointMilitary"];
         this.FBTN_UpgradeMilitary = this.FMainUI["BTN_UpgradeMilitary"];
         this.FBTN_MilitaryList = this.FMainUI["BTN_MilitaryList"];
         this.FLevelUpConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FLevelUpConfirmation);
         this.FLevelUpConfirmation.x = (FUICore.StageWidth - this.FLevelUpConfirmation.WindowWidth) / 2;
         this.FLevelUpConfirmation.y = (FUICore.StageHeight - this.FLevelUpConfirmation.WindowHeight) / 2;
         this.FLevelUpConfirmation.OnOK = this.UpgradeMilitary;
         this.FLevelUpConfirmation.Visible = false;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.PROTAGONIST_LevelupTip) as TConfigValue;
         this.FLevelupLevel = _loc1_.Value as uint;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function Perform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnBtnCloseClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBTN_UpgradeMilitary,this.OnUpgradeMilitaryClick);
         this.FBTN_UpgradeMilitary.buttonMode = true;
         TUtilityStandardBTN.SetBtnEventListener(this.FBTN_MilitaryList,this.HandleOnMilitaryListClick);
         this.FBTN_MilitaryList.buttonMode = true;
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateTextField() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         var _loc5_:String = null;
         _loc1_ = this.GetMilitaryLocalInforByMilitaryRank(this.FMilitaryData.MilitaryRank + 1);
         this.FTF_MilitaryName.text = _loc1_.AnyMilitaryName;
         this.FTF_PointMilitaryDayCost.text = TUtilityString.Format(STRING_PROTAGONIST.STRING_MilitaryDayCost,_loc1_.AnyMilitaryCreditDayCost);
         this.FTF_PointMilitarySiliverCoin.text = _loc1_.AnyMilitarySalarySilvercoin.toString();
         this.FTF_PointMilitarySpirit.text = _loc1_.AnyMilitarySalarySpirit.toString();
         this.FTF_PointMilitaryMaxHeroNum.text = _loc1_.AnyMilitaryMaxHeroNum.toString();
         this.FTF_PointMilitaryMaxFightHeroNum.text = _loc1_.AnyMilitaryFightHeroNum.toString();
         _loc3_ = _loc1_.AnyMilitaryUseableCount;
         _loc2_ = 0;
         while(_loc2_ < TProcessorWindowProtagonist.ATTRIBUTE_NUM)
         {
            if(_loc2_ < _loc3_)
            {
               _loc5_ = this.CreateAddAttributeShowString(_loc1_.AnyMilitaryAttributesValue[_loc2_],_loc2_);
               TextField(this.FMainUI["PointAttributes_" + _loc2_]).text = _loc5_;
               if(_loc2_ % 2 != 1)
               {
                  if(_loc2_ % 2 == 0 && _loc2_ < 4)
                  {
                  }
               }
            }
            else
            {
               TextField(this.FMainUI["PointAttributes_" + _loc2_]).text = "";
            }
            _loc2_++;
         }
      }
      
      protected function CreateAddAttributeShowString(param1:String, param2:int) : String
      {
         var _loc3_:int = 0;
         if(param2 > 3)
         {
            _loc3_ = Number(param1) * 100;
            param1 = TUtilityString.Format(STRING_PROTAGONIST.FormatString_Percentage,_loc3_.toString());
         }
         return STRING_PROTAGONIST.ADDAttributeNames[param2] + "+" + param1;
      }
      
      protected function UpdateButton() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         _loc1_ = this.GetMilitaryLocalInforByMilitaryRank(this.FMilitaryData.MilitaryRank + 1);
         if(_loc1_ == null)
         {
            this.FBTN_UpgradeMilitary.gotoAndStop("Disable");
            return;
         }
         if(this.FMilitaryData.CurrentCredit < _loc1_.UpgradeAnyLevelNeedCredit)
         {
            this.FBTN_UpgradeMilitary.gotoAndStop("Disable");
         }
         else
         {
            this.FBTN_UpgradeMilitary.gotoAndStop("Enable");
         }
         this.FMainUI["BTN_Close"].visible = this.FMilitaryData.CurrentCredit < _loc1_.UpgradeAnyLevelNeedCredit;
      }
      
      protected function GetMilitaryLocalInforByMilitaryRank(param1:int) : TMilitaryLocalData
      {
         var _loc2_:int = 0;
         var _loc3_:TMilitaryLocalData = null;
         _loc2_ = param1 - CONST_PROTAGONIST.MilitaryInforMinID;
         if(_loc2_ < this.FMilitaryData.InforCount)
         {
            _loc3_ = this.FMilitaryData.GetMilitaryInforByIndex(_loc2_);
         }
         return _loc3_;
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateTextField();
         this.UpdateButton();
      }
      
      protected function OnBtnCloseClick(param1:MouseEvent) : void
      {
         if(FOnClose != null)
         {
            FOnClose(param1);
         }
      }
      
      protected function OnUpgradeMilitaryClick(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TMilitaryLocalData = null;
         _loc3_ = param1.currentTarget as MovieClip;
         if(_loc3_.currentLabel != "Disable")
         {
            if(this.FLevelupLevel == this.FMilitaryData.MilitaryRank)
            {
               _loc4_ = this.GetMilitaryLocalInforByMilitaryRank(this.FMilitaryData.MilitaryRank + 1);
               _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.PROTAGONIST_FORMAT_03) as TSystemLanguage;
               this.FLevelUpConfirmation.Text = TUtilityString.Format(_loc2_.Desc.split("%n").join("\n"),_loc4_.AnyMilitaryName);
               this.FLevelUpConfirmation.Visible = true;
            }
            else
            {
               this.UpgradeMilitary(this);
            }
         }
      }
      
      protected function UpgradeMilitary(param1:Object) : void
      {
         if(this.FOnUpgradeMilitary != null)
         {
            this.FOnUpgradeMilitary(this);
         }
      }
      
      protected function HandleOnMilitaryListClick(param1:MouseEvent) : void
      {
         if(this.FOnMilitaryListClick != null)
         {
            this.FOnMilitaryListClick(this);
         }
      }
      
      public function set MilitaryData(param1:TMilitaryData) : void
      {
         this.FMilitaryData = param1;
      }
      
      public function set OnUpgradeMilitary(param1:Function) : void
      {
         this.FOnUpgradeMilitary = param1;
      }
      
      public function set OnBack(param1:Function) : void
      {
         this.FOnBack = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function set OnMilitaryListClick(param1:Function) : void
      {
         this.FOnMilitaryListClick = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         super.Visible = param1;
         if(this.FMainUI != null)
         {
            this.FMainUI.visible = param1;
         }
      }
      
      public function Init(param1:MovieClip) : void
      {
         this.FMainUI = param1;
         this.Perform_UIDispatch();
         this.Perform_UILocations();
      }
      
      public function Update() : void
      {
         if(!Visible)
         {
            return;
         }
         this.UpdateUI();
      }
   }
}

