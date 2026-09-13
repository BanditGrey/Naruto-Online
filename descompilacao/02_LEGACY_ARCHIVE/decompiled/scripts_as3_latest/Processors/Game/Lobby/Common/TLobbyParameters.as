package Processors.Game.Lobby.Common
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.Actuators.TActuatorBarrier;
   import Processors.Game.Lobby.Spaces.LobbySpace;
   
   use namespace LobbySpace;
   
   public class TLobbyParameters
   {
      
      protected var FActuatorBarrier:TActuatorBarrier;
      
      protected var FMountPointIcons:TUIComponent;
      
      protected var FMountPointWindow:TUIComponent;
      
      public function TLobbyParameters()
      {
         super();
         this.FActuatorBarrier = new TActuatorBarrier();
      }
      
      LobbySpace function CoerceProperties(param1:TUIComponent, param2:TUIComponent) : void
      {
         this.FMountPointIcons = param1;
         this.FMountPointWindow = param2;
      }
      
      public function get ActuatorBarrier() : TActuatorBarrier
      {
         return this.FActuatorBarrier;
      }
      
      public function get MountPointIcons() : TUIComponent
      {
         return this.FMountPointIcons;
      }
      
      public function get MountPointWindow() : TUIComponent
      {
         return this.FMountPointWindow;
      }
   }
}

