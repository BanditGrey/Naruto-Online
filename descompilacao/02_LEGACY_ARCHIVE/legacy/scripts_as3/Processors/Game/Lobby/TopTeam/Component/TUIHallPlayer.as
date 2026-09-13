package Processors.Game.Lobby.TopTeam.Component
{
   import Foundation.UI.TUIComponent;
   import Logics.SLogicsCore;
   import Logics.TopTeam.THallPlayer;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_COMMON;
   import flash.text.TextField;
   
   public class TUIHallPlayer extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Job:TextField;
      
      public function TUIHallPlayer(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FTF_Job = FResource["TF_Job"];
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:THallPlayer = null;
         _loc1_ = FContext as THallPlayer;
         this.FTF_Name.text = _loc1_.Name;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.Level);
         this.FTF_Job.text = STRING_COMMON.TYPE_PROFESSIONS[_loc1_.Job];
      }
   }
}

