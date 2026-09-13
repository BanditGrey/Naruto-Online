package Processors.Game.Lobby.Campaign.Monster
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Battle.*;
   import Logics.Campaign.*;
   import Processors.Game.Battle.Character.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TGroupMonster extends TUIComponent implements IRole
   {
      
      protected static const OppositeDirectionMinAngle:Number = -Math.PI / 2;
      
      protected static const OppositeDirectionMaxAngle:Number = Math.PI / 2;
      
      public static const CAMP_LEFT:int = 0;
      
      public static const CAMP_RIGNT:int = 1;
      
      private static const Random_AreaX:Number = 200;
      
      private static const Random_AreaY:Number = 90;
      
      protected static var BattleConfig_SortArr:Vector.<int> = SBattleConfig.SHOWIDX;
      
      protected var FMonsters:TMonsters;
      
      protected var FMonster:Vector.<TActive>;
      
      protected var FAutoMove:Boolean;
      
      protected var FAutoMoveCount:int;
      
      protected var FAutoTimeID:uint;
      
      protected var FAutoTalkID:uint;
      
      protected var FTalk:MovieClip;
      
      protected var FTalkActive:TActive;
      
      protected var FInitX:Number;
      
      protected var FInitY:Number;
      
      protected var FPos:int;
      
      protected var FCamp:int;
      
      protected var FIsDoor:Boolean;
      
      protected var FTargetMapX:Number;
      
      protected var FTargetMapY:Number;
      
      protected var FMapX:Number;
      
      protected var FMapY:Number;
      
      protected var FSpeedX:Number;
      
      protected var FSpeedY:Number;
      
      protected var FCostTime:int;
      
      protected var FTalkInfo:String;
      
      protected var FModuleId:uint;
      
      protected var FMoveEndCallBack:Function;
      
      protected var FSetControlGroupRole:Function;
      
      public function TGroupMonster(param1:TUIComponent, param2:uint, param3:int = 0, param4:Boolean = false)
      {
         super(param1);
         this.FModuleId = param2;
         this.FCamp = param3;
         this.FIsDoor = param4;
         this.FAutoMove = false;
         this.FMonster = new Vector.<TActive>();
         this.FSpeedX = 0;
         this.FSpeedY = 0;
      }
      
      protected function SortMonsters(param1:TMonster, param2:TMonster) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = BattleConfig_SortArr.indexOf(param2.MonsterPos);
         _loc3_ = BattleConfig_SortArr.indexOf(param1.MonsterPos);
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      protected function InitBaseMonster() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TMonster = null;
         var _loc4_:TActive = null;
         var _loc5_:int = 0;
         this.SaveRole();
         this.FAutoMoveCount = 0;
         this.FAutoTimeID = 0;
         this.FAutoTalkID = 0;
         _loc2_ = this.FMonsters.Count;
         _loc5_ = 100;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMonsters.GetMonsterByIndex(_loc1_);
            if(_loc3_)
            {
               if(!this.FIsDoor)
               {
                  _loc4_ = TPoolRole.GetActive(this,_loc3_.Identifier,this.FModuleId,true,true,true);
               }
               else
               {
                  _loc4_ = TPoolRole.GetActive(this,_loc3_.Identifier,this.FModuleId);
               }
               _loc4_.x = SBattleConfig.GetPostionByCamyPos(this.FCamp,_loc3_.MonsterPos,SBattleConfig.Type_PostionX) - SBattleConfig.GetPostionByCamyPos(this.FCamp,1,SBattleConfig.Type_PostionX);
               _loc4_.y = SBattleConfig.GetPostionByCamyPos(this.FCamp,_loc3_.MonsterPos,SBattleConfig.Type_PostionY) - SBattleConfig.GetPostionByCamyPos(this.FCamp,1,SBattleConfig.Type_PostionY);
               _loc4_.direction = this.FCamp == CAMP_LEFT;
               this.FMonster.push(_loc4_);
               if(_loc5_ > _loc3_.MonsterPos)
               {
                  _loc5_ = _loc3_.MonsterPos;
               }
            }
            _loc1_++;
         }
         if(_loc5_ != 1)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FMonster.length)
            {
               _loc4_ = this.FMonster[_loc1_];
               if(_loc4_.scaleX == 1)
               {
                  _loc4_.x += SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionX) - SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionX);
               }
               else
               {
                  _loc4_.x -= SBattleConfig.GetPostionByCamyPos(0,1,SBattleConfig.Type_PostionX) - SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionX);
               }
               _loc1_++;
            }
         }
         if(this.FTalk != null)
         {
            this.FTalk.visible = false;
         }
         if(this.FCamp == CAMP_RIGNT)
         {
            addEventListener(MouseEvent.CLICK,this.OnGotoTarget);
         }
      }
      
      protected function RoleMoveEnd() : void
      {
         --this.FAutoMoveCount;
         if(this.FAutoMoveCount <= 0)
         {
            if(this.FMoveEndCallBack != null)
            {
               this.FMoveEndCallBack();
            }
            else
            {
               this.MoveEnd();
            }
         }
      }
      
      protected function MoveEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TActive = null;
         var _loc3_:int = 0;
         _loc3_ = int(this.FMonster.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.FMonster[_loc1_];
            if(_loc2_)
            {
               if(!this.FIsDoor)
               {
                  _loc2_.ActivePlay(TActive.TYPE_ACTIVE_FIGHT_IDLE);
               }
               else
               {
                  _loc2_.ActivePlay(TActive.TYPE_ACTIVE_IDLE);
               }
            }
            _loc1_++;
         }
         if(this.FAutoMove)
         {
            this.FAutoTimeID = setTimeout(this.MoveTo,Math.random() * 2000 + 2000,Math.random() * Random_AreaX / 2 * -this.scaleX,Math.random() * Random_AreaY / 2 - Random_AreaY / 2);
         }
         else
         {
            clearTimeout(this.FAutoTimeID);
         }
      }
      
      protected function UpdateRoleMove() : void
      {
         if(this.FSpeedX != 0 || this.FSpeedY != 0)
         {
            this.MapX += this.FSpeedX;
            this.MapY += this.FSpeedY;
            --this.FCostTime;
            if(this.FCostTime < 0)
            {
               this.MapX = this.FTargetMapX;
               this.MapY = this.FTargetMapY;
               this.FSpeedX = 0;
               this.FSpeedY = 0;
               if(!this.FIsDoor)
               {
                  this.ActivePlay(TActive.TYPE_ACTIVE_FIGHT_IDLE);
               }
               else
               {
                  this.ActivePlay(TActive.TYPE_ACTIVE_IDLE);
               }
            }
         }
         this.x = this.FMapX - SLogicsCore.ScreenMapX;
         this.y = this.FMapY;
         if(this.FTalk != null && this.FTalkActive != null)
         {
            this.FTalk.x = this.FTalkActive.x;
            this.FTalk.y = this.FTalkActive.y - this.FTalkActive.RoleHeight;
         }
      }
      
      protected function AutoTalk() : void
      {
         if(!this.FTalkInfo || this.FTalkInfo.length <= 0)
         {
            return;
         }
         if(this.FTalk == null)
         {
            this.FTalk = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLESCENE.RESOURCE_ClassName_PopTalk) as MovieClip;
            this.FTalk.stop();
            addChild(this.FTalk);
         }
         if(this.FTalk == null)
         {
            this.FAutoTalkID = setTimeout(this.TalkEnd,6000);
            return;
         }
         this.FTalk.visible = true;
         this.FTalk.gotoAndPlay(1);
         this.FTalk.mc_desc.tf_desc.text = this.FTalkInfo;
         this.FTalk.mc_bg.mc_bg.scaleY = (this.FTalk.mc_desc.tf_desc.textHeight + 10) / this.FTalk.mc_desc.tf_desc.height;
         this.FTalk.mc_desc.tf_desc.y = -this.FTalk.mc_bg.mc_bg.height + 8;
         this.FTalkActive = this.FMonster[int(Math.random() * this.FMonster.length)];
         this.FAutoTalkID = setTimeout(this.TalkEnd,3000);
      }
      
      protected function TalkEnd() : void
      {
         if(!this.FTalkInfo || this.FTalkInfo.length <= 0)
         {
            return;
         }
         if(this.FTalk != null)
         {
            this.FTalk.visible = false;
         }
         if(this.FAutoMove)
         {
            this.FAutoTalkID = setTimeout(this.AutoTalk,Math.random() * 2000 + 2000);
         }
         else
         {
            clearTimeout(this.FAutoTalkID);
         }
      }
      
      protected function OnGotoTarget(param1:MouseEvent) : void
      {
         if(this.FSetControlGroupRole != null)
         {
            this.FSetControlGroupRole(this.MapX,this.MapY);
         }
      }
      
      public function get Count() : int
      {
         return this.FMonster.length;
      }
      
      public function GetActiveByIndex(param1:int) : TActive
      {
         return this.FMonster[param1];
      }
      
      public function set AutoMove(param1:Boolean) : void
      {
         this.FAutoMove = param1;
         if(this.FAutoMove)
         {
            this.MoveEnd();
            this.TalkEnd();
         }
         else
         {
            clearTimeout(this.FAutoTimeID);
            clearTimeout(this.FAutoTalkID);
         }
      }
      
      public function get Pos() : int
      {
         return this.FPos;
      }
      
      override public function get scaleX() : Number
      {
         var _loc1_:TActive = null;
         if(this.FMonster.length <= 0)
         {
            return 0;
         }
         _loc1_ = this.FMonster[0];
         if(_loc1_)
         {
            return _loc1_.scaleX;
         }
         return 0;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         var _loc4_:int = int(this.FMonster.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this.FMonster[_loc2_];
            if(_loc3_)
            {
               _loc3_.scaleX = param1;
            }
            _loc2_++;
         }
      }
      
      public function set ShowHighLight(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         var _loc4_:int = int(this.FMonster.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this.FMonster[_loc2_];
            _loc3_.ShowHighLight = param1;
            if(!param1)
            {
               _loc3_.CursorHovering = param1;
            }
            _loc2_++;
         }
      }
      
      public function get Camp() : int
      {
         return this.FCamp;
      }
      
      public function get MapX() : Number
      {
         return this.FMapX;
      }
      
      public function set MapX(param1:Number) : void
      {
         this.FMapX = param1;
      }
      
      public function get MapY() : Number
      {
         return this.FMapY;
      }
      
      public function set MapY(param1:Number) : void
      {
         this.FMapY = param1;
      }
      
      public function get SetControlGroupRole() : Function
      {
         return this.FSetControlGroupRole;
      }
      
      public function set SetControlGroupRole(param1:Function) : void
      {
         this.FSetControlGroupRole = param1;
      }
      
      public function get TalkInfo() : String
      {
         return this.FTalkInfo;
      }
      
      public function set TalkInfo(param1:String) : void
      {
         this.FTalkInfo = param1;
      }
      
      public function get ModuleId() : uint
      {
         return this.FModuleId;
      }
      
      public function set ModuleId(param1:uint) : void
      {
         this.FModuleId = param1;
      }
      
      public function ResetRole(param1:TMonsters) : void
      {
         this.FMonsters = param1;
         this.FMonsters.sort(this.SortMonsters);
         Visible = true;
         this.InitBaseMonster();
      }
      
      public function SetPos(param1:Number, param2:Number) : void
      {
         this.FInitX = param1;
         this.FInitY = param2;
         this.MapX = param1;
         this.MapY = param2;
         this.FTargetMapX = param1;
         this.FTargetMapY = param2;
      }
      
      public function MoveTo(param1:Number, param2:Number, param3:Function = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TActive = null;
         var _loc6_:int = int(this.FMonster.length);
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc5_ = this.FMonster[_loc4_];
            if(_loc5_)
            {
               _loc5_.ActivePlay(TActive.TYPE_ACTIVE_RUN);
               _loc5_.MoveTo(this.RoleMoveEnd,SBattleConfig.GetPostionByCamyPos(this.FCamp,this.FMonsters.GetMonsterByIndex(_loc4_).MonsterPos,SBattleConfig.Type_PostionX) - SBattleConfig.GetPostionByCamyPos(this.FCamp,1,SBattleConfig.Type_PostionX) + param1,SBattleConfig.GetPostionByCamyPos(this.FCamp,this.FMonsters.GetMonsterByIndex(_loc4_).MonsterPos,SBattleConfig.Type_PostionY) - SBattleConfig.GetPostionByCamyPos(this.FCamp,1,SBattleConfig.Type_PostionY) + param2,200);
               ++this.FAutoMoveCount;
            }
            _loc4_++;
         }
         this.FMoveEndCallBack = param3;
      }
      
      public function ActivePlay(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         var _loc4_:int = int(this.FMonster.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this.FMonster[_loc2_];
            if(_loc3_)
            {
               _loc3_.ActivePlay(param1);
            }
            _loc2_++;
         }
      }
      
      public function SaveRole() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActive = null;
         this.FTalkActive = null;
         _loc2_ = int(this.FMonster.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMonster[_loc1_];
            TPoolRole.SaveActive(_loc3_);
            _loc1_++;
         }
         this.FMonster.length = 0;
         if(hasEventListener(MouseEvent.CLICK))
         {
            removeEventListener(MouseEvent.CLICK,this.OnGotoTarget);
         }
         this.AutoMove = false;
         if(this.FTalk)
         {
            this.FTalk.visible = false;
         }
      }
      
      public function UpdataRole() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TActive = null;
         var _loc3_:int = 0;
         _loc3_ = int(this.FMonster.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.FMonster[_loc1_];
            if(_loc2_)
            {
               _loc2_.UpdateActive();
            }
            _loc1_++;
         }
         this.UpdateRoleMove();
      }
      
      public function UpdateRolePosition() : void
      {
         this.x = this.FInitX - SLogicsCore.ScreenMapX;
      }
      
      public function CheckMouseIn() : TActive
      {
         var _loc1_:int = 0;
         var _loc2_:TActive = null;
         var _loc3_:int = int(this.FMonster.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.FMonster[_loc1_];
            if(_loc2_.CheckMouseInColor())
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return null;
      }
      
      public function ReloadRole() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TActive = null;
         var _loc3_:int = 0;
         _loc3_ = int(this.FMonster.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = this.FMonster[_loc1_];
            _loc2_.ReloadRole();
            _loc1_++;
         }
      }
      
      public function StopMove() : void
      {
         this.FCostTime = 0;
         this.FSpeedX = 0;
         this.FSpeedY = 0;
         if(!this.FIsDoor)
         {
            this.ActivePlay(TActive.TYPE_ACTIVE_FIGHT_IDLE);
         }
         else
         {
            this.ActivePlay(TActive.TYPE_ACTIVE_IDLE);
         }
      }
      
      public function SetupTargetPosition(param1:Number, param2:Number, param3:Number, param4:Boolean = true, param5:int = 1) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         this.FTargetMapX = param1;
         this.FTargetMapY = param2;
         _loc6_ = param1 - this.MapX;
         _loc7_ = param2 - this.MapY;
         _loc8_ = Math.atan2(_loc7_,_loc6_);
         this.FSpeedX = Math.cos(_loc8_) * param3;
         this.FSpeedY = Math.sin(_loc8_) * param3;
         if(Math.abs(_loc6_) > Math.abs(_loc7_))
         {
            this.FCostTime = _loc6_ / this.FSpeedX;
         }
         else
         {
            this.FCostTime = _loc7_ / this.FSpeedY;
         }
         if(_loc8_ > OppositeDirectionMaxAngle || _loc8_ < OppositeDirectionMinAngle)
         {
            this.scaleX = -1;
         }
         else
         {
            this.scaleX = 1;
         }
         this.ActivePlay(TActive.TYPE_ACTIVE_RUN);
      }
   }
}

