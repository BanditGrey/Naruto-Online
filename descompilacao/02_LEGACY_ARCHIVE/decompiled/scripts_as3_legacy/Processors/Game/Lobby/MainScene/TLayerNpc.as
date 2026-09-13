package Processors.Game.Lobby.MainScene
{
   import Foundation.Network.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.Characters.MoveRole.*;
   import Logics.Quests.*;
   import Logics.Streamization.Characters.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Resources.Constants.*;
   import ghostcat.operation.quest.*;
   
   public class TLayerNpc extends TProcessorLobbyWindow
   {
      
      protected static const TIME_InitNpc:int = 50;
      
      protected static const TIME_InitNpcPeriod:int = 250;
      
      protected var FAllNpcsUI:Vector.<TUIRoleNpc>;
      
      protected var FCurrentNpcsUI:Vector.<TUIRoleNpc>;
      
      protected var FCurrentNpcsUIBack:Vector.<TUIRoleNpc>;
      
      protected var FCityDoor:TUIRoleNpc;
      
      protected var UnstreamizerRoleNPC:TUnstreamizerRoleNPC;
      
      protected var FTickInitStart:uint;
      
      protected var FTickInitPeriod:uint;
      
      protected var FLoadOver:Boolean;
      
      protected var FIfUpdate:Boolean;
      
      public function TLayerNpc(param1:TUIComponent)
      {
         super(param1);
         this.FAllNpcsUI = new Vector.<TUIRoleNpc>();
         this.FCurrentNpcsUI = new Vector.<TUIRoleNpc>();
         this.FCurrentNpcsUIBack = new Vector.<TUIRoleNpc>();
         this.UnstreamizerRoleNPC = new TUnstreamizerRoleNPC();
      }
      
      protected function UpdataNpc() : void
      {
         var _loc3_:TUIRoleNpc = null;
         var _loc4_:Boolean = false;
         var _loc1_:int = int(this.FCurrentNpcsUI.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FCurrentNpcsUI[_loc2_];
            _loc3_.UpdateData();
            _loc4_ = this.CheckIfInScreen(_loc3_);
            if(_loc4_)
            {
               _loc3_.UpdateView();
               _loc3_.visible = true;
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function CheckIfInScreen(param1:TUIRoleNpc) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.Direction == CONST_MainScene.DIRECTION_Left)
         {
            _loc3_ = param1.MapX + param1.CurrentFrame.Pivot.X;
            _loc2_ = param1.MapX - param1.CurrentFrame.Surface.width + param1.CurrentFrame.Pivot.X;
         }
         else
         {
            _loc3_ = param1.MapX + param1.CurrentFrame.Surface.width - param1.CurrentFrame.Pivot.X;
            _loc2_ = param1.MapX - param1.CurrentFrame.Pivot.X;
         }
         if(_loc2_ > CONST_COMMON.STAGE_Width + SLogicsCore.ScreenMapX || _loc3_ < SLogicsCore.ScreenMapX)
         {
            return false;
         }
         return true;
      }
      
      public function LoadNpcResource() : void
      {
         var _loc2_:TUIRoleNpc = null;
         var _loc3_:Boolean = false;
         var _loc1_:int = int(STimingCore.TickCount);
         _loc1_ -= this.FTickInitStart;
         if(_loc1_ > TIME_InitNpc)
         {
            _loc1_ = int(STimingCore.TickCount);
            _loc1_ -= this.FTickInitPeriod;
            if(_loc1_ > TIME_InitNpcPeriod)
            {
               _loc2_ = this.FCurrentNpcsUIBack.pop();
               if(_loc2_ == null)
               {
                  this.FLoadOver = true;
                  return;
               }
               this.FCurrentNpcsUI.push(_loc2_);
               this.addChild(_loc2_);
               _loc3_ = _loc2_.ChangeTextureID(_loc2_.TextrueID);
               if(_loc3_ == true)
               {
                  this.LoadNpcResource();
               }
               this.FTickInitPeriod = STimingCore.TickCount;
            }
         }
      }
      
      public function Update() : void
      {
         this.LoadNpcResource();
         this.UpdataNpc();
      }
      
      protected function GetQuestCareNpcID(param1:int, param2:TQuest) : int
      {
         switch(param1)
         {
            case CONST_QUEST.STATE_ACCEPT:
               return param2.AcceptTaskNpc;
            case CONST_QUEST.STATE_TASKING:
               if(param2.EventType == CONST_QUEST.QuestEventTypeJustRun)
               {
                  return param2.BackTaskNpc;
               }
               return param2.BackTaskNpc;
               break;
            case CONST_QUEST.STATE_TASKBACK:
               return param2.BackTaskNpc;
            case CONST_QUEST.STATE_ALREADYBACK:
               return param2.BackTaskNpc;
            default:
               return 0;
         }
      }
      
      protected function GetAutoSearchWayNpcID(param1:TQuest) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TUIRoleNpc = null;
         if(param1.EventType == CONST_QUEST.QuestEventTypeKillMonster && param1.TaskState == CONST_QUEST.STATE_TASKING)
         {
            return this.FCityDoor.RoleData.RoleTemplateID;
         }
         _loc2_ = this.GetQuestCareNpcID(param1.TaskState,param1);
         _loc3_ = this.GetNpcByNpcID(_loc2_,this.FCurrentNpcsUI);
         if(_loc3_ == null)
         {
            _loc3_ = this.GetNpcByNpcID(_loc2_,this.FCurrentNpcsUIBack);
         }
         return _loc3_ != null ? _loc2_ : int(this.FCityDoor.RoleData.RoleTemplateID);
      }
      
      protected function GetNpcByNpcID(param1:int, param2:Vector.<TUIRoleNpc>) : TUIRoleNpc
      {
         var _loc5_:TUIRoleNpc = null;
         var _loc3_:int = int(param2.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2[_loc4_];
            if(_loc5_.RoleData.RoleTemplateID == param1)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function AddNewQuests(param1:TQuests) : void
      {
         var _loc4_:TQuest = null;
         var _loc2_:int = param1.Count;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.GetQuestByIndex(_loc3_);
            this.AddNewQuest(_loc4_);
            _loc3_++;
         }
      }
      
      public function AddNewQuest(param1:TQuest) : void
      {
         var _loc2_:int = this.GetQuestCareNpcID(param1.TaskState,param1);
         var _loc3_:TUIRoleNpc = this.GetNpcByNpcID(_loc2_,this.FAllNpcsUI);
         if(_loc3_ != null)
         {
            _loc3_.AddNewQuest(param1);
         }
      }
      
      public function UpdateQuestState(param1:TQuest) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIRoleNpc = null;
         var _loc5_:TUIRoleNpc = null;
         var _loc6_:int = 0;
         if(param1.EventType == CONST_QUEST.QuestEventTypeJustRun && param1.TaskState == CONST_QUEST.STATE_TASKBACK)
         {
            _loc6_ = CONST_QUEST.STATE_ACCEPT;
         }
         else
         {
            _loc6_ = param1.TaskState - 1;
         }
         _loc2_ = this.GetQuestCareNpcID(_loc6_,param1);
         _loc3_ = this.GetQuestCareNpcID(param1.TaskState,param1);
         _loc4_ = this.GetNpcByNpcID(_loc2_,this.FAllNpcsUI);
         if(_loc2_ != _loc3_)
         {
            _loc5_ = this.GetNpcByNpcID(_loc3_,this.FAllNpcsUI);
            _loc4_.DeleteQuest(param1);
            _loc5_.AddNewQuest(param1);
         }
         else
         {
            _loc4_.UpdateQuest(param1);
         }
      }
      
      protected function SeleteCurrentNpc() : void
      {
         var _loc4_:TQuest = null;
         var _loc5_:int = 0;
         var _loc6_:TUIRoleNpc = null;
         var _loc1_:TQuests = SLogicsCore.Character.MainQuestComplete;
         if(_loc1_.Count != 0)
         {
            _loc4_ = _loc1_.GetQuestByIndex(_loc1_.Count - 1);
            _loc5_ = int(_loc4_.Identifier);
         }
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
         this.FCurrentNpcsUIBack.length = 0;
         var _loc2_:int = int(this.FAllNpcsUI.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = this.FAllNpcsUI[_loc3_];
            if(!(_loc6_.RoleData.TownID != SLogicsCore.Character.TownID || this.GetBoo(_loc6_.RoleData)))
            {
               if(_loc6_.RoleData.NpcStartTime <= _loc5_ && _loc6_.RoleData.NpcEndTime >= _loc5_)
               {
                  this.FCurrentNpcsUIBack.push(_loc6_);
               }
            }
            _loc3_++;
         }
      }
      
      protected function GetBoo(param1:TRoleNpc) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc2_:Vector.<uint> = SLogicsCore.Character.ConfigNpc;
         if(param1.RoleTemplateID == _loc2_[0])
         {
            _loc3_ = uint(SLogicsCore.Character.MainHero.Level);
            if(_loc3_ >= _loc2_[1])
            {
               return false;
            }
            return true;
         }
         return false;
      }
      
      protected function SeleteCityDoorNpc() : TUIRoleNpc
      {
         var _loc3_:TUIRoleNpc = null;
         var _loc1_:int = int(this.FAllNpcsUI.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FAllNpcsUI[_loc2_];
            if(_loc3_.RoleData.UserType == CONST_NPC.NPC_FUNCTION_GATE && _loc3_.RoleData.TownID == SLogicsCore.Character.TownID)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function SelectDoorByTownID(param1:int) : TUIRoleNpc
      {
         var _loc4_:TUIRoleNpc = null;
         var _loc2_:int = int(this.FAllNpcsUI.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.FAllNpcsUI[_loc3_];
            if(_loc4_.RoleData.UserType == CONST_NPC.NPC_FUNCTION_GATE && _loc4_.RoleData.TownID == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function get FreshGuideNpc() : TUIRoleNpc
      {
         return this.GetNpcByNpcID(22100003,this.FAllNpcsUI);
      }
      
      public function get IfUpdate() : Boolean
      {
         return this.FIfUpdate;
      }
      
      public function set IfUpdate(param1:Boolean) : void
      {
         this.FIfUpdate = param1;
      }
      
      public function get CityDoor() : TUIRoleNpc
      {
         return this.FCityDoor;
      }
      
      public function AutoSearchWay(param1:TQuest) : void
      {
         var _loc2_:int = this.GetAutoSearchWayNpcID(param1);
         var _loc3_:TUIRoleNpc = this.GetNpcByNpcID(_loc2_,this.FCurrentNpcsUI);
         if(_loc3_ == null)
         {
            _loc3_ = this.GetNpcByNpcID(_loc2_,this.FCurrentNpcsUIBack);
         }
         _loc3_.SimulateNpcClick();
      }
      
      public function InitNpcQuest() : void
      {
         this.AddNewQuests(SLogicsCore.Character.MainQuestsAlreadyAccept);
         this.AddNewQuests(SLogicsCore.Character.SubQuestsAlreadyAccept);
         this.AddNewQuests(SLogicsCore.Character.MainQuestsCanAccept);
         this.AddNewQuests(SLogicsCore.Character.SubQuestsCanAccept);
      }
      
      public function InitNPC() : void
      {
         this.UnstreamizerRoleNPC.Unstreamize(null,this.FAllNpcsUI,this);
      }
      
      public function UpdataCurrentCityNpc() : void
      {
         this.SeleteCurrentNpc();
         this.FCityDoor = this.SeleteCityDoorNpc();
         this.FTickInitStart = STimingCore.TickCount;
         this.FCurrentNpcsUI.length = 0;
         this.FLoadOver = false;
      }
      
      public function SearchRelationTownIDByQuest(param1:TQuest) : int
      {
         var _loc2_:int = this.GetQuestCareNpcID(param1.TaskState,param1);
         var _loc3_:TUIRoleNpc = this.GetNpcByNpcID(_loc2_,this.FAllNpcsUI);
         return _loc3_.RoleData.TownID;
      }
   }
}

