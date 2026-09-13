package Processors.Game.Lobby.Organization.Component
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Organization.TBaseOrganizationMember;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TUIOrgApplyListElement extends TUIComponent
   {
      
      protected var FIsInitialization:Boolean;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Rank:TextField;
      
      protected var FTF_MilitaryPower:TextField;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_Refuse:MovieClip;
      
      protected var FPlayerData:TBaseOrganizationMember;
      
      protected var FMC:MovieClip;
      
      protected var FClickBtn:Function;
      
      public function TUIOrgApplyListElement(param1:TUIComponent)
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
         this.FBtn_Refuse = this.FMC["Btn_Refuse"];
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         TGameUtil.setButtonMode(this.FBtn_Refuse,true);
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnBtnOkClick);
         this.FBtn_Refuse.addEventListener(MouseEvent.CLICK,this.OnBtnRefuseClick);
      }
      
      protected function UpdateList() : void
      {
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
      
      protected function OnBtnOkClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ConfirmApplyJoinGuildReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeShort(1);
         _loc3_.writeUnsignedInt(this.FPlayerData.Identifier0);
         _loc3_.writeUnsignedInt(this.FPlayerData.Identifier1);
         _loc3_.writeByte(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         if(this.FClickBtn != null)
         {
            this.FClickBtn(this,1,this.FPlayerData.Identifier0,this.FPlayerData.Identifier1);
         }
      }
      
      protected function OnBtnRefuseClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ConfirmApplyJoinGuildReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeShort(1);
         _loc3_.writeUnsignedInt(this.FPlayerData.Identifier0);
         _loc3_.writeUnsignedInt(this.FPlayerData.Identifier1);
         _loc3_.writeByte(0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         if(this.FClickBtn != null)
         {
            this.FClickBtn(this,0,this.FPlayerData.Identifier0,this.FPlayerData.Identifier1);
         }
      }
      
      public function get MC() : MovieClip
      {
         return this.FMC;
      }
      
      public function get ClickBtn() : Function
      {
         return this.FClickBtn;
      }
      
      public function set ClickBtn(param1:Function) : void
      {
         this.FClickBtn = param1;
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

