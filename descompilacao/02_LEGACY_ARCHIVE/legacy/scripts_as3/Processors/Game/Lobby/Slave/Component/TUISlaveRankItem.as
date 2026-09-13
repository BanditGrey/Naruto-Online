package Processors.Game.Lobby.Slave.Component
{
   import Foundation.UI.TUIComponent;
   import Logics.Slave.TSlaveRank;
   import Processors.Game.TProcessorGame;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TUISlaveRankItem extends TProcessorGame
   {
      
      protected var FTF_Rank:TextField;
      
      protected var FTF_UserName:TextField;
      
      protected var FTF_Server:TextField;
      
      protected var FTF_Count:TextField;
      
      protected var FResource:MovieClip;
      
      public function TUISlaveRankItem(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Initializition() : void
      {
         this.FTF_Rank = this.FResource["TF_Rank"];
         this.FTF_UserName = this.FResource["TF_UserName"];
         this.FTF_Server = this.FResource["TF_Server"];
         this.FTF_Count = this.FResource["TF_Count"];
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function Init() : void
      {
         this.Initializition();
      }
      
      public function SetInfo(param1:TSlaveRank) : void
      {
         this.FTF_Rank.text = param1.Rank.toString();
         this.FTF_UserName.text = param1.UserName;
         this.FTF_Server.text = param1.Server;
         this.FTF_Count.text = param1.Count.toString();
      }
   }
}

