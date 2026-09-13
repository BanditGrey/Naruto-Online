package Processors.Game.Lobby.DailyQuest.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Dailytask.TDailytask;
   import Logics.Dailytask.TQuestDaily;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DAILY_QUEST;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUITaskList extends TUIComponent
   {
      
      protected static const MAX_COUNT:int = 5;
      
      protected var FScene:MovieClip;
      
      protected var FMC_BmpIcon:Sprite;
      
      protected var FMC_BmpIcons:Vector.<Bitmap>;
      
      protected var FMC_Tag:MovieClip;
      
      protected var FMC_SelectedBox:Sprite;
      
      protected var FMC_Bmp_IconHighLight:Sprite;
      
      protected var FTaskLists:Vector.<TQuestDaily>;
      
      protected var FDailytask:TDailytask;
      
      protected var FSeleceds:Vector.<Sprite>;
      
      protected var FTags:Vector.<MovieClip>;
      
      protected var FMCs:Vector.<Sprite>;
      
      protected var FTaskOnClick:Function;
      
      protected var FTaskOnOver:Function;
      
      protected var FTaskOnOut:Function;
      
      protected var FTutorialNextStep:Function;
      
      public function TUITaskList(param1:TUIComponent, param2:MovieClip)
      {
         super(param1);
         this.FScene = param2;
         this.FTaskLists = new Vector.<TQuestDaily>(MAX_COUNT);
         this.FMCs = new Vector.<Sprite>(MAX_COUNT);
         this.FMC_BmpIcons = new Vector.<Bitmap>(MAX_COUNT);
         this.FDailytask = SLogicsCore.Character.DailyTask;
         this.InitTaskList();
      }
      
      protected function InitTaskList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Bitmap = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FScene[CONST_DAILY_QUEST.RESOURCE_Link_MC_RefreshTasks + _loc1_];
            _loc2_.buttonMode = true;
            this.FMC_BmpIcon = _loc2_[CONST_DAILY_QUEST.RESOURCE_Link_MC_Bmp_Icon];
            this.FMC_Tag = _loc2_[CONST_DAILY_QUEST.RESOURCE_Link_MC_Tag];
            this.FMC_Tag.visible = false;
            _loc3_ = new Bitmap();
            this.FMC_BmpIcons[_loc1_] = _loc3_;
            this.FMC_BmpIcon.addChild(_loc3_);
            this.FMC_SelectedBox = _loc2_[CONST_DAILY_QUEST.RESOURCE_Link_MC_SelectedBox];
            this.FMC_Bmp_IconHighLight = _loc2_[CONST_DAILY_QUEST.RESOURCE_Link_MC_Bmp_IconHighLight];
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.OnOver);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.OnOut);
            _loc2_.addEventListener(MouseEvent.CLICK,this.OnClick);
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMove);
            this.FMC_Bmp_IconHighLight.visible = false;
            this.FMC_SelectedBox.visible = false;
            _loc2_["MC_Effect"].visible = false;
            this.FMCs[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      protected function OnOver(param1:MouseEvent) : void
      {
         param1.currentTarget.MC_Bmp_IconHighLight.visible = true;
      }
      
      protected function OnOut(param1:MouseEvent) : void
      {
         param1.currentTarget.MC_Bmp_IconHighLight.visible = false;
         if(this.FTaskOnOut != null)
         {
            this.FTaskOnOut(this,this);
         }
      }
      
      protected function OnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            this.FMCs[_loc2_]["MC_SelectedBox"].visible = false;
            _loc2_++;
         }
         param1.currentTarget.MC_SelectedBox.visible = true;
         _loc2_ = this.FMCs.indexOf(param1.currentTarget);
         if(this.FTaskOnClick != null)
         {
            this.FTaskOnClick(_loc2_);
         }
         if(this.FTutorialNextStep != null)
         {
            this.FTutorialNextStep(2103);
         }
      }
      
      protected function OnMove(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FMCs.indexOf(param1.currentTarget);
         if(this.FTaskOnOver != null)
         {
            this.FTaskOnOver(this,_loc2_);
         }
      }
      
      public function get TaskOnClick() : Function
      {
         return this.FTaskOnClick;
      }
      
      public function set TaskOnClick(param1:Function) : void
      {
         this.FTaskOnClick = param1;
      }
      
      public function get TaskOnOver() : Function
      {
         return this.FTaskOnOver;
      }
      
      public function set TaskOnOver(param1:Function) : void
      {
         this.FTaskOnOver = param1;
      }
      
      public function get TaskOnOut() : Function
      {
         return this.FTaskOnOut;
      }
      
      public function set TaskOnOut(param1:Function) : void
      {
         this.FTaskOnOut = param1;
      }
      
      public function set TutorialNextStep(param1:Function) : void
      {
         this.FTutorialNextStep = param1;
      }
      
      public function SetTag(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < MAX_COUNT)
         {
            this.FMCs[_loc3_]["MC_Tag"].visible = false;
            if(_loc3_ == param2)
            {
               this.FMCs[_loc3_]["MC_Tag"].gotoAndStop(param1);
               this.FMCs[_loc3_]["MC_Tag"].visible = true;
               this.FMCs[_loc3_]["MC_SelectedBox"].visible = true;
            }
            else
            {
               this.FMCs[_loc3_]["MC_SelectedBox"].visible = false;
            }
            _loc3_++;
         }
      }
      
      public function UpdataTaskList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TQuestDaily = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc3_ = this.FDailytask.GetTaskByIndex(_loc1_);
            _loc2_ = this.FScene[CONST_DAILY_QUEST.RESOURCE_Link_MC_RefreshTasks + _loc1_];
            TGameUtil.ShowImageByID(TGameUtil.Type_DailyTask,this.FMC_BmpIcons[_loc1_],CONST_MODULES.MODULE_DailyQuest,_loc3_.SmallPic);
            _loc1_++;
         }
      }
      
      public function SetEffect(param1:uint, param2:Boolean) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < MAX_COUNT)
         {
            this.FMCs[_loc3_]["MC_Effect"].visible = false;
            _loc3_++;
         }
         if(param2)
         {
            this.FMCs[param1]["MC_Effect"].visible = true;
            this.FMCs[param1]["MC_Effect"].play();
         }
         else
         {
            this.FMCs[param1]["MC_Effect"].visible = false;
         }
      }
   }
}

