package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TEquipment;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TSuitEffect;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_OVERLAYEREQUIPMENT;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   
   public class TUIEquipDesc extends TUIComponent
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      public static const Ninja_Reincarnation_Logic_:int = CONST_COMMON.Ninja_Reincarnation_Logic_;
      
      protected static const CAPACITY_SuitEffects:uint = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUISlot:TUISlot;
      
      protected var FInventory:TInventory;
      
      protected var FInitialized:Boolean;
      
      protected var FNameFormat:TextFormat;
      
      protected var FOnQuerySequenceContext:Function;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnQuerySubscript:Function;
      
      public function TUIEquipDesc(param1:TUIComponent)
      {
         super(param1);
         this.FUISlot = new TUISlot(this);
         this.FNameFormat = new TextFormat();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.Resources_UIDispatchBox();
      }
      
      protected function Resources_UIDispatchBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         this.FUISlot.Resource = this.FMC_Scene["MC_Slot"] as Sprite;
         this.FUISlot.Resource.visible = false;
         this.FUISlot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.FUISlot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUISlot.OnQuerySubscript = this.SlotsOnQuerySubscript;
         this.FUISlot.OnOverlay = this.SlotsOnOver;
         this.FUISlot.OnOut = this.SlotsOnOut;
         this.FUISlot.Init();
      }
      
      protected function UpdateContext() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:TEquipment = null;
         var _loc9_:TSuitEffect = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:String = null;
         var _loc13_:String = null;
         _loc8_ = this.FInventory as TEquipment;
         this.FMC_Scene.TF_Name.text = this.FInventory.Name;
         this.FNameFormat.color = QUALITYCOLOR_INDEX[this.FInventory.Quality];
         this.FMC_Scene.TF_Name.setTextFormat(this.FNameFormat);
         if(_loc8_.RequirementLevel <= Ninja_Reincarnation_Logic_)
         {
            this.FMC_Scene.TF_Level.text = TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevel,_loc8_.RequirementLevel);
         }
         else
         {
            if(_loc8_.RequirementLevel - Ninja_Reincarnation_Logic_ > 50)
            {
               _loc5_ = CONST_COMMON.Ninja_Two_Reincarnation_Footstone;
            }
            else
            {
               _loc5_ = CONST_COMMON.Ninja_One_Reincarnation_Footstone;
            }
            _loc6_ = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(_loc5_ + _loc8_.RequirementLevel - Ninja_Reincarnation_Logic_);
            this.FMC_Scene.TF_Level.text = TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_RequirementLevelCopy,_loc8_.RequirementLevel,_loc6_);
         }
         _loc3_ = int(_loc8_.RequirementCareer.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc10_ = int(_loc8_.RequirementCareer[_loc1_]);
            _loc7_ = STRING_COMMON.TYPE_PROFESSIONS[_loc10_] + "  ";
            _loc1_++;
         }
         this.FMC_Scene.TF_Career.text = _loc7_;
         _loc1_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc8_.BasisPropertyCategory);
         this.FMC_Scene.TF_PropertyCategory.text = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc1_];
         this.FMC_Scene.TF_Property.text = _loc8_.BasisProperty.toString();
         this.FMC_Scene.TF_SuitName.text = TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_SuitCaption,_loc8_.SuitData.Name,_loc8_.SuitCount,_loc8_.SuitData.MaxCount);
         _loc1_ = 0;
         while(_loc1_ < CAPACITY_SuitEffects)
         {
            if(_loc8_.SuitData.SuitEffects.Count > 0)
            {
               _loc9_ = _loc8_.SuitData.SuitEffects.GetSuitEffectByIndex(_loc1_);
               _loc12_ = "";
               _loc4_ = int(_loc9_.Category.length);
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  if(_loc9_.Percentage[_loc2_] == 1)
                  {
                     _loc13_ = String((parseFloat(_loc9_.Value[_loc2_]) * 100).toFixed(0)) + "%";
                  }
                  else
                  {
                     _loc13_ = _loc9_.Value[_loc2_];
                  }
                  if(_loc9_.Category[_loc2_] == 102)
                  {
                     break;
                  }
                  _loc11_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc9_.Category[_loc2_]);
                  _loc12_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc11_] + "+" + _loc13_ + "\t";
                  _loc2_++;
               }
               _loc4_ = int(_loc9_.EffectDesc.length);
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  _loc12_ += "\n\t\t\t\t" + _loc9_.EffectDesc[_loc2_];
                  _loc2_++;
               }
               this.FMC_Scene["TF_SuitEffect" + _loc1_].text = TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_Suit_01,_loc9_.SuitQuantity,_loc12_);
            }
            else
            {
               this.FMC_Scene["TF_SuitEffect" + _loc1_].text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateSlot() : void
      {
         if(this.FInventory)
         {
            this.FUISlot.Context = this.FInventory;
            this.FUISlot.Resource.visible = true;
         }
         else
         {
            this.FUISlot.Context = null;
            this.FUISlot.Resource.visible = false;
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      public function get OnQuerySequenceContext() : Function
      {
         return this.FOnQuerySequenceContext;
      }
      
      public function set OnQuerySequenceContext(param1:Function) : void
      {
         this.FOnQuerySequenceContext = param1;
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnQuerySubscript() : Function
      {
         return this.FOnQuerySubscript;
      }
      
      public function set OnQuerySubscript(param1:Function) : void
      {
         this.FOnQuerySubscript = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(this.FInitialized && this.visible)
         {
            this.FUISlot.Update();
         }
      }
      
      public function UpdateUI(param1:TInventory) : void
      {
         this.FInventory = param1;
         this.UpdateContext();
         this.UpdateSlot();
      }
   }
}

