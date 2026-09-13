package Processors.Game.Lobby.InviteCode
{
   import Components.Standard.TUITab;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVITECODE;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorInviteCode extends TProcessorLobbyWindows
   {
      
      protected var FScene:MovieClip;
      
      protected var FUI_Tab:TUITab;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FProcesorInviteCodeList:TProcessorInviteCodeList;
      
      protected var FProcesorInviteCodeBinding:TProcessorInviteCodeBind;
      
      protected var FProcesorInviteCodeUser:TProcessorInviteCodeUser;
      
      protected var FMCInstanceList:Array;
      
      protected var FTabIndex:int;
      
      protected var FInviteCodeInfoVec:Array;
      
      public function TProcessorInviteCode(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FMCInstanceList = [];
         this.FProcesorInviteCodeList = new TProcessorInviteCodeList();
         this.FMCInstanceList.push(this.FProcesorInviteCodeList);
         this.FProcesorInviteCodeBinding = new TProcessorInviteCodeBind();
         this.FProcesorInviteCodeBinding.RequestBindFun = this.PerformPacket_CS_InviteCode_UseReq;
         this.FProcesorInviteCodeBinding.OnOver = UIComponentsHintOnOver;
         this.FProcesorInviteCodeBinding.OnOut = UIComponentsHintOnOut;
         this.FMCInstanceList.push(this.FProcesorInviteCodeBinding);
         this.FProcesorInviteCodeUser = new TProcessorInviteCodeUser();
         this.FMCInstanceList.push(this.FProcesorInviteCodeUser);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_INVITECODE.RESOURCESID_InviteCode);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_INVITECODE.Resource_ClassName_InviteCode) as MovieClip;
         addChild(this.FScene);
         this.FBTN_Close = this.FScene[CONST_INVITECODE.RESOURCE_Link_Btn_Close];
         this.FUI_Tab = new TUITab(this);
         _loc1_ = 0;
         while(_loc1_ < CONST_INVITECODE.CAPACITY_MC_Tabs)
         {
            _loc2_ = this.FScene[CONST_INVITECODE.Resource_Mc_Tab + _loc1_];
            this.FUI_Tab.SetTabByIndex(_loc2_,_loc1_);
            _loc1_++;
         }
         this.FUI_Tab.Init();
         this.FUI_Tab.OnSwitch = this.OnTabChange;
         _loc1_ = 1;
         while(_loc1_ <= this.FMCInstanceList.length)
         {
            this.FMCInstanceList[_loc1_ - 1].Perform_UIDispatch(this.FScene["MC_InviteCode_" + _loc1_]);
            _loc1_++;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.onCloseHandler);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_InviteCode_List_Ret,this.PerformPacket_SC_InviteCode_ListRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_InviteCode_Use_Ret,this.PerformPacket_SC_InviteCode_UseRet);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted)
         {
            this.FProcesorInviteCodeBinding.UpdateSlot();
         }
      }
      
      protected function PerformPacket_SC_InviteCode_ListRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:InviteCodeVO = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readShort();
         this.FInviteCodeInfoVec = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new InviteCodeVO();
            _loc7_.InviteCode = TUtilityString.FetchUTF(_loc2_);
            _loc7_.UserName = TUtilityString.FetchUTF(_loc2_);
            _loc7_.Recharge_gold = _loc2_.readUnsignedInt();
            this.FInviteCodeInfoVec.push(_loc7_);
            _loc5_++;
         }
         this.FProcesorInviteCodeBinding.TotalGold = _loc2_.readInt();
         this.FProcesorInviteCodeList.UpdateInviteCodeList(this.FInviteCodeInfoVec);
         this.FProcesorInviteCodeUser.UpdateInviteCodeList(this.FInviteCodeInfoVec);
         this.InitInviteCodeConfigData();
      }
      
      protected function PerformPacket_SC_InviteCode_UseRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         EffectGenerateText(new ConsumeFrame(CONST_SYSTEMLANGUAGE.STRING_yaoqingma_02).DescribeString);
      }
      
      protected function PerformPacket_CS_InviteCode_ListReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_InviteCode_List_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_InviteCode_UseReq(param1:String) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_InviteCode_Use_Req);
         TUtilityString.FlushUTF(_loc2_.Data,param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function onCloseHandler(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnTabChange(param1:int) : void
      {
         var _loc2_:int = 0;
         this.FTabIndex = param1;
         var _loc3_:uint = this.FMCInstanceList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(param1 == _loc2_)
            {
               this.FMCInstanceList[_loc2_].Visible = true;
            }
            else
            {
               this.FMCInstanceList[_loc2_].Visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function InitInviteCodeConfigData() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:Vector.<Object> = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,92000006) as TConfigValue;
         _loc2_ = _loc1_.Value as Vector.<Object>;
         this.FProcesorInviteCodeBinding.UpdateInviteCodeList(_loc2_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.OnTabChange(this.FTabIndex);
         this.PerformPacket_CS_InviteCode_ListReq();
      }
   }
}

class InviteCodeVO
{
   
   public var InviteCode:String;
   
   public var UserName:String;
   
   public var Recharge_gold:int;
   
   public function InviteCodeVO()
   {
      super();
   }
}
