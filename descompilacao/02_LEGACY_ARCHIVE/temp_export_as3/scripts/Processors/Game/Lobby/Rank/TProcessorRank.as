package Processors.Game.Lobby.Rank
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Rank.UserRankInfo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_BATTLE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_RANK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorRank extends TProcessorLobbyWindows
   {
      
      protected var UserRankList:Vector.<UserRankInfo> = new Vector.<UserRankInfo>();
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FTUITab:TUITab;
      
      protected const CAPACITY_MC_Tabs:uint = 5;
      
      protected var FTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var thisPanel:MovieClip;
      
      protected var FTF_Rank:TextField;
      
      protected const RANK_COUNT:int = 8;
      
      protected var RankUnitS:Vector.<TProcessorRankUnit> = new Vector.<TProcessorRankUnit>(this.RANK_COUNT);
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FWindowConfirmation:TUIWindowConfirmation;
      
      protected var ConfigValue:TConfigValue;
      
      protected var NeedCosts:Vector.<uint>;
      
      protected var FSetStatusType:Function;
      
      protected var FOnInitBattle:Function;
      
      public function TProcessorRank(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FTUITab = new TUITab(param1);
         this.FUIPage = new TUIPage(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_RANK.RESOURCEID_RANK);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc2_:TProcessorRankUnit = null;
         super.ResourcesPerform_UIDispatch();
         this.thisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_RANK.RESOURCE_ClassName_Rank) as MovieClip;
         addChild(this.thisPanel);
         this.FBTN_Close = this.thisPanel[CONST_RANK.RESOURCE_Link_Btn_Close];
         this.FBtn_Help = this.thisPanel[CONST_RANK.RESOURCE_Link_Btn_Help];
         var _loc1_:int = 0;
         while(_loc1_ < this.CAPACITY_MC_Tabs)
         {
            this.FTUITab.SetTabByIndex(this.thisPanel["MC_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FTUITab.Init();
         this.FTUITab.OnSwitch = this.OnTabSwitch;
         this.FUIPage.ButtonPrevious.Substrate = this.thisPanel["MC_ChangePage"]["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.thisPanel["MC_ChangePage"]["MC_PageRight"];
         this.FUIPage.LabelPage = this.thisPanel["MC_ChangePage"]["TF_Page"];
         this.FUIPage.PageSize = this.RANK_COUNT;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.OnChangePage;
         _loc1_ = 0;
         while(_loc1_ < this.RANK_COUNT)
         {
            _loc2_ = new TProcessorRankUnit(this.thisPanel[CONST_RANK.RESOURCE_Link_MC_INFO + _loc1_]);
            this.RankUnitS[_loc1_] = _loc2_;
            _loc2_.BTN_Show_Func = this.PerformPacket_CS_CrossUser_Req;
            _loc2_.BTN_Qiecuo_Func = this.PerformPacket_CS_CrossFight_Req;
            _loc1_++;
         }
         this.ConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,91700003) as TConfigValue;
         this.NeedCosts = this.ConfigValue.Value as Vector.<uint>;
         this.FWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FWindowConfirmation.x = (CONST_COMMON.STAGE_Width - this.FWindowConfirmation.WindowWidth) / 2;
         this.FWindowConfirmation.y = (CONST_COMMON.STAGE_Height - this.FWindowConfirmation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FWindowConfirmation);
         this.x = stage.stageWidth - this.width >> 1;
         this.y = stage.stageHeight - this.height >> 1;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.onBtnClose);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossRank_Ret,this.PerformPacket_SC_CrossRank_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_CrossFight_Ret,this.PerformPacket_SC_CrossFight_Ret);
      }
      
      protected function PerformPacket_SC_CrossRank_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:UserRankInfo = null;
         _loc2_ = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         var _loc4_:int = _loc2_.readShort();
         this.UserRankList.length = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new UserRankInfo();
            _loc6_.uid = _loc2_.readDouble();
            _loc6_.name = TUtilityString.FetchUTF(_loc2_);
            _loc6_.serverid = _loc2_.readInt();
            _loc6_.agent = _loc2_.readInt();
            _loc6_.heroId = _loc2_.readInt();
            _loc6_.rank = _loc2_.readInt();
            _loc6_.value.High = _loc2_.readInt();
            _loc6_.value.Low = _loc2_.readInt();
            this.UserRankList.push(_loc6_);
            _loc5_++;
         }
         this.UpdateCrossRank(_loc2_);
      }
      
      protected function PerformPacket_CS_CrossRank_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossRank_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_CrossUser_Req(param1:UserRankInfo) : void
      {
         var _loc2_:TPacket = null;
         if(!param1)
         {
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossUser_Req);
         _loc2_.Data.writeInt(param1.agent);
         _loc2_.Data.writeInt(param1.serverid);
         _loc2_.Data.writeDouble(param1.uid);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_SC_CrossFight_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         _loc2_ = param1.Data;
         var _loc6_:int = int(_loc2_.readUnsignedInt());
         if(_loc6_ > 0)
         {
            EffectGenerateTextByErrorCode(_loc6_);
            return;
         }
         _loc3_ = _loc2_.readInt();
         _loc4_ = _loc2_.readInt();
         _loc5_ = _loc2_.readDouble();
         UserRankInfo.QiecuoTms = _loc2_.readInt();
         this.FSetStatusType && this.FSetStatusType(this,CONST_BATTLE.BattleType_Qiecuo,0);
         this.FOnInitBattle && this.FOnInitBattle(this);
      }
      
      protected function PerformPacket_CS_CrossFight_Req(param1:UserRankInfo) : void
      {
         var FTms:int;
         var FUserRankInfo:UserRankInfo = param1;
         if(!FUserRankInfo)
         {
            return;
         }
         FTms = UserRankInfo.QiecuoTms;
         if(this.NeedCosts.length <= FTms)
         {
            EffectGenerateText("今日次数已用完");
            return;
         }
         this.FWindowConfirmation.Visible = true;
         this.FWindowConfirmation.Text = TUtilityString.Format(new ConsumeFrame(80002312).DescribeString,this.NeedCosts[FTms]);
         this.FWindowConfirmation.OnOK = function(param1:Object):void
         {
            var _loc2_:TPacket = null;
            _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CrossFight_Req);
            _loc2_.Data.writeInt(FUserRankInfo.agent);
            _loc2_.Data.writeInt(FUserRankInfo.serverid);
            _loc2_.Data.writeDouble(FUserRankInfo.uid);
            SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         };
      }
      
      protected function UpdateCrossRank(param1:ByteArray) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TProcessorRankUnit = null;
         var _loc2_:int = param1.readInt();
         UserRankInfo.QiecuoTms = param1.readInt();
         this.FTF_Rank = this.thisPanel[CONST_RANK.RESOURCE_Link_TF_Rank];
         this.FTF_Rank.text = _loc2_ > 500 ? "500+" : _loc2_.toString();
         this.FUIPage.TotalQuantity = this.UserRankList.length;
         this.FUIPage.Update();
         var _loc3_:Vector.<UserRankInfo> = this.UserRankList.slice(this.FUIPage.PageIndex * this.RANK_COUNT,(this.FUIPage.PageIndex + 1) * this.RANK_COUNT);
         var _loc6_:int = int(_loc3_.length);
         _loc4_ = 0;
         while(_loc4_ < this.RANK_COUNT)
         {
            _loc5_ = this.RankUnitS[_loc4_];
            if(_loc4_ < _loc6_)
            {
               _loc5_.UserRankInfo = _loc3_[_loc4_];
            }
            else
            {
               _loc5_.UserRankInfo = null;
            }
            _loc4_++;
         }
      }
      
      protected function OnTabSwitch(param1:int) : void
      {
         if(this.FTabIndex == param1)
         {
            return;
         }
         this.FTUITab.GetMoviClipByIndex(this.FTabIndex).wheel.stop();
         this.FTabIndex = param1;
         this.FTUITab.GetMoviClipByIndex(param1).wheel.play();
         this.PerformPacket_CS_CrossRank_Req(param1 + 1);
         this.FUIPage.Reset();
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TProcessorRankUnit = null;
         this.FUIPage.Update();
         var _loc3_:Vector.<UserRankInfo> = this.UserRankList.slice(this.FUIPage.PageIndex * this.RANK_COUNT,(this.FUIPage.PageIndex + 1) * this.RANK_COUNT);
         var _loc6_:int = int(_loc3_.length);
         _loc4_ = 0;
         while(_loc4_ < this.RANK_COUNT)
         {
            _loc5_ = this.RankUnitS[_loc4_];
            if(_loc4_ < _loc6_)
            {
               _loc5_.UserRankInfo = _loc3_[_loc4_];
            }
            else
            {
               _loc5_.UserRankInfo = null;
            }
            _loc4_++;
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_70170115);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function onBtnClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_CrossRank_Req(this.FTUITab.TabIndex + 1);
         this.FTUITab.GetMoviClipByIndex(this.FTabIndex).wheel.play();
      }
      
      public function get OnInitBattle() : Function
      {
         return this.FOnInitBattle;
      }
      
      public function set OnInitBattle(param1:Function) : void
      {
         this.FOnInitBattle = param1;
      }
      
      public function set SetStatusType(param1:Function) : void
      {
         this.FSetStatusType = param1;
      }
      
      public function get SetStatusType() : Function
      {
         return this.FSetStatusType;
      }
   }
}

