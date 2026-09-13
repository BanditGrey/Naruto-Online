package Processors.Game.Lobby.NarutoRoad.Components
{
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.NarutoRoad.TObligatoryCourses;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TNarutoRoadObligatory extends TUIComponent
   {
      
      protected var FObligatoryId:uint;
      
      protected var FObligatoryCount:uint;
      
      protected var FNarutoRoadDayTask:TNarutoRoadDayTask;
      
      protected var FMC_Scene:Sprite;
      
      protected var FMC_Icon:MovieClip;
      
      protected var FTF_Caption:TextField;
      
      protected var FTF_Info:TextField;
      
      protected var FBTN_Goto:MovieClip;
      
      protected var FFightGoto:Function;
      
      public function TNarutoRoadObligatory(param1:TUIComponent)
      {
         super(param1);
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_NARUTOROAD.RESOURCE_ClassName_MC_ObligatoryCourseItem) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_Icon = this.FMC_Scene["MC_Icon"];
         this.FTF_Caption = this.FMC_Scene["TF_Caption"];
         this.FTF_Info = this.FMC_Scene["TF_Info"];
         this.FBTN_Goto = this.FMC_Scene["BTN_Goto"];
         TGameUtil.setButtonMode(this.FBTN_Goto,true);
         this.FBTN_Goto.addEventListener(MouseEvent.CLICK,this.OnGotoTarget);
      }
      
      protected function OnGotoTarget(param1:MouseEvent) : void
      {
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FFightGoto != null)
         {
            this.FFightGoto(this,this.FNarutoRoadDayTask.Isgoto);
         }
      }
      
      public function get FightGoto() : Function
      {
         return this.FFightGoto;
      }
      
      public function set FightGoto(param1:Function) : void
      {
         this.FFightGoto = param1;
      }
      
      public function SetObligatory(param1:TObligatoryCourses) : void
      {
         this.FObligatoryId = param1.NarutoRoadDayId;
         this.FObligatoryCount = param1.NarutoRoadDayCount;
         this.FNarutoRoadDayTask = param1.NarutoRoadDayTask;
      }
      
      public function UpdataUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         this.FMC_Icon.gotoAndStop(this.FNarutoRoadDayTask.Picture);
         this.FTF_Caption.text = this.FNarutoRoadDayTask.Name;
         if(this.FNarutoRoadDayTask.Accept <= SLogicsCore.Character.GetMainLevel())
         {
            _loc1_ = TUtilityString.Format(this.FNarutoRoadDayTask.Description,this.FObligatoryCount);
            this.FMC_Scene.filters = [];
            TGameUtil.setButtonMode(this.FBTN_Goto,true);
         }
         else
         {
            _loc1_ = STRING_COMMON.COMMON_OPENLEVELTIP;
            if(this.FNarutoRoadDayTask.Accept >= 1000)
            {
               _loc2_ = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevelCopy(this.FNarutoRoadDayTask.Accept);
            }
            else
            {
               _loc2_ = this.FNarutoRoadDayTask.Accept.toString();
            }
            _loc1_ = _loc1_.split("%count%").join(_loc2_);
            this.FMC_Scene.filters = [TGameUtil.rBlackFilters];
            TGameUtil.setButtonMode(this.FBTN_Goto,false);
         }
         if(this.FObligatoryCount <= 0)
         {
            this.FMC_Scene.filters = [TGameUtil.rBlackFilters];
            TGameUtil.setButtonMode(this.FBTN_Goto,false);
         }
         this.FTF_Info.text = _loc1_;
      }
   }
}

