package Processors.Game.Lobby.Smithy
{
   import Components.Slots.*;
   import Foundation.Common.THint;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.TimeCoolDown.TTimeCoolDown;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class SmithyWindowStrengthen extends TProcessorLobbyWindow
   {
      
      public static const MillisecondsPerSecond:int = 1000;
      
      public static const MillisecondsPerMinute:int = 1000 * 60;
      
      public static const MillisecondsPerHour:int = 1000 * 60 * 60;
      
      public static const TimeClearOneTime:int = 2 * 60 * 1000;
      
      public static const STATE_READY:int = 0;
      
      public static const STATE_STRENGTHEN:int = 1;
      
      public static const STATE_WAITFORCLEAR:int = 2;
      
      public static const COST_CREDIT:uint = 10;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FCurrentState:int;
      
      protected var FInitialization:Boolean;
      
      protected var FEquipSlot:TUISlot;
      
      protected var FTF_StrengthenResult:TextField;
      
      protected var FTF_MainAttribute:TextField;
      
      protected var FStrengthenConsume:int;
      
      protected var FTF_StrengthenCost:TextField;
      
      protected var FTF_Discount:TextField;
      
      protected var FMC_Discount:MovieClip;
      
      protected var FMC_DoubleEffect:MovieClip;
      
      protected var FMC_SingleEffect:MovieClip;
      
      protected var FActivitysActiveTask:Vector.<MovieClip>;
      
      protected var FSmallIcons:Vector.<MovieClip>;
      
      protected var FTypePicTexts:Vector.<MovieClip>;
      
      protected var FTF_TypeText:TextField;
      
      protected var FTF_ActivitysCost:Vector.<TextField>;
      
      protected var FFunctions:Vector.<Function>;
      
      protected var FParameter:Vector.<int>;
      
      protected var FActivityName:MovieClip;
      
      protected var FTF_ActivityTime:TextField;
      
      protected var FTF_StrengthenColdTime:TextField;
      
      protected var FTextFormat:TextFormat;
      
      protected var FHint_Activitys:Vector.<THint>;
      
      protected var FMC_Activitys:Vector.<MovieClip>;
      
      protected var FTextRegistry:TRegistryInstance;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FBtn_Strengthen:MovieClip;
      
      protected var FBtn_ClearTime:SimpleButton;
      
      protected var FStrengthenLevelAfterStrength:int;
      
      protected var FStrengthenLevelBeforeStrength:int;
      
      protected var FCostGold:int;
      
      protected var FEnchantValueBins:TBins;
      
      protected var FSmithyEnchantCoefficient:Number;
      
      protected var FKaguyState:Boolean;
      
      protected var FMC_Kaguy_Icon:MovieClip = null;
      
      protected var FTF_Kaguy_Dec:TextField = null;
      
      protected var FReciveEquipment:TEquipment;
      
      protected var FHeroID:uint;
      
      protected var FStrengthenNetwork:Function;
      
      protected var FStrengthenColdTimeRequest:Function;
      
      protected var FTimeCoolDown:TTimeCoolDown;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      protected var FICMove:Function;
      
      protected var FICOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnClearTime:Function;
      
      protected var FUpdateHeroPower:Function;
      
      protected var FBackReset:Function;
      
      public function SmithyWindowStrengthen(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
         this.ConstructFlyText();
         this.FTimeCoolDown = new TTimeCoolDown(CONST_COMMON.TIME_COOLDOWN_Strengthen);
         SLogicsCore.Character.TimeCoolDowns.Add(this.FTimeCoolDown);
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.StrengthenUIDispath);
         this.FUIDispatchRoutines.push(this.ActivityUIDispath);
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         this.addChild(param1);
         _loc2_ = 0;
         while(_loc2_ < this.FUIDispatchRoutines.length)
         {
            _loc3_ = this.FUIDispatchRoutines[_loc2_];
            _loc3_(param1);
            _loc2_++;
         }
      }
      
      protected function ConstructLocationRoutines() : void
      {
         this.FUILocationRoutines = new Vector.<Function>();
         this.FUILocationRoutines.push(this.StrengthenLocation);
         this.FUILocationRoutines.push(this.ActivityLocation);
      }
      
      public function Perform_UILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         var _loc3_:TConfigValue = null;
         _loc1_ = 0;
         while(_loc1_ < this.FUILocationRoutines.length)
         {
            _loc2_ = this.FUILocationRoutines[_loc1_];
            _loc2_();
            _loc1_++;
         }
         this.FEnchantValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_EnchantValue);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Smithy_Enchant_Coefficient) as TConfigValue;
         this.FSmithyEnchantCoefficient = _loc3_.Value as Number;
         this.Reset();
         this.FInitialization = true;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialization)
         {
            this.FEquipSlot.Update();
            this.UpdateCDTime();
         }
      }
      
      protected function StrengthenUIDispath(param1:MovieClip) : void
      {
         var _loc2_:MovieClip = null;
         this.FEquipSlot = new TUISlot(this);
         _loc2_ = param1["Strengthen_Slot"];
         this.FEquipSlot.Resource = _loc2_;
         this.FTF_StrengthenResult = param1["Item_0"]["NewValue"];
         this.FTF_MainAttribute = param1["Item_1"]["OldValue"];
         this.FTF_StrengthenCost = param1["Item_2"]["StrengthenMoney"];
         this.FTF_Discount = param1["Item_3"]["NewMoney"];
         this.FMC_Discount = param1["Item_3"];
         this.FBtn_Strengthen = param1["Strengthen_OK"];
         this.FBtn_ClearTime = param1["Btn_Cleartime"];
         this.FMC_DoubleEffect = param1["MC_DoubleEffect"];
         this.FMC_SingleEffect = param1["MC_SingleEffect"];
         this.FMC_Kaguy_Icon = param1["MC_Kaguy_Icon"];
         this.FTF_Kaguy_Dec = param1["TF_Kaguy_Dec"];
         this.FMC_Kaguy_Icon.gotoAndStop(3);
         this.FUIWindowConfirmation = new TUIWindowConfirmation(parent.parent as TUIComponent);
         this.FUIWindowRecharge = new TUIWindowRecharge(parent.parent as TUIComponent);
      }
      
      protected function StrengthenLocation() : void
      {
         TJadeCommon.InitSlot(this.FEquipSlot,CONST_MODULES.MODULE_Smithy);
         this.FEquipSlot.OnClick = this.OnEquipSlotClick;
         this.FEquipSlot.Init();
         this.FEquipSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FEquipSlot.OnOut = this.UIComponentsHintOnOut;
         this.FMC_Kaguy_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.IconMove);
         this.FMC_Kaguy_Icon.addEventListener(MouseEvent.MOUSE_OUT,this.IconOut);
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Strengthen,this.OnStrengthenBtnClick);
         this.FBtn_ClearTime.addEventListener(MouseEvent.CLICK,this.HandleClearTime);
         this.FBtn_Strengthen.buttonMode = true;
         this.FMC_Discount.visible = false;
         this.FUIWindowConfirmation.OnOK = this.OnConfirmationOk;
         this.FUIWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         this.FUIWindowConfirmation.SetCheckBox(true);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         this.FBtn_Strengthen.gotoAndStop("Disable");
         this.FMC_DoubleEffect.gotoAndStop("End");
         this.FMC_SingleEffect.gotoAndStop("End");
      }
      
      protected function UpdateStrengthenBaseInfor() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this.FReciveEquipment == null)
         {
            this.ResetStrengthenBaseInfor();
            return;
         }
         _loc2_ = this.GetStrengthenAttributeName();
         _loc3_ = this.GetStrengthenValue(this.FReciveEquipment.UpgradingLevel + 1);
         _loc4_ = this.GetMainTypeValue();
         _loc5_ = this.GetStrengthenConsume(this.FReciveEquipment.UpgradingLevel);
         this.FStrengthenConsume = _loc5_;
         _loc1_ = _loc2_;
         _loc1_ += "+";
         _loc1_ += _loc3_ + _loc4_;
         this.FTF_StrengthenResult.text = _loc1_;
         _loc1_ = _loc2_;
         _loc1_ += "+";
         _loc1_ += _loc4_ + this.FReciveEquipment.UpgradingBasisProperty;
         this.FTF_MainAttribute.text = _loc1_;
         _loc1_ = _loc5_.toString();
         _loc1_ += " ";
         _loc1_ += STRING_COMMON.ITEMNAME_Coin;
         this.FTF_StrengthenCost.text = _loc1_;
         _loc1_ = int(_loc5_ * 0.8).toString();
         _loc1_ += " ";
         _loc1_ += STRING_COMMON.ITEMNAME_Coin;
         this.FTF_Discount.text = _loc1_;
         this.OpenUpdate();
      }
      
      public function OpenUpdate() : void
      {
         if(SLogicsCore.KaguyaData.OpenState == 0 || SLogicsCore.KaguyaData.IsLongTime == 7 || SLogicsCore.KaguyaData.CurLevel < 2)
         {
            this.FMC_Kaguy_Icon.filters = [TGameUtil.rBlackFilters];
            this.FKaguyState = false;
         }
         else
         {
            this.FMC_Kaguy_Icon.filters = [];
            this.FKaguyState = true;
         }
      }
      
      protected function UpdateEquipment() : void
      {
         var _loc1_:TEquipment = null;
         var _loc2_:TEnchantValue = null;
         _loc1_ = this.GetEquipmentByID(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1);
         _loc2_ = this.GetEnchantValue(_loc1_);
         if(_loc2_ != null)
         {
            _loc1_.EnchantValue = int(_loc2_.LevelCoefficient * _loc1_.EnchantCoefficient * _loc2_.TypeCoefficient * (_loc1_.UpgradingLevel + this.FSmithyEnchantCoefficient));
         }
         this.ReciveEquipment(_loc1_,this.FHeroID);
      }
      
      protected function GetEnchantValue(param1:TEquipment) : TEnchantValue
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TEnchantValue = null;
         _loc3_ = uint(this.FEnchantValueBins.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FEnchantValueBins.GetDatebaseByIndex(_loc2_) as TEnchantValue;
            if(_loc4_.Type == param1.CategorySecond && param1.RequirementLevel >= _loc4_.MinEquipLevel && param1.RequirementLevel <= _loc4_.MaxEquipLevel && param1.EnchantLevel == _loc4_.Level)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function ResetStrengthenBaseInfor() : void
      {
         this.FEquipSlot.Context = null;
         this.FTF_StrengthenResult.text = "";
         this.FTF_MainAttribute.text = "";
         this.FTF_StrengthenCost.text = "";
         this.FTF_Discount.text = "";
         this.FBtn_Strengthen.gotoAndStop("Disable");
      }
      
      protected function GetMainTypeValue() : int
      {
         var _loc1_:TBaseEquip = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,this.FReciveEquipment.IDTemplate) as TBaseEquip;
         return _loc1_.MainValue;
      }
      
      protected function GetStrengthenValue(param1:int) : int
      {
         var _loc2_:TArticle = null;
         var _loc3_:int = 0;
         var _loc4_:TBuildValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FReciveEquipment.IDTemplate) as TArticle;
         _loc3_ = _loc2_.MinorType * 10000 + _loc2_.Quality * 1000 + param1;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BuildValue,_loc3_) as TBuildValue;
         return _loc4_.Value;
      }
      
      protected function GetStrengthenConsume(param1:int) : int
      {
         var _loc2_:TArticle = null;
         var _loc3_:int = 0;
         var _loc4_:TBuildConsume = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FReciveEquipment.IDTemplate) as TArticle;
         _loc3_ = _loc2_.Quality * 1000 + param1;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BuildConsume,_loc3_) as TBuildConsume;
         return _loc4_.Consume;
      }
      
      protected function GetStrengthenAttributeName() : String
      {
         var _loc1_:TBaseEquip = null;
         var _loc2_:int = 0;
         var _loc3_:TStarPointDesc = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,this.FReciveEquipment.IDTemplate) as TBaseEquip;
         _loc2_ = 17500000 + _loc1_.MainType;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,_loc2_) as TStarPointDesc;
         return _loc3_.Desc;
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
      
      protected function PlaySingleEffect() : void
      {
         this.FMC_SingleEffect.gotoAndPlay(1);
      }
      
      protected function PlayDoubleEffect() : void
      {
         this.FMC_DoubleEffect.gotoAndPlay(1);
      }
      
      protected function ActivityUIDispath(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FActivitysActiveTask = new Vector.<MovieClip>();
         this.FTF_ActivitysCost = new Vector.<TextField>();
         this.FMC_Activitys = new Vector.<MovieClip>();
         this.FSmallIcons = new Vector.<MovieClip>();
         this.FTypePicTexts = new Vector.<MovieClip>();
         _loc2_ = 0;
         while(_loc2_ < CONST_SMITHY.ACTIVITYNUM)
         {
            _loc3_ = param1["StrengthenItem_" + _loc2_];
            this.FMC_Activitys.push(_loc3_);
            if(_loc2_ == 2)
            {
               _loc3_.visible = false;
            }
            this.FActivitysActiveTask.push(_loc3_["task"]);
            this.FTF_ActivitysCost.push(_loc3_["TFCost"]);
            this.FSmallIcons.push(_loc3_["SmallIcon"]);
            _loc3_["SmallIcon"].gotoAndStop(_loc2_ + 1);
            this.FSmallIcons.push(_loc3_["TypePicText"]);
            _loc3_["TypePicText"].gotoAndStop(_loc2_ + 1);
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.ActivityOnMouseMove);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.ActivityOnMouseOut);
            _loc2_++;
         }
         this.FTF_TypeText = param1["TF_TypeText"];
         this.FTF_ActivityTime = param1["ShippingTime"];
         this.FTF_StrengthenColdTime = param1["ColdDown"];
      }
      
      protected function ActivityLocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:THint = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_SMITHY.ACTIVITYNUM)
         {
            _loc2_ = this.FActivitysActiveTask[_loc1_];
            _loc2_.addEventListener(MouseEvent.CLICK,this.OnActivitysActiveTaskClick);
            _loc1_++;
         }
         this.FParameter = new Vector.<int>();
         this.FTextFormat = new TextFormat();
         this.FHint_Activitys = new Vector.<THint>();
         _loc1_ = 0;
         while(_loc1_ < CONST_SMITHY.ACTIVITYNUM)
         {
            _loc3_ = new THint();
            _loc3_.Caption = STRING_SMITHY.StrengthenActivitysDescribtion[_loc1_];
            this.FHint_Activitys.push(_loc3_);
            _loc1_++;
         }
         this.FTF_TypeText.visible = false;
         this.FTF_ActivityTime.visible = false;
      }
      
      protected function ResetActivity() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = int(this.FActivitysActiveTask.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FActivitysActiveTask[_loc1_];
            _loc3_.gotoAndStop("cancle");
            _loc1_++;
         }
         this.FParameter.length = 0;
         this.FMC_Discount.visible = false;
      }
      
      protected function UpdateCDTime() : void
      {
         if(this.FTimeCoolDown.TimingTime > CONST_SMITHY.CHANGEREDMINUTETIME * 60)
         {
            this.FTF_StrengthenColdTime.textColor = 16711680;
         }
         else
         {
            this.FTF_StrengthenColdTime.textColor = 16777011;
         }
         this.FTF_StrengthenColdTime.text = TGameUtil.fomatTime(this.FTimeCoolDown.TimingTime);
      }
      
      protected function ResetInterface() : void
      {
         this.FReciveEquipment = null;
      }
      
      protected function ConstructFlyText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<String> = null;
         this.FTextRegistry = new TRegistryInstance();
         _loc3_ = STRING_SMITHY.STRENGTHEN_FLYTEXTS;
         _loc2_ = int(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTextRegistry.Register(STRING_SMITHY.STRENGTHEN_TEXTIDS[_loc1_],STRING_SMITHY.STRENGTHEN_FLYTEXTS[_loc1_]);
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
         if(this.FStrengthenNetwork == null)
         {
            return false;
         }
         if(this.FBtn_Strengthen.currentFrameLabel == "Disable")
         {
            return false;
         }
         if(this.FTF_StrengthenColdTime.textColor == 16711680 && this.FActivitysActiveTask[2].currentFrameLabel == "cancle" && SLogicsCore.KaguyaData.Type_Count_Vector[1] == 0)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR102);
            return false;
         }
         if(SLogicsCore.Character.CreditSilverCoin.ToNumber() < this.FStrengthenConsume)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR106);
            return false;
         }
         if(SLogicsCore.Character.GetMainLevel() <= this.FReciveEquipment.UpgradingLevel)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR107);
            return false;
         }
         return true;
      }
      
      protected function OnStrengthenConfirmationOk(param1:Object = null) : void
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(this.FCostGold > _loc2_.CreditGold + _loc2_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         this.FStrengthenNetwork(this.FReciveEquipment.Identifier0,this.FReciveEquipment.Identifier1,this.FParameter);
         this.FStrengthenLevelBeforeStrength = this.FReciveEquipment.UpgradingLevel;
         this.FCurrentState = STATE_STRENGTHEN;
      }
      
      protected function OnStrengthenBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TCharacter = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         TutorialNextStep(802);
         if(!this.VerificationStrengthen())
         {
            return;
         }
         this.FParameter.length = 0;
         _loc4_ = 0;
         while(_loc4_ < this.FActivitysActiveTask.length)
         {
            _loc5_ = this.FActivitysActiveTask[_loc4_];
            if(_loc5_.currentFrameLabel == "ok")
            {
               this.FParameter.push(CONST_SMITHY.STRENGTHTYPEARRAY[_loc4_]);
            }
            _loc4_++;
         }
         _loc3_ = SLogicsCore.Character;
         this.FCostGold = this.FParameter.length * COST_CREDIT;
         if(!this.FUIWindowConfirmation.IsSelected && this.FCostGold > 0)
         {
            this.FUIWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Smithy_DoubleLevelup).DescribeString,this.FCostGold);
            this.FUIWindowConfirmation.SetCheckBox(true);
            this.FUIWindowConfirmation.Visible = true;
            this.FUIWindowConfirmation.OnOK = this.OnStrengthenConfirmationOk;
         }
         else
         {
            this.OnStrengthenConfirmationOk();
         }
      }
      
      protected function OnConfirmationOk(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TCharacter = null;
         _loc2_ = Math.ceil(this.FTimeCoolDown.TimingTime / 60);
         _loc3_ = SLogicsCore.Character;
         if(_loc2_ > _loc3_.CreditGold + _loc3_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FOnClearTime != null)
         {
            this.FOnClearTime();
            this.FCurrentState = STATE_WAITFORCLEAR;
         }
      }
      
      protected function HandleClearTime(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(this.FTimeCoolDown.TimingTime <= 0)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR109);
            return;
         }
         if(!this.FUIWindowConfirmation.IsSelected)
         {
            _loc2_ = Math.ceil(this.FTimeCoolDown.TimingTime / 60);
            _loc3_ = new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Smithy_ClearCD).DescribeString;
            _loc3_ = _loc3_.split("%0").join(_loc2_);
            this.FUIWindowConfirmation.Text = _loc3_;
            this.FUIWindowConfirmation.OnOK = this.OnConfirmationOk;
            this.FUIWindowConfirmation.visible = true;
         }
         else
         {
            this.OnConfirmationOk(this);
         }
      }
      
      protected function OnActivitysActiveTaskClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = this.FActivitysActiveTask.indexOf(_loc2_);
         _loc4_ = CONST_SMITHY.STRENGTHTYPEARRAY[_loc3_];
         if(_loc2_.currentFrameLabel == "ok")
         {
            _loc2_.gotoAndStop("cancle");
            if(_loc3_ == 1)
            {
               this.FMC_Discount.visible = false;
            }
            else if(_loc3_ == 0)
            {
               SLogicsCore.KaguyaData.IsSelectDoubel = false;
            }
         }
         else
         {
            _loc2_.gotoAndStop("ok");
            if(_loc3_ == 1)
            {
               this.FMC_Discount.visible = true;
            }
            else if(_loc3_ == 0)
            {
               SLogicsCore.KaguyaData.IsSelectDoubel = true;
            }
         }
      }
      
      protected function OnEquipSlotClick(param1:Object, param2:Object) : void
      {
         this.Reset();
         this.UIComponentsHintOnOut(param1,param2 as TInventory);
      }
      
      protected function IconMove(param1:MouseEvent) : void
      {
         if(this.FICMove != null)
         {
            this.FICMove();
         }
      }
      
      protected function IconOut(param1:MouseEvent) : void
      {
         if(this.FICOut != null)
         {
            this.FICOut();
         }
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
      
      protected function ActivityOnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         _loc2_ = param1.currentTarget as MovieClip;
         _loc3_ = this.FMC_Activitys.indexOf(_loc2_);
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint_Activitys[_loc3_]);
         }
      }
      
      protected function ActivityOnMouseOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function set StrengthenNetwork(param1:Function) : void
      {
         this.FStrengthenNetwork = param1;
      }
      
      public function set StrengthenLevel(param1:int) : void
      {
         this.FStrengthenLevelAfterStrength = param1;
      }
      
      public function set StrengthenCDTime(param1:uint) : void
      {
         this.FTimeCoolDown.TimingTime = param1;
      }
      
      public function set OnSlotMouseOver(param1:Function) : void
      {
         this.FOnSlotMouseOver = param1;
      }
      
      public function set OnSlotMouseOut(param1:Function) : void
      {
         this.FOnSlotMouseOut = param1;
      }
      
      public function set StrengthenColdTimeRequest(param1:Function) : void
      {
         this.FStrengthenColdTimeRequest = param1;
      }
      
      public function set StrengthenResult(param1:uint) : void
      {
         this.FStrengthenResult = param1;
      }
      
      public function set OnClearTime(param1:Function) : void
      {
         this.FOnClearTime = param1;
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
      
      public function get KaguyState() : Boolean
      {
         return this.FKaguyState;
      }
      
      public function set ICMove(param1:Function) : void
      {
         this.FICMove = param1;
      }
      
      public function set ICOut(param1:Function) : void
      {
         this.FICOut = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:THero = null;
         SLogicsCore.KaguyaData.C_S_Privilege(1);
         switch(this.FCurrentState)
         {
            case STATE_READY:
               break;
            case STATE_STRENGTHEN:
               if(this.FStrengthenResult == 0)
               {
                  this.UpdateEquipment();
                  if(this.FStrengthenLevelAfterStrength == this.FStrengthenLevelBeforeStrength + 2)
                  {
                     if(SLogicsCore.KaguyaData.IsSelectDoubel)
                     {
                        this.FlyText(STRING_SMITHY.TEXTID_STR103);
                     }
                     else
                     {
                        this.FlyText(STRING_SMITHY.TEXTID_STR113);
                     }
                     this.PlayDoubleEffect();
                  }
                  else
                  {
                     this.FlyText(STRING_SMITHY.TEXTID_STR101);
                     this.PlaySingleEffect();
                  }
                  if(this.FUpdateHeroPower != null && this.FHeroID != 0)
                  {
                     this.FUpdateHeroPower(this,this.FHeroID);
                  }
               }
               else
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR105);
               }
               this.FCurrentState = STATE_READY;
               break;
            case STATE_WAITFORCLEAR:
               if(this.FStrengthenResult == 0)
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR111);
               }
               else
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR110);
               }
               this.FCurrentState = STATE_READY;
         }
      }
      
      public function Reset() : void
      {
         this.FCurrentState = STATE_READY;
         this.ResetStrengthenBaseInfor();
         this.ResetActivity();
         this.ResetInterface();
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
         if(param1.UpgradingLevel >= CONST_SMITHY.StrengthenMaxLevel)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR112);
            return;
         }
         this.FReciveEquipment = param1;
         this.FHeroID = param2;
         this.FEquipSlot.Context = this.FReciveEquipment;
         this.UpdateStrengthenBaseInfor();
         if(this.FReciveEquipment == null)
         {
            this.FBtn_Strengthen.gotoAndStop("Disable");
         }
         else
         {
            this.FBtn_Strengthen.gotoAndStop("Enable");
         }
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FEquipSlot != null)
         {
            this.OnEquipSlotClick(this,this.FEquipSlot.Context);
         }
         super.Visible = param1;
      }
      
      public function UpdateFreeCount() : void
      {
         if(SLogicsCore.KaguyaData.Type_Count_Vector[1] == -1)
         {
            this.FTF_Kaguy_Dec.text = STRING_OhtsutsukiKaguya.Smithy_Dec_2;
         }
         else
         {
            this.FTF_Kaguy_Dec.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Smithy_Dec_1,SLogicsCore.KaguyaData.Type_Count_Vector[1]);
         }
      }
   }
}

