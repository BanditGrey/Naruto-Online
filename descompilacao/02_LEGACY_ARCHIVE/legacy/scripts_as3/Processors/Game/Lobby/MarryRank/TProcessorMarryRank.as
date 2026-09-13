package Processors.Game.Lobby.MarryRank
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TMarryClass;
   import Logics.DatebaseVO.VO.TMarryRankgift;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.MarryRank.Panel.TUIMarryRankRewards;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorMarryRank extends TProcessorLobbyWindows
   {
      
      protected var FPage:int = -1;
      
      protected var FMaxPage:int = -1;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FRewards:TUIMarryRankRewards;
      
      protected var FHelpTips:THint;
      
      public function TProcessorMarryRank(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         TMarryRankModel.ProcessorOnRankRet = this.ProcessorOnRankRet;
         TMarryRankModel.ProcessorOnReceiveRet = this.ProcessorOnReceiveRet;
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_MarryRank);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4043309060);
         super.ResourcesPerform_UIRequest();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_InfoReq();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_MarryRank") as MovieClip;
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.addChild(this.FMC_Scene);
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            this.FMC_Scene["MC_ExhibitList_" + _loc1_].visible = false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this.FMC_Scene["MC_RankList_" + _loc1_].visible = false;
            _loc1_++;
         }
         this.FRewards = new TUIMarryRankRewards(this);
         this.FRewards.OnItemOver = UIComponentsHintOnOver;
         this.FRewards.OnItemOut = UIComponentsHintOnOut;
         this.FRewards.Perform_UIDispatch(this.FMC_Scene["MC_Rewards"]);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_PageLeft,true);
         this.FMC_Scene.MC_PageLeft.addEventListener(MouseEvent.CLICK,this.OnPageLeftClick);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_PageRight,true);
         this.FMC_Scene.MC_PageRight.addEventListener(MouseEvent.CLICK,this.OnPageRightClick);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         this.FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Receive"],THomelandModel.selfHome.receive == 0);
         this.FMC_Scene["BTN_Receive"].addEventListener(MouseEvent.CLICK,this.OnReceiveClick);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Rewards"],true);
         this.FMC_Scene["BTN_Rewards"].addEventListener(MouseEvent.CLICK,this.OnRewardsClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted == false || Visible == false)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            if(this.FRewards.Visible)
            {
               this.FRewards.LogicsPerform();
            }
         }
      }
      
      protected function UpdateUI() : void
      {
         var _loc4_:Object = null;
         var _loc5_:TMarryClass = null;
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            this.FMC_Scene["MC_ExhibitList_" + _loc1_].visible = TMarryRankModel.MarryRanks.length > _loc1_;
            if(this.FMC_Scene["MC_ExhibitList_" + _loc1_].visible)
            {
               this.FMC_Scene["MC_ExhibitList_" + _loc1_]["Text_Host"].text = TMarryRankModel.MarryRanks[_loc1_].host;
               this.FMC_Scene["MC_ExhibitList_" + _loc1_]["Text_Hostess"].text = TMarryRankModel.MarryRanks[_loc1_].hostess;
            }
            _loc1_++;
         }
         var _loc2_:int = Math.max((this.FPage - 1) * 6,0);
         var _loc3_:int = Math.min(this.FPage * 6,TMarryRankModel.MarryRanks.length);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this.FMC_Scene["MC_RankList_" + _loc1_].visible = _loc2_ + _loc1_ < _loc3_;
            if(this.FMC_Scene["MC_RankList_" + _loc1_].visible)
            {
               _loc4_ = TMarryRankModel.MarryRanks[_loc2_ + _loc1_];
               _loc5_ = THomelandModel.getMarryVOByExp(_loc4_.charm);
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_Rank"].text = _loc4_.rank;
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_Host"].text = _loc4_.host;
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_Hostess"].text = _loc4_.hostess;
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_Host_Ring"].text = THomelandModel.getRingVOByExp(_loc4_.ring,_loc4_.hostRingExp).BuildLevel;
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_Hostess_Ring"].text = THomelandModel.getRingVOByExp(_loc4_.ring,_loc4_.hostessRingExp).BuildLevel;
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_MarryName"].text = _loc5_.Name + "(Lv." + _loc5_.Stars + ")";
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_MarryLevel"].text = TIllustratedModel.TextFormat(70480032,_loc4_.charm);
               this.FMC_Scene["MC_RankList_" + _loc1_]["Text_Server"].text = "S." + _loc4_.server;
            }
            _loc1_++;
         }
         this.FMC_Scene["MC_MyRank"].visible = TMarryRankModel.MyRank > 0;
         if(this.FMC_Scene["MC_MyRank"].visible)
         {
            _loc4_ = TMarryRankModel.MarryRanks[TMarryRankModel.MyRank - 1];
            _loc5_ = THomelandModel.getMarryVOByExp(_loc4_.charm);
            this.FMC_Scene["MC_MyRank"]["Text_Rank"].text = _loc4_.rank;
            this.FMC_Scene["MC_MyRank"]["Text_Host"].text = _loc4_.host;
            this.FMC_Scene["MC_MyRank"]["Text_Hostess"].text = _loc4_.hostess;
            this.FMC_Scene["MC_MyRank"]["Text_Host_Ring"].text = THomelandModel.getRingVOByExp(_loc4_.hostRing,_loc4_.hostRingExp).BuildLevel;
            this.FMC_Scene["MC_MyRank"]["Text_Hostess_Ring"].text = THomelandModel.getRingVOByExp(_loc4_.hostessRing,_loc4_.hostessRingExp).BuildLevel;
            this.FMC_Scene["MC_MyRank"]["Text_MarryName"].text = _loc5_.Name;
            this.FMC_Scene["MC_MyRank"]["Text_MarryLevel"].text = "(Lv." + _loc5_.Stars + ")";
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Scene["BTN_Receive"],false);
         }
      }
      
      protected function PerformPacket_CS_InfoReq() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_RankReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnRankRet(param1:TPacket) : void
      {
         var _loc5_:Object = null;
         TMarryRankModel.MarryRanks.length = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readShort();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = {};
            _loc5_.rank = _loc2_.readInt();
            _loc5_.host = THomelandModel.readString(_loc2_);
            _loc5_.hostess = THomelandModel.readString(_loc2_);
            _loc5_.charm = _loc2_.readInt();
            _loc5_.hostRingExp = _loc2_.readInt();
            _loc5_.hostessRingExp = _loc2_.readInt();
            _loc5_.agen = _loc2_.readInt();
            _loc5_.server = _loc2_.readInt();
            _loc5_.ring = _loc2_.readInt();
            TMarryRankModel.MarryRanks.push(_loc5_);
            _loc4_++;
         }
         TMarryRankModel.MyRank = _loc2_.readInt();
         if(this.FMaxPage == -1)
         {
            this.FMaxPage = Math.ceil(TMarryRankModel.MarryRanks.length / 6);
            this.Page = 1;
         }
         else
         {
            this.Page = this.Page;
         }
      }
      
      protected function ProcessorOnReceiveRet(param1:TPacket) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TMarryRankgift = null;
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:Object = null;
         var _loc11_:TArticle = null;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Receive"],false);
         THomelandModel.selfHome.receive = 1;
         _loc4_ = TMarryRankModel.MarryRankgift.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = TMarryRankModel.MyRank;
            _loc7_ = TMarryRankModel.MarryRankgift.GetDatebaseByIndex(_loc5_) as TMarryRankgift;
            if(_loc6_ >= _loc7_.Rankmin && _loc6_ <= _loc7_.Rankmax)
            {
               _loc8_ = "";
               _loc9_ = JSON.parse(_loc7_.RankGift) as Array;
               for each(_loc10_ in _loc9_)
               {
                  _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc10_.code) as TArticle;
                  _loc8_ += TIllustratedModel.TextFormat(70105002,_loc11_.Name,_loc10_.amount);
               }
               _loc8_ = _loc8_.replace(/\\n/g,"\n");
               EffectGenerateText(_loc8_);
               break;
            }
            _loc5_++;
         }
      }
      
      private function OnPageLeftClick(param1:MouseEvent) : void
      {
         --this.Page;
      }
      
      private function OnPageRightClick(param1:MouseEvent) : void
      {
         ++this.Page;
      }
      
      public function OnReceiveClick(param1:MouseEvent) : void
      {
         if(this.FMC_Scene["BTN_Receive"].currentFrame == 4)
         {
            return;
         }
         var _loc2_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_ReceiveReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      public function OnRewardsClick(param1:MouseEvent) : void
      {
         this.FRewards.SetVisible(true);
      }
      
      public function ButtonHelpOnOver(param1:MouseEvent = null) : void
      {
         var _loc2_:TSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170112) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      public function ButtonHelpOnOut(param1:MouseEvent = null) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      public function OnWindowClose(param1:MouseEvent = null) : void
      {
         ProcessorClose();
      }
      
      public function get Page() : int
      {
         return this.FPage;
      }
      
      public function set Page(param1:int) : void
      {
         this.FPage = Math.max(1,param1);
         this.FPage = Math.min(this.FMaxPage,this.FPage);
         this.FMC_Scene.TF_Page.text = this.FPage + "/" + this.FMaxPage;
         TGameUtil.setButtonMode(this.FMC_Scene.MC_PageLeft,this.FPage > 1);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_PageRight,this.FPage < this.FMaxPage);
         this.UpdateUI();
      }
   }
}

