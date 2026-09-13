package Processors.Game.Lobby.Exercise.MayActive.Compoents
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.MayActive.TMayActive2;
   import Logics.Exercise.MayActive.TMsgGraph;
   import Logics.Exercise.MayActive.TMsgTreasure;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.MayActive.TProcessorMayActive;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   public class TUIMayActive2 extends TUIBaseWindow
   {
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const SEEK_COUNT:int = 30;
      
      public static const REWARD_COUNT:int = 9;
      
      public static const TAB_COUNT:int = 3;
      
      public static const MARK_COUNT:int = 6;
      
      public static const MOVIE_TYPE_SHUFFLE:int = 1;
      
      public static const MOVIE_TYPE_OPEN_BOX:int = 2;
      
      public static const MOVIE_TYPE_REFRESH:int = 3;
      
      public static const MOVIE_TYPE_SEEK_BOX:int = 4;
      
      public static const MOVIE_TYPE_HAMMER:int = 5;
      
      protected var FChangeTabIndex:int;
      
      protected var FSeekIndex:int;
      
      protected var FRewardIndex:int;
      
      protected var FLastTabIndex:int;
      
      protected var FMayActive2:TMayActive2;
      
      protected var FCurType:int;
      
      protected var FMovieType:int;
      
      protected var FRewardStatus:int;
      
      protected var FMapIndex:int;
      
      protected var FMapStatus:int;
      
      protected var FBarMaxHeight:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FTreasureList:Vector.<MovieClip>;
      
      protected var FRewardList:Vector.<MovieClip>;
      
      protected var FSeekTreasureList:Vector.<MovieClip>;
      
      protected var FTreasureMarkList:Vector.<MovieClip>;
      
      protected var FRewardItemList:Vector.<TUIBaseBox>;
      
      protected var FMC_WorkCDTime:Sprite;
      
      protected var FTF_WorkCDTime:TextField;
      
      protected var FBTN_GoldRefresh:MovieClip;
      
      protected var FBTN_FreeRefresh:MovieClip;
      
      protected var FBTN_GiveUp:MovieClip;
      
      protected var FBTN_Start:MovieClip;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FMC_Bg:MovieClip;
      
      protected var FMC_RefreshMovie:MovieClip;
      
      protected var FMC_SeekMap:MovieClip;
      
      protected var FMC_TreasureMark:MovieClip;
      
      protected var FTF_FreeTreasureMap:TextField;
      
      protected var FTF_FreeSeekTreasure:TextField;
      
      protected var FBTN_Log:MovieClip;
      
      protected var FMC_Shuffle:MovieClip;
      
      protected var FBTN_Seek:MovieClip;
      
      protected var FMC_Mask:MovieClip;
      
      public function TUIMayActive2(param1:TUIComponent)
      {
         super(param1);
         this.FTabList = new Vector.<MovieClip>(TAB_COUNT);
         this.FTreasureList = new Vector.<MovieClip>(TAB_COUNT);
         this.FTreasureMarkList = new Vector.<MovieClip>(TAB_COUNT);
         this.FSeekTreasureList = new Vector.<MovieClip>(SEEK_COUNT);
         this.FRewardList = new Vector.<MovieClip>(REWARD_COUNT);
         this.FRewardItemList = new Vector.<TUIBaseBox>(REWARD_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FTabList[_loc2_] = FMC_Scene["MC_Tab" + _loc2_];
            this.FTabList[_loc2_].MC_Tab.gotoAndStop(_loc2_ + 1);
            this.FTabList[_loc2_].MC_Tab_Equip.gotoAndStop(_loc2_ + 1);
            this.FTabList[_loc2_].buttonMode = true;
            this.FTabList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FTreasureList[_loc2_] = FMC_Scene["MC_Treasure" + _loc2_];
            this.FTreasureList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTipOver);
            this.FTreasureList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnTipOut);
            this.FTreasureList[_loc2_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBox);
            TGameUtil.setButtonMode(this.FTreasureList[_loc2_].BTN_Buy,true);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < REWARD_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene["MC_Reward" + _loc2_]);
            _loc5_.RewardIndex = _loc2_;
            _loc5_.OnOverlay = this.SlotsOnOver;
            _loc5_.OnOut = this.SlotsOnOut;
            this.FRewardItemList[_loc2_] = _loc5_;
            FMC_Scene["MC_Reward" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Reward" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetTreasureReward);
            _loc2_++;
         }
         this.FBTN_GoldRefresh = FMC_Scene["BTN_GoldRefresh"];
         this.FBTN_FreeRefresh = FMC_Scene["BTN_FreeRefresh"];
         this.FBTN_GiveUp = FMC_Scene["BTN_GiveUp"];
         this.FBTN_Start = FMC_Scene["BTN_Start"];
         this.FMC_Reward = FMC_Scene["MC_Reward"];
         this.FMC_Bg = FMC_Scene["MC_Bg"];
         this.FMC_WorkCDTime = FMC_Scene["MC_WorkCDTime"];
         this.FTF_WorkCDTime = this.FMC_WorkCDTime["TF_WorkCDTime"];
         this.FMC_Shuffle = FMC_Scene["MC_Shuffle"];
         this.FMC_Shuffle.visible = false;
         this.FMC_RefreshMovie = FMC_Scene["MC_RefreshMovie"];
         this.FMC_RefreshMovie.visible = false;
         this.FMC_SeekMap = FMC_Scene["MC_SeekMap"];
         this.FMC_TreasureMark = FMC_Scene["MC_TreasureMark"];
         this.FTF_FreeTreasureMap = FMC_Scene["TF_FreeTreasureMap"];
         this.FBTN_Log = this.FMC_TreasureMark["BTN_Log"];
         this.FMC_SeekMap.visible = false;
         this.FTF_FreeSeekTreasure = this.FMC_SeekMap["TF_FreeSeekTreasure"];
         this.FBTN_Seek = FMC_Scene["MC_TreasureMark"]["BTN_Seek"];
         this.FMC_Mask = FMC_Scene["MC_Mask"];
         this.FBarMaxHeight = this.FMC_TreasureMark.MC_Bar0.MC_Mask.height;
         _loc2_ = 0;
         while(_loc2_ < SEEK_COUNT)
         {
            this.FSeekTreasureList[_loc2_] = this.FMC_SeekMap["MC_Point" + _loc2_];
            this.FSeekTreasureList[_loc2_].buttonMode = true;
            this.FSeekTreasureList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetSeekReward);
            this.FSeekTreasureList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSeekTipOver);
            this.FSeekTreasureList[_loc2_].addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnSeekTipOut);
            this.FSeekTreasureList[_loc2_].MC_Smoke.visible = false;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FTreasureMarkList[_loc2_] = this.FMC_TreasureMark["MC_TreasureMark" + _loc2_];
            _loc3_ = 0;
            while(_loc3_ < MARK_COUNT)
            {
               this.FTreasureMarkList[_loc2_]["MC_Mark" + _loc3_].MC_MarkIcon.visible = false;
               this.FTreasureMarkList[_loc2_]["MC_Mark" + _loc3_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnMarkTipOver);
               this.FTreasureMarkList[_loc2_]["MC_Mark" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnMarkTipOut);
               _loc3_++;
            }
            _loc2_++;
         }
         TGameUtil.setButtonMode(this.FBTN_Log,true);
         TGameUtil.setButtonMode(this.FBTN_FreeRefresh,true);
         TGameUtil.setButtonMode(this.FBTN_GoldRefresh,true);
         TGameUtil.setButtonMode(this.FBTN_Start,true);
         TGameUtil.setButtonMode(this.FBTN_GiveUp,true);
         this.FBTN_Log.addEventListener(MouseEvent.CLICK,this.PerformPacket_CS_LoadLogReq);
         this.FBTN_GiveUp.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiveUp);
         this.FBTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorStart);
         this.FBTN_GoldRefresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldRefresh);
         this.FBTN_FreeRefresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreeRefresh);
         this.FMC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRewardTipOver);
         this.FMC_Reward.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnRewardTipOut);
         this.FBTN_GiveUp.visible = false;
         this.FBTN_FreeRefresh.visible = false;
         this.FBTN_Seek.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenSeek);
         this.FBTN_Seek.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnOpenSeekTipOver);
         this.FBTN_Seek.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnOpenSeekTipOut);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnDescUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         this.FChangeTabIndex = 0;
      }
      
      protected function ProcessorOnOpenSeekTipOut(param1:MouseEvent) : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnOpenSeekTipOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FMayActive2.DescListNew[12]);
         }
      }
      
      protected function ProcessorOnOpenSeek(param1:MouseEvent) : void
      {
         var _loc2_:TMsgGraph = null;
         _loc2_ = this.FMayActive2.SeekTreasureMapBoxList[this.FChangeTabIndex];
         if(_loc2_.GraphStatus == TBaseActivity.STATUS_CANGET)
         {
            this.UpdateSeekTreasure();
            this.FMC_TreasureMark.visible = false;
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIBaseBox = null;
         if(FInitialized && this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRewardItemList.length)
            {
               _loc3_ = this.FRewardItemList[_loc1_];
               if(_loc3_ != null)
               {
                  _loc3_.LogicsPerform();
               }
               _loc1_++;
            }
            this.UpdateRefreshTime();
            if(FIsPlaying)
            {
               switch(this.FCurType)
               {
                  case MOVIE_TYPE_SHUFFLE:
                     _loc2_ = this.FMC_Shuffle.currentFrame;
                     break;
                  case MOVIE_TYPE_OPEN_BOX:
                     _loc2_ = int(this.FRewardList[this.FRewardIndex].MC_Smoke.currentFrame);
                     break;
                  case MOVIE_TYPE_REFRESH:
                     _loc2_ = this.FMC_RefreshMovie.currentFrame;
                     break;
                  case MOVIE_TYPE_HAMMER:
                     _loc2_ = int(this.FSeekTreasureList[this.FSeekIndex].MC_Smoke.currentFrame);
               }
               if(_loc2_ == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      protected function ProcessorOnCutTipOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         var _loc6_:TMsgTreasure = null;
         _loc6_ = this.FMayActive2.MsgTreasure[this.FChangeTabIndex];
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         if(FOnItemOut != null && _loc3_ != null && _loc6_.TreasureMapBoxList[_loc2_].Inventories != null)
         {
            _loc3_ = _loc6_.TreasureMapBoxList[_loc2_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc3_);
         }
      }
      
      protected function ProcessorOnCutTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:String = null;
         var _loc6_:TMsgTreasure = null;
         _loc6_ = this.FMayActive2.MsgTreasure[this.FChangeTabIndex];
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(9));
         if(FOnItemOver != null && _loc3_ != null && _loc6_.TreasureMapBoxList[_loc2_].Inventories != null)
         {
            _loc3_ = _loc6_.TreasureMapBoxList[_loc2_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnSeekTipOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FMayActive2.TreasureMapBoxList[_loc2_] == null)
         {
            return;
         }
         _loc4_ = this.FMayActive2.TreasureMapBoxList[_loc2_].Inventories;
         if(_loc4_ == null)
         {
            return;
         }
         if(_loc4_.Count == 0)
         {
            FOnItemOut(this,null);
            return;
         }
         _loc3_ = this.FMayActive2.TreasureMapBoxList[_loc2_].Inventories.GetInventoryByIndex(0);
         if(FOnItemOut != null && _loc3_ != null)
         {
            FOnItemOut(this,_loc3_);
         }
      }
      
      protected function ProcessorOnSeekTipOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FMayActive2.TreasureMapBoxList[_loc2_] == null)
         {
            return;
         }
         _loc4_ = this.FMayActive2.TreasureMapBoxList[_loc2_].Inventories;
         if(_loc4_ == null)
         {
            return;
         }
         _loc3_ = this.FMayActive2.TreasureMapBoxList[_loc2_].Inventories.GetInventoryByIndex(0);
         if(FOnItemOver != null && _loc3_ != null)
         {
            FOnItemOver(this,_loc3_);
         }
      }
      
      protected function ProcessorOnRewardTipOut(param1:MouseEvent) : void
      {
         FOnHideHtmlTip();
      }
      
      protected function ProcessorOnRewardTipOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:TMsgTreasure = null;
         _loc3_ = this.FMayActive2.MsgTreasure[this.FChangeTabIndex];
         _loc2_ = _loc3_.RewardDesc[0];
         FOnShowHtmlTip(_loc2_);
      }
      
      private function ProcessorOnTipOver(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         _loc3_ = this.FMayActive2.BuyTreasureMapBoxList[_loc2_].Inventories.GetInventoryByIndex(0);
         if(FOnItemOver != null)
         {
            FOnItemOver(this,_loc3_);
         }
      }
      
      private function ProcessorOnTipOut(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         _loc3_ = this.FMayActive2.BuyTreasureMapBoxList[_loc2_].Inventories.GetInventoryByIndex(0);
         if(FOnItemOut != null)
         {
            FOnItemOut(this,_loc3_);
         }
      }
      
      private function ProcessorOnMarkTipOut(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:TMsgGraph = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:TBaseBox = null;
         _loc4_ = int(String(param1.currentTarget.name).slice(7));
         _loc5_ = int(String(param1.currentTarget.parent.name).slice(15));
         _loc3_ = this.FMayActive2.SeekTreasureMapBoxList[_loc5_];
         _loc7_ = _loc3_.TreasureBoxList[_loc4_];
         if(FOnItemOut != null && _loc7_ != null)
         {
            if(_loc7_.Inventories != null)
            {
               _loc6_ = _loc7_.Inventories.GetInventoryByIndex(0);
               FOnItemOut(this,_loc6_);
            }
         }
      }
      
      private function ProcessorOnMarkTipOver(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:TMsgGraph = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:TBaseBox = null;
         _loc4_ = int(String(param1.currentTarget.name).slice(7));
         _loc5_ = int(String(param1.currentTarget.parent.name).slice(15));
         _loc3_ = this.FMayActive2.SeekTreasureMapBoxList[_loc5_];
         _loc7_ = _loc3_.TreasureBoxList[_loc4_];
         if(FOnItemOver != null && _loc7_ != null)
         {
            if(_loc7_.Inventories != null)
            {
               _loc6_ = _loc7_.Inventories.GetInventoryByIndex(0);
               FOnItemOver(this,_loc6_);
            }
         }
      }
      
      private function ProcessorOnGetTreasureReward(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:String = null;
         var _loc5_:TMsgTreasure = null;
         _loc5_ = this.FMayActive2.MsgTreasure[this.FChangeTabIndex];
         if(_loc5_.TreasureStatus == TBaseActivity.STATUS_CANNOTGET || _loc5_.TreasureStatus == TBaseActivity.STATUS_CANGET)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(9));
         this.FRewardIndex = _loc2_;
         _loc3_ = _loc5_.TreasureMapBoxList[_loc2_];
         _loc5_.TreasureStatus = TBaseActivity.STATUS_IS_GOT;
         if(this.FMayActive2.FreeTreasureMap > 0)
         {
            if(FOnBuyBox != null && _loc3_.Inventories == null)
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive.ACTVITTY_2_SEARCH,0,this.FChangeTabIndex + 1,TBaseActivity.SWEET_TYPE_FREE,"",_loc2_ + 1);
            }
            return;
         }
         if(FOnBuyBox != null && _loc5_.TreasureStatus == TBaseActivity.STATUS_IS_GOT && _loc3_.Inventories == null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive.ACTVITTY_2_SEARCH,_loc5_.Prize,this.FChangeTabIndex + 1,TBaseActivity.SWEET_TYPE_GOLD,"",_loc2_ + 1);
         }
      }
      
      protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_MayActive2_RewardLog_Req);
         _loc2_.Data.writeUnsignedInt(ACTIVITY_2_ID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnFreeRefresh(param1:MouseEvent) : void
      {
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive.ACTVITTY_2_FREE_REFRESH);
         }
      }
      
      protected function ProcessorOnGoldRefresh(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = TUtilityString.Format(this.FMayActive2.DescListNew[11],this.FMayActive2.RefreshPrize);
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive.ACTIVITY_2_GOLD_REFRESH,this.FMayActive2.RefreshPrize,0,TBaseActivity.SWEET_TYPE_GOLD,_loc2_);
         }
      }
      
      protected function ProcessorOnGetSeekReward(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(IsPlaying == true)
         {
            return;
         }
         this.FSeekIndex = _loc2_;
         if(this.FMayActive2.SeekTreasureCount > 0 && Boolean(this.FMayActive2.TreasureMapBoxList[_loc2_]))
         {
            if(FOnGetBox != null)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorMayActive.ACTVITTY_2_SEEK_BOX,_loc2_ + 1);
            }
         }
      }
      
      private function ProcessorOnDescUp(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorStart(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:TUIBaseBox = null;
         var _loc4_:String = null;
         var _loc5_:Vector.<Object> = null;
         var _loc6_:TConfigValue = null;
         var _loc7_:TMsgTreasure = null;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc5_ = _loc6_.Value as Vector.<Object>;
         _loc7_ = this.FMayActive2.MsgTreasure[this.FChangeTabIndex];
         _loc4_ = TUtilityString.Format(this.FMayActive2.DescListNew[3],_loc7_.NeedScore,_loc5_[12 + this.FChangeTabIndex]);
         if(this.FMayActive2.TreasureMapCount[this.FChangeTabIndex] < _loc7_.NeedScore)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive.ACTIVITY_2_START,0,this.FChangeTabIndex + 1,TBaseActivity.SWEET_TYPE_GOLD,_loc4_);
         }
      }
      
      protected function ProcessorOnGiveUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         _loc2_ = this.FMayActive2.DescListNew[4];
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive.ACTVITTY_2_GIVE_UP,0,this.FChangeTabIndex + 1,TBaseActivity.SWEET_TYPE_GOLD,_loc2_);
         }
      }
      
      protected function ProcessorOnBuyBox(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(11));
         _loc3_ = this.FMayActive2.BuyTreasureMapBoxList[_loc2_];
         if(FOnBuyBox != null)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorMayActive.ACTVITTY_2_BUY_BOX,_loc3_.Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         this.FChangeTabIndex = _loc2_;
         this.FTabList[this.FChangeTabIndex].MC_Tab.gotoAndStop(3);
         if(this.FChangeTabIndex != this.FLastTabIndex)
         {
            this.FTabList[this.FLastTabIndex].MC_Tab.gotoAndStop(1);
         }
         this.FLastTabIndex = this.FChangeTabIndex;
         this.FMC_Bg.gotoAndStop(this.FChangeTabIndex + 1);
         this.UpdateUI();
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMayActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMayActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMayActive2.DescListNew[0];
         this.FTF_FreeTreasureMap.text = TUtilityString.Format(this.FMayActive2.DescListNew[1],this.FMayActive2.FreeTreasureMap);
      }
      
      private function UpdateRefreshTime() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this.FMayActive2.RefreshBuyTime - STimingCore.GetServerTick();
         this.FTF_WorkCDTime.text = TGameUtil.fomatTime(this.FMayActive2.RefreshBuyTime - STimingCore.GetServerTick());
         if(_loc1_ > 0)
         {
            this.FBTN_FreeRefresh.visible = false;
            this.FBTN_GoldRefresh.visible = true;
         }
         else
         {
            this.FBTN_FreeRefresh.visible = true;
            this.FBTN_GoldRefresh.visible = false;
         }
      }
      
      protected function UpdateBuyTreasure() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:TInventory = null;
         var _loc4_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc2_ = this.FMayActive2.BuyTreasureMapBoxList[_loc1_];
            _loc4_ = this.FTreasureList[_loc1_];
            _loc4_.TF_Price.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_CUR_PRICE,_loc2_.Price);
            _loc3_ = _loc2_.Inventories.GetInventoryByIndex(0);
            _loc4_.MC_BoxPic.gotoAndStop("ID" + _loc3_.IDTemplate);
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               TGameUtil.setButtonMode(this.FTreasureList[_loc1_].BTN_Buy,true);
               this.FTreasureList[_loc1_].BTN_Buy.mouseEnabled = true;
            }
            else
            {
               TGameUtil.setButtonMode(this.FTreasureList[_loc1_].BTN_Buy,false);
               this.FTreasureList[_loc1_].BTN_Buy.mouseEnabled = false;
            }
            _loc1_++;
         }
         this.UpdateRefreshTime();
      }
      
      override public function UpdateUI() : void
      {
         this.FMayActive2 = SLogicsCore.MayActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TMayActive2;
         this.UpdateWindow();
      }
      
      public function UpdateWindow() : void
      {
         var _loc1_:TMsgGraph = null;
         var _loc2_:TBaseBox = null;
         this.UpdateText();
         this.UpdateBuyTreasure();
         this.UpdateOpenTreasure();
         _loc1_ = this.FMayActive2.SeekTreasureMapBoxList[this.FChangeTabIndex];
         if(this.FMayActive2.SeekTreasureStatue == TBaseActivity.STATUS_CANGET && this.FMayActive2.SeekTreasureCount > 0)
         {
            this.UpdateSeekTreasure();
            this.FMC_TreasureMark.visible = false;
         }
         else
         {
            this.UpdateSeekMark();
            this.FMC_SeekMap.visible = false;
         }
         this.UpdateTreasureMapCount();
      }
      
      private function UpdateTreasureMapCount() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            _loc2_.TF_MapCount.text = this.FMayActive2.TreasureMapCount[_loc1_];
            _loc2_.MC_Tab.gotoAndStop(_loc1_ + 1);
            _loc2_.MC_Tab_Equip.gotoAndStop(_loc1_ + 1);
            if(this.FChangeTabIndex == _loc1_)
            {
               _loc2_.MC_Tab.visible = true;
               _loc2_.MC_Tab_Equip.visible = false;
            }
            else
            {
               _loc2_.MC_Tab.visible = false;
               _loc2_.MC_Tab_Equip.visible = true;
            }
            _loc1_++;
         }
      }
      
      private function UpdateOpenTreasure() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TMsgTreasure = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TUIBaseBox = null;
         _loc2_ = this.FMayActive2.MsgTreasure[this.FChangeTabIndex];
         if(_loc2_.TreasureStatus == TBaseActivity.STATUS_CANGET)
         {
            this.FBTN_Start.visible = true;
            this.FBTN_GiveUp.visible = false;
            this.FMC_Mask.visible = false;
            _loc1_ = 0;
            while(_loc1_ < REWARD_COUNT)
            {
               _loc4_ = this.FRewardItemList[_loc1_];
               _loc4_.SetVisible(true);
               _loc4_.SetFrame(1);
               _loc4_.SetMCIsVisible("MC_CanGet",false);
               _loc3_ = _loc2_.TreasureMapBoxList[_loc1_];
               if(_loc3_ != null && Boolean(_loc3_.Inventories))
               {
                  _loc4_.UpdateUI(_loc3_.Inventories);
               }
               _loc1_++;
            }
         }
         else if(_loc2_.TreasureStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FBTN_Start.visible = true;
            this.FBTN_GiveUp.visible = false;
            this.FMC_Mask.visible = true;
            _loc1_ = 0;
            while(_loc1_ < REWARD_COUNT)
            {
               _loc4_ = this.FRewardItemList[_loc1_];
               _loc4_.SetVisible(true);
               _loc4_.SetFrame(1);
               _loc4_.SetSlotVisible(false);
               _loc4_.SetMCIsVisible("MC_CanGet",false);
               _loc1_++;
            }
         }
         else if(_loc2_.TreasureStatus == TBaseActivity.STATUS_IS_GOT)
         {
            this.FBTN_Start.visible = false;
            this.FBTN_GiveUp.visible = true;
            this.FMC_Mask.visible = false;
            _loc1_ = 0;
            while(_loc1_ < REWARD_COUNT)
            {
               _loc4_ = this.FRewardItemList[_loc1_];
               _loc4_.SetVisible(true);
               _loc3_ = _loc2_.TreasureMapBoxList[_loc1_];
               _loc4_.UpdateUI(null);
               if(_loc3_ != null && _loc3_.Inventories != null)
               {
                  _loc4_.SetFrame(2);
                  _loc4_.UpdateUI(_loc3_.Inventories);
                  _loc4_.SetMCIsVisible("MC_CanGet",false);
               }
               else
               {
                  _loc4_.SetFrame(1);
                  _loc4_.SetSlotVisible(false);
                  _loc4_.SetMCIsVisible("MC_CanGet",true);
               }
               _loc1_++;
            }
         }
         if(this.FMayActive2.TreasureMapCount[this.FChangeTabIndex] > 0)
         {
            TGameUtil.setButtonMode(this.FBTN_Start,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_Start,false);
         }
      }
      
      private function UpdateSeekTreasure() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TMsgGraph = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < SEEK_COUNT)
         {
            _loc3_ = this.FMayActive2.TreasureMapBoxList[_loc1_];
            if(_loc3_ != null && _loc3_.Inventories != null)
            {
               this.FSeekTreasureList[_loc1_].gotoAndStop(2);
            }
            else
            {
               this.FSeekTreasureList[_loc1_].gotoAndStop(1);
            }
            _loc1_++;
         }
         this.FTF_FreeSeekTreasure.text = TUtilityString.Format(this.FMayActive2.DescListNew[2],this.FMayActive2.SeekTreasureCount);
         this.FMC_SeekMap.visible = true;
         this.FMC_TreasureMark.visible = false;
      }
      
      private function UpdateSeekMark() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TMsgGraph = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         this.FMC_SeekMap.visible = false;
         this.FMC_TreasureMark.visible = true;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc2_ = this.FMayActive2.SeekTreasureMapBoxList[_loc1_];
            _loc5_ = Number(_loc2_.CurStep / 6) * this.FBarMaxHeight;
            _loc6_ = this.FMC_TreasureMark["MC_Bar" + _loc1_].MC_Mask;
            _loc6_.height = Math.min(_loc5_,this.FBarMaxHeight);
            _loc4_ = 0;
            while(_loc4_ < MARK_COUNT)
            {
               _loc3_ = _loc2_.TreasureBoxList[_loc1_];
               if(_loc4_ + 1 == _loc2_.CurStep)
               {
                  this.FTreasureMarkList[_loc1_]["MC_Mark" + _loc4_].MC_MarkIcon.visible = true;
               }
               else
               {
                  this.FTreasureMarkList[_loc1_]["MC_Mark" + _loc4_].MC_MarkIcon.visible = false;
               }
               _loc4_++;
            }
            if(_loc2_.CurStep == 6)
            {
               this.FMC_TreasureMark["MC_End" + _loc1_].visible = true;
            }
            else
            {
               this.FMC_TreasureMark["MC_End" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:TInventories = null;
         var _loc8_:TUIBaseBox = null;
         FIsPlaying = true;
         this.FCurType = param1;
         switch(param1)
         {
            case MOVIE_TYPE_SHUFFLE:
               this.FBTN_GiveUp.mouseEnabled = false;
               this.FBTN_Start.mouseEnabled = false;
               _loc6_ = this.FMC_Shuffle;
               FTotalFrame = _loc6_.totalFrames;
               _loc6_.visible = true;
               _loc6_.gotoAndPlay(1);
               _loc3_ = 0;
               while(_loc3_ < this.FRewardItemList.length)
               {
                  _loc8_ = this.FRewardItemList[_loc3_];
                  _loc8_.SetVisible(false);
                  _loc3_++;
               }
               break;
            case MOVIE_TYPE_OPEN_BOX:
               _loc6_ = this.FRewardList[this.FRewardIndex].MC_Smoke;
               FTotalFrame = _loc6_.totalFrames;
               _loc6_.gotoAndPlay(1);
               break;
            case MOVIE_TYPE_REFRESH:
               this.FBTN_GiveUp.mouseEnabled = false;
               this.FBTN_Start.mouseEnabled = false;
               _loc6_ = this.FMC_RefreshMovie;
               _loc6_.visible = true;
               FTotalFrame = _loc6_.totalFrames;
               _loc6_.gotoAndPlay(1);
               if(this.FRewardStatus == TBaseActivity.STATUS_CANGET)
               {
                  FMC_Scene.MC_Reward.gotoAndStop(2);
                  FMC_Scene.MC_Reward.MC_OpenMovie.gotoAndPlay(1);
               }
               break;
            case MOVIE_TYPE_HAMMER:
               _loc6_ = this.FSeekTreasureList[this.FSeekIndex].MC_Smoke;
               FTotalFrame = _loc6_.totalFrames;
               _loc6_.visible = true;
               _loc6_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         switch(this.FCurType)
         {
            case MOVIE_TYPE_SHUFFLE:
               this.FMC_Shuffle.visible = false;
               this.UpdateUI();
               this.FBTN_GiveUp.mouseEnabled = true;
               this.FBTN_Start.mouseEnabled = true;
               break;
            case MOVIE_TYPE_OPEN_BOX:
               this.UpdateOpenTreasure();
               break;
            case MOVIE_TYPE_REFRESH:
               this.FMC_RefreshMovie.visible = false;
               if(this.FRewardStatus == TBaseActivity.STATUS_CANGET)
               {
                  FMC_Scene.MC_Reward.gotoAndStop(1);
                  this.FRewardStatus = TBaseActivity.STATUS_CANNOTGET;
                  this.FMayActive2.MsgTreasure[this.FMapIndex].TreasureStatus = this.FMapStatus;
               }
               this.FBTN_GiveUp.mouseEnabled = true;
               this.FBTN_Start.mouseEnabled = true;
               this.UpdateUI();
               break;
            case MOVIE_TYPE_HAMMER:
               this.FSeekTreasureList[this.FSeekIndex].MC_Smoke.gotoAndStop(1);
               this.FSeekTreasureList[this.FSeekIndex].MC_Smoke.visible = false;
               this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FMapIndex = param1;
         this.FMapStatus = param2;
         this.FRewardStatus = param3;
         setTimeout(this.DelayPlayMovie,1000);
         this.FBTN_GiveUp.mouseEnabled = false;
         this.FBTN_Start.mouseEnabled = false;
      }
      
      public function DelayPlayMovie() : void
      {
         this.PlayMovie(MOVIE_TYPE_REFRESH);
      }
   }
}

