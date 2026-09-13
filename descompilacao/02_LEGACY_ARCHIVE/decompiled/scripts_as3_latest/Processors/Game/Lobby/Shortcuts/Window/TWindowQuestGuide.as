package Processors.Game.Lobby.Shortcuts.Window
{
   import Components.ScrollBar.*;
   import Foundation.Common.THint;
   import Foundation.Registries.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Repositories.*;
   import Foundation.Resources.Strings.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Quests.*;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutMode;
   import Processors.Game.Lobby.Common.Shortcuts.TLobbyShortcutQuestGuideModes;
   import Processors.TProcessor;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TWindowQuestGuide extends TProcessor
   {
      
      public static const TAG_ALREADYACCEPT:int = 0;
      
      public static const TAG_CANACCEPT:int = 1;
      
      public static const STRING_Quest:String = STRING_SHORTCUTS.STRING_Quest;
      
      protected var FHint:THint;
      
      protected var FCurrentVisibleTag:int;
      
      protected var FScorll:TScrollBarSimple;
      
      protected var FTextField:TScrollTextField;
      
      protected var FRegisterAlreadyAccept:TRegistryInstance;
      
      protected var FRegisterCanAccept:TRegistryInstance;
      
      protected var FScene:MovieClip;
      
      protected var FBackground:Sprite;
      
      protected var FAlreadyAcceptTag:MovieClip;
      
      protected var FCanAcceptTag:MovieClip;
      
      protected var FBTN_Open:MovieClip;
      
      protected var FBTN_Close:MovieClip;
      
      protected var FWidth:int;
      
      protected var FIsInitialization:Boolean;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FOnTextClick:Function;
      
      private var timer:int = 5;
      
      public function TWindowQuestGuide(param1:TUIComponent)
      {
         super(param1);
         this.FHint = new THint();
         this.FHint.Caption = STRING_Quest;
         this.FRegisterAlreadyAccept = new TRegistryInstance();
         this.FRegisterCanAccept = new TRegistryInstance();
         this.FWidth = 0;
         this.FIsInitialization = false;
      }
      
      protected function Resources_UIDispatch() : void
      {
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_QUEST.RESOURCE_ClassName_Task) as MovieClip;
         this.addChild(this.FScene);
         this.FScene.visible = false;
         this.FScene.addEventListener(MouseEvent.MOUSE_MOVE,this.QuestGuideOnMove,false,0,true);
         this.FScene.addEventListener(MouseEvent.ROLL_OVER,this.QuestGuideOnOver,false,0,true);
         this.FScene.addEventListener(MouseEvent.ROLL_OUT,this.QuestGuideOnOut,false,0,true);
         this.FScene.addEventListener(MouseEvent.CLICK,this.QuestGuideClick,false,0,true);
         this.FBackground = this.FScene.mc_scroll.mc_bg;
         this.FBackground.mouseEnabled = false;
         this.FBackground.visible = false;
         this.FTextField = new TScrollTextField(this.FScene.mc_scroll.tf_info);
         this.FTextField.OnTextClick = this.HandleTextClick;
         this.FScene.mc_scroll.addChild(this.FTextField);
         this.FScorll = new TScrollBarSimple(this,this.FScene.mc_scroll.mc_bar,this.FScene.mc_scroll.btn_up,this.FScene.mc_scroll.btn_down,58,this.FTextField);
         this.addChild(this.FScorll);
         this.FAlreadyAcceptTag = this.FScene["btn_curTask"];
         this.FAlreadyAcceptTag.addEventListener(MouseEvent.CLICK,this.OnCurTaskClick);
         this.FCanAcceptTag = this.FScene["btn_nextTask"];
         this.FCanAcceptTag.addEventListener(MouseEvent.CLICK,this.OnNextTaskClick);
         this.FBTN_Open = this.FScene["btn_open"];
         this.FBTN_Close = this.FScene["btn_close"];
         this.FBTN_Open.addEventListener(MouseEvent.CLICK,this.OnOpenTask);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseTask);
         TGameUtil.setButtonMode(this.FBTN_Open,true);
         this.Init();
         this.FIsInitialization = true;
      }
      
      protected function CreateTaskSubject(param1:TQuest) : String
      {
         var _loc2_:String = null;
         _loc2_ = STRING_QUEST.GetTaskNameHtmlText(param1);
         if(param1.TaskState == CONST_QUEST.STATE_TASKBACK)
         {
            param1.TaskGuideInforCompound = _loc2_;
         }
         return _loc2_;
      }
      
      protected function CreateTaskInfor(param1:TQuest) : String
      {
         var _loc2_:String = null;
         _loc2_ = STRING_QUEST.GetTaskInfor(param1);
         if(param1.TaskState != CONST_QUEST.STATE_TASKBACK)
         {
            param1.TaskGuideInforCompound = _loc2_;
         }
         return _loc2_;
      }
      
      protected function UpdateQuestInfor(param1:TQuest, param2:Boolean = true) : void
      {
         var _loc3_:TQuestInfor = this.FRegisterAlreadyAccept.GetInstanceByIdentifier(param1.Identifier) as TQuestInfor;
         if(_loc3_)
         {
            _loc3_.Subject = this.CreateTaskSubject(param1);
            _loc3_.Infor = this.CreateTaskInfor(param1);
         }
         if(param2 == true && _loc3_ != null && (this.FCurrentVisibleTag == TAG_ALREADYACCEPT || this.FCurrentVisibleTag == TAG_CANACCEPT))
         {
            this.SwitchTag(this.FCurrentVisibleTag);
         }
         _loc3_ = this.FRegisterCanAccept.GetInstanceByIdentifier(param1.Identifier) as TQuestInfor;
         if(_loc3_)
         {
            _loc3_.Subject = this.CreateTaskSubject(param1);
            _loc3_.Infor = this.CreateTaskInfor(param1);
         }
         if(param2 == true && _loc3_ != null && (this.FCurrentVisibleTag == TAG_ALREADYACCEPT || this.FCurrentVisibleTag == TAG_CANACCEPT))
         {
            this.SwitchTag(this.FCurrentVisibleTag);
         }
      }
      
      protected function FreshVisibleQuestsInfor(param1:TRegistryInstance) : void
      {
         var _loc2_:TQuestInfor = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FTextField.Clear();
         _loc4_ = param1.Count;
         var _loc5_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1.GetInstanceByIndex(_loc3_) as TQuestInfor;
            _loc5_ += _loc2_.Subject + _loc2_.Infor + "\n";
            _loc3_++;
         }
         this.FTextField.AppendText(_loc5_);
      }
      
      protected function GetQuestInfor(param1:TQuest) : TQuestInfor
      {
         var _loc2_:TQuestInfor = null;
         _loc2_ = this.FRegisterAlreadyAccept.GetInstanceByIdentifier(param1.Identifier) as TQuestInfor;
         if(_loc2_ == null)
         {
            _loc2_ = this.FRegisterCanAccept.GetInstanceByIdentifier(param1.Identifier) as TQuestInfor;
         }
         return _loc2_;
      }
      
      protected function SwitchTag(param1:int) : void
      {
         this.FCurrentVisibleTag = param1;
         switch(param1)
         {
            case TAG_ALREADYACCEPT:
               this.FreshVisibleQuestsInfor(this.FRegisterAlreadyAccept);
               break;
            case TAG_CANACCEPT:
               this.FreshVisibleQuestsInfor(this.FRegisterCanAccept);
         }
      }
      
      protected function UpdateBounds() : void
      {
         if(!this.FIsInitialization)
         {
            return;
         }
         if(this.FIsInitialization)
         {
            this.FWidth = this.width;
         }
         else
         {
            this.FWidth = 0;
         }
      }
      
      protected function QuestGuideOnMove(param1:MouseEvent) : void
      {
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(this,this.FHint);
         }
      }
      
      protected function QuestGuideOnOver(param1:MouseEvent) : void
      {
         this.FBackground.visible = true;
      }
      
      protected function QuestGuideOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
         this.FBackground.visible = false;
      }
      
      protected function QuestGuideClick(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      protected function HandleTextClick(param1:String) : void
      {
         if(this.FOnTextClick != null)
         {
            this.FOnTextClick(param1);
         }
      }
      
      protected function OnOpenTask(param1:MouseEvent) : void
      {
         this.FBTN_Open.visible = false;
         TGameUtil.setButtonMode(this.FBTN_Close,true);
         this.FScorll.visible = false;
         this.FScene.mc_scroll.visible = false;
      }
      
      protected function OnCloseTask(param1:MouseEvent) : void
      {
         this.FBTN_Open.visible = true;
         TGameUtil.setButtonMode(this.FBTN_Open,true);
         this.FScorll.visible = true;
         this.FScene.mc_scroll.visible = true;
      }
      
      protected function OnCurTaskClick(param1:MouseEvent = null) : void
      {
         if(this.FCurrentVisibleTag != TAG_ALREADYACCEPT)
         {
            this.SwitchTag(TAG_ALREADYACCEPT);
            TGameUtil.setButtonMode(this.FAlreadyAcceptTag,false);
            this.FAlreadyAcceptTag.gotoAndStop("down");
            TGameUtil.setButtonMode(this.FCanAcceptTag,true);
            this.FCanAcceptTag.gotoAndStop("up");
         }
      }
      
      protected function OnNextTaskClick(param1:MouseEvent = null) : void
      {
         if(this.FCurrentVisibleTag != TAG_CANACCEPT)
         {
            this.SwitchTag(TAG_CANACCEPT);
            TGameUtil.setButtonMode(this.FCanAcceptTag,false);
            this.FCanAcceptTag.gotoAndStop("down");
            TGameUtil.setButtonMode(this.FAlreadyAcceptTag,true);
            this.FAlreadyAcceptTag.gotoAndStop("up");
         }
      }
      
      public function get ShortcutWidth() : int
      {
         this.UpdateBounds();
         return this.FWidth;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function set OnTextClick(param1:Function) : void
      {
         this.FOnTextClick = param1;
      }
      
      public function Init() : void
      {
         this.FCurrentVisibleTag = TAG_CANACCEPT;
         this.OnCurTaskClick();
      }
      
      public function Perform_UIDispatch() : void
      {
         this.Resources_UIDispatch();
      }
      
      public function UpdateTaskInfor(param1:TQuest, param2:Boolean = true) : void
      {
         this.UpdateQuestInfor(param1,param2);
      }
      
      public function AddTaskList(param1:Array, param2:int) : void
      {
         var _loc5_:TQuest = null;
         var _loc6_:TQuestInfor = null;
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_] as TQuest;
            _loc6_ = new TQuestInfor();
            _loc6_.Subject = this.CreateTaskSubject(_loc5_);
            _loc6_.Infor = this.CreateTaskInfor(_loc5_);
            if(param2 == TAG_ALREADYACCEPT)
            {
               this.FRegisterAlreadyAccept.Register(_loc5_.Identifier,_loc6_);
               if(_loc4_ + 1 == _loc3_)
               {
                  this.FCurrentVisibleTag = TAG_CANACCEPT;
                  this.OnCurTaskClick();
               }
            }
            else if(param2 == TAG_CANACCEPT)
            {
               this.FRegisterCanAccept.Register(_loc5_.Identifier,_loc6_);
               if(_loc4_ + 1 == _loc3_)
               {
                  this.FCurrentVisibleTag = TAG_ALREADYACCEPT;
                  this.OnNextTaskClick();
               }
            }
            _loc4_++;
         }
      }
      
      public function AddTask(param1:TQuest, param2:int) : void
      {
         var _loc3_:TQuestInfor = null;
         _loc3_ = new TQuestInfor();
         _loc3_.Subject = this.CreateTaskSubject(param1);
         _loc3_.Infor = this.CreateTaskInfor(param1);
         switch(param2)
         {
            case TAG_ALREADYACCEPT:
               this.FRegisterAlreadyAccept.Register(param1.Identifier,_loc3_);
               this.FCurrentVisibleTag = TAG_CANACCEPT;
               this.OnCurTaskClick();
               break;
            case TAG_CANACCEPT:
               this.FRegisterCanAccept.Register(param1.Identifier,_loc3_);
               this.FCurrentVisibleTag = TAG_ALREADYACCEPT;
               this.OnNextTaskClick();
         }
      }
      
      public function DeleteTask(param1:TQuest) : void
      {
         var _loc2_:TQuestInfor = null;
         var _loc3_:Boolean = false;
         _loc3_ = this.FRegisterCanAccept.DeleteInstanceByIdentifier(param1.Identifier);
         if(_loc3_ && this.FCurrentVisibleTag == TAG_CANACCEPT)
         {
            this.FreshVisibleQuestsInfor(this.FRegisterCanAccept);
         }
         _loc3_ = this.FRegisterAlreadyAccept.DeleteInstanceByIdentifier(param1.Identifier);
         if(_loc3_ && this.FCurrentVisibleTag == TAG_ALREADYACCEPT)
         {
            this.FreshVisibleQuestsInfor(this.FRegisterAlreadyAccept);
         }
      }
      
      public function ShortcutsSetup(param1:TLobbyShortcutQuestGuideModes) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _loc2_ = int(param1.ShortcutMode);
         if(!this.FIsInitialization)
         {
            return;
         }
         switch(_loc2_)
         {
            case TLobbyShortcutMode.SHORTCUTMODE_Show:
               _loc3_ = true;
               break;
            case TLobbyShortcutMode.SHORTCUTMODE_Hidden:
               _loc3_ = false;
         }
         this.FScene.visible = _loc3_;
      }
   }
}

