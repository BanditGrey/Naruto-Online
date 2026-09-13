package Processors.Game.Lobby.AccessoryLing
{
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TBaseEquip;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEquipUpgrade;
   import Logics.DatebaseVO.VO.TStarPointDesc;
   import Logics.DatebaseVO.VO.TSuit;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_ACCESSORY_INTENSITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_HEROS;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorLingZhuArea extends Sprite
   {
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      public static const TWO:int = 2;
      
      public static const FOUR:int = 4;
      
      protected var FLingZhuPanel:MovieClip = null;
      
      protected var FUISltePreNext:Vector.<TSoltCell> = null;
      
      protected var FStuffVec:Vector.<TSoltCell> = null;
      
      protected var FIsInitilization:Boolean = false;
      
      protected var FTaskBtn:MovieClip = null;
      
      protected var parentPanel:TUIComponent;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FSelectMaterialInventories:TInventories;
      
      protected var FUniversalItemId:uint;
      
      protected var FNormalItemId:uint;
      
      protected var ExpendMaterialCount:Vector.<int>;
      
      protected var FAttriName:TextField;
      
      protected var FNewAttri:TextField;
      
      protected var FOldAttri:TextField;
      
      protected var FjichuhouAttri:TextField;
      
      protected var FjichuAqianAttri:TextField;
      
      protected var FjichuAqianAttriname:TextField;
      
      protected var FMc_Effect_LingZhu:MovieClip;
      
      protected var FTF_Stone:TextField;
      
      protected var FUniversalCount:uint;
      
      protected var FMC_Selected:MovieClip = null;
      
      protected var FMC_SelectedCurFream:int = 2;
      
      protected var IsCanClick:Boolean = false;
      
      protected var FSlotsOnQuerySequenceContext:Function = null;
      
      protected var FApplianceOnOver:Function = null;
      
      protected var FApplianceOnOut:Function = null;
      
      protected var FSlotsOnOver:Function = null;
      
      protected var FSlotsOnOut:Function = null;
      
      protected var FShowFilledWindow:Function = null;
      
      protected var FLingzhuBtnFunction:Function = null;
      
      protected var FExChangeTip:Function = null;
      
      protected var FCurrentIntensity:TInventory = null;
      
      protected var FCurEquipUpgrade:TEquipUpgrade;
      
      public function TProcessorLingZhuArea(param1:TUIComponent)
      {
         super();
         this.FUISltePreNext = new Vector.<TSoltCell>(TWO);
         this.FStuffVec = new Vector.<TSoltCell>(FOUR);
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectMaterialInventories = new TInventories();
         this.ExpendMaterialCount = new Vector.<int>();
         this.parentPanel = param1;
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
         if(this.FLingZhuPanel)
         {
            this.FLingZhuPanel.visible = param1;
         }
      }
      
      protected function setStateBtn(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_LingZhuBtn],param1);
      }
      
      public function UIPerformFill(param1:MovieClip) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc4_:int = 0;
         this.FLingZhuPanel = param1;
         if(this.FLingZhuPanel == null)
         {
            return;
         }
         this.setStateBtn(false);
         this.FMC_Selected = this.FLingZhuPanel["MC_Selected"];
         this.FMC_Selected.gotoAndStop(2);
         MovieClip(this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_LingZhuBtn]).addEventListener(MouseEvent.CLICK,this.LingzhuBtnClick);
         MovieClip(this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingLingZu_LingZhuBtn]).addEventListener(MouseEvent.CLICK,this.AdvLingzhuBtnClick);
         this.FMC_Selected.addEventListener(MouseEvent.CLICK,this.LingzhuBtnClick);
         if(SLogicsCore.Character.VipData.BuyOrnamentMaterial)
         {
            this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingLingZu_LingZhuBtn].visible = true;
         }
         else
         {
            this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingLingZu_LingZhuBtn].visible = false;
         }
         var _loc3_:TSoltCell = null;
         this.FAttriName = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_ + 1]["AttributeName"];
         this.FOldAttri = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_ + 1]["AttributeValue0"];
         this.FNewAttri = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_ + 1]["AttributeValue1"];
         this.FjichuAqianAttriname = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_ + 0]["AttributeName"];
         this.FjichuAqianAttri = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_ + 0]["AttributeValue0"];
         this.FjichuhouAttri = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_ + 0]["AttributeValue1"];
         this.FMc_Effect_LingZhu = this.FLingZhuPanel["Mc_Effect_LingZhu"];
         this.FTF_Stone = this.FLingZhuPanel["TF_Stone"];
         _loc4_ = 0;
         while(_loc4_ < FOUR)
         {
            _loc3_ = this.GetSlotCell();
            _loc3_.Resource = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Solt_ + _loc4_];
            _loc3_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc3_.Init();
            _loc3_.OnOverlay = this.ApplianceOver;
            _loc3_.OnOut = this.ApplianceOut;
            this.FStuffVec[_loc4_] = _loc3_;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < TWO)
         {
            _loc3_ = this.GetSlotCell();
            _loc3_.Resource = this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_Item_AttributeValue_ + _loc4_];
            _loc3_.OnQuerySequenceContext = this.OnQuerySequenceContext;
            _loc3_.OnQueryEuqipLevel = this.SlotsOnQueryEuqipLevel;
            _loc3_.Init();
            _loc3_.OnOverlay = this.OverEquipTip;
            _loc3_.OnOut = this.OutEquipTip;
            this.FUISltePreNext[_loc4_] = _loc3_;
            _loc4_++;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Accessories_Currency) as TConfigValue;
         this.FUniversalItemId = _loc2_.Value as int;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Accessories_Base) as TConfigValue;
         this.FNormalItemId = _loc2_.Value as int;
         this.FIsInitilization = true;
      }
      
      protected function SlotsOnQueryEuqipLevel(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TInventory = null;
         if(param2 is TInventory)
         {
            _loc4_ = param2 as TInventory;
            if(_loc4_.UpgradingLevel > 0)
            {
               param3.Value = STRING_COMMON.FORMAT_Level + _loc4_.UpgradingLevel.toString();
            }
         }
      }
      
      public function set CurrentIntensity(param1:TInventory) : void
      {
         this.FCurrentIntensity = param1;
      }
      
      public function UpdateIntensity(param1:TPacket) : void
      {
         this.FUniversalCount = this.GetUniversalMaterialCount();
         this.FTF_Stone.text = String(this.FUniversalCount);
         if(this.FCurrentIntensity)
         {
            this.AddExpendGods();
         }
         else
         {
            this.FMC_Selected.gotoAndStop(2);
            this.FMC_SelectedCurFream = 2;
            this.setNull();
         }
         TGameUtil.setButtonMode(this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingLingZu_LingZhuBtn],this.FCurrentIntensity != null && !this.IsCanClick);
      }
      
      protected function setNull() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FStuffVec.length)
         {
            this.FStuffVec[_loc1_].Context = null;
            this.FStuffVec[_loc1_].MaterialCount(0);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            this.FUISltePreNext[_loc1_].Context = null;
            this.FUISltePreNext[_loc1_].MaterialCount(0);
            _loc1_++;
         }
         this.FNewAttri.text = "";
         this.FOldAttri.text = "";
         this.FjichuhouAttri.text = "";
         this.FjichuAqianAttri.text = "";
         this.FAttriName.text = "";
         this.FjichuAqianAttriname.text = "";
         this.setStateBtn(false);
      }
      
      protected function AddExpendGods() : void
      {
         var _loc1_:TEquipUpgrade = null;
         var _loc2_:TBaseEquip = null;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,this.FCurrentIntensity.IDTemplate) as TBaseEquip;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EquipUpgrade,this.FCurrentIntensity.IDTemplate) as TEquipUpgrade;
         this.FCurEquipUpgrade = _loc1_;
         if(_loc1_ == null)
         {
            this.setNull();
            this.FExChangeTip(STRING_HEROS.STRING_MoutedAccessoryLingZhu);
            this.FCurrentIntensity = null;
            return;
         }
         this.FUISltePreNext[0].Context = this.FCurrentIntensity;
         this.ShowOldSuitAttri(_loc2_.SuitId);
         this.Showjichuqian();
         this.FTempSelectInventoriesId.push(_loc1_.GotEquipId);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.FSelectInventories.GetInventoryByIndex(0).UpgradingLevel = this.FCurrentIntensity.UpgradingLevel;
         this.FUISltePreNext[1].Context = this.FSelectInventories.GetInventoryByIndex(0);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,this.FSelectInventories.GetInventoryByIndex(0).IDTemplate) as TBaseEquip;
         this.ShowNewSuitAttri(_loc2_.SuitId);
         this.Showjichuhou(this.FSelectInventories.GetInventoryByIndex(0).IDTemplate);
         this.LoadMaterial(_loc1_);
      }
      
      protected function GetUniversalMaterialCount() : uint
      {
         var _loc1_:TInventories = SLogicsCore.Character.Materials;
         return _loc1_.GetAllCountByTempletID(this.FUniversalItemId);
      }
      
      protected function LoadMaterial(param1:TEquipUpgrade) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc5_:uint = 16777215;
         var _loc8_:TInventories = SLogicsCore.Character.Materials;
         this.setStateBtn(true);
         this.FSelectMaterialInventories.Clear();
         this.FTempSelectInventoriesId.length = 0;
         this.ExpendMaterialCount.length = 0;
         this.IsCanClick = true;
         _loc2_ = int(param1.Materials.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.FTempSelectInventoriesId.push(param1.Materials[_loc3_]);
            this.ExpendMaterialCount.push(param1.Quantitys[_loc3_]);
            _loc3_++;
         }
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectMaterialInventories,this.FTempSelectInventoriesId);
         _loc2_ = this.FSelectMaterialInventories.Count;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FSelectMaterialInventories.GetInventoryByIndex(_loc3_);
            this.FStuffVec[_loc3_].Context = _loc4_;
            _loc4_ = _loc8_.GetInventoryByTempletID(_loc4_.IDTemplate);
            if(_loc4_)
            {
               this.FStuffVec[_loc3_].SetDefaultFilters(false);
               _loc6_ = _loc8_.GetAllCountByTempletID(_loc4_.IDTemplate);
               if(_loc4_.IDTemplate != this.FNormalItemId)
               {
                  if(this.FMC_SelectedCurFream == 1)
                  {
                     _loc6_ += this.FUniversalCount;
                  }
               }
               if(_loc6_ >= this.ExpendMaterialCount[_loc3_])
               {
                  _loc5_ = 6736896;
               }
               else
               {
                  _loc5_ = 16777215;
                  this.IsCanClick = false;
                  this.setStateBtn(false);
               }
               this.FStuffVec[_loc3_].MaterialCount(_loc6_,this.ExpendMaterialCount[_loc3_],true,_loc5_);
            }
            else
            {
               _loc6_ = 0;
               if(this.FUniversalCount == 0)
               {
                  this.FStuffVec[_loc3_].SetDefaultFilters(true);
                  this.FStuffVec[_loc3_].MaterialCount(0,this.ExpendMaterialCount[_loc3_],true);
                  this.IsCanClick = false;
                  this.setStateBtn(false);
               }
               else
               {
                  _loc5_ = 16777215;
                  this.FStuffVec[_loc3_].SetDefaultFilters(false);
                  if(this.FSelectMaterialInventories.GetInventoryByIndex(_loc3_).IDTemplate != this.FNormalItemId)
                  {
                     if(this.FMC_SelectedCurFream == 1)
                     {
                        _loc6_ += this.FUniversalCount;
                     }
                  }
                  if(_loc6_ >= this.ExpendMaterialCount[_loc3_])
                  {
                     _loc5_ = 6736896;
                  }
                  else
                  {
                     this.IsCanClick = false;
                     this.setStateBtn(false);
                  }
                  this.FStuffVec[_loc3_].MaterialCount(_loc6_,this.ExpendMaterialCount[_loc3_],true,_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      protected function Showjichuqian() : void
      {
         var _loc1_:TBaseEquip = null;
         var _loc2_:int = 0;
         var _loc3_:TStarPointDesc = null;
         var _loc4_:String = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,this.FCurrentIntensity.IDTemplate) as TBaseEquip;
         _loc2_ = 17500000 + _loc1_.MainType;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,_loc2_) as TStarPointDesc;
         this.FjichuAqianAttri.text = "+" + _loc1_.MainValue;
      }
      
      protected function Showjichuhou(param1:uint) : void
      {
         var _loc2_:TBaseEquip = null;
         var _loc3_:int = 0;
         var _loc4_:TStarPointDesc = null;
         var _loc5_:String = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseEquip,param1) as TBaseEquip;
         _loc3_ = 17500000 + _loc2_.MainType;
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_StarPointDesc,_loc3_) as TStarPointDesc;
         this.FjichuhouAttri.text = "+" + _loc2_.MainValue;
         this.FjichuAqianAttriname.text = _loc4_.Desc;
      }
      
      protected function ShowOldSuitAttri(param1:int) : void
      {
         var _loc2_:TSuit = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param1 > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,param1) as TSuit;
            _loc3_ = int(_loc2_.SuitEffects.length);
            _loc8_ = BASEATTRIBUTENAMES.indexOf(_loc2_.SuitEffects[0].Category[0]);
            _loc5_ = STRINGS_BASEATTRIBUTENAMES[_loc8_];
            _loc6_ = Number(_loc2_.SuitEffects[0].Value[0]);
            _loc6_ = _loc6_ * 100;
            _loc9_ = int(_loc6_);
            _loc7_ = String(_loc6_);
            if(_loc6_ != _loc9_)
            {
               _loc7_ = _loc6_.toFixed(1);
            }
            this.FOldAttri.text = "+" + _loc7_ + "%";
         }
      }
      
      protected function ShowNewSuitAttri(param1:int) : void
      {
         var _loc2_:TSuit = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(param1 > 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Suit,param1) as TSuit;
            _loc3_ = int(_loc2_.SuitEffects.length);
            _loc8_ = BASEATTRIBUTENAMES.indexOf(_loc2_.SuitEffects[0].Category[0]);
            _loc5_ = STRINGS_BASEATTRIBUTENAMES[_loc8_];
            _loc6_ = Number(_loc2_.SuitEffects[0].Value[0]);
            _loc6_ = _loc6_ * 100;
            _loc9_ = int(_loc6_);
            _loc7_ = String(_loc6_);
            if(_loc6_ != _loc9_)
            {
               _loc7_ = _loc6_.toFixed(1);
            }
            this.FNewAttri.text = "+" + _loc7_ + "%";
            this.FAttriName.text = _loc5_;
         }
      }
      
      protected function GetSlotCell() : TSoltCell
      {
         var _loc1_:TSoltCell = null;
         _loc1_ = new TSoltCell(this.parentPanel);
         _loc1_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         return _loc1_;
      }
      
      public function LingzhuBtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_PagingLingZu_LingZhuBtn]:
               if(this.IsCanClick && Boolean(this.FCurrentIntensity))
               {
                  this.FLingzhuBtnFunction(this.FCurrentIntensity,2);
               }
               break;
            case this.FMC_Selected:
               if(!this.FCurrentIntensity)
               {
                  return;
               }
               this.FMC_Selected.gotoAndStop(this.FMC_Selected.currentFrame == 1 ? 2 : 1);
               this.FMC_SelectedCurFream = this.FMC_Selected.currentFrame;
               this.LoadMaterial(this.FCurEquipUpgrade);
         }
      }
      
      public function AdvLingzhuBtnClick(param1:MouseEvent) : void
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
         this.FLingzhuBtnFunction(this.FCurrentIntensity,int(param2));
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(this.FIsInitilization)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FStuffVec.length)
            {
               this.FStuffVec[_loc1_].Update();
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < this.FUISltePreNext.length)
            {
               this.FUISltePreNext[_loc1_].Update();
               _loc1_++;
            }
         }
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
      
      public function set LingzhuBtnFunction(param1:Function) : void
      {
         this.FLingzhuBtnFunction = param1;
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
      
      public function setEffectPlay(param1:int) : void
      {
         if(param1)
         {
            this.FMc_Effect_LingZhu.gotoAndPlay(1);
         }
         else
         {
            this.FMc_Effect_LingZhu.gotoAndStop(1);
         }
      }
      
      public function VipLevelUpCheckBtnStatus() : void
      {
         if(this.FLingZhuPanel == null)
         {
            return;
         }
         if(SLogicsCore.Character.VipData.BuyOrnamentMaterial)
         {
            this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingLingZu_LingZhuBtn].visible = true;
         }
         else
         {
            this.FLingZhuPanel[CONST_ACCESSORY_INTENSITY.INTENSITY_AdvPagingLingZu_LingZhuBtn].visible = false;
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
         while(_loc3_ < this.FTempSelectInventoriesId.length)
         {
            _loc6_ = _loc5_.GetAllCountByTempletID(this.FTempSelectInventoriesId[_loc3_]);
            _loc7_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FTempSelectInventoriesId[_loc3_]) as TArticle;
            if(_loc7_.Identifier == this.FNormalItemId)
            {
               _loc9_ += Math.max(this.ExpendMaterialCount[_loc3_] - _loc6_,0) * _loc7_.GoldNumberA;
            }
            else
            {
               _loc9_ += Math.max(this.ExpendMaterialCount[_loc3_] - _loc6_ - (param2 ? this.FUniversalCount : 0),0) * _loc7_.GoldNumberA;
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
            _loc8_ = TUtilityString.Format(STRING_HEROS.STRING_Accessory_SureFilledUpgradeCopyAgine,_loc9_ - _loc12_,_loc9_,this.FCurrentIntensity.Name);
         }
         else
         {
            _loc8_ = TUtilityString.Format(STRING_HEROS.STRING_Accessory_SureFilledUpgradeCopy,SLogicsCore.KaguyaData.CurLevel,STRING_HEROS.GetDiscountValue(_loc11_),_loc12_,_loc9_ - _loc12_,_loc12_,this.FCurrentIntensity.Name);
         }
         return _loc8_;
      }
   }
}

