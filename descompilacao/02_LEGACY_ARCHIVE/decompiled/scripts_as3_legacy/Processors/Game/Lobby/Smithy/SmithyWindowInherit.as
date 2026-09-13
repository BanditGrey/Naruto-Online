package Processors.Game.Lobby.Smithy
{
   import Components.Slots.*;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class SmithyWindowInherit extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_INHEIRIT:int = 1;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FCurrentState:int;
      
      protected var FInitialization:Boolean;
      
      protected var FOldEquipmentSlot:TUISlot;
      
      protected var FNewEquipmentSlot:TUISlot;
      
      protected var FOldEquipment:TEquipment;
      
      protected var FNewEquipment:TEquipment;
      
      protected var FExchangeGift:Boolean;
      
      protected var FMC_InheritTask:MovieClip;
      
      protected var FMC_Screw:MovieClip;
      
      protected var FMC_ScrewGlow:MovieClip;
      
      protected var FTF_BeforeInherit:TextField;
      
      protected var FTF_AfterInherit:TextField;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FBtn_Inherit:MovieClip;
      
      protected var FTextRegistry:TRegistryInstance;
      
      protected var FUpgradeLevel:int;
      
      protected var FEnchantValueBins:TBins;
      
      protected var FSmithyEnchantCoefficient:Number;
      
      protected var FReciveEquipment:TEquipment;
      
      protected var FHeroID:uint;
      
      protected var FInheritNetwork:Function;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      protected var FUpdateHerosPower:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FBackReset:Function;
      
      public function SmithyWindowInherit(param1:TUIComponent)
      {
         super(param1);
         this.ConstructDispatchRoutines();
         this.ConstructLocationRoutines();
         this.ConstructFlyText();
      }
      
      protected function ConstructDispatchRoutines() : void
      {
         this.FUIDispatchRoutines = new Vector.<Function>();
         this.FUIDispatchRoutines.push(this.EquipmentUIDispatch);
         this.FUIDispatchRoutines.push(this.ConfirmUIDispatch);
         this.FUIDispatchRoutines.push(this.BtnUIDispatch);
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
         this.FUILocationRoutines.push(this.EquipmentLocation);
         this.FUILocationRoutines.push(this.ConfirmLocation);
         this.FUILocationRoutines.push(this.BtnLocation);
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
         this.StopScrew();
         this.FInitialization = true;
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FInitialization)
         {
            this.FOldEquipmentSlot.Update();
            this.FNewEquipmentSlot.Update();
         }
      }
      
      protected function EquipmentUIDispatch(param1:MovieClip) : void
      {
         this.FOldEquipmentSlot = new TUISlot(this);
         this.FOldEquipmentSlot.Resource = param1["Old_Slot"];
         this.FNewEquipmentSlot = new TUISlot(this);
         this.FNewEquipmentSlot.Resource = param1["New_Slot"];
         this.FMC_InheritTask = param1["Inherit_Selected"];
         this.FMC_Screw = param1["Screw"];
         this.FMC_ScrewGlow = this.FMC_Screw["Glow"];
         this.FTF_BeforeInherit = param1["TF_InheritBefore"];
         this.FTF_AfterInherit = param1["TF_InheritAfter"];
      }
      
      protected function EquipmentLocation() : void
      {
         TJadeCommon.InitSlot(this.FOldEquipmentSlot,CONST_MODULES.MODULE_Smithy);
         this.FOldEquipmentSlot.OnClick = this.OnSlotClick;
         this.FOldEquipmentSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FOldEquipmentSlot.OnOut = this.UIComponentsHintOnOut;
         this.FOldEquipmentSlot.Init();
         TJadeCommon.InitSlot(this.FNewEquipmentSlot,CONST_MODULES.MODULE_Smithy);
         this.FNewEquipmentSlot.OnClick = this.OnSlotClick;
         this.FNewEquipmentSlot.OnOverlay = this.UIComponentsHintOnOver;
         this.FNewEquipmentSlot.OnOut = this.UIComponentsHintOnOut;
         this.FNewEquipmentSlot.Init();
         this.FMC_InheritTask.addEventListener(MouseEvent.CLICK,this.OnTaskClick);
      }
      
      protected function SendEquipment(param1:TEquipment) : void
      {
         if(this.FOldEquipment == null)
         {
            if(this.FNewEquipment != param1)
            {
               this.FOldEquipment = param1;
            }
         }
         else if(this.FNewEquipment == null)
         {
            if(this.FOldEquipment != param1)
            {
               this.FNewEquipment = param1;
            }
         }
         else
         {
            this.FOldEquipment = param1;
            this.FNewEquipment = null;
         }
         if(this.FOldEquipment != null && this.FNewEquipment != null)
         {
            this.FBtn_Inherit.gotoAndStop("Enable");
         }
         this.UpdateEquipmentSlot();
      }
      
      protected function UpdateEquipmentSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FOldEquipmentSlot.Context = this.FOldEquipment;
         this.FNewEquipmentSlot.Context = this.FNewEquipment;
         if(this.FOldEquipment != null)
         {
            _loc2_ = STRING_SMITHY.STRING_Inherit_before;
            _loc2_ = _loc2_.split("%count%").join(this.FOldEquipment.UpgradingLevel);
            this.FTF_BeforeInherit.text = _loc2_;
         }
         else
         {
            this.FTF_BeforeInherit.text = "";
         }
         if(this.FNewEquipment != null && this.FOldEquipment != null)
         {
            _loc1_ = this.EquipmentInherit(this.FOldEquipment,this.FNewEquipment);
            _loc2_ = STRING_SMITHY.STRING_Inherit_end;
            _loc2_ = _loc2_.split("%count%").join(_loc1_);
            this.FTF_AfterInherit.text = _loc2_;
         }
         else
         {
            this.FTF_AfterInherit.text = "";
         }
      }
      
      protected function ResetEquipmentSlot() : void
      {
         this.FOldEquipment = null;
         this.FNewEquipment = null;
         this.UpdateEquipmentSlot();
         this.StopScrew();
      }
      
      protected function StopScrew() : void
      {
         this.FMC_Screw.gotoAndStop(1);
         this.FMC_ScrewGlow.gotoAndStop(1);
      }
      
      protected function StartScrew() : void
      {
         this.FMC_Screw.play();
         this.FMC_ScrewGlow.play();
      }
      
      protected function SetInheritTask(param1:Boolean) : void
      {
         this.FExchangeGift = param1;
         if(param1)
         {
            this.FMC_InheritTask.gotoAndStop("ok");
         }
         else
         {
            this.FMC_InheritTask.gotoAndStop("cancle");
         }
      }
      
      protected function ConfirmUIDispatch(param1:MovieClip) : void
      {
         this.FUIWindowConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         this.FUIWindowConfirmation.x = (STAGE_Width - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (STAGE_Height - this.FUIWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
      }
      
      protected function ConfirmLocation() : void
      {
         this.FUIWindowConfirmation.OnOK = this.OnClickCofirmOk;
      }
      
      protected function OnClickCofirmOk(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(this.FInheritNetwork != null)
         {
            if(this.FExchangeGift)
            {
               _loc2_ = 1;
            }
            else
            {
               _loc2_ = 0;
            }
            this.FInheritNetwork(this.FOldEquipment.Identifier0,this.FOldEquipment.Identifier1,this.FNewEquipment.Identifier0,this.FNewEquipment.Identifier1,_loc2_);
            this.FCurrentState = STATE_INHEIRIT;
         }
      }
      
      protected function EquipmentInherit(param1:TEquipment, param2:TEquipment) : int
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc3_:Number = 0;
         _loc3_ = param1.SellingValue;
         _loc5_ = int(param2.UpgradingLevel);
         while(true)
         {
            _loc6_ = CONST_SMITHY.GetBuildConsumeID(param2.Quality,_loc5_);
            _loc4_ = this.GetConsumeByID(_loc6_);
            if(_loc3_ < _loc4_)
            {
               break;
            }
            _loc3_ -= _loc4_;
            if(++_loc5_ >= SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.GetMainLevel()))
            {
               _loc5_ = int(SLogicsCore.Character.GetMainHeroLogicLevel(SLogicsCore.Character.GetMainLevel()));
               break;
            }
         }
         return _loc5_;
      }
      
      protected function GetConsumeByID(param1:uint) : uint
      {
         var _loc2_:TBuildConsume = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BuildConsume,param1) as TBuildConsume;
         return _loc2_.Consume;
      }
      
      protected function BtnUIDispatch(param1:MovieClip) : void
      {
         this.FBtn_Inherit = param1["Inherit_OK"];
      }
      
      protected function BtnLocation() : void
      {
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Inherit,this.OnBtnInheritClick);
         this.FBtn_Inherit.buttonMode = true;
         this.FBtn_Inherit.gotoAndStop(1);
      }
      
      protected function ResetBtn() : void
      {
         this.FBtn_Inherit.gotoAndStop("Disable");
         if(this.FBackReset != null)
         {
            this.FBackReset();
         }
      }
      
      protected function ConstructFlyText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<String> = null;
         this.FTextRegistry = new TRegistryInstance();
         _loc3_ = STRING_SMITHY.INHERIT_FLYTEXTS;
         _loc2_ = int(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FTextRegistry.Register(STRING_SMITHY.INHERIT_TEXTIDS[_loc1_],STRING_SMITHY.INHERIT_FLYTEXTS[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function FlyText(param1:int) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FTextRegistry.GetInstanceByIdentifier(param1) as String;
         EffectGenerateText(_loc2_);
      }
      
      protected function VerificationInherit() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.FBtn_Inherit.currentFrameLabel == "Disable")
         {
            return false;
         }
         if(this.FOldEquipment == null || this.FNewEquipment == null)
         {
            return false;
         }
         if(this.FMC_InheritTask.currentFrameLabel == "ok" && this.FOldEquipment.HoleCount + this.FOldEquipment.ExpandHoleCount != this.FNewEquipment.HoleCount + this.FNewEquipment.ExpandHoleCount)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR302);
            return false;
         }
         this.FUpgradeLevel = this.EquipmentInherit(this.FOldEquipment,this.FNewEquipment);
         if(this.FUpgradeLevel == this.FNewEquipment.UpgradingLevel)
         {
            this.FlyText(STRING_SMITHY.TEXTID_STR303);
            return false;
         }
         return true;
      }
      
      protected function OnTaskClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         _loc2_ = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrameLabel == "ok")
         {
            this.SetInheritTask(false);
         }
         else
         {
            this.SetInheritTask(true);
         }
      }
      
      public function OnBtnInheritClick(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         _loc2_ = this.VerificationInherit();
         if(!_loc2_)
         {
            return;
         }
         this.FUIWindowConfirmation.visible = true;
         _loc3_ = STRING_SMITHY.String_UpgradeLevel;
         _loc3_ = _loc3_.split("%level%").join(this.FNewEquipment.UpgradingLevel);
         _loc3_ = _loc3_.split("%UpgradeLevel%").join(this.FUpgradeLevel);
         this.FUIWindowConfirmation.Text = _loc3_;
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
         var _loc3_:TUISlot = null;
         _loc3_ = param1 as TUISlot;
         this.UIComponentsHintOnOut(param1,param2 as TInventory);
         if(_loc3_ == this.FOldEquipmentSlot)
         {
            this.FOldEquipment = null;
         }
         else
         {
            this.FNewEquipment = null;
         }
         this.ResetBtn();
         this.UpdateEquipmentSlot();
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
      
      protected function UpdateEquipment() : void
      {
         var _loc1_:TEnchantValue = null;
         if(this.FOldEquipment == null || this.FNewEquipment == null)
         {
            return;
         }
         _loc1_ = this.GetEnchantValue(this.FOldEquipment);
         if(_loc1_ != null)
         {
            this.FOldEquipment.EnchantValue = int(_loc1_.LevelCoefficient * this.FOldEquipment.EnchantCoefficient * _loc1_.TypeCoefficient * (this.FOldEquipment.UpgradingLevel + this.FSmithyEnchantCoefficient));
         }
         _loc1_ = this.GetEnchantValue(this.FNewEquipment);
         if(_loc1_ != null)
         {
            this.FNewEquipment.EnchantValue = int(_loc1_.LevelCoefficient * this.FNewEquipment.EnchantCoefficient * _loc1_.TypeCoefficient * (this.FNewEquipment.UpgradingLevel + this.FSmithyEnchantCoefficient));
         }
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
      
      public function set InheritNetwork(param1:Function) : void
      {
         this.FInheritNetwork = param1;
      }
      
      public function set OnSlotMouseOver(param1:Function) : void
      {
         this.FOnSlotMouseOver = param1;
      }
      
      public function set OnSlotMouseOut(param1:Function) : void
      {
         this.FOnSlotMouseOut = param1;
      }
      
      public function set StrengthenResult(param1:uint) : void
      {
         this.FStrengthenResult = param1;
      }
      
      public function set UpdateHerosPower(param1:Function) : void
      {
         this.FUpdateHerosPower = param1;
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
               break;
            case STATE_INHEIRIT:
               if(this.FStrengthenResult == 0)
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR301);
                  if(this.FUpdateHerosPower != null && this.FHeroID != 0)
                  {
                     this.FUpdateHerosPower(this);
                  }
                  this.FHeroID = 0;
                  this.UpdateEquipment();
               }
               else
               {
                  this.FlyText(STRING_SMITHY.TEXTID_STR302);
               }
               this.FCurrentState = STATE_READY;
         }
         this.StartScrew();
      }
      
      public function Reset() : void
      {
         this.ResetEquipmentSlot();
         this.SetInheritTask(false);
         this.ResetBtn();
      }
      
      public function set BackReset(param1:Function) : void
      {
         this.FBackReset = param1;
      }
      
      public function ReciveEquipment(param1:TEquipment, param2:uint) : void
      {
         this.FHeroID |= param2;
         this.FReciveEquipment = param1;
         this.SendEquipment(param1);
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FOldEquipmentSlot != null && param1)
         {
            this.OnSlotClick(this.FOldEquipmentSlot,this.FOldEquipmentSlot.Context);
            this.OnSlotClick(this.FNewEquipmentSlot,this.FNewEquipmentSlot.Context);
         }
         super.Visible = param1;
      }
   }
}

