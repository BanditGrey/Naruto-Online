package Processors.Game.Lobby.Organization.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIOrgSwitchPowerListElement extends TUIComponent
   {
      
      protected var FIsInitialization:Boolean;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Rank:TextField;
      
      protected var FTF_MilitaryPower:TextField;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FPlayerData:TBaseOrganizationMember;
      
      protected var FMC:MovieClip;
      
      protected var FClickOnOk:Function;
      
      public function TUIOrgSwitchPowerListElement(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         this.FTF_Name = this.FMC["TF_Name"];
         this.FTF_Level = this.FMC["TF_Level"];
         this.FTF_Rank = this.FMC["TF_Rank"];
         this.FTF_MilitaryPower = this.FMC["TF_MilitaryPower"];
         this.FBtn_Ok = this.FMC["Btn_Ok"];
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnOkClick);
      }
      
      protected function UpdateList() : void
      {
         if(this.FPlayerData.Identifier0 == SLogicsCore.Character.Identifier0 && this.FPlayerData.Identifier1 == SLogicsCore.Character.Identifier1)
         {
            this.FBtn_Ok.visible = false;
         }
         else
         {
            this.FBtn_Ok.visible = true;
         }
         if(this.FPlayerData != null)
         {
            this.FTF_Name.text = String(this.FPlayerData.PlayerName);
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevel(this.FPlayerData.PlayerLevel);
            this.FTF_Rank.text = String(this.FPlayerData.Rank);
            this.FTF_MilitaryPower.text = String(this.FPlayerData.PlayerOrgPower);
         }
         else
         {
            this.FTF_Name.text = "";
            this.FTF_Level.text = "";
            this.FTF_Rank.text = "";
            this.FTF_MilitaryPower.text = "";
         }
      }
      
      protected function OnOkClick(param1:MouseEvent) : void
      {
         if(this.FClickOnOk != null)
         {
            this.FClickOnOk(this,this.FPlayerData.Identifier0,this.FPlayerData.Identifier1);
         }
      }
      
      public function get MC() : MovieClip
      {
         return this.FMC;
      }
      
      public function get ClickOnOk() : Function
      {
         return this.FClickOnOk;
      }
      
      public function set ClickOnOk(param1:Function) : void
      {
         this.FClickOnOk = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpDateList(param1:TBaseOrganizationMember) : void
      {
         this.FPlayerData = param1;
         this.UpdateList();
      }
   }
}

