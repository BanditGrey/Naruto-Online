package Processors.Game.Lobby.Smithy
{
   import Components.Slots.*;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.Jade.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class SmithyWindowUpgrade extends TProcessorLobbyWindow
   {
      
      protected static const STATE_READY:int = 0;
      
      protected static const STATE_INHEIRIT:int = 1;
      
      protected static const MAX_MATERIAL_COUNT:uint = 3;
      
      protected var FUIDispatchRoutines:Vector.<Function>;
      
      protected var FUILocationRoutines:Vector.<Function>;
      
      protected var FCurrentState:int;
      
      protected var FInitialization:Boolean;
      
      protected var FOldEquipmentSlot:TUISlot;
      
      protected var FNewEquipmentSlot:TUISlot;
      
      protected var FUIMaterialSlotVect:Vector.<TUISlot>;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FMC_Scene:MovieClip;
      
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
      
      protected var FUpgradeNetwork:Function;
      
      protected var FStrengthenResult:uint;
      
      protected var FOnSlotMouseOver:Function;
      
      protected var FOnSlotMouseOut:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FBackReset:Function;
      
      public function SmithyWindowUpgrade(param1:TUIComponent)
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
         this.FMC_Scene = param1;
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
         this.FInitialization = true;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         super.LogicsPerform();
         if(this.FInitialization)
         {
            this.FOldEquipmentSlot.Update();
            this.FNewEquipmentSlot.Update();
            _loc1_ = int(this.FUIMaterialSlotVect.length);
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this.FUIMaterialSlotVect[_loc2_];
               _loc3_.Update();
               _loc2_++;
            }
         }
      }
      
      protected function EquipmentUIDispatch(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FOldEquipmentSlot = new TUISlot(this);
         this.FOldEquipmentSlot.Resource = param1["Old_Slot"];
         this.FNewEquipmentSlot = new TUISlot(this);
         this.FNewEquipmentSlot.Resource = param1["New_Slot"];
         this.FMC_Screw = param1["Screw"];
         this.FMC_ScrewGlow = this.FMC_Screw["Glow"];
         this.FTF_BeforeInherit = param1["TF_InheritBefore"];
         this.FTF_AfterInherit = param1["TF_InheritAfter"];
         this.FUIMaterialSlotVect = new Vector.<TUISlot>();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         _loc2_ = 0;
         while(_loc2_ < MAX_MATERIAL_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = param1["mc_Material" + _loc2_];
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc3_.OnOverlay = this.UIComponentsHintOnOver;
            _loc3_.OnOut = this.UIComponentsHintOnOut;
            _loc3_.Init();
            this.FUIMaterialSlotVect.push(_loc3_);
            _loc2_++;
         }
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
      }
      
      protected function SendEquipment(param1:TEquipment) : void
      {
         this.FOldEquipment = param1;
         this.FNewEquipment = null;
         this.UpdateEquipmentSlot();
         this.UpdateEquipMaterial();
      }
      
      protected function UpdateEquipmentSlot() : void
      {
         this.FOldEquipmentSlot.Context = this.FOldEquipment;
         this.FNewEquipmentSlot.Context = this.FNewEquipment;
      }
      
      protected function UpdateEquipMaterial() : void
      {
         var _loc1_:TEquipUpgrade = null;
         var _loc2_:TInventories = null;
         var _loc3_:TInventory = null;
         var _loc4_:TUISlot = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Boolean = false;
         var _loc10_:TBins = null;
         var _loc11_:TBins = null;
         var _loc12_:TBuildConsume = null;
         var _loc13_:TConfigValue = null;
         var _loc14_:TBuildValue = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:TInventories = null;
         if(this.FOldEquipment == null)
         {
            this.FOldEquipmentSlot.Context = null;
            this.FNewEquipmentSlot.Context = null;
            _loc6_ = int(this.FUIMaterialSlotVect.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = this.FUIMaterialSlotVect[_loc5_];
               _loc4_.Context = null;
               this.FMC_Scene["mc_Material" + _loc5_]["TF_NeedNum"].text = "";
               _loc5_++;
            }
            TGameUtil.setButtonMode(this.FBtn_Inherit,false);
         }
         else
         {
            this.FOldEquipment = this.FOldEquipmentSlot.Context as TEquipment;
            _loc9_ = true;
            _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,this.FOldEquipment.IDTemplate) as TEquipUpgrade;
            if(_loc1_ == null)
            {
               return;
            }
            _loc11_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildConsume);
            if(this.FOldEquipment.UpgradingLevel > 0)
            {
               _loc15_ = 0;
               _loc6_ = _loc11_.Count;
               _loc5_ = 0;
               while(_loc5_ < _loc6_)
               {
                  _loc12_ = _loc11_.GetDatebaseByIndex(_loc5_) as TBuildConsume;
                  if(_loc12_.Quality == this.FOldEquipment.Quality)
                  {
                     _loc15_ += _loc12_.Consume;
                     if(_loc12_.BuildLevel == this.FOldEquipment.UpgradingLevel)
                     {
                        _loc15_ -= _loc12_.Consume;
                        break;
                     }
                  }
                  _loc5_++;
               }
               _loc13_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_EQUIPADVANCED.EQUIP_CONSUME_RATE) as TConfigValue;
               _loc16_ = uint(int(_loc15_ * (_loc13_.Value as Number)));
               _loc15_ = 0;
               _loc6_ = _loc11_.Count;
               if(_loc16_ >= 0)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc6_)
                  {
                     _loc12_ = _loc11_.GetDatebaseByIndex(_loc5_) as TBuildConsume;
                     if(_loc12_.Quality == this.FOldEquipment.Quality + 1)
                     {
                        _loc15_ += _loc12_.Consume;
                        if(_loc16_ < _loc15_)
                        {
                           _loc17_ = uint(_loc12_.BuildLevel);
                           break;
                        }
                     }
                     _loc5_++;
                  }
               }
            }
            _loc19_ = new TInventories();
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc19_,Vector.<uint>([_loc1_.GotEquipId]));
            this.FNewEquipment = _loc19_.GetInventoryByIndex(0) as TEquipment;
            _loc10_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuildValue);
            _loc6_ = _loc10_.Count;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc14_ = _loc10_.GetDatebaseByIndex(_loc5_) as TBuildValue;
               if(this.FNewEquipment.CategorySecond == _loc14_.EquipType && this.FNewEquipment.Quality == _loc14_.Quality && _loc17_ == _loc14_.BuildLevel)
               {
                  _loc18_ = uint(_loc14_.Value);
               }
               _loc5_++;
            }
            this.FNewEquipment.UpgradingLevel = _loc17_;
            this.FNewEquipment.UpgradingBasisProperty = _loc18_;
            this.FNewEquipmentSlot.Context = this.FNewEquipment;
            _loc2_ = new TInventories();
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,_loc2_,_loc1_.Materials);
            _loc6_ = int(this.FUIMaterialSlotVect.length);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = this.FUIMaterialSlotVect[_loc5_];
               _loc3_ = _loc2_.GetInventoryByIndex(_loc5_);
               _loc4_.Context = _loc3_;
               _loc7_ = this.GetMaterialCountByID(_loc3_.IDTemplate);
               _loc8_ = _loc1_.Quantitys[_loc5_];
               this.FMC_Scene["mc_Material" + _loc5_]["TF_NeedNum"].text = _loc7_ + "/" + _loc8_;
               if(_loc7_ < _loc8_)
               {
                  _loc9_ = false;
                  this.FMC_Scene["mc_Material" + _loc5_]["TF_NeedNum"].textColor = CONST_COMMON.TEXT_White_Color;
               }
               else
               {
                  this.FMC_Scene["mc_Material" + _loc5_]["TF_NeedNum"].textColor = CONST_COMMON.TEXT_Green_Color;
               }
               _loc5_++;
            }
            if(this.FHeroID > 0 && SLogicsCore.Character.Heros.GetHeroByIdentifier(this.FHeroID).Level < this.FNewEquipment.RequirementLevel)
            {
               _loc9_ = false;
            }
            TGameUtil.setButtonMode(this.FBtn_Inherit,_loc9_);
         }
      }
      
      protected function ResetEquipmentSlot() : void
      {
         this.FOldEquipment = null;
         this.FNewEquipment = null;
         this.UpdateEquipmentSlot();
         this.UpdateEquipMaterial();
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
      }
      
      protected function BtnUIDispatch(param1:MovieClip) : void
      {
         this.FBtn_Inherit = param1["Inherit_OK"];
      }
      
      protected function BtnLocation() : void
      {
         TUtilityStandardBTN.SetBtnEventListener(this.FBtn_Inherit,this.OnBtnUpgradeClick);
         this.FBtn_Inherit.buttonMode = true;
         this.FBtn_Inherit.gotoAndStop(1);
      }
      
      protected function ResetBtn() : void
      {
         TGameUtil.setButtonMode(this.FBtn_Inherit,false);
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
      
      public function OnBtnUpgradeClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FUpgradeNetwork != null)
         {
            this.FUpgradeNetwork(this.FOldEquipment.Identifier0,this.FOldEquipment.Identifier1);
            this.FCurrentState = STATE_INHEIRIT;
         }
      }
      
      protected function OnSlotClick(param1:Object = null, param2:Object = null) : void
      {
         this.UIComponentsHintOnOut(param1,param2 as TInventory);
         this.Reset();
      }
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Smithy);
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
      
      protected function GetMaterialCountByID(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TInventories = null;
         var _loc5_:TInventory = null;
         var _loc6_:uint = 0;
         _loc4_ = SLogicsCore.Character.Materials;
         _loc3_ = uint(_loc4_.Count);
         _loc6_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = _loc4_.GetInventoryByIndex(_loc2_);
            if(_loc5_.IDTemplate == param1)
            {
               _loc6_ += _loc5_.Quantity;
            }
            _loc2_++;
         }
         return _loc6_;
      }
      
      public function set UpgradeNetwork(param1:Function) : void
      {
         this.FUpgradeNetwork = param1;
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
                  this.FHeroID = 0;
                  this.Reset();
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
         this.ResetBtn();
      }
      
      public function set BackReset(param1:Function) : void
      {
         this.FBackReset = param1;
      }
      
      public function ReciveEquipment(param1:TEquipment, param2:uint) : void
      {
         this.FHeroID = param2;
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

