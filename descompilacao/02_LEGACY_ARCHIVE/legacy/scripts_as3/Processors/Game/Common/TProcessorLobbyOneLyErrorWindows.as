package Processors.Game.Common
{
   import Foundation.UI.TUIComponent;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   
   public class TProcessorLobbyOneLyErrorWindows extends TProcessorLobbyWindows
   {
      
      public function TProcessorLobbyOneLyErrorWindows(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
      }
      
      public function IntroductionError(param1:int) : void
      {
         EffectGenerateTextByErrorCode(param1);
      }
   }
}

