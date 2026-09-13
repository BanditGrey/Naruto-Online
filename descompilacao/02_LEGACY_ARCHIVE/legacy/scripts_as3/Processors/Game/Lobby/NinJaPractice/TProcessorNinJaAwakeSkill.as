package Processors.Game.Lobby.NinJaPractice
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorNinJaAwakeSkill extends TProcessorLobbyWindow
   {
      
      protected var FCurHero:THero;
      
      protected var FNinJaPractice:TProcessorNinJaPractice;
      
      protected var FReincarnationPanel:MovieClip;
      
      protected var FMC_Awake_Btn:MovieClip;
      
      protected var Slot:TUISlot;
      
      protected var Slot1:TUISlot;
      
      protected var SlotVector:Vector.<TUISlot> = new Vector.<TUISlot>();
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FMC_Buy_Material:MovieClip;
      
      protected var FTF_Material_Num0:TextField;
      
      protected var FTF_Material_Num1:TextField;
      
      protected var FReincarnationback:MovieClip = null;
      
      protected var FReincarnationbackScr:TextField = null;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FApplianceOnOver:Function;
      
      protected var FApplianceOnOut:Function;
      
      protected var FAwake_Btn_Func:Function;
      
      public function TProcessorNinJaAwakeSkill(param1:TUIComponent, param2:TProcessorNinJaPractice)
      {
         super(param1);
         this.FNinJaPractice = param2;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
      }
      
      public function Initiliztion() : void
      {
         this.FReincarnationPanel = this.FNinJaPractice.MC_AwakeSkill;
         this.FMC_Buy_Material = this.FReincarnationPanel["MC_Buy_Material"];
         this.FReincarnationback = this.FReincarnationPanel["MC_How_Turn_How_Level"];
         this.FReincarnationbackScr = this.FReincarnationback["TF_Scr"];
         this.FMC_Awake_Btn = this.FReincarnationPanel["MC_Reincarnation_Btn"];
         this.FTF_Material_Num0 = this.FReincarnationPanel["TF_Material_Num"];
         this.FTF_Material_Num1 = this.FReincarnationPanel["TF_Material_Num1"];
         this.Slot = new TUISlot(this);
         this.Slot.Resource = this.FReincarnationPanel["MC_ReincarnationStuff"] as MovieClip;
         this.Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.Slot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.Slot.OnOverlay = this.FApplianceOnOverF;
         this.Slot.OnOut = this.FApplianceOnOutF;
         this.Slot.Init();
         this.SlotVector.push(this.Slot);
         this.Slot1 = new TUISlot(this);
         this.Slot1.Resource = this.FReincarnationPanel["MC_ReincarnationStuff1"] as MovieClip;
         this.Slot1.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.Slot1.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.Slot1.OnOverlay = this.FApplianceOnOverF;
         this.Slot1.OnOut = this.FApplianceOnOutF;
         this.Slot1.Init();
         this.SlotVector.push(this.Slot1);
         TGameUtil.setButtonMode(this.FMC_Buy_Material,true);
         TGameUtil.setButtonMode(this.FMC_Awake_Btn,true);
         this.addEvent();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_NinJaPractice);
         }
      }
      
      protected function addEvent() : void
      {
         this.FMC_Awake_Btn.addEventListener(MouseEvent.CLICK,this.MaterialClick);
      }
      
      public function UpdateInterface(param1:THero) : void
      {
         this.FCurHero = param1;
         if(!this.FCurHero)
         {
            return;
         }
         this.UpdateAwakeDesc();
         this.UpdateSlot();
      }
      
      protected function UpdateAwakeDesc() : void
      {
         var _loc1_:TSkillConfig = null;
         var _loc2_:TBaseHero = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FCurHero.Identifier) as TBaseHero;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc2_.Active) as TSkillConfig;
         TextField(this.FReincarnationPanel["TF_Awake_Describe"]).text = _loc1_.Awakedesc;
         if(this.FCurHero.AwakeSkil == 1)
         {
            _loc4_ = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Awake_Skill);
         }
         else
         {
            _loc4_ = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Not_AwakeSkill);
         }
         this.FReincarnationbackScr.text = _loc4_;
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:TSkillConfig = null;
         var _loc2_:TBaseHero = null;
         var _loc3_:Object = null;
         var _loc5_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:int = 0;
         var _loc4_:Vector.<uint> = new Vector.<uint>();
         var _loc6_:Vector.<uint> = new Vector.<uint>();
         var _loc7_:int = 2;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,this.FCurHero.Identifier) as TBaseHero;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc2_.Active) as TSkillConfig;
         _loc3_ = _loc1_.AwakecostObject;
         if(_loc3_.length == 0)
         {
            this.Slot.Context = this.Slot1.Context = null;
            this.FTF_Material_Num0.text = this.FTF_Material_Num1.text = "";
         }
         else
         {
            for each(_loc8_ in _loc3_)
            {
               _loc4_.push(CONST_COMMON.GetItemIDByType(_loc8_.type,_loc8_.code,null));
               _loc6_.push(_loc8_.amount);
            }
            this.FSelectInventories.Clear();
            this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,_loc4_);
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               if(_loc9_ < this.FSelectInventories.Count)
               {
                  this.SlotVector[_loc9_].Context = this.FSelectInventories.GetInventoryByIndex(_loc9_);
                  this["FTF_Material_Num" + _loc9_].text = this.getInventoryCountById(_loc9_) + "/" + _loc6_[_loc9_];
                  this["FTF_Material_Num" + _loc9_].textColor = this.getInventoryCountById(_loc9_) >= _loc6_[_loc9_] ? 26112 : 16711680;
               }
               else
               {
                  this.SlotVector[_loc9_].Context = null;
                  this["FTF_Material_Num" + _loc9_].text = "";
               }
               _loc9_++;
            }
         }
      }
      
      protected function getInventoryCountById(param1:int) : int
      {
         var _loc2_:TInventory = this.FSelectInventories.GetInventoryByIndex(param1);
         var _loc3_:TInventories = SLogicsCore.Character.Appliances;
         if(_loc2_.IDTemplate == 14100061)
         {
            return SLogicsCore.Character.HeroSoulBlueSoul;
         }
         if(_loc2_.IDTemplate == 14100062)
         {
            return SLogicsCore.Character.HeroSoulPurpleSoul;
         }
         if(_loc2_.IDTemplate == 14100063)
         {
            return SLogicsCore.Character.HeroSoulGoldSoul;
         }
         if(_loc2_.IDTemplate == 14100064)
         {
            return SLogicsCore.Character.HeroSoulOrangeSoul;
         }
         if(_loc2_.IDTemplate == 14107059 || _loc2_.IDTemplate == 14107060 || _loc2_.IDTemplate == 14107061 || _loc2_.IDTemplate == 14107062)
         {
            return _loc3_.GetAllCountByTempletID(_loc2_.IDTemplate) + _loc3_.GetAllCountByTempletID(14107058);
         }
         return _loc3_.GetAllCountByTempletID(_loc2_.IDTemplate);
      }
      
      public function LogicPerform() : void
      {
         this.Slot.Update();
         this.Slot1.Update();
      }
      
      public function MaterialClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Buy_Material:
               if(this.FOnShortcutHyperlinks != null)
               {
                  this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Mall,5);
               }
               break;
            case this.FMC_Awake_Btn:
               if(this.FAwake_Btn_Func != null)
               {
                  this.FAwake_Btn_Func();
               }
         }
      }
      
      public function FApplianceOnOverF(param1:Object, param2:Object) : void
      {
         if(this.FApplianceOnOver != null)
         {
            this.FApplianceOnOver(param1,param2);
         }
      }
      
      public function FApplianceOnOutF(param1:Object, param2:Object) : void
      {
         if(this.FApplianceOnOut != null)
         {
            this.FApplianceOnOut(param1,param2);
         }
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set ApplianceOnOver(param1:Function) : void
      {
         this.FApplianceOnOver = param1;
      }
      
      public function get ApplianceOnOver() : Function
      {
         return this.FApplianceOnOver;
      }
      
      public function set ApplianceOnOut(param1:Function) : void
      {
         this.FApplianceOnOut = param1;
      }
      
      public function get ApplianceOnOut() : Function
      {
         return this.FApplianceOnOut;
      }
      
      public function set Awake_Btn_Func(param1:Function) : void
      {
         this.FAwake_Btn_Func = param1;
      }
   }
}

