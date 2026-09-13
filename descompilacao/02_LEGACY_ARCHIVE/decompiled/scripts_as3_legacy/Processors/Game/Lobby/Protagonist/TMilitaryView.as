package Processors.Game.Lobby.Protagonist
{
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Military.*;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TMilitaryView extends TProcessorLobbyWindow
   {
      
      protected var FTF_CurrentMilitaryPrefixName:TextField;
      
      protected var FTF_CurrentMilitarySubfixName:TextField;
      
      protected var FTF_CurrentMilitaryDayCost:TextField;
      
      protected var FTF_CurrentMilitarySiliverCoin:TextField;
      
      protected var FTF_CurrentMilitarySpirit:TextField;
      
      protected var FTF_CurrentMilitaryMaxHeroNum:TextField;
      
      protected var FTF_CurrentMilitaryMaxFightHeroNum:TextField;
      
      protected var FTF_CurrentMilitaryAttributes:TextField;
      
      protected var FTF_PointMilitaryPrefixName:TextField;
      
      protected var FTF_PointMilitarySubfixName:TextField;
      
      protected var FTF_PointMilitaryDayCost:TextField;
      
      protected var FTF_PointMilitarySiliverCoin:TextField;
      
      protected var FTF_PointMilitarySpirit:TextField;
      
      protected var FTF_PointMilitaryMaxHeroNum:TextField;
      
      protected var FTF_PointMilitaryMaxFightHeroNum:TextField;
      
      protected var FTF_PointMilitaryAttributes:TextField;
      
      protected var FTF_PointMilitaryNeedPrestige:TextField;
      
      protected var FMCArray_MilitaryCard:Array;
      
      protected var FArrorLeft_MilitaryCard:MovieClip;
      
      protected var FArrorRight_MilitaryCard:MovieClip;
      
      protected var FStartMilitaryIDInMilitaryCards:int;
      
      protected var FSelectMilitaryCardId:int;
      
      protected var FCurrentMilitary_Arrow:MovieClip;
      
      protected var FNextMilitary_Arrow:MovieClip;
      
      protected var FMaxMilitaryID:int;
      
      protected var FBTN_Infor:SimpleButton;
      
      protected var FBTN_Back:SimpleButton;
      
      protected var FTFGotoArena:TextField;
      
      protected var FPendantLeft:MovieClip;
      
      protected var FPendantRight:MovieClip;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FMilitaryData:TMilitaryData;
      
      protected var FOnUpgradeMilitary:Function;
      
      protected var FOnBack:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FOnShortcutHyperlinks:Function;
      
      public function TMilitaryView(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispath();
         this.ConstructLocation();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PROTAGONIST.RESOURCESID_Swf_MilitaryList);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         var _loc3_:MovieClip = null;
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance("MilitaryInforUI") as MovieClip;
         addChild(_loc3_);
         _loc1_ = 0;
         while(_loc1_ < this.FUIDispatchRoutines.length)
         {
            _loc2_ = this.FUIDispatchRoutines[_loc1_];
            _loc2_(_loc3_);
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         _loc1_ = 0;
         while(_loc1_ < this.FUILocationRoutines.length)
         {
            _loc2_ = this.FUILocationRoutines[_loc1_];
            _loc2_();
            _loc1_++;
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function ConstructDispath() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.DispatchUICurrentMilitary);
         this.FUIDispatchRoutines.push(this.DispatchUIPointMilitary);
         this.FUIDispatchRoutines.push(this.DispatchUIMilitaryCards);
         this.FUIDispatchRoutines.push(this.DispatchUIButton);
      }
      
      protected function ConstructLocation() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.LocationCurrentMilitary);
         this.FUILocationRoutines.push(this.LocationPointMilitary);
         this.FUILocationRoutines.push(this.LocationMilitaryMilitaryCards);
         this.FUILocationRoutines.push(this.LocationButton);
      }
      
      protected function DispatchUICurrentMilitary(param1:MovieClip) : void
      {
         this.FTF_CurrentMilitaryDayCost = param1["TF_CostPrestige"];
         this.FTF_CurrentMilitarySiliverCoin = param1["TF_Silivercoin_Military"];
         this.FTF_CurrentMilitarySpirit = param1["TF_Spirit_Military"];
         this.FTF_CurrentMilitaryMaxHeroNum = param1["TF_MaxHeroNum"];
         this.FTF_CurrentMilitaryMaxFightHeroNum = param1["TF_FightHeroNum"];
         this.FTF_CurrentMilitaryAttributes = param1["MC_CurrentAttributes"];
      }
      
      protected function LocationCurrentMilitary() : void
      {
      }
      
      protected function UpdateCurrentMilitary() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc1_ = this.GetMilitaryLocalInforByMilitaryRank(this.FMilitaryData.MilitaryRank);
         this.FTF_CurrentMilitaryPrefixName.text = _loc1_.AnyMilitaryNamePrefix;
         this.FTF_CurrentMilitarySubfixName.text = _loc1_.AnyMilitaryNameSubfix;
         this.FTF_CurrentMilitaryDayCost.text = _loc1_.AnyMilitaryCreditDayCost.toString();
         this.FTF_CurrentMilitarySiliverCoin.text = _loc1_.AnyMilitarySalarySilvercoin.toString();
         this.FTF_CurrentMilitarySpirit.text = _loc1_.AnyMilitarySalarySpirit.toString();
         this.FTF_CurrentMilitaryMaxHeroNum.text = _loc1_.AnyMilitaryMaxHeroNum.toString();
         this.FTF_CurrentMilitaryMaxFightHeroNum.text = _loc1_.AnyMilitaryFightHeroNum.toString();
         _loc3_ = _loc1_.AnyMilitaryUseableCount;
         this.FTF_CurrentMilitaryAttributes.text = "";
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.CreateAddAttributeShowString(_loc1_.AnyMilitaryAttributesValue[_loc2_],_loc2_);
            this.FTF_CurrentMilitaryAttributes.appendText(_loc4_);
            this.FTF_CurrentMilitaryAttributes.appendText("\n");
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
      
      protected function DispatchUIPointMilitary(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc2_ = param1["PointMilitaryName"];
         this.FTF_PointMilitaryPrefixName = _loc2_["TF_CurrentMilitaryPrefixName"];
         this.FTF_PointMilitarySubfixName = _loc2_["TF_CurrentMilitarySubfixName"];
         this.FTF_PointMilitaryDayCost = param1["TF_NextCostPrestige"];
         this.FTF_PointMilitarySiliverCoin = param1["TF_NextSilivercoin_PointMilitary"];
         this.FTF_PointMilitarySpirit = param1["TF_NextSpirit_PointMilitary"];
         this.FTF_PointMilitaryMaxHeroNum = param1["TF_NextMaxHeroNum_PointMilitary"];
         this.FTF_PointMilitaryMaxFightHeroNum = param1["TF_NextFightHeroNum_PointMilitary"];
         this.FTF_PointMilitaryAttributes = param1["MC_PointAttributes"];
         this.FTF_PointMilitaryNeedPrestige = param1["TF_NeedCostPrestige"];
      }
      
      protected function LocationPointMilitary() : void
      {
      }
      
      protected function UpdatePointMilitaryInfor(param1:int) : void
      {
         var _loc2_:TMilitaryLocalData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TextField = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         _loc2_ = this.GetMilitaryLocalInforByMilitaryRank(param1);
         this.FTF_PointMilitaryPrefixName.text = _loc2_.AnyMilitaryNamePrefix;
         this.FTF_PointMilitarySubfixName.text = _loc2_.AnyMilitaryNameSubfix;
         this.FTF_PointMilitaryDayCost.text = _loc2_.AnyMilitaryCreditDayCost.toString();
         this.FTF_PointMilitarySiliverCoin.text = _loc2_.AnyMilitarySalarySilvercoin.toString();
         this.FTF_PointMilitarySpirit.text = _loc2_.AnyMilitarySalarySpirit.toString();
         this.FTF_PointMilitaryMaxHeroNum.text = _loc2_.AnyMilitaryMaxHeroNum.toString();
         this.FTF_PointMilitaryMaxFightHeroNum.text = _loc2_.AnyMilitaryFightHeroNum.toString();
         this.FTF_PointMilitaryNeedPrestige.text = _loc2_.UpgradeAnyLevelNeedCredit.toString();
         _loc4_ = _loc2_.AnyMilitaryUseableCount;
         this.FTF_PointMilitaryAttributes.text = "";
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = this.CreateAddAttributeShowString(_loc2_.AnyMilitaryAttributesValue[_loc3_],_loc3_);
            this.FTF_PointMilitaryAttributes.appendText(_loc6_);
            this.FTF_PointMilitaryAttributes.appendText("\n");
            _loc3_++;
         }
         _loc7_ = 0;
         _loc2_ = this.GetMilitaryLocalInforByMilitaryRank(param1);
      }
      
      protected function DispatchUIMilitaryCards(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         this.FMCArray_MilitaryCard = new Array();
         _loc3_ = 0;
         while(_loc3_ < CONST_PROTAGONIST.MILITARYCARD_NUM)
         {
            _loc2_ = param1["Military_Card_" + _loc3_];
            this.FMCArray_MilitaryCard.push(_loc2_);
            _loc3_++;
         }
         this.FArrorLeft_MilitaryCard = param1["MC_ArrorLeft"];
         this.FArrorRight_MilitaryCard = param1["MC_ArrorRight"];
         this.FCurrentMilitary_Arrow = param1["MC_CurrentMilitary"];
         this.FNextMilitary_Arrow = param1["MC_NextMilitary"];
      }
      
      protected function LocationMilitaryMilitaryCards() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         TUtilityStandardBTN.SetBtnEventListener(this.FArrorLeft_MilitaryCard,this.LeftArrorOnMouseClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FArrorRight_MilitaryCard,this.RightArrorOnMouseClick);
         _loc1_ = 0;
         while(_loc1_ < CONST_PROTAGONIST.MILITARYCARD_NUM)
         {
            _loc2_ = this.FMCArray_MilitaryCard[_loc1_];
            _loc2_.addEventListener(MouseEvent.CLICK,this.OnMilitaryCardClick);
            _loc2_.buttonMode = true;
            _loc2_.mouseChildren = false;
            _loc1_++;
         }
         this.FArrorLeft_MilitaryCard.buttonMode = true;
         this.FArrorRight_MilitaryCard.buttonMode = true;
      }
      
      protected function UpdateMilitaryCardInfor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TMilitaryLocalData = null;
         var _loc3_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_PROTAGONIST.MILITARYCARD_NUM)
         {
            this.FlushTextMilitaryCard(this.FMCArray_MilitaryCard[_loc1_],this.FStartMilitaryIDInMilitaryCards + _loc1_);
            _loc1_++;
         }
         this.FCurrentMilitary_Arrow.visible = false;
         this.FNextMilitary_Arrow.visible = false;
         _loc3_ = this.FMilitaryData.MilitaryRank - this.FStartMilitaryIDInMilitaryCards;
         if(_loc3_ <= CONST_PROTAGONIST.MILITARYCARD_NUM - 1 && _loc3_ >= 0)
         {
            this.FCurrentMilitary_Arrow.visible = true;
            this.FCurrentMilitary_Arrow.y = this.FMCArray_MilitaryCard[_loc3_].y + 7;
         }
         if(this.FMilitaryData.MilitaryRank < CONST_PROTAGONIST.MilitaryInforMaxID)
         {
            _loc3_ = this.FMilitaryData.MilitaryRank + 1 - this.FStartMilitaryIDInMilitaryCards;
            if(_loc3_ <= CONST_PROTAGONIST.MILITARYCARD_NUM - 1 && _loc3_ >= 0)
            {
               this.FNextMilitary_Arrow.visible = true;
               this.FNextMilitary_Arrow.y = this.FMCArray_MilitaryCard[_loc3_].y + 7;
            }
         }
      }
      
      protected function UpdateMilitaryArrorState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = CONST_PROTAGONIST.MilitaryInforMinID;
         if(this.FStartMilitaryIDInMilitaryCards <= _loc2_)
         {
            this.FArrorLeft_MilitaryCard.gotoAndStop("Disable");
         }
         else
         {
            this.FArrorLeft_MilitaryCard.gotoAndStop("Enable");
         }
         _loc1_ = CONST_PROTAGONIST.MilitaryInforMaxID - CONST_PROTAGONIST.MILITARYCARD_NUM + 1;
         if(this.FStartMilitaryIDInMilitaryCards >= _loc1_)
         {
            this.FArrorRight_MilitaryCard.gotoAndStop("Disable");
         }
         else
         {
            this.FArrorRight_MilitaryCard.gotoAndStop("Enable");
         }
      }
      
      protected function FlushTextMilitaryCard(param1:MovieClip, param2:int) : void
      {
         var _loc3_:TMilitaryLocalData = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         _loc3_ = this.GetMilitaryLocalInforByMilitaryRank(param2);
         if(param2 == this.FSelectMilitaryCardId)
         {
            if(param2 > this.FMilitaryData.MilitaryRank)
            {
               param1.gotoAndStop("BlackChoosed");
            }
            else
            {
               param1.gotoAndStop("WhiteChoosed");
            }
            _loc5_ = param1["SelectTask"];
            _loc5_.gotoAndPlay(1);
         }
         else if(param2 > this.FMilitaryData.MilitaryRank)
         {
            param1.gotoAndStop("BlackUnchoosed");
         }
         else
         {
            param1.gotoAndStop("WhiteUnchoosed");
         }
         _loc4_ = param1["rolename"];
         _loc4_.text = _loc3_.AnyMilitaryName;
      }
      
      protected function DispatchUIButton(param1:MovieClip) : void
      {
         this.FBTN_Infor = param1["Btn_Infor"];
         this.FBTN_Back = param1["BTN_Close"];
         this.FPendantLeft = param1["MC_PendantLeft"];
         this.FPendantRight = param1["MC_PendantRight"];
         this.FTFGotoArena = param1["TF_Arena"];
      }
      
      protected function LocationButton() : void
      {
         this.FBTN_Back.addEventListener(MouseEvent.CLICK,this.OnBackBtnClick);
         this.FTFGotoArena.htmlText = STRING_PROTAGONIST.FormatString_GotoArena;
         this.FTFGotoArena.addEventListener(TextEvent.LINK,this.GotoArena);
      }
      
      protected function ShackPendant() : void
      {
         this.FPendantLeft.gotoAndPlay(1);
         this.FPendantRight.gotoAndPlay(1);
      }
      
      protected function StopPendant() : void
      {
         this.FPendantLeft.gotoAndStop(1);
         this.FPendantRight.gotoAndStop(1);
      }
      
      protected function UpdateBtns() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         _loc1_ = this.GetMilitaryLocalInforByMilitaryRank(this.FMilitaryData.MilitaryRank + 1);
         if(_loc1_ == null)
         {
            return;
         }
         if(this.FMilitaryData.CurrentCredit < _loc1_.UpgradeAnyLevelNeedCredit)
         {
         }
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
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(_loc2_.currentLabel != "Disable")
         {
            if(this.FOnUpgradeMilitary != null)
            {
               this.FOnUpgradeMilitary();
            }
         }
      }
      
      protected function OnBackBtnClick(param1:MouseEvent) : void
      {
         if(this.FOnBack != null)
         {
            this.FOnBack();
            this.StopPendant();
         }
      }
      
      protected function GotoArena(param1:TextEvent) : void
      {
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            return;
         }
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Arena);
         }
      }
      
      protected function LeftArrorOnMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = CONST_PROTAGONIST.MilitaryInforMinID;
         if(this.FStartMilitaryIDInMilitaryCards > _loc3_)
         {
            --this.FStartMilitaryIDInMilitaryCards;
            this.UpdateMilitaryCardInfor();
         }
         this.UpdateMilitaryArrorState();
      }
      
      protected function RightArrorOnMouseClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = CONST_PROTAGONIST.MilitaryInforMaxID - CONST_PROTAGONIST.MILITARYCARD_NUM + 1;
         if(this.FStartMilitaryIDInMilitaryCards < _loc3_)
         {
            ++this.FStartMilitaryIDInMilitaryCards;
            this.UpdateMilitaryCardInfor();
         }
         this.UpdateMilitaryArrorState();
      }
      
      protected function OnMilitaryCardClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FMCArray_MilitaryCard.length)
         {
            if(param1.currentTarget == this.FMCArray_MilitaryCard[_loc2_])
            {
               break;
            }
            _loc2_++;
         }
         this.FSelectMilitaryCardId = this.FStartMilitaryIDInMilitaryCards + _loc2_;
         this.UpdatePointMilitaryInfor(this.FSelectMilitaryCardId);
         this.UpdateMilitaryCardInfor();
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
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         if(this.FMilitaryData == null)
         {
            return;
         }
         if(this.FMilitaryData.MilitaryRank < CONST_PROTAGONIST.MilitaryInforMaxID)
         {
            this.FSelectMilitaryCardId = this.FMilitaryData.MilitaryRank + 1;
            this.UpdatePointMilitaryInfor(this.FSelectMilitaryCardId);
         }
         else
         {
            this.FSelectMilitaryCardId = this.FMilitaryData.MilitaryRank;
            this.UpdatePointMilitaryInfor(this.FSelectMilitaryCardId);
         }
         _loc1_ = CONST_PROTAGONIST.MilitaryInforMaxID - CONST_PROTAGONIST.MILITARYCARD_NUM + 1;
         this.FStartMilitaryIDInMilitaryCards = this.FMilitaryData.MilitaryRank;
         if(this.FStartMilitaryIDInMilitaryCards > _loc1_)
         {
            this.FStartMilitaryIDInMilitaryCards = _loc1_;
         }
         this.UpdateMilitaryArrorState();
         this.UpdateMilitaryCardInfor();
         this.ShackPendant();
      }
      
      public function Show() : void
      {
         this.visible = true;
      }
   }
}

