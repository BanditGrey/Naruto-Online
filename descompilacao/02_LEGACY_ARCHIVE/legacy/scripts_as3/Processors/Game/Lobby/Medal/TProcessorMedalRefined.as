package Processors.Game.Lobby.Medal
{
   import Components.ScrollBar.TScrollBar;
   import Components.Slots.*;
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.*;
   import Logics.Medal.TMedalRefinedPakcetUnstreamizerData;
   import Logics.Smithy.*;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.Talisman.TSingleEquip;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TProcessorMedalRefined extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_ONETIMEREFINE:int = 1;
      
      protected static const STATE_EXCHANGED:int = 3;
      
      protected static const UIWIDTH:int = 480;
      
      protected static const UIHEIGHT:int = 535;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FInitialization:Boolean;
      
      protected var FCurrentState:int;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_List:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FMC_SingleEquipList:Vector.<TSingleEquip>;
      
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
      
      protected var FRefinedMaterial:int;
      
      protected var FRefinedMaterialVec:Vector.<uint>;
      
      protected var FRefinedSlotIndex:int = 1;
      
      protected var FMCRefinedAttibuteList:Array;
      
      protected var FFatherUI:MovieClip;
      
      protected var FBtn_SingleRefined:MovieClip;
      
      protected var FBtn_Replace:MovieClip;
      
      protected var FBtn_Ignore:MovieClip;
      
      protected var FBtn_GotoBack:MovieClip;
      
      protected var FTextRegistry:TRegistryInstance;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationCopy:TUIWindowConfirmation;
      
      protected var FUIWindowConfirmationCopy2:TUIWindowConfirmation;
      
      protected var FIdentifier0:uint;
      
      protected var FIdentifier1:uint;
      
      protected var OldColorCount:Array;
      
      protected var NewColorCount:Array;
      
      protected var FReciveEquipment:TEquipment;
      
      protected var FHeroID:uint;
      
      protected var FRoleIndex:uint;
      
      protected var FItemIndex:uint;
      
      protected var FCurrentRefinedAttributeUnstreamizerData:TMedalRefinedPakcetUnstreamizerData;
      
      protected var FRefinedOnClick:Function;
      
      protected var FRefinedExchange:Function;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var WoQu:Boolean;
      
      protected var FBackReset:Function;
      
      public function TProcessorMedalRefined(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
         this.ConstructFlyText();
         this.FMC_SingleEquipList = new Vector.<TSingleEquip>();
         this.FUIWindowRecharge = new TUIWindowRecharge(parent.parent as TUIComponent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         this.NewColorCount = new Array();
         this.OldColorCount = new Array();
         this.FMCRefinedAttibuteList = new Array();
         this.FCharacter = SLogicsCore.Character;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_MEDAL.RESOURCES_ID_Swf);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         var _loc3_:MovieClip = null;
         var _loc4_:TConfigValue = null;
         super.ResourcesPerform_UIDispatch();
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_MEDAL.RESOURCE_ClassName_MC_Medal_Refined) as MovieClip;
         this.FFatherUI = _loc3_["UIRefined"];
         addChild(_loc3_);
         this.x = CONST_MEDAL.POSX_MC_SCENE;
         this.y = CONST_MEDAL.POSY_MC_SCENE;
         this.FMC_List = _loc3_[CONST_MEDAL.RESOURCE_Link_Mc_List];
         this.FScrollBar = new TScrollBar(this.FMC_List,348,false,0);
         _loc1_ = 0;
         while(_loc1_ < this.FUIDispatchRoutines.length)
         {
            _loc2_ = this.FUIDispatchRoutines[_loc1_];
            _loc2_(this.FFatherUI);
            _loc1_++;
         }
         this.FUIWindowConfirmation = new TUIWindowConfirmation(parent.parent as TUIComponent);
         this.FUIWindowConfirmation.OnOK = null;
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
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Rune_RefinedMaterial) as TConfigValue;
         this.FRefinedMaterial = _loc4_.Value as uint;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Rune_RefinedMaterialCount) as TConfigValue;
         this.FRefinedMaterialVec = _loc4_.Value as Vector.<uint>;
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
         this.Reset();
         this.FInitialization = true;
         this.FCurrentState = STATE_READY;
         super.ResourcesPerform_UILocations();
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.EquipmentUIDispatch);
         this.FUIDispatchRoutines.push(this.AttributeUIDispatch);
         this.FUIDispatchRoutines.push(this.ActivityUIDispatch);
         this.FUIDispatchRoutines.push(this.BtnsUIDispatch);
      }
      
      protected function ConstructLocationRoutines() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.EquipmentLocation);
         this.FUILocationRoutines.push(this.AttributeLocation);
         this.FUILocationRoutines.push(this.BtnsLocation);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         super.LogicsPerform();
         if(this.FInitialization)
         {
            this.FEquipmentSlot.Update();
            _loc2_ = this.FMC_SingleEquipList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               this.FMC_SingleEquipList[_loc1_].UpdateSingleEquip();
               _loc1_++;
            }
         }
      }
      
      protected function UpdateEquip() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:* = 0;
         var _loc3_:TSingleEquip = null;
         var _loc4_:TInventory = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         this.FScrollBar.Clear();
         _loc10_ = 0;
         _loc8_ = uint(this.FCharacter.Heros.Count);
         _loc9_ = _loc8_ - 1;
         _loc1_ = this.FMC_SingleEquipList.length;
         _loc2_ = int(_loc1_ - 1);
         while(_loc2_ > -1)
         {
            _loc3_ = this.FMC_SingleEquipList[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_--;
         }
         this.FMC_SingleEquipList.length = 0;
         if(this.FRoleIndex > _loc9_)
         {
            _loc1_ = uint(this.FCharacter.Medals.Count);
         }
         else
         {
            _loc1_ = CONST_MEDAL.CAPACITY_MedalNum;
         }
         this.WoQu = false;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(this.FRoleIndex > _loc9_)
            {
               _loc4_ = this.FCharacter.Medals.GetInventoryByIndex(_loc2_);
            }
            else
            {
               _loc4_ = this.FCharacter.Heros.GetHeroByIndex(this.FRoleIndex).MedalsMounted.GetInventoryByIndex(_loc2_);
            }
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.Name;
               _loc6_ = _loc4_.UpgradingLevel;
               _loc7_ = _loc4_.Quality;
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               _loc3_.StubReferences.Reference(this);
               _loc3_.OnClick = this.SingleEquipOnClick;
               _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
               _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
               _loc3_.OnOut = this.SlotsOnOut;
               _loc3_.OnOver = this.SlotsOnMove;
               this.FMC_SingleEquipList.push(_loc3_);
               _loc3_.SetEquip(_loc4_,_loc5_,STRING_COMMON.FORMAT_Level + _loc6_,_loc7_);
               this.FScrollBar.AddItem(_loc3_);
               _loc10_++;
               if(_loc4_.Identifier0 == this.FIdentifier0 && _loc4_.Identifier1 == this.FIdentifier1)
               {
                  this.WoQu = true;
                  _loc3_.OnSelect();
               }
            }
            _loc2_++;
         }
         if(_loc1_ < CONST_MEDAL.CAPACITY_EQUIP || _loc1_ == 0)
         {
            _loc1_ = CONST_MEDAL.CAPACITY_EQUIP;
            _loc2_ = 0;
            while(_loc2_ < _loc1_ - _loc10_)
            {
               _loc3_ = SLogicsCore.PoolUISingleEquipment.AcquireUISingleEquipment(this);
               this.FScrollBar.AddItem(_loc3_);
               _loc2_++;
            }
         }
      }
      
      protected function EquipmentUIDispatch(param1:MovieClip) : void
      {
         this.FEquipmentSlot = new TUISlot(this);
         this.FEquipmentSlot.Resource = param1["Wash_Slot"];
      }
      
      protected function EquipmentLocation() : void
      {
         TJadeCommon.InitSlot(this.FEquipmentSlot,CONST_MODULES.MODULE_Medal);
         this.FEquipmentSlot.OnClick = this.OnEquipSlotClick;
         this.FEquipmentSlot.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
         this.FEquipmentSlot.OnOverlay = this.SlotsOnMove;
         this.FEquipmentSlot.OnOut = this.SlotsOnOut;
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
         if(this.FEquipmentSlot)
         {
            this.FEquipmentSlot.Context = null;
         }
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
            _loc8_ = _loc6_.MedalsMounted.GetInventoryByIdentifier(param1,param2) as TEquipment;
            if(_loc8_ != null)
            {
               return _loc8_;
            }
            _loc3_++;
         }
         _loc5_ = SLogicsCore.Character.Medals;
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
            _loc4_ = param1["UIPrevRefined"]["refineAttr_" + _loc2_];
            this.FMCRefinedAttibuteList.push(_loc4_);
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
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FMC_OldAttributesList[_loc1_];
            _loc5_.visible = false;
            _loc1_++;
         }
         this.OldColorCount.length = 0;
         _loc3_ = this.FReciveEquipment.AppendAttributes.GetAttributeByIndex(this.FRefinedSlotIndex - 1);
         if(_loc3_)
         {
            this.SetTextByAttribute(this.FRefinedSlotIndex,_loc3_);
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
            _loc7_.visible = false;
            _loc1_++;
         }
         this.NewColorCount.length = 0;
         _loc3_ = this.FReciveEquipment.AppendAttributes.GetAttributeByIndex(this.FRefinedSlotIndex - 1);
         if(_loc3_)
         {
            this.SetTextByAttribute(this.FRefinedSlotIndex,_loc3_);
         }
      }
      
      protected function SetRefinedAttributeList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TEquipmentAppendAttribute = null;
         _loc1_ = 0;
         while(_loc1_ < this.FReciveEquipment.AppendAttributes.Count)
         {
            _loc3_ = this.FReciveEquipment.AppendAttributes.GetAttributeByIndex(_loc1_);
            if(_loc3_)
            {
               _loc2_ = this.FMCRefinedAttibuteList[_loc1_];
               _loc2_.AttributeName.text = _loc3_.Name ? _loc3_.Name : "";
               _loc2_.AttributeValue.text = _loc3_.OldValue ? (_loc3_.Percentage == 1 ? _loc3_.OldValue.toFixed(2) + "%" : _loc3_.OldValue.toFixed(2)) : "";
            }
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
            _loc3_ = this.FMCRefinedAttibuteList[_loc1_];
            _loc3_["AttributeName"].text = "";
            _loc3_["AttributeValue"].text = "";
            _loc1_++;
         }
      }
      
      protected function SetTextByAttribute(param1:int, param2:TEquipmentAppendAttribute) : void
      {
         var _loc3_:TextField = null;
         var _loc4_:TextField = null;
         var _loc5_:MovieClip = null;
         _loc5_ = this.FMC_OldAttributesList[0];
         if(Boolean(param2.OldValue) && Boolean(param2.Name))
         {
            _loc5_["AttributeName"].text = param2.Name;
            _loc5_["AttributeValue"].text = param2.Percentage == 1 ? param2.OldValue.toFixed(2) + "%" : param2.OldValue.toFixed(2);
            _loc5_.visible = true;
         }
         _loc5_ = this.FMC_NewightAttributesList[0];
         if(Boolean(param2.NewCategory) && Boolean(param2.NewValue))
         {
            _loc5_["AttributeName"].text = param2.NewCategory;
            _loc5_["AttributeValue"].text = param2.Percentage == 1 ? param2.NewValue.toFixed(2) + "%" : param2.NewValue.toFixed(2);
            _loc5_.visible = true;
         }
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
         _loc4_ = param1["Activity_0"];
         this.FMC_Activitys.push(_loc4_);
         _loc4_["TypePicText"].gotoAndStop(4);
         this.FMC_ActivitysTask.push(_loc4_["task"]);
         this.FTF_ActivityCostValue.push(_loc4_["CostValue"]);
         this.FTF_ActivityCostName.push(_loc4_["CostName"]);
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
         this.FTF_ActivityCostName[0].text = "";
      }
      
      protected function UpdateNormalRefinedCost() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         if(this.FReciveEquipment == null)
         {
            this.FTF_ActivityCostValue[0].text = "";
            return;
         }
         var _loc3_:TArticle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FRefinedMaterial) as TArticle;
         _loc2_ = _loc3_.Name;
         _loc1_ = int(this.FRefinedMaterialVec[this.FRefinedSlotIndex - 1]);
         this.FTF_ActivityCostValue[0].text = _loc1_.toString();
         this.FTF_ActivityCostName[0].text = _loc2_;
      }
      
      protected function BtnsUIDispatch(param1:MovieClip) : void
      {
         this.FBtn_SingleRefined = param1["SingleRefined"];
         this.FBtn_Replace = param1["Replace"];
         this.FBtn_Ignore = param1["Ignore"];
         this.FBtn_GotoBack = param1["Gotoback"];
      }
      
      protected function BtnsLocation() : void
      {
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_SingleRefined,this.OnBtnSingleRefinedClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Replace,this.OnBtnExchangeClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Ignore,this.OnBtnIgnoreClick);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_GotoBack,this.OnBtnGotoBackClick);
         var _loc1_:int = 1;
         while(_loc1_ <= 4)
         {
            TUtilityStandardBTN.SetBtnEventListener(this.FFatherUI["UIPrevRefined"]["FBtn_refined_" + _loc1_],this.OnGotoRefinedClick);
            _loc1_++;
         }
         this.FBtn_SingleRefined.buttonMode = true;
         this.FBtn_Replace.buttonMode = true;
         this.FBtn_Ignore.buttonMode = true;
         this.FBtn_GotoBack.buttonMode = true;
      }
      
      protected function ShowRefinedBtns(param1:Boolean) : void
      {
         if(param1)
         {
            this.FBtn_SingleRefined.visible = true;
            this.FBtn_Replace.visible = false;
            this.FBtn_Ignore.visible = false;
            this.FBtn_GotoBack.visible = true;
         }
         else
         {
            this.FBtn_SingleRefined.visible = false;
            this.FBtn_Replace.visible = true;
            this.FBtn_Ignore.visible = true;
            this.FBtn_GotoBack.visible = false;
         }
      }
      
      protected function DisableBtns(param1:Boolean) : void
      {
         if(param1)
         {
            this.FBtn_SingleRefined.gotoAndStop("Disable");
         }
         else
         {
            this.FBtn_SingleRefined.gotoAndStop("Enable");
         }
      }
      
      protected function UpdateRefineBtns() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         if(Boolean(this.FReciveEquipment) && this.FReciveEquipment.HoleCount > 0)
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               _loc1_ = this.FFatherUI["UIPrevRefined"]["FBtn_refined_" + _loc2_];
               if(_loc2_ <= this.FReciveEquipment.HoleCount)
               {
                  TGameUtil.LockOrUnlockButton(_loc1_,true);
               }
               else
               {
                  TGameUtil.LockOrUnlockButton(_loc1_,false);
               }
               _loc2_++;
            }
         }
      }
      
      protected function EnableBtn_refined(param1:Boolean) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 1;
         while(_loc3_ <= 4)
         {
            _loc2_ = this.FFatherUI["UIPrevRefined"]["FBtn_refined_" + _loc3_];
            TGameUtil.LockOrUnlockButton(_loc2_,param1);
            _loc3_++;
         }
      }
      
      protected function ResetBtns() : void
      {
         this.ShowRefinedBtns(true);
         this.DisableBtns(true);
         this.EnableBtn_refined(false);
      }
      
      protected function ResetRefinedUI(param1:Boolean) : void
      {
         var _loc2_:TEquipmentAppendAttribute = null;
         this.FFatherUI["UIPrevRefined"].visible = !param1;
         if(!param1)
         {
            return;
         }
         if(Boolean(this.FReciveEquipment) && this.FReciveEquipment.AppendAttributes.Count >= this.FRefinedSlotIndex)
         {
            _loc2_ = this.FReciveEquipment.AppendAttributes.GetAttributeByIndex(this.FRefinedSlotIndex - 1);
            if(Boolean(_loc2_) && Boolean(_loc2_.NewCategory) && Boolean(_loc2_.NewValue))
            {
               this.ShowRefinedBtns(false);
            }
            else
            {
               this.ShowRefinedBtns(true);
            }
         }
         else
         {
            this.ShowRefinedBtns(true);
         }
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
         if(this.FRefinedOnClick == null)
         {
            return false;
         }
         if(this.FBtn_SingleRefined.currentFrameLabel == "Disable")
         {
            return false;
         }
         return true;
      }
      
      protected function SingleEquipOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TSingleEquip = null;
         var _loc6_:TInventory = null;
         _loc5_ = param1 as TSingleEquip;
         _loc4_ = int(this.FMC_SingleEquipList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FMC_SingleEquipList[_loc3_].BClick = false;
            _loc3_++;
         }
         _loc5_.BSelect = true;
         _loc6_ = param2 as TInventory;
         this.FEquipmentSlot.Context = _loc6_;
         this.Reset();
         this.ResetRefinedUI(false);
         this.ReciveEquipment(_loc6_ as TEquipment,0);
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(this,param2,null);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(this,param2,null);
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Medal);
         }
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TEquipment = null;
         if(param2 is TEquipment)
         {
            _loc4_ = param2 as TEquipment;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      protected function OnBtnSingleRefinedClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         _loc2_ = this.VerificationStrengthen();
         if(!_loc2_)
         {
            return;
         }
         if(this.FRefinedOnClick != null)
         {
            this.FRefinedOnClick(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1,1,this.FRefinedSlotIndex);
         }
         this.FCurrentState = STATE_ONETIMEREFINE;
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
         if(this.FRefinedOnClick != null)
         {
            this.FRefinedOnClick(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1,2,this.FRefinedSlotIndex);
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
               this.WoQu1();
            }
         }
         else
         {
            this.WoQu1();
         }
      }
      
      protected function WoQu1() : void
      {
         this.FCurrentRefinedAttributeUnstreamizerData = null;
         this.UpdateNewAttribute();
         this.ShowRefinedBtns(true);
      }
      
      protected function OnConfirmationOkCopy2(param1:Object = null) : void
      {
         this.WoQu1();
      }
      
      protected function OnConfirmationOkCopy(param1:Object = null) : void
      {
         this._c_s();
      }
      
      protected function OnEquipSlotClick(param1:Object, param2:Object) : void
      {
         this.Reset();
         this.SlotsOnOut(param1,param2 as TInventory);
      }
      
      protected function OnGotoRefinedClick(param1:MouseEvent) : void
      {
         this.FRefinedSlotIndex = param1.currentTarget.name.substr(-1,1);
         this.ResetRefinedUI(true);
         this.UpdateAttribute();
         this.UpdateNormalRefinedCost();
      }
      
      protected function OnBtnGotoBackClick(param1:MouseEvent) : void
      {
         this.ResetRefinedUI(false);
      }
      
      public function set RefinedOnClick(param1:Function) : void
      {
         this.FRefinedOnClick = param1;
      }
      
      public function set CurrentRefinedAttributeData(param1:TMedalRefinedPakcetUnstreamizerData) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TEquipmentAppendAttribute = null;
         this.FCurrentRefinedAttributeUnstreamizerData = param1;
         this.StrengthenResult = this.FCurrentRefinedAttributeUnstreamizerData.ResultCode;
         if(this.FStrengthenResult != 0)
         {
            return;
         }
         _loc2_ = this.FCurrentRefinedAttributeUnstreamizerData.RefinedIndex;
         this.FCurrentRefinedAttributeUnstreamizerData.UpdataRefinedAttributeDataByIndex(this.FReciveEquipment,_loc2_);
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function set RefinedExchange(param1:Function) : void
      {
         this.FRefinedExchange = param1;
      }
      
      public function set StrengthenResult(param1:uint) : void
      {
         this.FStrengthenResult = param1;
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         super.OnEffectText = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function Update(param1:uint, param2:uint = 0) : void
      {
         this.FRoleIndex = param1;
         this.FItemIndex = param2;
         this.Reset();
         this.UpdateEquip();
      }
      
      public function Update1() : void
      {
         switch(this.FCurrentState)
         {
            case STATE_READY:
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
               this.UpdateNewAttribute();
               this.UpdateEquipment();
               this.FCurrentState = STATE_READY;
               break;
            case STATE_EXCHANGED:
               if(this.FStrengthenResult == 0)
               {
                  this.FCurrentRefinedAttributeUnstreamizerData = null;
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
         this.UpdateRefineBtns();
         if(this.FReciveEquipment != null)
         {
            this.FEquipmentSlot.Context = param1;
            this.DisableBtns(false);
            this.FCurrentRefinedAttributeUnstreamizerData = null;
            this.SetRefinedAttributeList();
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FEquipmentSlot != null)
         {
            this.OnEquipSlotClick(this,this.FEquipmentSlot.Context);
         }
         super.Visible = param1;
      }
   }
}

