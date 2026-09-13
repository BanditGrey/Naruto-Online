package Processors.Game.Lobby.Lead
{
   import Components.Pages.TUIPage;
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.LevelGifts.TLeadLevelGiftsData;
   import Logics.LevelGifts.TLeadLevelGiftsVO;
   import Logics.SLogicsCore;
   import Logics.Streamization.LevelGifts.TUnstreamizerLeadLevelGifts;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.Lead.Component.TUILeadLevelGifts;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorLeadLevelGifts extends TProcessorLobbyWindows
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected static const MAX_COUNT:int = 5;
      
      protected var FResPanel:MovieClip;
      
      protected var FUIModel:TUIHero;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUIPage:TUIPage;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:SimpleButton;
      
      protected var FUIListGifts:Vector.<TUILeadLevelGifts>;
      
      protected var FLevelGifts:Vector.<TLeadLevelGiftsVO>;
      
      protected var FUnstreamizerLeadLevelGifts:TUnstreamizerLeadLevelGifts;
      
      protected var FLevelGiftData:TLeadLevelGiftsData;
      
      protected var FCurStage:int = 1;
      
      protected var FTopupnum:int;
      
      protected var FPageIndex:int;
      
      protected var FOnOpenActivity:Function;
      
      public function TProcessorLeadLevelGifts(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerLeadLevelGifts = new TUnstreamizerLeadLevelGifts();
         this.FLevelGiftData = new TLeadLevelGiftsData();
         this.FUIListGifts = new Vector.<TUILeadLevelGifts>(MAX_COUNT);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4026531849);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FResPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_LeadLevelGifts") as MovieClip;
         addChild(this.FResPanel);
         this.FScrollBar = new TScrollBar(this.FResPanel.MC_List,348,false,0);
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = this.FResPanel.MC_Page["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.FResPanel.MC_Page["MC_PageRight"];
         this.FUIPage.LabelPage = this.FResPanel.MC_Page["TF_Page"];
         this.FUIPage.PageSize = 1;
         this.FUIPage.OnChangePage = this.OnPageChange;
         this.FUIPage.Init();
         this.FBtn_Close = this.FResPanel.MC_Close;
         this.FBtn_Help = this.FResPanel.Btn_Help;
         this.FUIModel = new TUIHero(this);
         this.FResPanel.MC_Role.addChild(this.FUIModel);
         this.FUIModel.OnQuerySequenceContext = this.OnQuerySequenceContext;
         this.FUIModel.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FUIModel.Context = SLogicsCore.Character.MainHero.Identifier;
         this.FResPanel.x = FUICore.StageWidth - this.FResPanel.width >> 1;
         this.FResPanel.y = FUICore.StageHeight - this.FResPanel.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnCloseHandle);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LeadLevelGifts_Info,this.PerformPacket_SC_LeadLevelGifts_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LeadLevelGifts_Reward,this.PerformPacket_SC_LeadLevelGifts_Reward);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_LeadLevelGifts_Open,this.PerformPacket_SC_OpenActiveRet);
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUILeadLevelGifts = null;
         var _loc4_:TLeadLevelGiftsVO = null;
         this.FLevelGifts = this.GetLeadLevelGiftsByPageIndex(this.FPageIndex);
         this.FScrollBar.Clear();
         this.FUIListGifts = new Vector.<TUILeadLevelGifts>();
         _loc1_ = 0;
         while(_loc1_ < this.FLevelGifts.length)
         {
            _loc3_ = new TUILeadLevelGifts(this);
            _loc3_.OnRewardLevelGift = this.PerformPacket_CS_LeadLevelGifts_Reward;
            _loc3_.OnHintOver = UIComponentsHintOnOver;
            _loc3_.OnHintOut = UIComponentsHintOnOut;
            _loc4_ = this.FLevelGifts[_loc1_] as TLeadLevelGiftsVO;
            this.FScrollBar.AddItem(_loc3_);
            _loc3_.SetDate(_loc4_);
            this.FUIListGifts.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function SetActtext() : void
      {
         this.FResPanel.TF_desc.text = TUtilityString.Format(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_LeadLevelGifts),this.FTopupnum);
      }
      
      protected function UpdateLeadLevelGiftsView() : void
      {
         this.FLevelGifts = this.GetLeadLevelGiftsByStage();
         this.UpdateLeadLevelGiftsViewByPageIndex(this.FCurStage - 1);
      }
      
      protected function UpdateLeadLevelGiftsViewByPageIndex(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUILeadLevelGifts = null;
         var _loc5_:TLeadLevelGiftsVO = null;
         var _loc6_:int = 0;
         this.FUIPage.PageIndex = param1;
         this.FUIPage.Update();
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc6_ = _loc2_ + param1 * MAX_COUNT;
            if(_loc6_ < this.FLevelGifts.length)
            {
               _loc5_ = this.FLevelGifts[_loc6_];
               _loc4_ = this.FUIListGifts[_loc2_];
               _loc4_.SetDate(_loc5_);
               _loc4_.Visible = true;
            }
            else
            {
               _loc4_ = this.FUIListGifts[_loc2_];
               _loc4_.Visible = false;
            }
            _loc2_++;
         }
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         SLogicsCore.ActivityThirdModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_ActiveListThird_LeadLevelGifts,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
      }
      
      protected function PerformPacket_SC_LeadLevelGifts_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerLeadLevelGifts.Unstreamize(_loc2_,this.FLevelGiftData,null);
         this.FUIPage.TotalQuantity = this.TotalPage;
         this.FUIPage.Update();
         this.ConstructScroolBar();
         this.SetActtext();
      }
      
      protected function PerformPacket_CS_LeadLevelGifts_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LeadLevelGifts_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_LeadLevelGifts_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc6_:TLeadLevelGiftsVO = null;
         var _loc7_:TUILeadLevelGifts = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         _loc6_ = this.FLevelGiftData.GetTLevelGiftsByIdentifier(_loc4_);
         if(_loc5_ == GIFTS_NORMAL)
         {
            _loc6_.Reward = 1;
         }
         else if(_loc5_ == GIFTS_TOPUP)
         {
            _loc6_.TopReward = 1;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this.FUIListGifts.length)
         {
            _loc7_ = this.FUIListGifts[_loc8_] as TUILeadLevelGifts;
            if(_loc7_.LevelGifts.Identifier == _loc4_)
            {
               _loc7_.SetDate(_loc6_);
               break;
            }
            _loc8_++;
         }
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
         this.FUIPage.TotalQuantity = this.TotalPage;
         this.FUIPage.Update();
      }
      
      protected function PerformPacket_CS_LeadLevelGifts_Reward(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_LeadLevelGifts_Reward);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function GetLeadLevelGiftsByPageIndex(param1:int) : Vector.<TLeadLevelGiftsVO>
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<TLeadLevelGiftsVO> = null;
         var _loc4_:TLeadLevelGiftsVO = null;
         _loc3_ = new Vector.<TLeadLevelGiftsVO>();
         _loc2_ = 0;
         while(_loc2_ < this.FLevelGiftData.LevelGifts.length)
         {
            _loc4_ = this.FLevelGiftData.LevelGifts[_loc2_] as TLeadLevelGiftsVO;
            if(_loc4_.Stage == param1 + 1)
            {
               _loc3_.push(_loc4_);
               this.FTopupnum = _loc4_.LeadLevelGifts.Topupnum;
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      protected function GetLeadLevelGiftsByStage() : Vector.<TLeadLevelGiftsVO>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<TLeadLevelGiftsVO> = null;
         var _loc3_:TLeadLevelGiftsVO = null;
         var _loc4_:Boolean = true;
         _loc2_ = new Vector.<TLeadLevelGiftsVO>();
         _loc1_ = 0;
         while(_loc1_ < this.FLevelGiftData.LevelGifts.length)
         {
            _loc3_ = this.FLevelGiftData.LevelGifts[_loc1_] as TLeadLevelGiftsVO;
            if(_loc3_.Stage > this.FCurStage && !_loc4_)
            {
               break;
            }
            _loc2_.push(_loc3_);
            if(_loc3_.TopReward != 1 || _loc3_.Reward != 1)
            {
               this.FCurStage = _loc3_.Stage;
               this.FTopupnum = _loc3_.LeadLevelGifts.Topupnum;
               _loc4_ = false;
            }
            _loc1_++;
         }
         if(_loc4_)
         {
            return this.FLevelGiftData.LevelGifts;
         }
         return _loc2_;
      }
      
      protected function OnPageChange(param1:Object, param2:int) : void
      {
         this.FPageIndex = param2;
         this.ConstructScroolBar();
         this.SetActtext();
      }
      
      protected function get TotalPage() : int
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<TLeadLevelGiftsVO> = null;
         var _loc3_:TLeadLevelGiftsVO = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = true;
         _loc2_ = new Vector.<TLeadLevelGiftsVO>();
         _loc1_ = 0;
         while(_loc1_ < this.FLevelGiftData.LevelGifts.length)
         {
            _loc3_ = this.FLevelGiftData.LevelGifts[_loc1_] as TLeadLevelGiftsVO;
            _loc4_ = _loc3_.Stage;
            if(_loc3_.TopReward != 1 || _loc3_.Reward != 1)
            {
               _loc4_ = _loc3_.Stage;
               break;
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_LeadLevelGifts);
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
      
      protected function OnCloseHandle(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this.FUIListGifts)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUIListGifts.length)
            {
               if(this.FUIListGifts[_loc1_])
               {
                  this.FUIListGifts[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
         if(this.FUIModel)
         {
            this.FUIModel.Update();
         }
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      protected function OnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as int;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIModel.X = _loc8_.X;
            this.FUIModel.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIModel.X = 0;
            this.FUIModel.Y = 0;
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_LeadLevelGifts_Info();
      }
   }
}

