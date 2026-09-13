package Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc
{
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPFreeCell
   {
      
      protected var ThisPanel:MovieClip = null;
      
      protected var Fall_value:TextField = null;
      
      protected var Fnow_value:TextField = null;
      
      protected var FFree_Trial_btn:SimpleButton = null;
      
      protected var FBackFun:Function;
      
      public function TPFreeCell()
      {
         super();
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.ThisPanel = param1;
         this.initilization();
      }
      
      public function initilization() : void
      {
         this.Fall_value = this.ThisPanel["all_value"];
         this.Fnow_value = this.ThisPanel["now_value"];
         this.FFree_Trial_btn = this.ThisPanel["Free_Trial_btn"];
         this.FFree_Trial_btn.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function Update() : void
      {
         this.Fall_value.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.TF_All_Vslue,SLogicsCore.KaguyaData.BeforeValue);
         this.Fnow_value.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.TF_Now_Value,SLogicsCore.KaguyaData.GoldArr[0][1]);
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         if(this.FBackFun != null)
         {
            this.FBackFun();
         }
      }
      
      public function getThisPanel() : MovieClip
      {
         return this.ThisPanel;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
   }
}

