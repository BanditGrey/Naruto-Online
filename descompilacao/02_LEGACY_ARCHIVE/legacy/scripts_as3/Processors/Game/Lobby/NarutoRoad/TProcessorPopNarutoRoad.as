package Processors.Game.Lobby.NarutoRoad
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.NarutoRoad.*;
   import Processors.Game.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.*;
   
   public class TProcessorPopNarutoRoad extends TProcessorGame
   {
      
      protected static const TASK_Lock:int = 0;
      
      protected static const TASK_Going:int = 1;
      
      protected static const TASK_FINISH:int = 2;
      
      protected static const INIT_SCENE_WIDTH:int = 207;
      
      protected static const INIT_SCENE_HEIGHT:int = 340;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_View:MovieClip;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FTF_Context:TextField;
      
      protected var FBtn_Close:MovieClip;
      
      protected var FBtn_Open:MovieClip;
      
      protected var FCurNarutoRoadTask:TNarutoRoadMission;
      
      protected var FOnOpenView:Function;
      
      public function TProcessorPopNarutoRoad(param1:TUIComponent)
      {
         super(param1);
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_GrowRoadTip) as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["MC_Close"];
         this.FBtn_Open = this.FMC_Scene["MC_Open"];
         this.FMC_Scene.y = INIT_SCENE_HEIGHT;
         this.FMC_Scene.x = FUICore.StageWidth;
         this.FMC_Scene.buttonMode = true;
         this.FMC_View = this.FMC_Scene["MC_View"];
         this.FMC_Effect = this.FMC_View["MC_Effect"];
         this.FMC_Effect.gotoAndStop(1);
         this.FMC_Icon = this.FMC_View["MC_Icon"];
         this.FTF_Title = this.FMC_View["TF_Title"];
         this.FTF_Context = this.FMC_View["TF_Context"];
         this.FMC_Scene.visible = false;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_View.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenView);
         this.FMC_View.addEventListener(MouseEvent.ROLL_OVER,this.ProcessorOnOver);
         this.FMC_View.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnOut);
         if(this.FBtn_Close != null)
         {
            TGameUtil.setButtonMode(this.FBtn_Close,true);
            this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnHidePop);
         }
         if(this.FBtn_Open != null)
         {
            TGameUtil.setButtonMode(this.FBtn_Open,true);
            this.FBtn_Open.addEventListener(MouseEvent.CLICK,this.OnShowPop);
         }
         super.ResourcesPerform_UILocations();
      }
      
      protected function PlayEffect(param1:Boolean) : void
      {
         if(param1)
         {
            this.FMC_Effect.visible = true;
            this.FMC_Effect.gotoAndPlay(1);
         }
         else
         {
            this.FMC_Effect.visible = false;
            this.FMC_Effect.stop();
         }
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TNarutoRoadTask = null;
         this.FCurNarutoRoadTask = SLogicsCore.NarutoRoadData.GetCurrShowTaskById();
         if(!this.FMC_Scene)
         {
            return;
         }
         if(this.FCurNarutoRoadTask != null)
         {
            _loc1_ = this.FCurNarutoRoadTask.NarutoRoadTask;
            this.FMC_Icon.gotoAndStop(_loc1_.Picture);
            this.FTF_Title.text = _loc1_.Name;
            if(this.FCurNarutoRoadTask.MissionStatus == TASK_FINISH)
            {
               this.FMC_Scene.filters = [];
               this.FTF_Context.text = _loc1_.Description + STRING_NARUTOROAD.STRING_COMPLETE;
               this.PlayEffect(true);
            }
            else if(this.FCurNarutoRoadTask.MissionStatus == TASK_Going)
            {
               this.FMC_Scene.filters = [];
               this.FTF_Context.text = _loc1_.Description;
               this.PlayEffect(false);
            }
            else
            {
               this.FMC_Scene.filters = [TGameUtil.GaryColorFilters];
               this.FTF_Context.text = _loc1_.Description;
               this.PlayEffect(false);
            }
         }
         else
         {
            this.FMC_Scene.visible = false;
         }
      }
      
      protected function ProcessorOnOver(param1:MouseEvent) : void
      {
         this.FMC_Scene.gotoAndStop(2);
      }
      
      protected function ProcessorOnOut(param1:MouseEvent) : void
      {
         this.FMC_Scene.gotoAndStop(1);
      }
      
      protected function ProcessorOnOpenView(param1:MouseEvent) : void
      {
         var _loc2_:ByteArray = null;
         if(this.FCurNarutoRoadTask == null)
         {
            return;
         }
         _loc2_ = new ByteArray();
         _loc2_.writeUnsignedInt(0);
         _loc2_.writeUnsignedInt(this.FCurNarutoRoadTask.NarutoRoadTask.Type);
         _loc2_.writeUnsignedInt(this.FCurNarutoRoadTask.Identifier);
         _loc2_.position = 0;
         if(this.FOnOpenView != null)
         {
            this.FOnOpenView(this,_loc2_);
         }
      }
      
      protected function OnHidePop(param1:MouseEvent) : void
      {
         this.Hide();
      }
      
      protected function OnShowPop(param1:MouseEvent) : void
      {
         this.Show();
      }
      
      public function get OnOpenView() : Function
      {
         return this.FOnOpenView;
      }
      
      public function set OnOpenView(param1:Function) : void
      {
         this.FOnOpenView = param1;
      }
      
      public function set ViewVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
      
      public function Show() : void
      {
         if(this.FBtn_Open)
         {
            this.FBtn_Open.visible = false;
         }
         if(this.FBtn_Close)
         {
            this.FBtn_Close.visible = true;
         }
         this.UpdateUI();
         if(this.FCurNarutoRoadTask == null)
         {
            Visible = false;
            this.FMC_Scene.visible = false;
            return;
         }
         if(SLogicsCore.Character.RoleSencePosition != CONST_COMMON.SCENEPOSITION_MAINCITY)
         {
            return;
         }
         TweenUtil.to(this.FMC_Scene,500,{"x":FUICore.StageWidth - INIT_SCENE_WIDTH});
      }
      
      public function Hide() : void
      {
         this.FBtn_Open.visible = true;
         this.FBtn_Close.visible = false;
         TweenUtil.to(this.FMC_Scene,500,{"x":1222});
      }
   }
}

