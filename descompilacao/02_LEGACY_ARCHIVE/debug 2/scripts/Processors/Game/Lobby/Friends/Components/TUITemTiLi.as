package Processors.Game.Lobby.Friends.Components
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TFriendDigestTiLi;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_FRIEND;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUITemTiLi
   {
      
      protected var FThisPanel:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_TiLi:TextField;
      
      protected var FMC_GetBtn:MovieClip;
      
      protected var FCurData:TFriendDigestTiLi;
      
      protected var FBackFun:Function;
      
      public function TUITemTiLi()
      {
         super();
      }
      
      public function set ThisPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.Initilization();
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
      
      protected function Initilization() : void
      {
         this.FTF_Name = this.FThisPanel["TF_Name"];
         this.FTF_Level = this.FThisPanel["TF_Level"];
         this.FTF_TiLi = this.FThisPanel["TF_TiLi"];
         this.FMC_GetBtn = this.FThisPanel["MC_GetBtn"];
         this.FMC_GetBtn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function set SetDate(param1:TFriendDigestTiLi) : void
      {
         this.FCurData = param1;
         this.UpdateView();
      }
      
      public function UpdateView() : void
      {
         this.FTF_Name.text = this.FCurData.Name;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FCurData.Level);
         this.FTF_TiLi.text = TUtilityString.Format(STRING_FRIEND.STRING_GiveDec,SLogicsCore.Friends.OneTimesNum);
         if(this.FCurData.IsGet)
         {
            TGameUtil.setButtonMode(this.FMC_GetBtn,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_GetBtn,true);
         }
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         if(!this.FMC_GetBtn.buttonMode)
         {
            return;
         }
         if(this.FBackFun != null)
         {
            this.FBackFun(this.FCurData);
         }
      }
   }
}

