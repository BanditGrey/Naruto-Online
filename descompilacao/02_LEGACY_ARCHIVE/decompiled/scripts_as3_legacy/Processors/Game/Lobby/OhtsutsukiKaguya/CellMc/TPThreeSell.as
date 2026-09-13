package Processors.Game.Lobby.OhtsutsukiKaguya.CellMc
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.SLogicsCore;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TPThreeSell
   {
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FTF_Name:TextField = null;
      
      protected var FTF_Price:TextField = null;
      
      protected var FTF_CurPrice:TextField = null;
      
      protected var FBTN_Confirm:MovieClip = null;
      
      protected var FCurIndex:int;
      
      protected var FBackOpen:Function;
      
      public function TPThreeSell()
      {
         super();
      }
      
      public function SetThisPanel(param1:MovieClip, param2:int) : void
      {
         this.FThisPanel = param1;
         this.FCurIndex = param2;
         this.Initilization();
      }
      
      protected function Initilization() : void
      {
         this.FTF_Name = this.FThisPanel["TF_Name"];
         this.FTF_Price = this.FThisPanel["TF_Price"];
         this.FTF_CurPrice = this.FThisPanel["TF_CurPrice"];
         this.FBTN_Confirm = this.FThisPanel["BTN_Confirm"];
         TGameUtil.setButtonMode(this.FBTN_Confirm,true);
         this.FBTN_Confirm.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      public function Update() : void
      {
         this.FTF_Name.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.add_Today_count,SLogicsCore.KaguyaData.TimeArr[this.FCurIndex][1]);
         this.FTF_CurPrice.text = String(SLogicsCore.KaguyaData.GoldArr[this.FCurIndex][1]);
         this.FTF_Price.text = String(SLogicsCore.KaguyaData.BeforeGoldArr[this.FCurIndex][1]);
      }
      
      public function set BackOpen(param1:Function) : void
      {
         this.FBackOpen = param1;
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         if(this.FBackOpen != null)
         {
            this.FBackOpen(this.FCurIndex);
         }
      }
   }
}

