package Processors.Game.Lobby.MainScene.Role
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.MoveRole.TRoleCanControl;
   import Logics.DatebaseVO.VO.TPetImage;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MainScene;
   import Resources.Strings.STRING_MAINSCENE;
   import flash.events.MouseEvent;
   
   public class TUIRoleCanMovePet extends TUIRoleCanMove
   {
      
      protected var DistanceStartRun:int = 22500;
      
      protected var MinDistance:int = 10000;
      
      protected var State_Following:int = 0;
      
      protected var State_Leaveing:int = 1;
      
      protected var State_Leaved:int = 2;
      
      protected var FCurrentPetState:int;
      
      public var PetImageID:uint;
      
      public var FPetImageVO:TPetImage;
      
      protected var FFollowRole:TUIRoleCanMovePlayerRole;
      
      public function TUIRoleCanMovePet(param1:TUIComponent)
      {
         super(param1);
         this.removeEventListener(MouseEvent.MOUSE_OVER,HandleOnMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,HandleOnMouseOut);
         this.removeEventListener(MouseEvent.CLICK,HandleOnMouseClick);
         this.removeEventListener(MouseEvent.MOUSE_MOVE,HandleOnMouseMove);
         FTextFiledName.textColor = 16777215;
         this.FCurrentPetState = this.State_Leaved;
         this.mouseEnabled = false;
      }
      
      public function UpdatePetPosition() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         _loc1_ = this.CheckIfCollision(this.MinDistance);
         if(_loc1_)
         {
            ChangeRoleState(CONST_MainScene.INDEX_IDLE);
            return;
         }
         _loc2_ = !this.CheckIfCollision(this.DistanceStartRun);
         if(_loc2_)
         {
            SetupTargetPosition(this.FFollowRole.MapX,this.FFollowRole.MapY + 2,CONST_MainScene.RoleMoveSpeed);
         }
      }
      
      protected function CheckIfCollision(param1:int) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = this.FFollowRole.MapX - MapX;
         _loc3_ = this.FFollowRole.MapY - MapY;
         if(_loc2_ * _loc2_ + _loc3_ * _loc3_ > param1)
         {
            return false;
         }
         return true;
      }
      
      protected function UpdateDirection() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FFollowRole.MapX > this.MapX ? CONST_MainScene.DIRECTION_RIGHT : CONST_MainScene.DIRECTION_Left;
         ChangeDirection(_loc1_);
      }
      
      protected function InitPetName() : void
      {
         this.FPetImageVO = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_PetImage,FTextrueID) as TPetImage;
         FTextFiledName.text = TUtilityString.Format(STRING_MAINSCENE.FormatString_PetName,this.FFollowRole.RoleData.RoleName,this.FPetImageVO.Name);
         FTextFiledName.y = -FTextFiledName.height;
         UpdateDisplayObjectPosition(FTextFiledName);
      }
      
      override protected function DoArriveTargetPosition() : void
      {
         super.DoArriveTargetPosition();
         if(this.FCurrentPetState == this.State_Leaveing)
         {
            this.FCurrentPetState = this.State_Leaved;
         }
         ChangeRoleState(CONST_MainScene.INDEX_IDLE);
      }
      
      protected function SwitchState(param1:int) : void
      {
         this.FCurrentPetState = param1;
         switch(this.FCurrentPetState)
         {
            case this.State_Following:
            case this.State_Leaveing:
            case this.State_Leaved:
         }
      }
      
      public function set FollowRole(param1:TUIRoleCanMovePlayerRole) : void
      {
         this.FFollowRole = param1;
      }
      
      public function get FollowRole() : TUIRoleCanMovePlayerRole
      {
         return this.FFollowRole;
      }
      
      public function get RelexBoo() : Boolean
      {
         switch(this.FCurrentPetState)
         {
            case this.State_Following:
               return false;
            case this.State_Leaveing:
               return false;
            case this.State_Leaved:
               return true;
            default:
               return false;
         }
      }
      
      public function set RelexBoo(param1:Boolean) : void
      {
         if(param1)
         {
            if(this.FCurrentPetState == this.State_Following)
            {
               this.FCurrentPetState = this.State_Leaveing;
               this.SetupTargetPosition(0,MapY,CONST_MainScene.RoleMoveSpeed);
               ChangeDirection(CONST_MainScene.DIRECTION_Left);
            }
            else
            {
               this.FCurrentPetState = this.State_Leaved;
            }
         }
         if(!param1)
         {
            if(this.FCurrentPetState != this.State_Following)
            {
               this.FCurrentPetState = this.State_Following;
            }
         }
      }
      
      public function Assign(param1:TRoleCanControl) : void
      {
         this.RelexBoo = param1.RelexBoo;
         FTextrueID = param1.TextureID;
      }
      
      override public function UpdateData() : void
      {
         switch(this.FCurrentPetState)
         {
            case this.State_Following:
               this.UpdatePetPosition();
               break;
            case this.State_Leaveing:
            case this.State_Leaved:
         }
         super.UpdateData();
      }
      
      override public function UpdateView() : void
      {
         switch(this.FCurrentPetState)
         {
            case this.State_Following:
               this.UpdateDirection();
            case this.State_Leaveing:
               super.UpdateView();
               UpdateDisplayObjectPosition(FTextFiledName);
               break;
            case this.State_Leaved:
         }
      }
      
      override public function Release() : void
      {
         super.Release();
         parent.removeChild(this);
         StubReferences.Dereference(this.FFollowRole);
         this.FollowRole = null;
         this.FCurrentPetState = this.State_Leaved;
      }
      
      public function Reset() : void
      {
         super.Release();
      }
      
      public function Init() : void
      {
         if(!this.RelexBoo)
         {
            this.InitPetName();
            if(FTextrueID > 18101900)
            {
               ChangeTextureID(this.FPetImageVO.HeadPic);
            }
            else
            {
               ChangeTextureID(FTextrueID);
            }
         }
         FOnArriveTarget = StopToNormalIdle;
      }
   }
}

