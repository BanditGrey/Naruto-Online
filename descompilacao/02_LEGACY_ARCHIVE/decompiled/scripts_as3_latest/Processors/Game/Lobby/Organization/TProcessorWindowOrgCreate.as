package Processors.Game.Lobby.Organization
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.SensitiveWord.SSensitiveWord;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_ORGANIZATION;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowOrgCreate extends TProcessorLobbyWindow
   {
      
      protected var FMC:Sprite;
      
      protected var FTF_InputOrgName:TextField;
      
      protected var FTF_Prompt:TextField;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_Cancel:MovieClip;
      
      public function TProcessorWindowOrgCreate(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_ORGANIZATION.RESOURCESID_Swf_OrganizationMain);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_ORGANIZATION.RESOURCE_ClassName_MC_CreateOrganization) as Sprite;
         addChild(this.FMC);
         this.FTF_InputOrgName = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_InputOrgName];
         this.FTF_InputOrgName.text = "";
         this.FTF_Prompt = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_TF_Prompt];
         this.FBtn_Ok = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_Ok];
         this.FBtn_Cancel = this.FMC[CONST_ORGANIZATION.RESOURCE_Link_Btn_Cancel];
         TGameUtil.setButtonMode(this.FBtn_Ok,true);
         TGameUtil.setButtonMode(this.FBtn_Cancel,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnOkClick);
         this.FBtn_Cancel.addEventListener(MouseEvent.CLICK,OnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUI() : void
      {
         this.FTF_InputOrgName.text = "";
      }
      
      protected function OnOkClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:TPacket = null;
         var _loc5_:ByteArray = null;
         _loc2_ = String(this.FTF_InputOrgName.text);
         _loc2_ = SSensitiveWord.Filter(_loc2_);
         _loc3_ = _loc2_.indexOf("*");
         if(_loc3_ != -1)
         {
            EffectGenerateText(STRING_ORGANIZATION.STRING_OrgNameIllegalCharacter);
            return;
         }
         if(_loc2_ == null || _loc2_ == "")
         {
            EffectGenerateText(STRING_ORGANIZATION.STRING_OrgNameIsNull);
            return;
         }
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Organization_CreateGulidReq);
         _loc5_ = _loc4_.Data;
         TUtilityString.FlushUTF(_loc5_,_loc2_);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      public function UpDateUI() : void
      {
         this.UpdateUI();
      }
   }
}

