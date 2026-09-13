package Processors.Game.Lobby.Smithy
{
   import Components.Slots.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Registries.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.Inventories.*;
   import Logics.Smithy.*;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class SmithyWindowRefined extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_ONETIMEREFINE:int = 1;
      
      protected static const STATE_BATCHREFINED:int = 2;
      
      protected static const STATE_EXCHANGED:int = 3;
      
      protected static const UIWIDTH:int = 480;
      
      protected static const UIHEIGHT:int = 535;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FInitialization:Boolean;
      
      protected var FCurrentState:int;
      
      protected var UnstreamizerEquipmentAppendAttribute:TUnstreamizerEquipmentAppendAttribute;
      
      protected var FEquipmentSlot:TUISlot;
      
      protected var FMC_OldAttributesList:Vector.<MovieClip>;
      
      protected var FTF_OldAttributesName:Vector.<TextField>;
      
      protected var FTF_OldAttributesValue:Vector.<TextField>;
      
      protected var FMC_NewightAttributesList:Vector.<MovieClip>;
      
      protected var FTF_NewAttributesName:Vector.<TextField>;
      
      protected var FTF_NewAttributesValue:Vector.<TextField>;
      
      protected var FTextFormat:TextFormat;
      
      protected var FAppendAttribute:TEquipmentAppendAttribute;
      
      protected var FMC_Activitys:Vector.<MovieClip>;
      
      protected var FMC_ActivitysTask:Vector.<MovieClip>;
      
      protected var FTF_ActivityCostValue:Vector.<TextField>;
      
      protected var FTF_ActivityCostName:Vector.<TextField>;
      
      protected var FCurrentStrengthenActivity:uint;
      
      protected var FRefinedNeedSiliverCoin:int;
      
      protected var FActivities_Hint:Vector.<THint>;
      
      protected var FBoundsBatchRefined:TBounds;
      
      protected var FWindowBatchRefined:TWindowBatchRefined;
      
      protected var FVipLowHint:THint;
      
      protected var FFatherUI:MovieClip;
      
      protected var FBtn_SingleRefined:MovieClip;
      
      protected var FBtn_AnyTimeRefined:MovieClip;
      
      protected var FBtn_Replace:MovieClip;
      
      protected var FBtn_Ignore:MovieClip;
      
      protected var FTextRegistry:TRegistryInstance;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationCopy2:TUIWindowConfirmation;
      
      protected var OldColorCount:Array;
      
      protected var NewColorCount:Array;
      
      protected var FReciveEquipment:TEquipment;
      
      protected var FHeroID:uint;
      
      protected var FCurrentSmithyAttributeUnstreamizerData:TSmithyRefinedPakcetUnstreamizerData;
      
      protected var FRefinedNetwork:Function;
      
      protected var FRefinedExchange:Function;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FBackReset:Function;
      
      public function SmithyWindowRefined(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
         this.ConstructFlyText();
         this.FWindowBatchRefined = new TWindowBatchRefined(this);
         this.FWindowBatchRefined.OnWindowClose = this.OnBatchRefinedWindowClose;
         this.FWindowBatchRefined.x = 200;
         this.FWindowBatchRefined.y = 0;
         this.UnstreamizerEquipmentAppendAttribute = new TUnstreamizerEquipmentAppendAttribute();
         this.FUIWindowRecharge = new TUIWindowRecharge(parent.parent as TUIComponent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         this.NewColorCount = new Array();
         this.OldColorCount = new Array();
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.EquipmentUIDispatch);
         this.FUIDispatchRoutines.push(this.AttributeUIDispatch);
         this.FUIDispatchRoutines.push(this.ActivityUIDispatch);
         this.FUIDispatchRoutines.push(this.BtnsUIDispatch);
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FFatherUI = param1;
         this.addChild(param1);
         _loc2_ = 0;
         while(_loc2_ < this.FUIDispatchRoutines.length)
         {
            _loc3_ = this.FUIDispatchRoutines[_loc2_];
            _loc3_(param1);
            _loc2_++;
         }
         this.addChild(this.FWindowBatchRefined);
         this.FWindowBatchRefined.Load();
         this.FUIWindowConfirmation = new TUIWindowConfirmation(parent.parent as TUIComponent);
         this.FUIWindowConfirmation.OnOK = this.OnConfirmationOk;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowConfirmationCopy = new TUIWindowConfirmation(parent.parent as TUIComponent);
         this.FUIWindowConfirmationCopy.OnOK = this.OnConfirmationOkCopy;
         this.FUIWindowConfirmationCopy.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationCopy.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationCopy.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy);
         this.FUIWindowConfirmationCopy.SetCheckBox(true);
         this.FUIWindowConfirmationCopy2 = new TUIWindowConfirmation(parent.parent as TUIComponent);
         this.FUIWindowConfirmationCopy2.OnOK = this.OnConfirmationOkCopy2;
         this.FUIWindowConfirmationCopy2.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmationCopy2.WindowWidth) / 2;
         this.FUIWindowConfirmationCopy2.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmationCopy2.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationCopy2);
         this.FUIWindowConfirmationCopy2.SetCheckBox(true);
      }
      
      protected function ConstructLocationRoutines() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.EquipmentLocation);
         this.FUILocationRoutines.push(this.AttributeLocation);
         this.FUILocationRoutines.push(this.ActivityLocation);
         this.FUILocationRoutines.push(this.BtnsLocation);
      }
      
      public function Perform_UILocation() : void
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
         this.FInitialization = true;
         this.FCurrentState = STATE_READY;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialization)
         {
            this.FEquipmentSlot.Update();
         }
      }
      
      protected function EquipmentUIDispatch(param1:MovieClip) : void
      {
         this.FEquipmentSlot = new TUISlot(this);
         this.FEquipmentSlot.Resource = param1["Wash_Slot"];
      }
      
      protected function EquipmentLocation() : void
      {
         TJadeCommon.InitSlot(this.FEquipmentSlot,CONST_MODULES.MODULE_Smithy);
         this.FEquipmentSlot.OnClick = this.OnEquipSlotClick;
         this.FEquipmentSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FEquipmentSlot.OnOut = this.UIComponentsHintOnOut;
         this.FEquipmentSlot.Init();
      }
      
      protected function UpdateEquipment() : void
      {
         var _loc1_:TEquipment = null;
         if(this.FReciveEquipment != null)
         {
            _loc1_ = this.GetEquipmentByID(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1);
            this.ReciveEquipment(_loc1_,this.FHeroID);
         }
      }
      
      protected function ResetEquipment() : void
      {
         this.FEquipmentSlot.Context = null;
      }
      
      protected function GetEquipmentByID(param1:uint, param2:uint) : TEquipment
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventories = null;
         var _loc6_:THero = null;
         var _loc7_:THeros = null;
         var _loc8_:TEquipment = null;
         _loc7_ = SLogicsCore.Character.Heros;
         _loc4_ = _loc7_.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = _loc7_.GetHeroByIndex(_loc3_);
            _loc8_ = _loc6_.EquipmentsMounted.GetInventoryByIdentifier(param1,param2) as TEquipment;
            if(_loc8_ != null)
            {
               return _loc8_;
            }
            _loc3_++;
         }
         _loc5_ = SLogicsCore.Character.Equipments;
         return _loc5_.GetInventoryByIdentifier(param1,param2) as TEquipment;
      }
      
      protected function AttributeUIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.FMC_OldAttributesList = new Vector.<MovieClip>();
         this.FTF_OldAttributesName = new Vector.<TextField>();
         this.FTF_OldAttributesValue = new Vector.<TextField>();
         this.FMC_NewightAttributesList = new Vector.<MovieClip>();
         this.FTF_NewAttributesName = new Vector.<TextField>();
         this.FTF_NewAttributesValue = new Vector.<TextField>();
         _loc3_ = CONST_SMITHY.MAX_ATTRIBUTENUM;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1["Old_" + _loc2_];
            this.FMC_OldAttributesList.push(_loc4_);
            this.FTF_OldAttributesName.push(_loc4_["AttributeName"]);
            this.FTF_OldAttributesValue.push(_loc4_["AttributeValue"]);
            _loc4_ = param1["New_" + _loc2_];
            this.FMC_NewightAttributesList.push(_loc4_);
            this.FTF_NewAttributesName.push(_loc4_["AttributeName"]);
            this.FTF_NewAttributesValue.push(_loc4_["AttributeValue"]);
            _loc2_++;
         }
      }
      
      protected function AttributeLocation() : void
      {
         this.FTextFormat = new TextFormat();
         this.FAppendAttribute = new TEquipmentAppendAttribute();
      }
      
      protected function UpdateAttribute() : void
      {
         this.UpdateOldAttribute();
         this.UpdateNewAttribute();
      }
      
      protected function UpdateOldAttribute() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEquipmentAppendAttribute = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         if(this.FReciveEquipment == null)
         {
            this.ResetAttribute();
            return;
         }
         _loc4_ = this.FReciveEquipment.AppendAttributes.Count;
         _loc2_ = CONST_SMITHY.MAX_ATTRIBUTENUM;
         _loc1_ = _loc4_;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FMC_OldAttributesList[_loc1_];
            _loc5_.visible = false;
            _loc1_++;
         }
         this.OldColorCount.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = this.FReciveEquipment.AppendAttributes.GetAttributeByIndex(_loc1_);
            _loc5_ = this.FMC_OldAttributesList[_loc1_];
            this.SetTextByAttribute(this.FTF_OldAttributesName[_loc1_],this.FTF_OldAttributesValue[_loc1_],_loc3_);
            this.OldSetTextColor(this.FTF_OldAttributesValue[_loc1_],_loc3_);
            _loc5_.visible = true;
            _loc1_++;
         }
      }
      
      protected function UpdateNewAttribute() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TEquipmentAppendAttribute = null;
         var _loc4_:TEquipmentAppendAttribute = null;
         var _loc5_:TEquipmentAppendAttributes = null;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         _loc6_ = this.FReciveEquipment.AppendAttributes.Count;
         _loc2_ = CONST_SMITHY.MAX_ATTRIBUTENUM;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc7_ = this.FMC_NewightAttributesList[_loc1_];
            if(_loc1_ < _loc6_)
            {
               this.FTF_NewAttributesName[_loc1_].text = "";
               this.FTF_NewAttributesValue[_loc1_].text = "";
               _loc7_.visible = true;
            }
            else
            {
               _loc7_.visible = false;
            }
            _loc1_++;
         }
         if(this.FCurrentSmithyAttributeUnstreamizerData == null)
         {
            return;
         }
         _loc5_ = this.FCurrentSmithyAttributeUnstreamizerData.SmithyAttributeList.GetAttributesByIndex(0);
         this.NewColorCount.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc6_)
         {
            _loc4_ = _loc5_.GetAttributeByIndex(_loc1_);
            _loc7_ = this.FMC_NewightAttributesList[_loc1_];
            this.SetTextByAttribute(this.FTF_NewAttributesName[_loc1_],this.FTF_NewAttributesValue[_loc1_],_loc4_);
            this.NewSetTextColor(this.FTF_NewAttributesValue[_loc1_],_loc4_);
            _loc1_++;
         }
      }
      
      protected function ResetAttribute() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = CONST_SMITHY.MAX_ATTRIBUTENUM;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_OldAttributesList[_loc1_];
            _loc3_.visible = false;
            _loc3_ = this.FMC_NewightAttributesList[_loc1_];
            _loc3_.visible = false;
            _loc1_++;
         }
      }
      
      protected function OldSetTextColor(param1:TextField, param2:TEquipmentAppendAttribute) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Vector.<Number> = null;
         _loc3_ = (param2.Value - param2.MinValue) / (param2.MaxValue - param2.MinValue);
         _loc5_ = CONST_SMITHY.HitPercentRate;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(_loc3_ <= _loc5_[_loc4_])
            {
               break;
            }
            _loc4_++;
         }
         this.OldColorCount.push(_loc4_);
         this.FTextFormat.color = CONST_SMITHY.TextColor[_loc4_];
         param1.setTextFormat(this.FTextFormat);
      }
      
      protected function NewSetTextColor(param1:TextField, param2:TEquipmentAppendAttribute) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:Vector.<Number> = null;
         _loc3_ = (param2.Value - param2.MinValue) / (param2.MaxValue - param2.MinValue);
         _loc5_ = CONST_SMITHY.HitPercentRate;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(_loc3_ <= _loc5_[_loc4_])
            {
               break;
            }
            _loc4_++;
         }
         this.NewColorCount.push(_loc4_);
         this.FTextFormat.color = CONST_SMITHY.TextColor[_loc4_];
         param1.setTextFormat(this.FTextFormat);
      }
      
      protected function SetTextByAttribute(param1:TextField, param2:TextField, param3:TEquipmentAppendAttribute) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         param1.text = param3.Name;
         if(param3.Percentage == 1)
         {
            _loc4_ = this.ChangeToRateString(param3.MaxValue,param3.Divisor);
            _loc5_ = this.ChangeToRateString(param3.Value,param3.Divisor);
         }
         else
         {
            _loc4_ = param3.MaxValue.toString();
            _loc5_ = param3.Value.toString();
         }
         _loc6_ = TUtilityString.Format(STRING_SMITHY.FORMAT_AttributeValue,_loc5_,_loc4_);
         param2.text = _loc6_;
      }
      
      protected function ChangeToRateString(param1:uint, param2:uint) : String
      {
         if(param2 == 1000)
         {
            return param1 / 10 + "%";
         }
         return param1 + "%";
      }
      
      protected function ActivityUIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.FMC_Activitys = new Vector.<MovieClip>();
         this.FMC_ActivitysTask = new Vector.<MovieClip>();
         this.FTF_ActivityCostValue = new Vector.<TextField>();
         this.FTF_ActivityCostName = new Vector.<TextField>();
         _loc3_ = CONST_SMITHY.MAX_ACTIVITYNUM;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1["Activity_" + _loc2_];
            this.FMC_Activitys.push(_loc4_);
            _loc4_["TypePicText"].gotoAndStop(_loc2_ + 4);
            this.FMC_ActivitysTask.push(_loc4_["task"]);
            this.FTF_ActivityCostValue.push(_loc4_["CostValue"]);
            this.FTF_ActivityCostName.push(_loc4_["CostName"]);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ActivityOnMouseMove);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,this.ActivityOnMouseOut);
            _loc2_++;
         }
         this.FMC_Activitys[2].visible = false;
      }
      
      protected function ActivityLocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:THint = null;
         _loc2_ = int(this.FMC_ActivitysTask.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_ActivitysTask[_loc1_];
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnActivitysActiveTaskClick);
            _loc1_++;
         }
         this.FTF_ActivityCostName[0].text = CONST_SMITHY.REFINEDTYPE_NORMALCOSTNAME;
         this.FTF_ActivityCostValue[1].text = CONST_SMITHY.REFINEDTYPE_DIRECTIONCOSTVALUE;
         this.FTF_ActivityCostName[1].text = CONST_SMITHY.REFINEDTYPE_DIRECTIONCOSTNAME;
         this.FTF_ActivityCostValue[2].text = CONST_SMITHY.REFINEDTYPE_SKILLCOSTVALUE;
         this.FTF_ActivityCostName[2].text = CONST_SMITHY.REFINEDTYPE_SKILLCOSTNAME;
         this.FActivities_Hint = new Vector.<THint>();
         _loc1_ = 0;
         while(_loc1_ < CONST_SMITHY.MAX_ACTIVITYNUM)
         {
            _loc4_ = new THint();
            _loc4_.Caption = STRING_SMITHY.RefinedActivitysDescribtion[_loc1_];
            this.FActivities_Hint.push(_loc4_);
            _loc1_++;
         }
      }
      
      protected function ResetActivity() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FMC_ActivitysTask[0].gotoAndStop("ok");
         _loc2_ = int(this.FMC_Activitys.length);
         _loc1_ = 1;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_ActivitysTask[_loc1_];
            _loc3_.gotoAndStop("cancle");
            _loc1_++;
         }
         this.FTF_ActivityCostValue[0].text = "";
      }
      
      protected function UpdateNormalRefinedCost() : void
      {
         var _loc1_:int = 0;
         if(this.FReciveEquipment == null)
         {
            this.FTF_ActivityCostValue[0].text = "";
            return;
         }
         _loc1_ = this.FReciveEquipment.SellValue * CONST_SMITHY.NORMALREFINEDCOSTTIMES;
         this.FRefinedNeedSiliverCoin = _loc1_;
         this.FTF_ActivityCostValue[0].text = _loc1_.toString();
      }
      
      protected function GetSelectActiveActivityIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = int(this.FMC_ActivitysTask.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_ActivitysTask[_loc1_];
            if(_loc3_.currentFrameLabel == "ok")
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      protected function ActionToActivityTaskClick(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         _loc3_ = int(this.FMC_ActivitysTask.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FMC_ActivitysTask[_loc2_];
            _loc4_.gotoAndStop("cancle");
            _loc2_++;
         }
         _loc2_ = this.FMC_ActivitysTask.indexOf(param1);
         this.FMC_ActivitysTask[_loc2_].gotoAndStop("ok");
      }
      
      protected function BtnsUIDispatch(param1:MovieClip) : void
      {
         this.FBtn_SingleRefined = param1["SingleRefined"];
         this.FBtn_AnyTimeRefined = param1["AnyTimeRefined"];
         this.FFatherUI.addChild(this.FBtn_SingleRefined);
         this.FFatherUI.addChild(this.FBtn_AnyTimeRefined);
         param1.gotoAndStop(2);
         this.FBtn_Replace = param1["Replace"];
         this.FBtn_Ignore = param1["Ignore"];
         this.FFatherUI.addChild(this.FBtn_SingleRefined);
         this.FFatherUI.addChild(this.FBtn_AnyTimeRefined);
         this.FVipLowHint = new THint();
      }
      
      protected function BtnsLocation() : void
      {
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_SingleRefined,this.OnBtnSingleRefinedClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_AnyTimeRefined,this.OnBtnAnyTimeRefinedClick);
         this.FBtn_AnyTimeRefined.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMoveAnyTime);
         this.FBtn_AnyTimeRefined.addEventListener(MouseEvent.MOUSE_OUT,this.OnMouseOutAnyTime);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Replace,this.OnBtnExchangeClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Ignore,this.OnBtnIgnoreClick);
         this.FBtn_SingleRefined.buttonMode = true;
         this.FBtn_AnyTimeRefined.buttonMode = true;
         this.FBtn_Replace.buttonMode = true;
         this.FBtn_Ignore.buttonMode = true;
         this.FVipLowHint.Caption = STRING_SMITHY.BatchRefinedVipLow;
         this.FFatherUI.addChild(this.FBtn_Replace);
         this.FFatherUI.addChild(this.FBtn_Ignore);
      }
      
      protected function ShowRefinedBtns(param1:Boolean) : void
      {
         if(param1)
         {
            this.FBtn_Replace.visible = false;
            this.FBtn_Ignore.visible = false;
         }
         else
         {
            this.FBtn_Replace.visible = true;
            this.FBtn_Ignore.visible = true;
         }
      }
      
      protected function DisableBtns(param1:Boolean) : void
      {
         if(param1)
         {
            this.FBtn_SingleRefined.gotoAndStop("Disable");
            this.FBtn_AnyTimeRefined.gotoAndStop("Disable");
         }
         else
         {
            this.FBtn_SingleRefined.gotoAndStop("Enable");
            this.FBtn_AnyTimeRefined.gotoAndStop("Enable");
         }
      }
      
      protected function ResetBtns() : void
      {
         this.ShowRefinedBtns(true);
         this.DisableBtns(true);
      }
      
      protected function ConstructFlyText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<String> = null;
         this.FTextRegistry = new TRegistryInstance();
         _loc3_ = STRING_SMITHY.REFINED_FLYTEXTS;
         _loc2_ = int(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTextRegistry.Register(STRING_SMITHY.REFINED_TEXTIDS[_loc1_],STRING_SMITHY.REFINED_FLYTEXTS[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function FlyText(param1:int) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FTextRegistry.GetInstanceByIdentifier(param1) as String;
         EffectGenerateText(_loc2_);
      }
      
      protected function VerificationStrengthen() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.FRefinedNetwork == null)
         {
            return false;
         }
         if(this.FBtn_SingleRefined.currentFrameLabel == "Disable")
         {
            return false;
         }
         if(SLogicsCore.Character.CreditSilverCoin.ToNumber() < this.FRefinedNeedSiliverCoin)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR207);
            return false;
         }
         return true;
      }
      
      protected function VipCheck() : void
      {
         this.FBtn_AnyTimeRefined.enabled = SLogicsCore.Character.VipData.OneTimeWash;
      }
      
      protected function OnConfirmationOk(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TCharacter = SLogicsCore.Character;
         _loc2_ = this.GetSelectActiveActivityIndex();
         _loc3_ = CONST_SMITHY.REFINEDTYPEARRAY[_loc2_];
         if(int(CONST_SMITHY.REFINEDTYPE_DIRECTIONCOSTVALUE) > _loc4_.CreditGold + _loc4_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.visible = true;
            return;
         }
         if(this.FRefinedNetwork != null)
         {
            this.FRefinedNetwork(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1,_loc3_,1);
         }
         this.FCurrentState = STATE_ONETIMEREFINE;
      }
      
      protected function OnBtnSingleRefinedClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc4_ = this.VerificationStrengthen();
         if(!_loc4_)
         {
            return;
         }
         _loc2_ = this.GetSelectActiveActivityIndex();
         _loc3_ = CONST_SMITHY.REFINEDTYPEARRAY[_loc2_];
         if(_loc2_ == 1)
         {
            if(!this.FUIWindowConfirmation.IsSelected)
            {
               this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Smithy_Succinct).DescribeString,CONST_SMITHY.REFINEDTYPE_DIRECTIONCOSTVALUE);
               this.FUIWindowConfirmation.SetCheckBox(true);
               this.FUIWindowConfirmation.Visible = true;
            }
            else
            {
               this.OnConfirmationOk();
            }
         }
         else
         {
            if(this.FRefinedNetwork != null)
            {
               this.FRefinedNetwork(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1,_loc3_,1);
            }
            this.FCurrentState = STATE_ONETIMEREFINE;
         }
      }
      
      protected function GoodPlayBegin() : Boolean
      {
         this.NewColorCount.sort(Array.NUMERIC);
         this.OldColorCount.sort(Array.NUMERIC);
         if(this.OldColorCount[2] > this.NewColorCount[2])
         {
            return true;
         }
         if(this.OldColorCount[2] < this.NewColorCount[2])
         {
            return false;
         }
         if(this.OldColorCount[1] > this.NewColorCount[1])
         {
            return true;
         }
         if(this.OldColorCount[1] < this.NewColorCount[1])
         {
            return false;
         }
         if(this.OldColorCount[0] > this.NewColorCount[0])
         {
            return true;
         }
         if(this.OldColorCount[0] < this.NewColorCount[0])
         {
            return false;
         }
         return false;
      }
      
      protected function GoodPlayBeginCopy() : Boolean
      {
         this.NewColorCount.sort(Array.NUMERIC);
         this.OldColorCount.sort(Array.NUMERIC);
         if(this.NewColorCount[2] > this.OldColorCount[2])
         {
            return true;
         }
         if(this.NewColorCount[2] < this.OldColorCount[2])
         {
            return false;
         }
         if(this.NewColorCount[1] > this.OldColorCount[1])
         {
            return true;
         }
         if(this.NewColorCount[1] < this.OldColorCount[1])
         {
            return false;
         }
         if(this.NewColorCount[0] > this.NewColorCount[0])
         {
            return true;
         }
         if(this.NewColorCount[0] < this.OldColorCount[0])
         {
            return false;
         }
         return false;
      }
      
      protected function OnBtnExchangeClick(param1:MouseEvent) : void
      {
         if(this.GoodPlayBegin())
         {
            if(!this.FUIWindowConfirmationCopy.IsSelected)
            {
               this.FUIWindowConfirmationCopy.Text = new ConsumeFrame(CONST_SYSTEMLANGUAGE.HELPTIPS_777777_0).DescribeString;
               this.FUIWindowConfirmationCopy.SetCheckBox(true);
               this.FUIWindowConfirmationCopy.Visible = true;
            }
            else
            {
               this._c_s();
            }
         }
         else
         {
            this._c_s();
         }
      }
      
      protected function _c_s() : void
      {
         if(this.FRefinedExchange != null)
         {
            this.FRefinedExchange(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1,0);
         }
         this.FCurrentState = STATE_EXCHANGED;
      }
      
      protected function OnBtnIgnoreClick(param1:MouseEvent) : void
      {
         if(this.GoodPlayBeginCopy())
         {
            if(!this.FUIWindowConfirmationCopy2.IsSelected)
            {
               this.FUIWindowConfirmationCopy2.Text = new ConsumeFrame(CONST_SYSTEMLANGUAGE.HELPTIPS_777777_1).DescribeString;
               this.FUIWindowConfirmationCopy2.SetCheckBox(true);
               this.FUIWindowConfirmationCopy2.Visible = true;
            }
            else
            {
               this.WoQu();
            }
         }
         else
         {
            this.WoQu();
         }
      }
      
      protected function WoQu() : void
      {
         this.FCurrentSmithyAttributeUnstreamizerData = null;
         this.UpdateNewAttribute();
         this.ShowRefinedBtns(true);
      }
      
      protected function OnConfirmationOkCopy2(param1:Object = null) : void
      {
         this.WoQu();
      }
      
      protected function OnConfirmationOkCopy(param1:Object = null) : void
      {
         this._c_s();
      }
      
      protected function OnBtnAnyTimeRefinedClick(param1:MouseEvent) : void
      {
         if(this.FBtn_AnyTimeRefined.currentFrameLabel == "Disable")
         {
            return;
         }
         if(!SLogicsCore.Character.VipData.OneTimeWash)
         {
            return;
         }
         this.FWindowBatchRefined.ReciveEquipment = this.FReciveEquipment;
         this.FWindowBatchRefined.Update();
         this.FWindowBatchRefined.visible = true;
         this.FCurrentState = STATE_BATCHREFINED;
      }
      
      protected function OnMouseMoveAnyTime(param1:MouseEvent) : void
      {
         if(!SLogicsCore.Character.VipData.OneTimeWash)
         {
            if(this.FHintOnOver != null)
            {
               this.FHintOnOver(this,this.FVipLowHint);
            }
         }
      }
      
      protected function OnMouseOutAnyTime(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      protected function OnActivitysActiveTaskClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         this.ActionToActivityTaskClick(_loc2_);
      }
      
      protected function OnEquipSlotClick(param1:Object, param2:Object) : void
      {
         this.Reset();
         this.UIComponentsHintOnOut(param1,param2 as TInventory);
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOver != null)
         {
            this.FOnSlotMouseOver(param1,param2);
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnSlotMouseOut != null)
         {
            this.FOnSlotMouseOut(param1,param2);
         }
      }
      
      protected function OnBatchRefinedWindowClose() : void
      {
         this.UpdateEquipment();
      }
      
      protected function ActivityOnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = this.FMC_Activitys.indexOf(_loc2_);
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FActivities_Hint[_loc3_]);
         }
      }
      
      protected function ActivityOnMouseOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function set RefinedNetwork(param1:Function) : void
      {
         this.FRefinedNetwork = param1;
         this.FWindowBatchRefined.RefinedNetwork = param1;
      }
      
      public function set CurrentSmithyAttributeList(param1:TSmithyRefinedPakcetUnstreamizerData) : void
      {
         if(this.FCurrentState == STATE_BATCHREFINED)
         {
            this.FWindowBatchRefined.AttributeList = param1;
         }
         else
         {
            this.FCurrentSmithyAttributeUnstreamizerData = param1;
            if(this.FCurrentSmithyAttributeUnstreamizerData.ResultCode == 0)
            {
               this.UpdateNewAttribute();
            }
         }
      }
      
      public function set OnSlotMouseOver(param1:Function) : void
      {
         this.FOnSlotMouseOver = param1;
      }
      
      public function set OnSlotMouseOut(param1:Function) : void
      {
         this.FOnSlotMouseOut = param1;
      }
      
      public function set RefinedExchange(param1:Function) : void
      {
         this.FRefinedExchange = param1;
         this.FWindowBatchRefined.RefinedExchange = param1;
      }
      
      public function set StrengthenResult(param1:uint) : void
      {
         this.FStrengthenResult = param1;
         this.FWindowBatchRefined.StrengthenResult = param1;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         super.OnEffectText = param1;
         this.FWindowBatchRefined.OnEffectText = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function Update() : void
      {
         switch(this.FCurrentState)
         {
            case STATE_READY:
               this.VipCheck();
               break;
            case STATE_ONETIMEREFINE:
               if(this.FStrengthenResult == 0)
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR201);
               }
               else
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR208);
               }
               this.ShowRefinedBtns(false);
               this.FCurrentState = STATE_READY;
               break;
            case STATE_EXCHANGED:
               if(this.FStrengthenResult == 0)
               {
                  this.FCurrentSmithyAttributeUnstreamizerData = null;
                  this.UpdateNewAttribute();
                  this.UpdateEquipment();
                  this.FlyText(STRING_SMITHY.TEXTID_STR205);
                  if(this.FUpdateHeroPower != null && this.FHeroID != 0)
                  {
                     this.FUpdateHeroPower(this,this.FHeroID);
                  }
               }
               else
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR206);
               }
               this.ShowRefinedBtns(true);
               this.FCurrentState = STATE_READY;
               break;
            case STATE_BATCHREFINED:
               this.FWindowBatchRefined.Update();
         }
      }
      
      public function Reset() : void
      {
         this.ResetEquipment();
         this.ResetAttribute();
         this.ResetActivity();
         this.ResetBtns();
         if(this.FBackReset != null)
         {
            this.FBackReset();
         }
      }
      
      public function set BackReset(param1:Function) : void
      {
         this.FBackReset = param1;
      }
      
      public function ReciveEquipment(param1:TEquipment, param2:uint) : void
      {
         this.FReciveEquipment = param1;
         this.FHeroID = param2;
         if(this.FReciveEquipment != null)
         {
            this.ShowRefinedBtns(true);
            if(this.FReciveEquipment.AppendAttributes.Count == 0)
            {
               this.DisableBtns(true);
               super.EffectGenerateText(STRING_SMITHY.String_CantRefined);
               this.FReciveEquipment = null;
            }
            else
            {
               this.FEquipmentSlot.Context = param1;
               this.FCurrentSmithyAttributeUnstreamizerData = null;
               this.UpdateOldAttribute();
               this.UpdateNormalRefinedCost();
               this.DisableBtns(false);
            }
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FEquipmentSlot != null && param1)
         {
            this.OnEquipSlotClick(this,this.FEquipmentSlot.Context);
         }
         super.Visible = param1;
      }
   }
}

