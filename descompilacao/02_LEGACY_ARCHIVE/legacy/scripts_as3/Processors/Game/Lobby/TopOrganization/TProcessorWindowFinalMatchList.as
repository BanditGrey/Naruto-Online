package Processors.Game.Lobby.TopOrganization
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.TopOrganization.TGVG3Top32Org;
   import Processors.Game.Lobby.Common.TProcessorWindowTemplate;
   import Processors.Game.Lobby.TopOrganization.Componets.TUIFinalMatchList;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowFinalMatchList extends TProcessorWindowTemplate
   {
      
      protected const STRING_GVG3RewardTipsVec:Vector.<uint> = Vector.<uint>([CONST_SYSTEMLANGUAGE.GVG_STRING_20,CONST_SYSTEMLANGUAGE.GVG_STRING_21,CONST_SYSTEMLANGUAGE.GVG_STRING_22,CONST_SYSTEMLANGUAGE.GVG_STRING_23]);
      
      protected var FTF_CDTime:TextField;
      
      protected var FMC_Explanation:SimpleButton;
      
      protected var FUIFinalMatchList:TUIFinalMatchList;
      
      protected var FRankingBoxVec:Vector.<MovieClip>;
      
      protected var FHint:THint;
      
      protected var FTabIndex:uint;
      
      protected var FOnReturnMainUI:Function;
      
      protected var FBetOnClick:Function;
      
      protected var FLookOnClick:Function;
      
      public function TProcessorWindowFinalMatchList(param1:TUIComponent)
      {
         super(param1);
         this.Init();
      }
      
      protected function Init() : void
      {
         this.FRankingBoxVec = new Vector.<MovieClip>(CONST_TOPORGANIZATION.CAPACITY_Boxes);
         this.FUIFinalMatchList = new TUIFinalMatchList(this);
         this.FUIFinalMatchList.TabOnClick = this.ProcessorTabOnClick;
         this.FUIFinalMatchList.BetOnClick = this.ProcessorBetOnClick;
         this.FUIFinalMatchList.OnEffectText = this.ProcessorOnEffectText;
         this.FUIFinalMatchList.LookOnClick = this.ProcessorLookOnClick;
         this.FHint = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TOPORGANIZATION.RESOURCESID_Swf_TopOrganization);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function LogicsPerform() : void
      {
         if(!Visible)
         {
            return;
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Sprite = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         FMainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_TOPORGANIZATION.RESOURCE_ClassName_MC_FinalMatchList) as Sprite;
         UIDispatch();
         this.FTF_CDTime = FMainUI["TF_CDTime"];
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = FMainUI["MC_Boxes"]["MC_Box_" + _loc1_] as MovieClip;
            _loc4_.gotoAndStop(_loc1_ + 1);
            this.FRankingBoxVec[_loc1_] = _loc4_;
            _loc1_++;
         }
         this.FUIFinalMatchList.UIDispatch();
         this.FUIFinalMatchList.x = FMainUI.x + 128;
         this.FUIFinalMatchList.y = FMainUI.y + 191;
         addChild(this.FUIFinalMatchList);
         this.FMC_Explanation = FMainUI["MC_Explanation"];
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         UILocations();
         _loc2_ = CONST_TOPORGANIZATION.CAPACITY_Boxes;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FRankingBoxVec[_loc1_];
            _loc3_.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRewardOnOver,false,0,true);
            _loc3_.addEventListener(MouseEvent.MOUSE_OUT,this.MCRewardOnOut,false,0,true);
            _loc1_++;
         }
         this.FMC_Explanation.addEventListener(MouseEvent.MOUSE_MOVE,this.MCExplanationOnOver,false,0,true);
         this.FMC_Explanation.addEventListener(MouseEvent.MOUSE_OUT,this.MCExplanationOnOut,false,0,true);
         this.FUIFinalMatchList.UILocations();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function ResourcesPerform_UIFinalize() : void
      {
         var _loc1_:TSystemLanguage = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.GVG_Tips_09) as TSystemLanguage;
         FHelpTips.Content = _loc1_.Desc;
         super.ResourcesPerform_UIFinalize();
      }
      
      protected function UpdateUI() : void
      {
         this.FUIFinalMatchList.Update();
      }
      
      protected function ProcessorOnEffectText(param1:String) : void
      {
         if(FOnEffectText != null)
         {
            FOnEffectText(this,param1);
         }
      }
      
      protected function ProcessorBetOnClick(param1:Object, param2:TGVG3Top32Org, param3:TGVG3Top32Org) : void
      {
         if(this.FBetOnClick != null)
         {
            this.FBetOnClick(this,param2.AgentID,param2.ServerID,param2.OrgID,param3.AgentID,param3.ServerID,param3.OrgID);
         }
      }
      
      protected function ProcessorLookOnClick(param1:Object, param2:TGVG3Top32Org, param3:TGVG3Top32Org) : void
      {
         if(this.FLookOnClick != null)
         {
            this.FLookOnClick(this,param2.AgentID,param2.ServerID,param2.OrgID,param3.AgentID,param3.ServerID,param3.OrgID);
         }
      }
      
      protected function ProcessorTabOnClick(param1:Object, param2:int) : void
      {
         this.FTabIndex = param2;
         this.PacketPerform_CS_GVG3_GetTop_Req(param2);
      }
      
      protected function PacketPerform_CS_GVG3_GetBetState_Req(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetBetState_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_GVG3_GetTop_Req(param1:uint) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TopOrganization_GVG3_GetTop_Req);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      override protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         super.ButtonCloseOnClick(param1);
         this.FUIFinalMatchList.Reset();
      }
      
      protected function MCRewardOnOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         var _loc4_:TSystemLanguage = null;
         _loc3_ = uint((param1.currentTarget as MovieClip).name.split("_")[2]);
         _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.STRING_GVG3RewardTipsVec[_loc3_]) as TSystemLanguage;
         if(_loc4_ != null)
         {
            this.FHint.Content = _loc4_.Desc;
            if(FOnHelpTipsOver != null)
            {
               FOnHelpTipsOver(this,this.FHint);
            }
         }
      }
      
      protected function MCRewardOnOut(param1:MouseEvent) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      protected function MCExplanationOnOver(param1:MouseEvent) : void
      {
         if(FOnHelpTipsOver != null)
         {
            FOnHelpTipsOver(this,FHelpTips);
         }
      }
      
      protected function MCExplanationOnOut(param1:MouseEvent) : void
      {
         if(FOnHelpTipsOut != null)
         {
            FOnHelpTipsOut(this);
         }
      }
      
      public function set OnReturnMainUI(param1:Function) : void
      {
         this.FOnReturnMainUI = param1;
      }
      
      public function set BetOnClick(param1:Function) : void
      {
         this.FBetOnClick = param1;
      }
      
      public function set LookOnClick(param1:Function) : void
      {
         this.FLookOnClick = param1;
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function UpdateNotify() : void
      {
         this.FUIFinalMatchList.UpdateNotify();
      }
      
      public function UpdateBetButtonUI() : void
      {
         this.FUIFinalMatchList.UpdateBetButtonUI();
      }
      
      public function RequestBetState() : void
      {
         this.PacketPerform_CS_GVG3_GetBetState_Req(this.FTabIndex);
      }
      
      public function UpdateCDTimeText(param1:uint) : void
      {
         this.FTF_CDTime.text = TGameUtil.fomatSmallTime(param1);
      }
   }
}

