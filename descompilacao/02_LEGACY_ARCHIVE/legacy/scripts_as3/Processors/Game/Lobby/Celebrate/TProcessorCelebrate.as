package Processors.Game.Lobby.Celebrate
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TCharacter;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyPlate;
   import Processors.Game.Lobby.MainScene.TLayerBackGround;
   import Processors.Game.Lobby.MainScene.TLayerCanMove;
   import Processors.Game.Lobby.MainScene.TLayerLittleScript;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.Sprite;
   import flash.utils.ByteArray;
   
   public class TProcessorCelebrate extends TProcessorLobbyPlate
   {
      
      protected static const SendToServerPositionMinimumSpacing:int = 300 * 300;
      
      protected var FPreTargetMapX:int;
      
      protected var FPreTargetMapY:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FIsArriveTarget:Boolean;
      
      protected var FBackGround:TLayerBackGround;
      
      protected var FBackLayerMask:Sprite;
      
      protected var FCanMove:TLayerCanMove;
      
      protected var FMonsterLayer:TUIComponent;
      
      protected var FLayerLittleScript:TLayerLittleScript;
      
      protected var FOnEnterCityScene:Function;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      protected var FOnUpdateReturnHomePanel:Function;
      
      protected var FSetSceneBitmapData:Function;
      
      protected var FOnEndAutoBattle:Function;
      
      protected var FExecuteCommand:Function;
      
      protected var FOpenThisPanel:Function;
      
      public function TProcessorCelebrate(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FBackGround = new TLayerBackGround(this,CONST_MODULES.MODULE_TraitorAttack);
         this.FBackGround.OnLoadCompleted = this.ProcessorResourcesOnLoadCompleted;
         this.FBackGround.IsNeedSmallPic = false;
         this.FBackGround.visible = true;
         this.FBackGround.RoleControlWidth = CONST_COMMON.STAGE_Width;
         this.FBackLayerMask = new Sprite();
         this.FBackLayerMask.graphics.beginFill(0,0.2);
         this.FBackLayerMask.graphics.drawRect(0,0,this.FBackGround.Width,this.FBackGround.Height);
         this.FBackLayerMask.graphics.endFill();
         this.FBackLayerMask.visible = false;
         this.addChild(this.FBackLayerMask);
         this.FCanMove = new TLayerCanMove(this.FBackGround,CONST_MODULES.MODULE_TraitorAttack);
         this.FCanMove.visible = false;
         this.FMonsterLayer = new TUIComponent(this.FBackGround);
         this.FLayerLittleScript = new TLayerLittleScript(this);
         this.FLayerLittleScript.visible = true;
         this.FLayerLittleScript.MouseEventObject = this.FBackGround;
         this.FLayerLittleScript.ChangeRolePositionByMouse = this.OnMoveByMouse;
         this.FLayerLittleScript.LongClickMove = false;
         this.FCharacter = SLogicsCore.Character;
         SetUIModuleID(CONST_MODULES.MODULE_Celebrate);
      }
      
      protected function ProcessorResourcesOnLoadCompleted(param1:Object) : void
      {
         this.FCanMove.visible = true;
      }
      
      protected function OnMoveByMouse() : void
      {
         this.FIsArriveTarget = false;
         this.UpdateRolePositionSendToServer();
      }
      
      protected function UpdateRolePositionSendToServer() : void
      {
         var _loc1_:int = this.FLayerLittleScript.TargetMapX - this.FPreTargetMapX;
         var _loc2_:int = this.FLayerLittleScript.TargetMapY - this.FPreTargetMapY;
         var _loc3_:Number = _loc1_ * _loc1_ + _loc2_ * _loc2_;
         if(_loc3_ > SendToServerPositionMinimumSpacing)
         {
            this.FPreTargetMapX = this.FLayerLittleScript.TargetMapX;
            this.FPreTargetMapY = this.FLayerLittleScript.TargetMapY;
            this.PacketPerform_CS_LOBBY_Town_Move(this.FLayerLittleScript.TargetMapX,this.FLayerLittleScript.TargetMapY);
         }
      }
      
      protected function PacketPerform_CS_LOBBY_Town_Move(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LOBBY_Town_Move);
         var _loc4_:ByteArray = _loc3_.Data;
         _loc4_.writeShort(param1);
         _loc4_.writeShort(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnUpdateReturnHomePanel(param1:Function) : void
      {
         this.FOnUpdateReturnHomePanel = param1;
      }
      
      public function get OnUpdateReturnHomePanel() : Function
      {
         return this.FOnUpdateReturnHomePanel;
      }
      
      public function get SetSceneBitmapData() : Function
      {
         return this.FSetSceneBitmapData;
      }
      
      public function set SetSceneBitmapData(param1:Function) : void
      {
         this.FSetSceneBitmapData = param1;
      }
      
      public function get OnEndAutoBattle() : Function
      {
         return this.FOnEndAutoBattle;
      }
      
      public function set OnEndAutoBattle(param1:Function) : void
      {
         this.FOnEndAutoBattle = param1;
      }
      
      public function get OnEnterCityScene() : Function
      {
         return this.FOnEnterCityScene;
      }
      
      public function set OnEnterCityScene(param1:Function) : void
      {
         this.FOnEnterCityScene = param1;
      }
      
      public function get ExecuteCommand() : Function
      {
         return this.FExecuteCommand;
      }
      
      public function set ExecuteCommand(param1:Function) : void
      {
         this.FExecuteCommand = param1;
      }
      
      public function set OpenThisPanel(param1:Function) : void
      {
         this.FOpenThisPanel = param1;
      }
   }
}

