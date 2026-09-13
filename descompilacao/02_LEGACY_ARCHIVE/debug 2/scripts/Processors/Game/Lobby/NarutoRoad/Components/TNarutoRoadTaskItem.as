package Processors.Game.Lobby.NarutoRoad.Components
{
   import Foundation.Common.Stubs.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.*;
   import Logics.NarutoRoad.*;
   import Logics.Unlocks.*;
   import Processors.Game.Common.Effects.Display.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TNarutoRoadTaskItem extends TUIComponent
   {
      
      public static const FFilterColor:int = 16777113;
      
      public static const FilterGlowWidth:int = 4;
      
      public static const FilterGlowStrength:int = 20;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_ICON:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_Context:TextField;
      
      protected var FMC_Get:MovieClip;
      
      protected var FMC_GetVip:MovieClip;
      
      protected var FMC_Got:MovieClip;
      
      private var FMC_Selected:MovieClip;
      
      protected var FMissionData:TNarutoRoadMission;
      
      protected var FCharacter:TCharacter;
      
      protected var FOnTaskUp:Function;
      
      protected var FIsSelected:Boolean;
      
      protected var FStubReferences:TStubReferences;
      
      public function TNarutoRoadTaskItem(param1:TUIComponent)
      {
         super(param1);
         this.Initialization();
      }
      
      protected function Initialization() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NARUTOROAD.RESOURCE_Link_MC_GrowRoadTab) as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.gotoAndStop("up");
         this.FMC_ICON = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_ICON];
         this.FTF_Title = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_TF_Title];
         this.FTF_Context = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_TF_Context];
         this.FMC_Get = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_Get];
         this.FMC_GetVip = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_GetVip];
         this.FMC_Got = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_Link_MC_Got];
         this.FMC_Selected = this.FMC_Scene[CONST_NARUTOROAD.RESOURCE_LINK_MC_Selected];
         this.FMC_Selected.visible = false;
         this.FCharacter = SLogicsCore.Character;
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
         this.FMC_Scene.addEventListener(MouseEvent.CLICK,this.ProcessorOnTaskUp);
         this.FMC_Scene.addEventListener(MouseEvent.ROLL_OVER,this.ProcessorOnTaskOver);
         this.FMC_Scene.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTaskOut);
      }
      
      protected function ProcessorOnTaskUp(param1:MouseEvent) : void
      {
         if(this.FIsSelected)
         {
            return;
         }
         if(this.FOnTaskUp != null)
         {
            this.FOnTaskUp(this,this.FMissionData);
         }
         this.FIsSelected = true;
         this.FMC_Selected.visible = true;
      }
      
      protected function ProcessorOnTaskOver(param1:MouseEvent) : void
      {
         if(this.FIsSelected)
         {
            return;
         }
         param1.currentTarget.gotoAndStop("over");
      }
      
      protected function ProcessorOnTaskOut(param1:MouseEvent) : void
      {
         if(this.FIsSelected)
         {
            return;
         }
         param1.currentTarget.gotoAndStop("up");
      }
      
      protected function CheckBigDipperIsOpen() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:TConfigValue = null;
         var _loc3_:uint = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.SERVENSTAR_OPEN_LEVEL) as TConfigValue;
         _loc3_ = _loc2_.Value as uint;
         var _loc4_:uint = uint(SLogicsCore.Character.GetMainLevel());
         if(_loc4_ >= _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function get MissionData() : TNarutoRoadMission
      {
         return this.FMissionData;
      }
      
      public function set MissionData(param1:TNarutoRoadMission) : void
      {
         this.FMissionData = param1;
      }
      
      public function get OnTaskUp() : Function
      {
         return this.FOnTaskUp;
      }
      
      public function set OnTaskUp(param1:Function) : void
      {
         this.FOnTaskUp = param1;
      }
      
      public function get IsSelected() : Boolean
      {
         return this.FIsSelected;
      }
      
      public function set IsSelected(param1:Boolean) : void
      {
         this.FIsSelected = param1;
         this.FMC_Selected.visible = this.FIsSelected;
         if(this.FIsSelected)
         {
            this.FMC_Scene.gotoAndStop("over");
         }
         else
         {
            this.FMC_Scene.gotoAndStop("up");
         }
      }
      
      public function Update() : void
      {
         var _loc1_:String = null;
         var _loc2_:TNarutoRoadTask = null;
         if(this.FMissionData != null)
         {
            _loc2_ = this.FMissionData.NarutoRoadTask;
            this.FMC_ICON.gotoAndStop(_loc2_.Picture);
            this.FTF_Title.text = _loc2_.Name;
            this.FMC_Got.visible = false;
            this.FMC_Get.visible = false;
            this.FMC_GetVip.visible = false;
            if(this.FMissionData.MissionStatus == 0)
            {
               _loc1_ = _loc2_.TaskLocked;
               this.filters = [TGameUtil.GaryColorFilters];
            }
            else if(this.FMissionData.MissionStatus == 1)
            {
               _loc1_ = TUtilityString.Format(_loc2_.TaskTarget,this.FMissionData.MissionCount);
               this.filters = [];
            }
            else if(this.FMissionData.MissionStatus == 2)
            {
               if(this.FMissionData.HasReward())
               {
                  this.FMC_Get.visible = true;
                  this.FMC_Get.play();
               }
               else if(this.FMissionData.HasRewardVip())
               {
                  this.FMC_GetVip.visible = true;
                  this.FMC_GetVip.play();
               }
               else
               {
                  this.FMC_Got.visible = true;
                  this.FMC_Got.play();
               }
               _loc1_ = TUtilityString.Format(_loc2_.TaskTarget,this.FMissionData.MissionCount);
               this.filters = [];
            }
            this.FTF_Context.text = _loc1_;
         }
      }
   }
}

