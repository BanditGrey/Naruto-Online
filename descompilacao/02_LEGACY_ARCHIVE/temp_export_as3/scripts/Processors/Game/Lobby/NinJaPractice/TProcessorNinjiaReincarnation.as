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
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Strings.STRING_NINJIAREINCARNATION;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorNinjiaReincarnation extends TProcessorLobbyWindow
   {
      
      public static const Four:int = 4;
      
      protected var FNinJaPractice:TProcessorNinJaPractice = null;
      
      protected var FCurHero:THero = null;
      
      protected var FReincarnationPanel:MovieClip = null;
      
      protected var FMC_Buy_Material:MovieClip = null;
      
      protected var FMC_Reincarnation_Btn:MovieClip = null;
      
      protected var FMC_Replace:MovieClip = null;
      
      protected var FBtn_GetReward:MovieClip = null;
      
      protected var FBtn_Ignore_Btn:MovieClip = null;
      
      protected var FReincarnationback:MovieClip = null;
      
      protected var FReincarnationbackScr:TextField = null;
      
      protected var FReincarnationbefor:MovieClip = null;
      
      protected var FReincarnationbeforScr:TextField = null;
      
      protected var FTF_Talent_Name:TextField = null;
      
      protected var FTF_Talent_Describe:TextField = null;
      
      protected var FTF_Material_Num:TextField = null;
      
      protected var FTempMachampId:int = 0;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FReincarnationBaseData:ReincarnationBaseData = null;
      
      protected var Slot:TUISlot = null;
      
      protected var FIsInitilization:int;
      
      protected var FOnShortcutHyperlinks:Function = null;
      
      protected var FApplianceOnOver:Function = null;
      
      protected var FApplianceOnOut:Function = null;
      
      protected var FTalentMoveF:Function = null;
      
      protected var FTalentOutF:Function = null;
      
      protected var FReincarnation_Btn_Func:Function = null;
      
      protected var FReplace_Btn_Func:Function = null;
      
      protected var FGetReward_Btn_Func:Function = null;
      
      public function TProcessorNinjiaReincarnation(param1:TUIComponent, param2:TProcessorNinJaPractice, param3:ReincarnationBaseData)
      {
         super(param1);
         this.FNinJaPractice = param2;
         this.FReincarnationBaseData = param3;
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FSelectInventories = new TInventories();
         this.FTempSelectInventoriesId = new Vector.<uint>(2);
      }
      
      public function Initiliztion() : void
      {
         this.FTempSelectInventoriesId[0] = this.FReincarnationBaseData.ReinCarnationNeedStuffId;
         this.FTempSelectInventoriesId[1] = this.FReincarnationBaseData.ReinCarnationNeedStuffIdThree;
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.FReincarnationPanel = this.FNinJaPractice.MC_Reincarnation;
         this.FMC_Buy_Material = this.FReincarnationPanel["MC_Buy_Material"];
         this.FReincarnationback = this.FReincarnationPanel["MC_How_Turn_How_Level"];
         this.FReincarnationbackScr = this.FReincarnationback["TF_Scr"];
         this.FReincarnationbefor = this.FReincarnationPanel["MC_Turn_Level"];
         this.FReincarnationbeforScr = this.FReincarnationbefor["TF_Scr"];
         this.FMC_Reincarnation_Btn = this.FReincarnationPanel["MC_Reincarnation_Btn"];
         this.FMC_Replace = this.FReincarnationPanel["MC_Replace"];
         this.FBtn_GetReward = this.FReincarnationPanel["Btn_GetReward"];
         this.FBtn_Ignore_Btn = this.FReincarnationPanel["Btn_Ignore_Btn"];
         this.FTF_Material_Num = this.FReincarnationPanel["TF_Material_Num"];
         this.FTF_Talent_Name = this.FReincarnationPanel["TF_Talent_Name"];
         this.FTF_Talent_Describe = this.FReincarnationPanel["TF_Talent_Describe"];
         this.Slot = new TUISlot(this);
         this.Slot.Resource = this.FReincarnationPanel["MC_ReincarnationStuff"] as MovieClip;
         this.Slot.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
         this.Slot.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.Slot.OnOverlay = this.FApplianceOnOverF;
         this.Slot.OnOut = this.FApplianceOnOutF;
         this.Slot.Init();
         TGameUtil.setButtonMode(this.FMC_Buy_Material,true);
         TGameUtil.setButtonMode(this.FMC_Reincarnation_Btn,true);
         TGameUtil.setButtonMode(this.FMC_Replace,true);
         TGameUtil.setButtonMode(this.FBtn_GetReward,true);
         TGameUtil.setButtonMode(this.FBtn_Ignore_Btn,true);
         this.addEvent();
         this.FIsInitilization = 1;
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
      
      public function YouHuaBtnState() : void
      {
         if(this.FCurHero.Level >= 120)
         {
            TGameUtil.setButtonMode(this.FMC_Reincarnation_Btn,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Reincarnation_Btn,false);
         }
         if(this.FCurHero.Level >= this.FReincarnationBaseData.LevelNeedThree && this.FCurHero.ReincarnationOneOrTwo == 2)
         {
            this.FReincarnationbeforScr.text = TUtilityString.Format(STRING_NINJIAREINCARNATION.STRING_TurnBackLevel,this.FCurHero.GetLevelStrByLevel(this.FCurHero.GetThreeTurnLevel()));
         }
         else if(this.FCurHero.Level >= this.FReincarnationBaseData.LevelNeedTwo && this.FCurHero.ReincarnationOneOrTwo == 1)
         {
            this.FReincarnationbeforScr.text = TUtilityString.Format(STRING_NINJIAREINCARNATION.STRING_TurnBackLevel,this.FCurHero.GetLevelStrByLevel(this.FCurHero.GetTwoTurnLevel()));
         }
         else if(this.FCurHero.Level >= this.FReincarnationBaseData.LevelNeedOne && this.FCurHero.ReincarnationOneOrTwo == 0)
         {
            this.FReincarnationbeforScr.text = TUtilityString.Format(STRING_NINJIAREINCARNATION.STRING_TurnBackLevel,this.FCurHero.GetLevelStrByLevel(this.FCurHero.GetOneTurnLevel()));
         }
         else
         {
            this.FReincarnationbeforScr.text = STRING_NINJIAREINCARNATION.STRING_LevelLimit;
         }
      }
      
      protected function addEvent() : void
      {
         this.FMC_Buy_Material.addEventListener(MouseEvent.CLICK,this.MaterialClick);
         this.FMC_Reincarnation_Btn.addEventListener(MouseEvent.CLICK,this.MaterialClick);
         this.FMC_Replace.addEventListener(MouseEvent.CLICK,this.MaterialClick);
         this.FBtn_GetReward.addEventListener(MouseEvent.CLICK,this.MaterialClick);
         this.FBtn_Ignore_Btn.addEventListener(MouseEvent.CLICK,this.MaterialClick);
         this.FTF_Talent_Name.addEventListener(MouseEvent.MOUSE_MOVE,this.TalentMove);
         this.FTF_Talent_Name.addEventListener(MouseEvent.MOUSE_OUT,this.TalentOut);
         this.FTF_Talent_Describe.addEventListener(MouseEvent.MOUSE_MOVE,this.TalentMove);
         this.FTF_Talent_Describe.addEventListener(MouseEvent.MOUSE_OUT,this.TalentOut);
      }
      
      public function UpdateInterface(param1:THero) : void
      {
         this.FCurHero = param1;
         if(!this.FCurHero)
         {
            return;
         }
         this.YouHuaBtnState();
         this.judgeIsReincarnation();
         this.UpdateProperty();
         this.UpdateSkill();
         this.UpdateMachamp();
         this.UpdateStuffCount();
         this.UpdateItem();
      }
      
      public function UpdateInterface_for_Machamp() : void
      {
         if(!this.FCurHero)
         {
            return;
         }
         this.UpdateMachamp();
      }
      
      protected function UpdateStuffCount() : void
      {
         var _loc1_:int = 0;
         switch(this.FCurHero.ReincarnationOneOrTwo)
         {
            case 0:
               _loc1_ = this.FReincarnationBaseData.StuffNeedOne;
               break;
            case 1:
               _loc1_ = this.FReincarnationBaseData.StuffNeedTwo;
               break;
            case 2:
               _loc1_ = this.FReincarnationBaseData.StuffNeedThree;
         }
         if(_loc1_ <= this.getInventoryById())
         {
            this.FTF_Material_Num.textColor = 26112;
         }
         else
         {
            this.FTF_Material_Num.textColor = 16711680;
         }
         this.FTF_Material_Num.text = this.getInventoryById() + "/" + _loc1_;
      }
      
      protected function UpdateMachamp() : void
      {
         if(this.FCurHero.TempMachampId != 0)
         {
            this.FReincarnationBaseData.MachampId = this.FCurHero.TempMachampId;
         }
         else
         {
            this.FReincarnationBaseData.MachampId = this.FCurHero.MachampId;
         }
         this.FTF_Talent_Name.text = this.FReincarnationBaseData.MachampName;
         this.FTF_Talent_Describe.text = this.FReincarnationBaseData.MachampDescribe;
      }
      
      protected function UpdateSkill() : void
      {
         TextField(this.FReincarnationPanel["TF_Skill_Name"]).text = this.FReincarnationBaseData.SkillName;
         TextField(this.FReincarnationPanel["TF_Middle_Describe"]).htmlText = this.FCurHero.AwakeSkil == 1 ? this.FReincarnationBaseData.AwakeDescReincarnation : this.FReincarnationBaseData.SkillOpenLevel + this.FReincarnationBaseData.SkillDesReincarnation.split("%n").join("");
      }
      
      protected function UpdateProperty() : void
      {
         var _loc1_:int = 0;
         if(this.FReincarnationBaseData.NinjaVariousGrowthRate.length == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < Four)
            {
               TextField(this.FReincarnationPanel["TF_Property_0" + _loc1_]).text = "";
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.FReincarnationBaseData.NinjaVariousGrowthRate.length)
            {
               TextField(this.FReincarnationPanel["TF_Property_0" + _loc1_]).text = String(this.FReincarnationBaseData.NinjaVariousGrowthRate[_loc1_]);
               _loc1_++;
            }
         }
         if(this.FReincarnationBaseData.NinjaAfterGrowthRate.length == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < Four)
            {
               TextField(this.FReincarnationPanel["TF_Property_1" + _loc1_]).text = "";
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.FReincarnationBaseData.NinjaAfterGrowthRate.length)
            {
               TextField(this.FReincarnationPanel["TF_Property_1" + _loc1_]).text = String(this.FReincarnationBaseData.NinjaAfterGrowthRate[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      protected function judgeIsReincarnation() : void
      {
         this.FReincarnationbackScr.text = this.FCurHero.GetLevelStrByLevel(this.FCurHero.Level);
         this.FReincarnationback.visible = true;
      }
      
      public function LogicPerform() : void
      {
         if(this.FIsInitilization)
         {
            this.Slot.Update();
         }
      }
      
      public function OpenThisPanel() : void
      {
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
            case this.FMC_Reincarnation_Btn:
               if(this.FReincarnation_Btn_Func != null)
               {
                  this.FReincarnation_Btn_Func();
               }
               break;
            case this.FMC_Replace:
               if(this.FReplace_Btn_Func != null)
               {
                  this.FReplace_Btn_Func();
               }
               break;
            case this.FBtn_GetReward:
               if(this.FGetReward_Btn_Func != null)
               {
                  this.FGetReward_Btn_Func(1);
               }
               break;
            case this.FBtn_Ignore_Btn:
               if(this.FGetReward_Btn_Func != null)
               {
                  this.FGetReward_Btn_Func(2);
               }
         }
      }
      
      public function setBtnVisibel(param1:int) : void
      {
         this.FBtn_GetReward.visible = false;
         this.FBtn_Ignore_Btn.visible = false;
         this.FMC_Replace.visible = false;
         if(param1 == 1)
         {
            this.FBtn_GetReward.visible = true;
         }
         else
         {
            this.FBtn_Ignore_Btn.visible = true;
            this.FMC_Replace.visible = true;
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
      
      public function set Reincarnation_Btn_Func(param1:Function) : void
      {
         this.FReincarnation_Btn_Func = param1;
      }
      
      public function set Replace_Btn_Func(param1:Function) : void
      {
         this.FReplace_Btn_Func = param1;
      }
      
      public function get Reincarnation_Btn_Func() : Function
      {
         return this.FReincarnation_Btn_Func;
      }
      
      public function get Replace_Btn_Func() : Function
      {
         return this.FReplace_Btn_Func;
      }
      
      protected function TalentMove(param1:MouseEvent) : void
      {
         if(this.FTalentMoveF != null)
         {
            this.FTalentMoveF(param1);
         }
      }
      
      protected function TalentOut(param1:MouseEvent) : void
      {
         if(this.FTalentOutF != null)
         {
            this.FTalentOutF(param1);
         }
      }
      
      public function set TalentMoveF(param1:Function) : void
      {
         this.FTalentMoveF = param1;
      }
      
      public function get TalentMoveF() : Function
      {
         return this.FTalentMoveF;
      }
      
      public function set TalentOutF(param1:Function) : void
      {
         this.FTalentOutF = param1;
      }
      
      public function get TalentOutF() : Function
      {
         return this.FTalentOutF;
      }
      
      public function set GetReward_Btn_Func(param1:Function) : void
      {
         this.FGetReward_Btn_Func = param1;
      }
      
      public function get GetReward_Btn_Func() : Function
      {
         return this.FGetReward_Btn_Func;
      }
      
      public function get TempMachampId() : int
      {
         return this.FTempMachampId;
      }
      
      public function set TempMachampId(param1:int) : void
      {
         this.FTempMachampId = param1;
      }
      
      protected function getInventoryById() : int
      {
         var _loc1_:TInventories = SLogicsCore.Character.Appliances;
         if(this.FCurHero.ReincarnationOneOrTwo < 2)
         {
            return _loc1_.GetAllCountByTempletID(this.FSelectInventories.GetInventoryByIndex(0).IDTemplate);
         }
         return _loc1_.GetAllCountByTempletID(this.FSelectInventories.GetInventoryByIndex(1).IDTemplate);
      }
      
      public function SlotReset() : void
      {
         if(this.Slot)
         {
            this.Slot.Context = null;
         }
      }
      
      protected function UpdateItem() : void
      {
         if(this.FCurHero.ReincarnationOneOrTwo < 2)
         {
            this.Slot.Context = this.FSelectInventories.GetInventoryByIndex(0);
         }
         else
         {
            this.Slot.Context = this.FSelectInventories.GetInventoryByIndex(1);
         }
      }
   }
}

