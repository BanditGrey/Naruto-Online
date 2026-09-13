package Processors.Game.Lobby.Exercise.Hallowmas
{
   import Components.Pages.TUIPage;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.Hallowmas.THallowmas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerHallowmas;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.NationalDay.TOverlayerSimpleNinjia;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_SEVENTHEVENING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorHallowmas extends TProcessorBaseActivity
   {
      
      public static const SWEET_COUNT:int = 3;
      
      public static const RANK_COUNT:int = 10;
      
      public static const NINJIA_COUNT:int = 2;
      
      public static const CONFIRMATION_TYPE_BUY_SWEET:int = 1;
      
      public static const TYPE_KNIGHT:int = THallowmas.TYPE_KNIGHT;
      
      public static const TYPE_BASE_SWEET:int = THallowmas.TYPE_BASE_SWEET;
      
      public static const REQ_TYPE_KILL_KNIGHT:int = 1;
      
      public static const REQ_TYPE_EXCHANGE_ITEM:int = 2;
      
      public static const REQ_TYPE_GET_KILL_BOX:int = 3;
      
      public static const REQ_TYPE_CALL_KNIGHT:int = 4;
      
      public static const MOVIE_TYPE_FLY_SWEET:int = 1;
      
      public static const MOVIE_TYPE_ADD_SWEET_0:int = 2;
      
      public static const MOVIE_TYPE_ADD_SWEET_1:int = 3;
      
      public static const MOVIE_TYPE_ADD_SWEET_2:int = 4;
      
      public static const MOVIE_TYPE_FLY_KNIGHT:int = 5;
      
      public static const MOVIE_TYPE_CALL_KNIGHT:int = 6;
      
      public static const MOVIE_TYPE_KILL_KNIGHT:int = 7;
      
      protected var FHallowmas:THallowmas;
      
      protected var FBeClicked:Boolean;
      
      protected var FUnstreamizerHallowmas:TUnstreamizerHallowmas;
      
      protected var FProcessorHallowmasExchange:TProcessorHallowmasExchange;
      
      protected var FProcessorHallowmasRank:TProcessorHallowmasRank;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FSweetVect:Vector.<MovieClip>;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FRankList:Vector.<Sprite>;
      
      protected var FMC_Rank:MovieClip;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCurType:int;
      
      protected var FTotalFrame:int;
      
      protected var FAddSweetType:int;
      
      protected var FOverlayerSimpleNinjia:TOverlayerSimpleNinjia;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FAllTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      public function TProcessorHallowmas(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FHallowmas = SLogicsCore.Hallowmas;
         this.FUnstreamizerHallowmas = new TUnstreamizerHallowmas();
         this.FProcessorHallowmasExchange = new TProcessorHallowmasExchange(this.Parent);
         this.FProcessorHallowmasRank = new TProcessorHallowmasRank(this.Parent);
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FOverlayerSimpleNinjia = new TOverlayerSimpleNinjia(this.Parent);
         this.FOverlayerSimpleNinjia.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this.Parent);
         this.FOverlayerTitle.Visible = false;
         this.FAllTitles = new TTitles();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FSweetVect = new Vector.<MovieClip>(SWEET_COUNT);
         this.FRankList = new Vector.<Sprite>(RANK_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            this.FSweetVect[_loc1_] = FMC_Scene["MC_Sprite" + _loc1_];
            _loc1_++;
         }
         this.FProcessorHallowmasRank.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorHallowmasRank.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorHallowmasRank.OnOut = UIComponentsHintOnOut;
         this.FProcessorHallowmasRank.OnGetBox = this.ProcessorOnGetKillBoxUp;
         this.FProcessorHallowmasRank.TitleHintOnOver = this.ProcessorOnTitleOver;
         this.FProcessorHallowmasRank.TitleHintOnOut = this.ProcessorOnTitleOut;
         this.FProcessorHallowmasRank.Visible = false;
         this.FProcessorHallowmasExchange.OnCloseUp = this.ProcessorOnCloseWindow;
         this.FProcessorHallowmasExchange.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorHallowmasExchange.OnOut = UIComponentsHintOnOut;
         this.FProcessorHallowmasExchange.OnShowRecruit = this.ProcessorOnShowExchangeHero;
         this.FProcessorHallowmasExchange.OnGetBox = this.ProcessorOnExchangeItemUp;
         this.FProcessorHallowmasExchange.OnGetHero = this.ProcessorOnExchangeHeroUp;
         this.FProcessorHallowmasExchange.OnNinjiaOver = this.ProcessorOnNinjiaOver;
         this.FProcessorHallowmasExchange.OnNinjiaOut = this.ProcessorOnNinjiaOut;
         this.FProcessorHallowmasExchange.Visible = false;
         this.FUIPage = new TUIPage(this);
         this.FMC_Rank = FMC_Scene.MC_Rank;
         this.FMC_ChangePage = this.FMC_Rank.MC_ChangePage;
         this.FUI_Left_Btn = this.FMC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = RANK_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSimpleNinjia);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_GotoRank.addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GotoRank,true);
         FMC_Scene.BTN_GotoExchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnGotoExchange);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GotoExchange,true);
         FMC_Scene.BTN_GetSweet.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetSweetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GetSweet,true);
         FMC_Scene.BTN_Kill.addEventListener(MouseEvent.CLICK,this.ProcessorOnKillUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Kill,true);
         FMC_Scene.BTN_Call.addEventListener(MouseEvent.CLICK,this.ProcessorOnCallUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Call,true);
         FMC_Scene.BTN_ShowHeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowHeroDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_ShowHeroDesc,true);
         FMC_Scene.MC_Sweet.MC_Light.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
         FMC_Scene.MC_Sweet.MC_Light.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSweetOut);
         FMC_Scene.MC_KNight.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnKnightOver);
         FMC_Scene.MC_KNight.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnKnightOut);
         FMC_Scene.MC_Box.buttonMode = true;
         FMC_Scene.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         super.LogicsPerform();
         if(FInitialized)
         {
            if(Boolean(FMC_Scene) && FMC_Scene.visible)
            {
               if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
            }
            if(this.FIsPlaying)
            {
               switch(this.FCurType)
               {
                  case MOVIE_TYPE_FLY_SWEET:
                     _loc2_ = FMC_Scene.MC_Sweet.MC_FlySweet;
                     break;
                  case MOVIE_TYPE_ADD_SWEET_0:
                  case MOVIE_TYPE_ADD_SWEET_1:
                  case MOVIE_TYPE_ADD_SWEET_2:
                     _loc2_ = this.FSweetVect[this.FAddSweetType - TYPE_BASE_SWEET].MC_Icon;
                     break;
                  case MOVIE_TYPE_FLY_KNIGHT:
                     _loc2_ = FMC_Scene.MC_Sweet.MC_FlyKnight;
                     break;
                  case MOVIE_TYPE_CALL_KNIGHT:
                     _loc2_ = FMC_Scene.MC_CallHero;
                     break;
                  case MOVIE_TYPE_KILL_KNIGHT:
                     _loc2_ = FMC_Scene.MC_KillHero;
               }
               _loc1_ = _loc2_.currentFrame;
               if(_loc1_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateBox();
         this.UpdateHero();
         this.UpdateRank();
         this.UpdateWindow();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FHallowmas.CurRank == 0)
         {
            FMC_Scene.TF_CurRank.text = STRING_BASEACTIVITY.FORMAT_NEVER_IN_RANK;
         }
         else
         {
            FMC_Scene.TF_CurRank.text = this.FHallowmas.CurRank.toString();
         }
         FMC_Scene.TF_KillCount.text = this.FHallowmas.KilledTimes.toString();
         FMC_Scene.TF_CanKillCount.text = this.FHallowmas.CanKillTimes.toString();
         FMC_Scene.TF_FreeCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_FREE_COUNTS,this.FHallowmas.FreeTimes);
         FTF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FHallowmas.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FHallowmas.EndTime - 1) * 1000)));
         FTF_Desc.text = this.FHallowmas.ActivityDesc;
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            _loc2_ = this.FSweetVect[_loc1_];
            _loc2_.MC_Icon.stop();
            _loc2_.MC_Icon.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_.TF_Count.text = this.FHallowmas.SweetVect[_loc1_];
            _loc1_++;
         }
      }
      
      protected function UpdateBox() : void
      {
         if(this.FHallowmas.HallowmasBoxStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Box.visible = false;
            FMC_Scene.MC_Box.MC_GetBox.stop();
            FMC_Scene.MC_Box.MC_Box.stop();
         }
         else
         {
            FMC_Scene.MC_Box.visible = true;
            FMC_Scene.MC_Box.MC_GetBox.play();
            FMC_Scene.MC_Box.MC_Box.play();
         }
      }
      
      protected function UpdateHero() : void
      {
         FMC_Scene.MC_CallHero.visible = false;
         FMC_Scene.MC_KillHero.visible = false;
         if(this.FHallowmas.CanKillTimes > 0)
         {
            FMC_Scene.BTN_Kill.visible = true;
            FMC_Scene.BTN_Call.visible = false;
         }
         else
         {
            FMC_Scene.BTN_Kill.visible = false;
            FMC_Scene.BTN_Call.visible = true;
         }
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         var _loc6_:TextField = null;
         var _loc7_:TConsumeRankInfo = null;
         this.FUIPage.TotalQuantity = this.FHallowmas.RankList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < RANK_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * RANK_COUNT;
            _loc3_ = this.FMC_Rank["MC_Rank" + _loc1_];
            _loc4_ = _loc3_.TF_Name;
            _loc5_ = _loc3_.TF_Count;
            _loc6_ = _loc3_.TF_ServerID;
            if(_loc2_ < this.FHallowmas.RankList.length)
            {
               _loc7_ = this.FHallowmas.RankList[_loc2_];
               if(this.FCurPage == 0)
               {
                  this.FMC_Rank["TF_FirstNum"].visible = true;
                  this.FMC_Rank["TF_SecondNum"].visible = true;
                  this.FMC_Rank["TF_ThirdNum"].visible = true;
               }
               else
               {
                  this.FMC_Rank["TF_FirstNum"].visible = false;
                  this.FMC_Rank["TF_SecondNum"].visible = false;
                  this.FMC_Rank["TF_ThirdNum"].visible = false;
               }
               _loc4_.visible = true;
               if(_loc2_ < 3)
               {
                  _loc4_.text = TUtilityString.Format(STRING_SEVENTHEVENING.FORMAT_RankNameNonePoint,_loc7_.UserName);
               }
               else
               {
                  _loc4_.text = TUtilityString.Format(STRING_SEVENTHEVENING.FORMAT_RankName,_loc2_ + 1,_loc7_.UserName);
               }
               _loc5_.visible = true;
               _loc6_.visible = true;
               _loc5_.text = _loc7_.Score.toString();
               _loc6_.text = _loc7_.ServerID.toString();
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
               _loc6_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateWindow() : void
      {
         if(this.FProcessorHallowmasRank.visible)
         {
            this.FProcessorHallowmasRank.UpdateUI();
         }
         if(this.FProcessorHallowmasExchange.visible)
         {
            this.FProcessorHallowmasExchange.UpdateUI();
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateRank();
      }
      
      protected function ProcessorOnGotoRank(param1:MouseEvent) : void
      {
         if(this.FHallowmas.KillBox[0] == null)
         {
            return;
         }
         this.FProcessorHallowmasRank.Visible = true;
         this.FProcessorHallowmasRank.UpdateUI();
      }
      
      protected function ProcessorOnGotoExchange(param1:MouseEvent) : void
      {
         if(this.FHallowmas.ExchangeItemVect[0] == null)
         {
            return;
         }
         this.FProcessorHallowmasExchange.Visible = true;
         this.FProcessorHallowmasExchange.UpdateUI();
      }
      
      protected function ProcessorOnGetSweetUp(param1:MouseEvent) : void
      {
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FIsPlaying)
         {
            ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         if(this.FHallowmas.FreeTimes > 0)
         {
            this.FBeClicked = true;
            this.PerformPacket_CS_BuyBoxReq();
            return;
         }
         FReqType = 0;
         FIndex = 0;
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = this.FHallowmas.SweetGold;
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         if(this.FHallowmas.IsGoldEnough(this.FCost))
         {
            this.FBeClicked = true;
            if(FReqType == 0)
            {
               this.PerformPacket_CS_BuyBoxReq();
            }
            else
            {
               this.PerformPacket_CS_OtherReq();
            }
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_BuyBoxReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnCallUp(param1:MouseEvent) : void
      {
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FIsPlaying)
         {
            ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         FReqType = REQ_TYPE_CALL_KNIGHT;
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = this.FHallowmas.CallGold;
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_BaseActivity_GetRewardReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         _loc2_.Data.writeUnsignedInt(1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnKillUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FBeClicked)
         {
            return;
         }
         if(this.FIsPlaying)
         {
            ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_WAIT_AMOUNT);
            return;
         }
         this.FBeClicked = true;
         FReqType = REQ_TYPE_KILL_KNIGHT;
         FIndex = 0;
         this.PerformPacket_CS_OtherReq();
      }
      
      protected function ProcessorOnGetKillBoxUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         FIndex = param1;
         FReqType = REQ_TYPE_GET_KILL_BOX;
         this.PerformPacket_CS_OtherReq();
      }
      
      protected function ProcessorOnExchangeItemUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         FIndex = param1 + NINJIA_COUNT;
         FReqType = REQ_TYPE_EXCHANGE_ITEM;
         this.PerformPacket_CS_OtherReq();
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         FIndex = param1;
         FReqType = REQ_TYPE_EXCHANGE_ITEM;
         this.PerformPacket_CS_OtherReq();
      }
      
      protected function PerformPacket_CS_OtherReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Hallowmas_OtherReq);
         _loc1_.Data.writeUnsignedInt(FReqType);
         _loc1_.Data.writeUnsignedInt(FIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnShowHeroDesc(param1:MouseEvent) : void
      {
         if(this.FHallowmas.NinjiaVect[1])
         {
            this.FProcessorWindowRecruit.SetHeroData(uint(this.FHallowmas.NinjiaVect[1].Identify));
         }
      }
      
      protected function ProcessorOnShowExchangeHero(param1:int) : void
      {
         if(this.FHallowmas.NinjiaVect[param1])
         {
            this.FProcessorWindowRecruit.SetHeroData(uint(this.FHallowmas.NinjiaVect[param1].Identify));
         }
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FHallowmas.Inventories) && this.FHallowmas.Inventories.Count > 0)
         {
            UIComponentsHintOnOver(this,this.FHallowmas.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(Boolean(this.FHallowmas.Inventories) && this.FHallowmas.Inventories.Count > 0)
         {
            UIComponentsHintOnOut(this,this.FHallowmas.Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnNinjiaOver(param1:int) : void
      {
         if(this.FHallowmas.NinjiaVect[param1])
         {
            this.FOverlayerSimpleNinjia.Context = this.FHallowmas.NinjiaVect[param1];
            this.FOverlayerSimpleNinjia.Render(FUICore.MouseCoordinate);
            this.FOverlayerSimpleNinjia.Show();
         }
      }
      
      protected function ProcessorOnNinjiaOut() : void
      {
         this.FOverlayerSimpleNinjia.Hide();
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         ProcessorOnShowTip(STRING_BASEACTIVITY.FORMAT_SWEET_TIP);
      }
      
      protected function ProcessorOnSweetOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnKnightOver(param1:MouseEvent) : void
      {
         ProcessorOnShowTip(STRING_BASEACTIVITY.FORMAT_KNIGHT_TIP);
      }
      
      protected function ProcessorOnKnightOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         this.FProcessorHallowmasExchange.Visible = false;
         this.FProcessorHallowmasRank.Visible = false;
      }
      
      protected function ProcessorOnTitleOver(param1:uint) : void
      {
         var _loc2_:TTitle = null;
         _loc2_ = this.FAllTitles.GetTitleByIdentifier(param1);
         if(_loc2_ != null)
         {
            this.FOverlayerTitle.Context = _loc2_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function ProcessorOnTitleOut() : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorHallowmasRank.Load();
            this.FProcessorHallowmasExchange.Load();
            this.FProcessorWindowRecruit.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.FIsPlaying = false;
         this.FCurType = 0;
         this.FTotalFrame = 0;
         if(FMC_Scene)
         {
            FMC_Scene.MC_Sweet.MC_FlySweet.visible = false;
            FMC_Scene.MC_Sweet.MC_FlyKnight.visible = false;
            FMC_Scene.MC_KillHero.visible = false;
            FMC_Scene.MC_CallHero.visible = false;
         }
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         super.ProcessorOnLoadInfoRet();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerHallowmas.Unstreamize(_loc2_,this.FHallowmas,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Vector.<uint> = null;
         var _loc10_:Vector.<uint> = null;
         var _loc11_:TInventories = null;
         var _loc12_:String = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc2_.readShort();
         _loc6_ = _loc2_.readUnsignedInt();
         _loc7_ = int(_loc2_.readUnsignedInt());
         if(this.FHallowmas.FreeTimes > 0)
         {
            --this.FHallowmas.FreeTimes;
         }
         if(_loc6_ == TYPE_KNIGHT)
         {
            _loc12_ = STRING_BASEACTIVITY.FORMAT_CALL_KNIGHT;
            this.PlayMovie(MOVIE_TYPE_FLY_KNIGHT);
            ++this.FHallowmas.CanKillTimes;
         }
         else
         {
            this.FAddSweetType = _loc6_;
            _loc12_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED + STRING_BASEACTIVITY.FORMAT_SWEET_NAME[this.FAddSweetType - TYPE_BASE_SWEET] + "*" + _loc7_;
            this.FHallowmas.SweetVect[this.FAddSweetType - TYPE_BASE_SWEET] += _loc7_;
            this.PlayMovie(MOVIE_TYPE_FLY_SWEET);
         }
         ProcessorCheckEffect(FActivityID,this.FHallowmas.CheckEffect());
         ProcessorEffectText(_loc12_);
         this.UpdateText();
         this.UpdateHero();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
         ProcessorEffectText(_loc4_);
         this.FHallowmas.HallowmasBoxStatus = TBaseActivity.STATUS_GETED;
         ProcessorCheckEffect(FActivityID,this.FHallowmas.CheckEffect());
         this.UpdateUI();
      }
      
      public function ProcessorOtherRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FProcessorHallowmasRank.BeClicked = false;
            this.FProcessorHallowmasExchange.BeClicked = false;
            return;
         }
         switch(_loc5_)
         {
            case REQ_TYPE_KILL_KNIGHT:
               this.PlayMovie(MOVIE_TYPE_KILL_KNIGHT);
               break;
            case REQ_TYPE_CALL_KNIGHT:
               this.PlayMovie(MOVIE_TYPE_CALL_KNIGHT);
               break;
            case REQ_TYPE_GET_KILL_BOX:
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               ProcessorEffectText(_loc4_);
               this.FHallowmas.KillBox[FIndex].Status = TBaseActivity.STATUS_GETED;
               this.FProcessorHallowmasRank.BeClicked = false;
               ProcessorCheckEffect(FActivityID,this.FHallowmas.CheckEffect());
               this.UpdateUI();
               break;
            case REQ_TYPE_EXCHANGE_ITEM:
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               ProcessorEffectText(_loc4_);
               if(FIndex > 1)
               {
                  ++this.FHallowmas.ExchangeItemVect[FIndex - NINJIA_COUNT].BuyCount;
                  _loc6_ = 0;
                  while(_loc6_ < SWEET_COUNT)
                  {
                     this.FHallowmas.SweetVect[_loc6_] -= this.FHallowmas.ExchangeItemVect[FIndex - NINJIA_COUNT].ExchangeVect[_loc6_];
                     _loc6_++;
                  }
               }
               else
               {
                  ++this.FHallowmas.NinjiaVect[FIndex].BuyCount;
                  this.FHallowmas.NinjiaVect[FIndex].Status = TBaseActivity.STATUS_GETED;
                  _loc6_ = 0;
                  while(_loc6_ < SWEET_COUNT)
                  {
                     this.FHallowmas.SweetVect[_loc6_] -= this.FHallowmas.NinjiaVect[FIndex].ExchangeVect[_loc6_];
                     _loc6_++;
                  }
               }
               this.FProcessorHallowmasExchange.BeClicked = false;
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         this.FCurType = param1;
         switch(param1)
         {
            case MOVIE_TYPE_FLY_SWEET:
               _loc2_ = FMC_Scene.MC_Sweet.MC_FlySweet;
               FMC_Scene.MC_Sweet.MC_FlySweet.MC_Icon.gotoAndStop(this.FAddSweetType - TYPE_BASE_SWEET + 1);
               _loc2_.visible = true;
               break;
            case MOVIE_TYPE_ADD_SWEET_0:
            case MOVIE_TYPE_ADD_SWEET_1:
            case MOVIE_TYPE_ADD_SWEET_2:
               _loc2_ = this.FSweetVect[this.FAddSweetType - TYPE_BASE_SWEET].MC_Icon;
               break;
            case MOVIE_TYPE_FLY_KNIGHT:
               _loc2_ = FMC_Scene.MC_Sweet.MC_FlyKnight;
               _loc2_.visible = true;
               break;
            case MOVIE_TYPE_CALL_KNIGHT:
               _loc2_ = FMC_Scene.MC_CallHero;
               _loc2_.visible = true;
               break;
            case MOVIE_TYPE_KILL_KNIGHT:
               _loc2_ = FMC_Scene.MC_KillHero;
               _loc2_.visible = true;
         }
         if(_loc2_)
         {
            this.FIsPlaying = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:String = null;
         switch(this.FCurType)
         {
            case MOVIE_TYPE_FLY_SWEET:
               FMC_Scene.MC_Sweet.MC_FlySweet.gotoAndStop(1);
               this.PlayMovie(MOVIE_TYPE_ADD_SWEET_0 + (this.FAddSweetType - TYPE_BASE_SWEET));
               FMC_Scene.MC_Sweet.MC_FlySweet.visible = false;
               break;
            case MOVIE_TYPE_ADD_SWEET_0:
            case MOVIE_TYPE_ADD_SWEET_1:
            case MOVIE_TYPE_ADD_SWEET_2:
               this.FSweetVect[this.FAddSweetType - TYPE_BASE_SWEET].MC_Icon.gotoAndStop(1);
               break;
            case MOVIE_TYPE_FLY_KNIGHT:
               FMC_Scene.MC_Sweet.MC_FlyKnight.gotoAndStop(1);
               FMC_Scene.MC_Sweet.MC_FlyKnight.visible = false;
               break;
            case MOVIE_TYPE_CALL_KNIGHT:
               FMC_Scene.MC_CallHero.gotoAndStop(1);
               FMC_Scene.MC_CallHero.visible = false;
               _loc1_ = STRING_BASEACTIVITY.FORMAT_CALL_KNIGHT;
               ProcessorEffectText(_loc1_);
               ++this.FHallowmas.CanKillTimes;
               this.UpdateText();
               this.UpdateHero();
               break;
            case MOVIE_TYPE_KILL_KNIGHT:
               FMC_Scene.MC_KillHero.gotoAndStop(1);
               FMC_Scene.MC_KillHero.visible = false;
               _loc1_ = STRING_BASEACTIVITY.FORMAT_KILL_KNIGHT;
               ProcessorEffectText(_loc1_);
               ++this.FHallowmas.KilledTimes;
               --this.FHallowmas.CanKillTimes;
               this.UpdateText();
               this.UpdateHero();
         }
         ProcessorCheckEffect(FActivityID,this.FHallowmas.CheckEffect());
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:Vector.<int> = Vector.<int>([1,0,0,0,0]);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         TUtilityString.FlushUTF(_loc3_,"万圣节活动");
         TUtilityString.FlushUTF(_loc3_,"万圣节活动");
         TUtilityString.FlushUTF(_loc3_,"万圣节活动");
         _loc3_.writeUnsignedInt(14100001 + _loc1_);
         _loc3_.writeInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeShort(11);
         _loc1_ = 0;
         while(_loc1_ < 11)
         {
            TUtilityString.FlushUTF(_loc3_,"aaa");
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc1_++;
         }
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(11210009 + _loc1_);
            _loc3_.writeInt(0);
            _loc3_.writeUnsignedInt(10);
            TUtilityString.FlushUTF(_loc3_,"aaa");
            TUtilityString.FlushUTF(_loc3_,"bbb");
            TUtilityString.FlushUTF(_loc3_,"ccc");
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 3);
            _loc3_.writeUnsignedInt(_loc1_ + 10);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1 + _loc2_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(_loc1_ + 2);
            _loc3_.writeUnsignedInt(10010);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeUnsignedInt(20);
            _loc3_.writeUnsignedInt(1);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

