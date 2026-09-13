package Processors.Game.Lobby.Organization.Component
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.Organization.TBaseOrganiztionList;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TUIOrgMemberListElement extends TUIComponent
   {
      
      protected var FTF_Ranking:TextField;
      
      protected var FMC_Home:MovieClip;
      
      protected var FTF_OrgName:TextField;
      
      protected var FTF_OrgLevel:TextField;
      
      protected var FTF_OrgMasterName:TextField;
      
      protected var FTF_OrgMembers:TextField;
      
      protected var FBTN_ApplyOrg:MovieClip;
      
      protected var FIsInitialization:Boolean;
      
      protected var FElementData:TBaseOrganiztionList;
      
      protected var FOrgID:uint;
      
      protected var FRank:uint;
      
      protected var FBAddOrg:Boolean;
      
      protected var FMC:MovieClip;
      
      protected var FClickApplyOrg:Function;
      
      public function TUIOrgMemberListElement(param1:TUIComponent)
      {
         super(param1);
         this.FIsInitialization = false;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC = param1;
         this.FTF_Ranking = this.FMC["TF_Ranking"];
         this.FMC_Home = this.FMC["MC_Home"];
         this.FTF_OrgName = this.FMC["TF_OrgName"];
         this.FTF_OrgLevel = this.FMC["TF_OrgLevel"];
         this.FTF_OrgMasterName = this.FMC["TF_OrgMasterName"];
         this.FTF_OrgMembers = this.FMC["TF_OrgMembers"];
         this.FBTN_ApplyOrg = this.FMC["BTN_ApplyOrg"];
         TGameUtil.setButtonMode(this.FBTN_ApplyOrg,true);
         this.FBTN_ApplyOrg.addEventListener(MouseEvent.CLICK,this.OnApplyOrgClick);
      }
      
      protected function UpdateElement(param1:TBaseOrganiztionList) : void
      {
         this.FOrgID = param1.OrgID;
         this.FTF_Ranking.text = String(this.FRank);
         this.FMC_Home.gotoAndStop(param1.OrgFamily > 0 ? param1.OrgFamily : 1);
         this.FTF_OrgName.text = param1.OrgName;
         this.FTF_OrgLevel.text = String(param1.OrgLevel);
         this.FTF_OrgMasterName.text = param1.OrgMasterName;
         this.FTF_OrgMembers.text = param1.OrgMembersCount + "/" + param1.OrgMaxMemberCount;
         if(!this.FBAddOrg)
         {
            if(SLogicsCore.Character.Country == param1.OrgFamily)
            {
               if(!param1.OrgIsApply)
               {
                  this.FBTN_ApplyOrg.visible = true;
               }
               else
               {
                  this.FBTN_ApplyOrg.visible = false;
               }
            }
            else
            {
               this.FBTN_ApplyOrg.visible = false;
            }
         }
         else
         {
            this.FBTN_ApplyOrg.visible = false;
         }
      }
      
      protected function OnApplyOrgClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FOrgID > 0)
         {
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_ApplyJoinGulidReq);
            _loc3_ = _loc2_.Data;
            _loc3_.writeUnsignedInt(this.FOrgID);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         }
         this.FBTN_ApplyOrg.visible = false;
      }
      
      public function get ClickApplyOrg() : Function
      {
         return this.FClickApplyOrg;
      }
      
      public function set ClickApplyOrg(param1:Function) : void
      {
         this.FClickApplyOrg = param1;
      }
      
      public function get MC() : MovieClip
      {
         return this.FMC;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FIsInitialization = true;
      }
      
      public function UpDateElement(param1:TBaseOrganiztionList, param2:uint, param3:Boolean) : void
      {
         this.FBAddOrg = param3;
         this.FRank = param2;
         this.UpdateElement(param1);
      }
   }
}

