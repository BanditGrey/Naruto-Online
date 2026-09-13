package Processors.Game.Lobby.MainScene.Role
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TCharacter;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_MainScene;
   
   public class TUIRoleCanMove extends TUIRole
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FTargetMapX:Number;
      
      protected var FTargetMapY:Number;
      
      protected var FSpeedX:Number;
      
      protected var FSpeedY:Number;
      
      protected var FCostTime:int;
      
      protected var FOnArriveTarget:Function;
      
      protected var FCharacter:TCharacter;
      
      public function TUIRoleCanMove(param1:TUIComponent)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
         this.FCharacter = SLogicsCore.Character;
      }
      
      protected function UpdateRoleMove() : void
      {
         if(FRoleState == CONST_MainScene.INDEX_RUN || FRoleState == CONST_MainScene.INDEX_FLY)
         {
            FMapX += this.FSpeedX;
            FMapY += this.FSpeedY;
            --this.FCostTime;
            if(this.FCostTime < 0)
            {
               FMapX = this.FTargetMapX;
               FMapY = this.FTargetMapY;
               this.DoArriveTargetPosition();
            }
         }
      }
      
      protected function DoArriveTargetPosition() : void
      {
         if(this.FOnArriveTarget != null)
         {
            this.FOnArriveTarget();
         }
      }
      
      public function get TargetMapX() : Number
      {
         return this.FTargetMapX;
      }
      
      public function get TargetMapY() : Number
      {
         return this.FTargetMapY;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function set OnArriveTarget(param1:Function) : void
      {
         this.FOnArriveTarget = param1;
      }
      
      override public function SetupTargetPosition(param1:Number, param2:Number, param3:Number, param4:Boolean = true, param5:int = 1) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         this.FTargetMapX = param1;
         this.FTargetMapY = param2;
         _loc6_ = param1 - FMapX;
         _loc7_ = param2 - FMapY;
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
         if(_loc6_ < 0)
         {
            ChangeDirection(CONST_MainScene.DIRECTION_Left);
         }
         else if(_loc6_ > 0)
         {
            ChangeDirection(CONST_MainScene.DIRECTION_RIGHT);
         }
         if(param4)
         {
            if(this.FCharacter.Wing.TransformID != 0 && TextrueID <= 11100024 && this.FCharacter.Wing.HideWing == 2)
            {
               ChangeRoleState(CONST_MainScene.INDEX_FLY);
            }
            else
            {
               ChangeRoleState(CONST_MainScene.INDEX_RUN);
            }
         }
         else if(param5 == 2)
         {
            ChangeRoleState(CONST_MainScene.INDEX_FLY);
         }
         else
         {
            ChangeRoleState(CONST_MainScene.INDEX_RUN);
         }
      }
      
      override public function UpdateData() : void
      {
         super.UpdateData();
         this.UpdateRoleMove();
      }
      
      override public function UpdateView() : void
      {
         super.UpdateView();
      }
      
      public function StopMove() : void
      {
         ChangeRoleState(CONST_MainScene.INDEX_IDLE);
      }
      
      public function StopToNormalIdle() : void
      {
         ChangeRoleState(CONST_MainScene.INDEX_IDLE);
      }
      
      public function StopToBattleIdle() : void
      {
         ChangeRoleState(CONST_MainScene.INDEX_FIGHT_IDLE);
      }
   }
}

