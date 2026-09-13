package Processors.Game.Lobby.AccessoryLing
{
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TOrnamentBuildConsume;
   import Logics.DatebaseVO.VO.TStarPointDesc;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_ACCESSORY_INTENSITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_HEROS;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorIntensityArea extends Sprite
   {
      
      protected var FIntensityArea:MovieClip = null;
      
      protected var FDoubleEffect:MovieClip = null;
      
      protected var FMainAttriButy:TextField = null;
      
      protected var FNextAttriButy:TextField = null;
      
      protected var FMCEffect:MovieClip = null;
      
      protected var FTaskBtn:MovieClip = null;
      
      protected var FUiSolt:TSoltCell = null;
      
      protected var FMC_Selected:MovieClip = null;
      
      protected var FMC_SelectedCurFream:int = 2;
      
      protected var FUISlots:Vector.<TSoltCell> = null;
      
      protected var RealQualit:Vector.<uint>;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FIsInitilization:Boolean = false;
      
      protected var parentPanel:TUIComponent;
      
      protected var FIntensityLevl:TextField;
      
      protected var FTF_Stone:TextField;
      
      protected var FCurrentIntensity:TInventory = null;
      
      protected var FAccessoryIntensityLevel:int;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FUniversalItemId:uint;
      
      protected var FNormalItemId:uint;
      
      protected var FSlotsOnQuerySequenceContext:Function = null;
      
      protected var FApplianceOnOver:Function = null;
      
      protected var FApplianceOnOut:Function = null;
      
      protected var FIntenSityBtn:Function = null;
      
      protected var FSlotsOnOver:Function = null;
      
      protected var FSlotsOnOut:Function = null;
      
      protected var FShowFilledWindow:Function = null;
      
      protected var FUniversalCount:uint;
      
      protected var FExChangeTip:Function = null;
      
      protected var IsCanClick:Boolean = true;
      
      public function TProcessorIntensityArea(param1:TUIComponent)
      {
         super();
         this.FUISlots = new Vector.<TSoltCell>(4);
         this.RealQualit = new Vector.<uint>();
         this.parentPanel = param1;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FIntensityLevl = new TextField();
      }
      
      public function set SlotsOnOver(param1:Function) : void
      {
         this.FSlotsOnOver = param1;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      public function set ShowFilledWindow(param1:Function) : void
      {
         this.FShowFilledWindow = param1;
      }
      
      public function set ExChangeTip(param1:Function) : void
      {
         this.FExChangeTip = param1;
      }
      
      public function set IsVisible(param1:Boolean) : void
      {
         if(this.FIntensityArea)
         {
            this.FIntensityArea.visible = param1;
         }
      }
      
      protected function StateIntensityBtn(param1:Boolean) : void
      {
         if(param1)
         {
            TGameUtil.setButtonMode(this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_OKBtn],true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_OKBtn],false);
         }
      }
      
      public function UIPerformFill(param1:MovieClip) : void
      {
         var _loc3_:TConfigValue = null;
         var _loc2_:int = 0;
         this.FIntensityArea = param1;
         if(this.FIntensityArea == null)
         {
            return;
         }
         this.StateIntensityBtn(false);
         this.FMC_Selected = this.FIntensityArea["MC_Selected"];
         this.FMC_Selected.gotoAndStop(2);
         MovieClip(this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_OKBtn]).addEventListener(MouseEvent.CLICK,this.IntensityClick);
         MovieClip(this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingIntensify_OKBtn]).addEventListener(MouseEvent.CLICK,this.AdvIntensityClick);
         this.FMC_Selected.addEventListener(MouseEvent.CLICK,this.IntensityClick);
         if(SLogicsCore.Character.VipData.BuyOrnamentMaterial)
         {
            this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingIntensify_OKBtn].visible = true;
         }
         else
         {
            this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingIntensify_OKBtn].visible = false;
         }
         this.FMainAttriButy = this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_TF_Scr];
         this.FNextAttriButy = this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_TF_ScrC];
         this.FMainAttriButy.text = "";
         this.FNextAttriButy.text = "";
         this.FMCEffect = this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_DoubleEffect];
         this.FMCEffect.mouseChildren = false;
         this.FMCEffect.mouseEnabled = false;
         this.FMCEffect.gotoAndStop(35);
         this.FIntensityLevl = this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_TF_LevelScr];
         this.FTF_Stone = this.FIntensityArea["TF_Stone"];
         var _loc4_:TSoltCell = null;
         while(_loc2_ < 4)
         {
            _loc4_ = this.GetSlotCell();
            _loc4_.Resource = this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_Slot_ + _loc2_];
            _loc4_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc4_.Init();
            _loc4_.OnOverlay = this.ApplianceOver;
            _loc4_.OnOut = this.ApplianceOut;
            this.FUISlots[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FUiSolt = this.GetSlotCell();
         this.FUiSolt.Resource = this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_Strengthen_Slot];
         this.FUiSolt.OnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FUiSolt.Init();
         this.FUiSolt.OnOverlay = this.OverEquipTip;
         this.FUiSolt.OnOut = this.OutEquipTip;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.AccessoryIntensityLevel) as TConfigValue;
         this.FAccessoryIntensityLevel = _loc3_.Value as int;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Accessories_Currency) as TConfigValue;
         this.FUniversalItemId = _loc3_.Value as int;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Accessories_Base) as TConfigValue;
         this.FNormalItemId = _loc3_.Value as int;
         this.FIsInitilization = true;
      }
      
      public function set CurrentIntensity(param1:TInventory) : void
      {
         this.FCurrentIntensity = param1;
      }
      
      public function UpdateIntensity(param1:TPacket) : void
      {
         var _loc2_:int = 0;
         this.FUniversalCount = this.GetUniversalMaterialCount();
         this.FTF_Stone.text = String(this.FUniversalCount);
         if(this.FCurrentIntensity)
         {
            this.FUiSolt.Context = this.FCurrentIntensity;
            this.AddExpendGods();
         }
         else
         {
            this.FUiSolt.Context = null;
            this.FMC_Selected.gotoAndStop(2);
            this.FMC_SelectedCurFream = 2;
            _loc2_ = 0;
            while(_loc2_ < this.FUISlots.length)
            {
               this.FUISlots[_loc2_].Context = null;
               this.FUISlots[_loc2_].MaterialCount(0);
               _loc2_++;
            }
            this.FMainAttriButy.text = "";
            this.FNextAttriButy.text = "";
            this.FIntensityLevl.text = "";
            this.StateIntensityBtn(false);
         }
         TGameUtil.setButtonMode(this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingIntensify_OKBtn],this.FCurrentIntensity != null);
      }
      
      protected function AddExpendGods() : void
      {
         var _loc1_:TOrnamentBuildConsume = null;
         var _loc3_:uint = 0;
         var _loc4_:THero = null;
         var _loc6_:TBins = null;
         this.RealQualit.length = 0;
         var _loc2_:Array = null;
         _loc4_ = SLogicsCore.Character.GetMainHero();
         _loc3_ = _loc4_.Level;
         var _loc5_:int = 0;
         this.FIntensityLevl.text = String(this.FCurrentIntensity.UpgradingLevel);
         _loc6_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_OrnamentBuildConsume) as TBins;
         if(this.FCurrentIntensity.UpgradingLevel != 0)
         {
            if(this.FCurrentIntensity.UpgradingLevel >= _loc3_)
            {
               this.FCurrentIntensity = null;
               this.UpdateIntensity(null);
               this.FExChangeTip(STRING_HEROS.STRING_MoutedAccessoryIntensity);
               return;
            }
            if(this.FCurrentIntensity.UpgradingLevel >= this.FAccessoryIntensityLevel)
            {
               this.FCurrentIntensity = null;
               this.UpdateIntensity(null);
               this.FExChangeTip(STRING_HEROS.STRING_MoutedAccessoryIntensityMast);
               return;
            }
            _loc1_ = _loc6_.GetDatebaseByValue2("AccessoryId",this.FCurrentIntensity.IDTemplate,"AccessoryLevel",this.FCurrentIntensity.UpgradingLevel) as TOrnamentBuildConsume;
            this.FMainAttriButy.text = this.GetStrengthenAttributeName(this.FCurrentIntensity,_loc1_.AddValue);
         }
         else
         {
            this.FMainAttriButy.text = this.GetStrengthenAttributeName(this.FCurrentIntensity,0,1);
         }
         _loc1_ = _loc6_.GetDatebaseByValue2("AccessoryId",this.FCurrentIntensity.IDTemplate,"AccessoryLevel",this.FCurrentIntensity.UpgradingLevel + 1) as TOrnamentBuildConsume;
         this.FNextAttriButy.text = this.GetStrengthenAttributeName(this.FCurrentIntensity,_loc1_.AddValue);
         _loc2_ = _loc1_.ItemsArr;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            this.RealQualit.push(_loc2_[_loc5_][1]);
            this.FTempSelectInventoriesId.push(_loc2_[_loc5_][0]);
            _loc5_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.LoadMaterial();
      }
      
      protected function GetUniversalMaterialCount() : uint
      {
         var _loc1_:TInventories = SLogicsCore.Character.Materials;
         return _loc1_.GetAllCountByTempletID(this.FUniversalItemId);
      }
      
      protected function LoadMaterial() : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         var _loc5_:uint = 0;
         var _loc1_:int = 0;
         var _loc4_:TInventories = SLogicsCore.Character.Materials;
         this.IsCanClick = true;
         _loc1_ = 0;
         while(_loc1_ < this.FSelectInventories.Count)
         {
            this.FUISlots[_loc1_].Context = this.FSelectInventories.GetInventoryByIndex(_loc1_);
            _loc3_ = _loc4_.GetInventoryByTempletID(this.FSelectInventories.GetInventoryByIndex(_loc1_).IDTemplate);
            if(_loc3_)
            {
               _loc5_ = 16777215;
               this.FUISlots[_loc1_].SetDefaultFilters(false);
               _loc2_ = _loc4_.GetAllCountByTempletID(_loc3_.IDTemplate);
               if(_loc3_.IDTemplate != this.FNormalItemId)
               {
                  if(this.FMC_SelectedCurFream == 1)
                  {
                     _loc2_ += this.FUniversalCount;
                  }
               }
               if(_loc2_ >= this.RealQualit[_loc1_])
               {
                  _loc5_ = 6736896;
               }
               else
               {
                  this.IsCanClick = false;
               }
               this.FUISlots[_loc1_].MaterialCount(_loc2_,this.RealQualit[_loc1_],true,_loc5_);
            }
            else
            {
               _loc2_ = 0;
               if(this.FUniversalCount == 0)
               {
                  this.FUISlots[_loc1_].SetDefaultFilters(true);
                  this.FUISlots[_loc1_].MaterialCount(0,this.RealQualit[_loc1_],true);
                  this.IsCanClick = false;
               }
               else
               {
                  _loc5_ = 16777215;
                  this.FUISlots[_loc1_].SetDefaultFilters(false);
                  if(this.FSelectInventories.GetInventoryByIndex(_loc1_).IDTemplate != this.FNormalItemId)
                  {
                     if(this.FMC_SelectedCurFream == 1)
                     {
                        _loc2_ += this.FUniversalCount;
                     }
                  }
                  if(_loc2_ >= this.RealQualit[_loc1_])
                  {
                     _loc5_ = 6736896;
                  }
                  else
                  {
                     this.IsCanClick = false;
                  }
                  this.FUISlots[_loc1_].MaterialCount(_loc2_,this.RealQualit[_loc1_],true,_loc5_);
               }
            }
            _loc1_++;
         }
         this.StateIntensityBtn(this.IsCanClick);
      }
      
      protected function GetStrengthenAttributeName(param1:TInventory, param2:int, param3:int = 0) : String
      {
         var _loc4_:TBaseEquip = null;
         var _loc5_:int = 0;
         var _loc6_:TStarPointDesc = null;
         var _loc7_:String = null;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1.IDTemplate) as TBaseEquip;
         _loc5_ = 17500000 + _loc4_.MainType;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,_loc5_) as TStarPointDesc;
         if(param3)
         {
            _loc7_ = _loc6_.Desc + "+" + _loc4_.MainValue;
         }
         else
         {
            _loc7_ = _loc6_.Desc + "+" + (_loc4_.MainValue + param2);
         }
         return _loc7_;
      }
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         this.FSlotsOnQuerySequenceContext(param1,param2,param3,param4);
      }
      
      protected function ApplianceOver(param1:Object, param2:Object) : void
      {
         this.FApplianceOnOver(param1,param2);
      }
      
      protected function ApplianceOut(param1:Object, param2:Object) : void
      {
         this.FApplianceOnOut(param1,param2);
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInitilization)
         {
            while(_loc1_ < this.FUISlots.length)
            {
               this.FUISlots[_loc1_].Update();
               _loc1_++;
            }
            this.FUiSolt.Update();
         }
      }
      
      protected function GetSlotCell() : TSoltCell
      {
         var _loc1_:TSoltCell = null;
         _loc1_ = new TSoltCell(this.parentPanel);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      public function IntensityClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingIntensify_OKBtn]:
               if(this.FUiSolt.Context == null || !this.IsCanClick)
               {
                  return;
               }
               this.FIntenSityBtn(this.FUiSolt.Context,2);
               break;
            case this.FMC_Selected:
               if(!this.FCurrentIntensity)
               {
                  return;
               }
               this.FMC_Selected.gotoAndStop(this.FMC_Selected.currentFrame == 1 ? 2 : 1);
               this.FMC_SelectedCurFream = this.FMC_Selected.currentFrame;
               this.LoadMaterial();
         }
      }
      
      public function AdvIntensityClick(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCurrentIntensity)
         {
            if(this.FShowFilledWindow != null)
            {
               this.FShowFilledWindow(this);
            }
         }
      }
      
      public function OnUseFilled(param1:Object, param2:Boolean) : void
      {
         this.FIntenSityBtn(this.FCurrentIntensity,int(param2));
      }
      
      public function setEffectPaly() : void
      {
         this.FMCEffect.gotoAndPlay(1);
      }
      
      public function set IntenSityBtn(param1:Function) : void
      {
         this.FIntenSityBtn = param1;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function set ApplianceOnOver(param1:Function) : void
      {
         this.FApplianceOnOver = param1;
      }
      
      public function set ApplianceOnOut(param1:Function) : void
      {
         this.FApplianceOnOut = param1;
      }
      
      public function OverEquipTip(param1:Object, param2:Object) : void
      {
         this.FSlotsOnOver(param1,param2);
      }
      
      public function OutEquipTip(param1:Object, param2:Object) : void
      {
         this.FSlotsOnOut(param1,param2);
      }
      
      public function VipLevelUpCheckBtnStatus() : void
      {
         if(this.FIntensityArea == null)
         {
            return;
         }
         if(SLogicsCore.Character.VipData.BuyOrnamentMaterial)
         {
            this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingIntensify_OKBtn].visible = true;
         }
         else
         {
            this.FIntensityArea[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingIntensify_OKBtn].visible = false;
         }
      }
      
      public function GetNeedCost(param1:Object, param2:Boolean) : String
      {
         var _loc3_:uint = 0;
         var _loc4_:TInventory = null;
         var _loc5_:TInventories = null;
         var _loc6_:uint = 0;
         var _loc7_:TArticle = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(this.FCurrentIntensity == null)
         {
            return "";
         }
         _loc5_ = SLogicsCore.Character.Materials;
         _loc9_ = 0;
         this.FUniversalCount = this.GetUniversalMaterialCount();
         _loc3_ = 0;
         while(_loc3_ < this.FSelectInventories.Count)
         {
            _loc6_ = _loc5_.GetAllCountByTempletID(this.FSelectInventories.GetInventoryByIndex(_loc3_).IDTemplate);
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FSelectInventories.GetInventoryByIndex(_loc3_).IDTemplate) as TArticle;
            if(_loc7_.Identifier == this.FNormalItemId)
            {
               _loc9_ += Math.max(this.RealQualit[_loc3_] - _loc6_,0) * _loc7_.GoldNumberA;
            }
            else
            {
               _loc9_ += Math.max(this.RealQualit[_loc3_] - _loc6_ - (param2 ? this.FUniversalCount : 0),0) * _loc7_.GoldNumberA;
            }
            _loc3_++;
         }
         _loc11_ = _loc10_ = int(SLogicsCore.KaguyaData.GetValueByType(3));
         var _loc12_:uint = _loc9_ * _loc11_ / 100;
         if(!_loc12_)
         {
            _loc12_ = _loc9_;
         }
         if(SLogicsCore.KaguyaData.IsLongTime == 7)
         {
            _loc8_ = TUtilityString.Format(STRING_HEROS.STRING_Accessory_SureFilledLevelUpCopyAgine,_loc9_ - _loc12_,_loc9_,this.FCurrentIntensity.Name);
         }
         else
         {
            _loc8_ = TUtilityString.Format(STRING_HEROS.STRING_Accessory_SureFilledLevelUpCopy,SLogicsCore.KaguyaData.CurLevel,STRING_HEROS.GetDiscountValue(_loc11_),_loc12_,_loc9_ - _loc12_,_loc12_,this.FCurrentIntensity.Name);
         }
         return _loc8_;
      }
   }
}

