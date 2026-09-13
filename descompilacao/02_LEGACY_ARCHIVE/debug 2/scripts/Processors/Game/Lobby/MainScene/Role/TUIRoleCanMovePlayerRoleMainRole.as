package Processors.Game.Lobby.MainScene.Role
{
   import Foundation.UI.TUIComponent;
   import Resources.Constants.CONST_MainScene;
   
   public class TUIRoleCanMovePlayerRoleMainRole extends TUIRoleCanMovePlayerRole
   {
      
      protected var FMovingToTargetNpc:Boolean;
      
      public function TUIRoleCanMovePlayerRoleMainRole(param1:TUIComponent)
      {
         super(param1);
         this.mouseEnabled = false;
      }
      
      override protected function DoArriveTargetPosition() : void
      {
         super.DoArriveTargetPosition();
         ChangeRoleState(CONST_MainScene.INDEX_IDLE);
      }
      
      public function UpdateMilitaryRank() : void
      {
         super.InitMilitaryRank();
      }
      
      public function UpdateMainRoleNameColor() : void
      {
         super.InitRoleName();
      }
      
      override public function Init() : void
      {
         ChangeHeroShape(FChangeShape,FNewShapeBaseHeroID);
         InitRoleName();
         InitMilitaryRank();
         InitTitle();
         InitLittlePet();
         InitWing();
         InitBadge();
         UpdateTextFieldPosition();
      }
      
      override public function Release() : void
      {
      }
   }
}

