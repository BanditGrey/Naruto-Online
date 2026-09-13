package Processors.Game.Lobby.Lottery
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLottery;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Lottery.TUnstreamizerExchangeItem;
   import Logics.Streamization.Lottery.TUnstreamizerLottery;
   import Logics.Streamization.Lottery.TUnstreamizerLotteryItem;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Inventories.TOverlayerAccessory;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.Inventories.TOverlayerEquipment;
   import Rendering.Overlayers.Inventories.TOverlayerTreasure;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_INVENTORY;
   import Resources.Constants.CONST_LOTTERY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_LOTTERY;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorLottery extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Recruit:uint = 394;
      
      protected static const SIZE_HEIGHT_Recruit:uint = 379;
      
      public static const TAB_TYPE_FREE_LOTTERY:int = 0;
      
      public static const TAB_TYPE_GOLD_LOTTERY:int = 1;
      
      public static const TYPE_OUTSIDE:int = 1;
      
      public static const TYPE_INSIDE:int = 2;
      
      public static const TYPE_ONE:int = 0;
      
      public static const TYPE_TEN:int = 1;
      
      public static const TYPE_FIFTY:int = 2;
      
      public static const CAPACITY_INVENTORIES:uint = CONST_COMMON.CAPACITY_INVENTORIES;
      
      public static const CATEGORY_Normal:uint = CONST_INVENTORY.CATEGORY_Normal;
      
      public static const CATEGORY_Equipment:uint = CONST_INVENTORY.CATEGORY_Equipment;
      
      public static const CATEGORY_Gem:uint = CONST_INVENTORY.CATEGORY_Gem;
      
      public static const CATEGORY_Treasure:uint = CONST_INVENTORY.CATEGORY_Treasure;
      
      public static const CATEGORY_Material:uint = CONST_INVENTORY.CATEGORY_Material;
      
      public static const CATEGORY_Accessories:uint = CONST_INVENTORY.CATEGORY_Accessories;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected var SIZE_Lottery_Width:int = 818;
      
      protected var SIZE_Lottery_Height:int = 563;
      
      protected var FProcessorWindowLottery:TProcessorWindowLottery;
      
      protected var FProcessorWindowExchange:TProcessorWindowExchange;
      
      protected var FProcessorWindowLotteryLog:TProcessorWindowLotteryLog;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FBoundsRecruit:TBounds;
      
      protected var FBoundsLottery:TBounds;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FTab_Lottery:TUITab;
      
      protected var FTabVect:Vector.<MovieClip>;
      
      protected var FBtn_TabFreeLottery:MovieClip;
      
      protected var FBtn_TabGoldLottery:MovieClip;
      
      protected var FBtn_TabStorage:MovieClip;
      
      protected var FChangeTabIndex:int;
      
      protected var FLottery:TLottery;
      
      protected var FUnstreamizerLottery:TUnstreamizerLottery;
      
      protected var FUnstreamizerLotteryItem:TUnstreamizerLotteryItem;
      
      protected var FUnstreamizerExchangeItem:TUnstreamizerExchangeItem;
      
      protected var FExchangeIdentify:int;
      
      protected var FLotteryType:int;
      
      protected var FIsOutside:int;
      
      protected var FTimeId:int;
      
      protected var FNewsTimeId:int;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FStringID:int;
      
      protected var FSystemLanguage:TSystemLanguage;
      
      protected var FEndTimeID:int;
      
      protected var FDelayTimeID:int;
      
      protected var FEndTime:int;
      
      protected var FOnOpenLottery:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnOpenActivity:Function;
      
      public function TProcessorLottery(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerLottery = new TUnstreamizerLottery();
         this.FUnstreamizerLotteryItem = new TUnstreamizerLotteryItem();
         this.FUnstreamizerExchangeItem = new TUnstreamizerExchangeItem();
         this.FLottery = SLogicsCore.Lottery;
         this.FProcessorWindowLottery = new TProcessorWindowLottery(this);
         this.FProcessorWindowLottery.OnRecordUp = this.ProcessorOnRecordUp;
         this.FProcessorWindowLottery.OnExchangeUp = this.ProcessorOnExchangeUp;
         this.FProcessorWindowLottery.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowLottery.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowLottery.OnFreeLotteryUp = this.PerformPacket_CS_FreeLotteryReq;
         this.FProcessorWindowLottery.OnGoldLotteryUp = this.PerformPacket_CS_GoldLotteryReq;
         this.FProcessorWindowLottery.TipOnOver = this.TipOnOver;
         this.FProcessorWindowLottery.TipOnOut = this.TipOnOut;
         this.FProcessorWindowLottery.OnMovieEnd = this.ProcessorOnMovieEnd;
         this.FProcessorWindowLottery.OnShowHeroInfo = this.ProcessorOnShowHeroInfo;
         this.FProcessorWindowLottery.OnShowRecruit1 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowLottery.OnShowRecruit2 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowLottery.OnShowRecruit3 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowLottery.OnShowRecruit4 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowLotteryLog = new TProcessorWindowLotteryLog(this);
         this.FProcessorWindowLotteryLog.OnCloseUp = this.ProcessorOnRecordUp;
         this.FProcessorWindowExchange = new TProcessorWindowExchange(this);
         this.FProcessorWindowExchange.OnCloseUp = this.ProcessorOnExchangeUp;
         this.FProcessorWindowExchange.OnExchange = this.PerformPacket_CS_ExchangeReq;
         this.FProcessorWindowExchange.DownHintOnOver = UIComponentsHintOnOver;
         this.FProcessorWindowExchange.DownHintOnOut = UIComponentsHintOnOut;
         this.FProcessorWindowExchange.TipOnOver = this.TipOnOver;
         this.FProcessorWindowExchange.TipOnOut = this.TipOnOut;
         this.FProcessorWindowExchange.OnShowRecruit1 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit2 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit3 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit4 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit5 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit6 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit7 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowExchange.OnShowRecruit8 = this.ProcessorOnShowRecruit1;
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = this.TipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = this.TipOnOut;
         this.FTab_Lottery = new TUITab(this);
         this.FTabVect = new Vector.<MovieClip>();
         this.FChangeTabIndex = 0;
         this.FEffectTexts = new Vector.<String>();
         this.FBoundsLottery = new TBounds();
         this.FBoundsLottery.Width = this.SIZE_Lottery_Width;
         this.FBoundsLottery.Height = this.SIZE_Lottery_Height;
         ComponentBoundsCenter(this,this.FBoundsLottery);
         SetUIModuleID(CONST_MODULES.ACTIVE_Test);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_LOTTERY.RESOURCESID_Swf_Lottery);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance(CONST_LOTTERY.RESOURCE_ClassName_MC_Lottery) as Sprite;
         addChild(this.FMC_Scene);
         this.FMC_EffectLeft = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_EffectLeft];
         this.FMC_EffectRight = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_EffectRight];
         this.FBtn_Close = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_BTN_Close];
         this.FBtn_TabFreeLottery = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_TabFreeLottery];
         this.FBtn_TabGoldLottery = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_TabGoldLottery];
         this.FTabVect.push(this.FBtn_TabFreeLottery);
         this.FTabVect.push(this.FBtn_TabGoldLottery);
         _loc1_ = 0;
         while(_loc1_ < this.FTabVect.length)
         {
            this.FTab_Lottery.SetTabByIndex(this.FTabVect[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FTab_Lottery.Init();
         this.FTab_Lottery.OnSwitch = this.ChangeTabOnSwitch;
         this.FProcessorWindowLottery.Perform_UIDispatch(this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_LotteryView]);
         addChild(this.FProcessorWindowLottery);
         addChild(this.FProcessorWindowLotteryLog);
         addChild(this.FProcessorWindowExchange);
         addChild(this.FProcessorWindowRecruit);
         this.FProcessorWindowRecruit.x = this.x;
         this.FProcessorWindowRecruit.y = this.y + 100;
         FOverlayerEquipment = new TOverlayerEquipment(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerEquipment.Visible = false;
         FOverlayerTreasure = new TOverlayerTreasure(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerTreasure.Visible = false;
         FOverlayerAppliance = new TOverlayerAppliance(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAppliance.Visible = false;
         FOverlayerAccessory = new TOverlayerAccessory(this.Parent,CONST_MODULES.ACTIVE_Test);
         FOverlayerAccessory.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerEquipment);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerTreasure);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAppliance);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerAccessory);
         FOverlayerHint = new TOverlayerHint(this.Parent);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         super.PacketRegisterRoutines();
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_LoadInfoRet,this.PerformPacket_SC_LoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_FreeLotteryRet,this.PerformPacket_SC_FreeLotteryRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_GoldLotteryRet,this.PerformPacket_SC_GoldLotteryRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_LotteryNewsRet,this.PerformPacket_SC_LotteryNewsRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_LoadExchangeItemRet,this.PerformPacket_SC_LoadExchangeItemRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_ExchangeRet,this.PerformPacket_SC_ExchangeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_LotteryLogRet,this.PerformPacket_SC_ExchargeInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_LoadLotteryItemRet,this.PerformPacket_SC_LoadLotteryItemRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Lottery_OpenActiveRet,this.PerformPacket_SC_OpenActiveRet);
      }
      
      protected function SetTabCanClick(param1:Boolean) : void
      {
         if(this.FChangeTabIndex == TAB_TYPE_FREE_LOTTERY)
         {
            if(param1)
            {
               this.FTab_Lottery.SetTabEnabledByIndex(1,false);
               this.FTab_Lottery.SetTabCanClickByIndex(1);
            }
            else
            {
               this.FTab_Lottery.SetTabEnabledByIndex(1,true);
            }
         }
         else if(param1)
         {
            this.FTab_Lottery.SetTabEnabledByIndex(0,false);
            this.FTab_Lottery.SetTabCanClickByIndex(0);
         }
         else
         {
            this.FTab_Lottery.SetTabEnabledByIndex(0,true);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
         {
            this.FProcessorWindowRecruit.UpdataBitmap();
         }
         this.LogicsPerform_EffectText();
      }
      
      protected function ProcessorDelayCloseActivity() : void
      {
         if(this.FEndTimeID != 0)
         {
            clearTimeout(this.FEndTimeID);
            this.FEndTimeID = 0;
         }
         var _loc1_:Number = (this.FEndTime - STimingCore.GetServerTick()) * 1000;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         if(_loc1_ > int.MAX_VALUE)
         {
            _loc1_ = int.MAX_VALUE;
         }
         this.FEndTimeID = setTimeout(this.ProcessorCloseActivity,_loc1_);
         clearTimeout(this.FDelayTimeID);
      }
      
      protected function ProcessorCloseActivity() : void
      {
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_Lottery,false);
         if(this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
         clearTimeout(this.FEndTimeID);
         this.FEndTimeID = 0;
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Lottery_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadItemReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Lottery_LoadLotteryItemReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_LoadExchangeItemReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Lottery_LoadExchangeItemReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_FreeLotteryReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FProcessorWindowLottery.IsMovieStart())
         {
            return;
         }
         this.SetTabCanClick(false);
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Lottery_FreeLotteryReq);
         _loc3_ = _loc2_.Data;
         if(param1 == TYPE_OUTSIDE)
         {
            _loc3_.writeUnsignedInt(TYPE_OUTSIDE);
         }
         else
         {
            _loc3_.writeUnsignedInt(TYPE_INSIDE);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FIsOutside = param1;
         this.ProcessorOnLockBtn(param1);
      }
      
      protected function PerformPacket_CS_GoldLotteryReq(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         if(this.FProcessorWindowLottery.IsMovieStart())
         {
            return;
         }
         this.SetTabCanClick(false);
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Lottery_GoldLotteryReq);
         _loc4_ = _loc3_.Data;
         if(param1 == TYPE_OUTSIDE)
         {
            _loc4_.writeUnsignedInt(TYPE_OUTSIDE);
         }
         else
         {
            _loc4_.writeUnsignedInt(TYPE_INSIDE);
         }
         if(param2 == TYPE_ONE)
         {
            _loc4_.writeUnsignedInt(TYPE_ONE);
         }
         else if(param2 == TYPE_TEN)
         {
            _loc4_.writeUnsignedInt(TYPE_TEN);
         }
         else
         {
            _loc4_.writeUnsignedInt(TYPE_FIFTY);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         this.FIsOutside = param1;
         this.FLotteryType = param2;
         this.ProcessorOnLockBtn(param1);
      }
      
      protected function PerformPacket_CS_ExchangeReq(param1:int) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Lottery_ExchangeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.FExchangeIdentify = param1;
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedByte());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FLottery.LotteryEndTime = _loc2_.readUnsignedInt();
         this.FEndTime = this.FLottery.LotteryEndTime;
         SLogicsCore.Lottery = this.FLottery;
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_Lottery,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenLottery != null)
         {
            this.FOnOpenLottery();
         }
         if(this.FDelayTimeID != 0)
         {
            clearTimeout(this.FDelayTimeID);
            this.FDelayTimeID = 0;
         }
         this.FDelayTimeID = setTimeout(this.ProcessorDelayCloseActivity,10 * 1000);
      }
      
      protected function PerformPacket_SC_LoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerLottery.Unstreamize(_loc2_,this.FLottery,null);
         SLogicsCore.Lottery = this.FLottery;
      }
      
      protected function PerformPacket_SC_LoadLotteryItemRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerLotteryItem.Unstreamize(_loc2_,this.FLottery.LotteryItems,null);
         SLogicsCore.Lottery = this.FLottery;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowLottery.Visible = true;
            this.FProcessorWindowLotteryLog.Visible = false;
            this.FProcessorWindowExchange.Visible = false;
            this.FProcessorWindowLottery.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_LoadExchangeItemRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerExchangeItem.Unstreamize(_loc2_,this.FLottery.ExchangeItems,null);
         SLogicsCore.Lottery = this.FLottery;
         if(FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowExchange.UpdateUI();
         }
      }
      
      protected function PerformPacket_SC_FreeLotteryRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc6_:Vector.<int> = null;
         _loc2_ = param1.Data;
         var _loc5_:int = _loc2_.readInt();
         if(_loc5_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc5_);
            this.FProcessorWindowLottery.UpdateUI();
         }
         else
         {
            _loc3_ = int(_loc2_.readUnsignedInt());
            _loc6_ = new Vector.<int>();
            _loc6_.push(_loc3_);
            if(this.FIsOutside == TYPE_OUTSIDE)
            {
               this.FTimeId = setTimeout(this.DelayReport,4500,_loc6_);
            }
            else
            {
               this.FTimeId = setTimeout(this.DelayReport,3500,_loc6_);
            }
            this.FProcessorWindowLottery.PerformPacket_SC_FreeLotteryRet(_loc3_);
         }
      }
      
      protected function PerformPacket_SC_GoldLotteryRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Vector.<int> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:String = null;
         _loc2_ = param1.Data;
         var _loc8_:int = int(_loc2_.readUnsignedInt());
         if(_loc8_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc8_);
            this.FProcessorWindowLottery.UpdateUI();
         }
         else
         {
            _loc4_ = int(_loc2_.readUnsignedShort());
            _loc3_ = new Vector.<int>(_loc4_);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_[_loc5_] = _loc2_.readUnsignedInt();
               _loc5_++;
            }
            if(this.FIsOutside == TYPE_OUTSIDE)
            {
               this.FTimeId = setTimeout(this.DelayReport,4500,_loc3_);
            }
            else
            {
               this.FTimeId = setTimeout(this.DelayReport,3500,_loc3_);
            }
            this.FProcessorWindowLottery.PerformPacket_SC_GoldLotteryRet(_loc3_);
         }
      }
      
      protected function PerformPacket_SC_LotteryNewsRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TLotteryNews = null;
         _loc2_ = param1.Data;
         _loc4_ = new TLotteryNews();
         _loc4_.NewsType = _loc2_.readUnsignedInt();
         _loc4_.Identify = _loc2_.readUnsignedInt();
         _loc4_.PlayerNick = TUtilityString.FetchUTF(_loc2_);
         _loc4_.Identifier0 = _loc2_.readUnsignedInt();
         _loc4_.Identifier1 = _loc2_.readUnsignedInt();
         this.FLottery = SLogicsCore.Lottery;
         _loc3_ = int(this.FLottery.LotteryNews.length);
         if(_loc3_ >= 50)
         {
            this.FLottery.LotteryNews.shift();
         }
         this.FLottery.LotteryNews.push(_loc4_);
         setTimeout(this.DelayNews,4500);
      }
      
      protected function PerformPacket_SC_ExchargeInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TLotteryNews = null;
         _loc2_ = param1.Data;
         _loc4_ = new TLotteryNews();
         _loc4_.NewsType = _loc2_.readUnsignedInt();
         _loc4_.Identify = _loc2_.readUnsignedInt();
         _loc4_.GetTime = _loc2_.readUnsignedInt();
         this.FLottery = SLogicsCore.Lottery;
         this.FLottery.LotteryLog.push(_loc4_);
      }
      
      protected function PerformPacket_SC_ExchangeRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:Vector.<int> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         _loc2_ = param1.Data;
         var _loc7_:int = int(_loc2_.readUnsignedInt());
         if(_loc7_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc7_);
            this.FProcessorWindowExchange.UpdateUI();
         }
         else
         {
            _loc6_ = TUtilityString.Format(STRING_LOTTERY.FORMAT_EXCHANGE_ITEM,this.FLottery.getInventoryByIdentify(2,this.FExchangeIdentify).Name + "*" + this.FLottery.getInventoryByIdentify(2,this.FExchangeIdentify).Quantity);
            EffectGenerateText(_loc6_);
            this.FLottery.Point -= this.FLottery.getCostPointByIdentify(this.FExchangeIdentify);
            this.FProcessorWindowExchange.PerformPacket_SC_ExchangeRet(this.FExchangeIdentify);
         }
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.FProcessorWindowLottery.ChangeTabOnSwitch(_loc2_);
      }
      
      protected function ProcessorOnRecordUp(param1:Boolean) : void
      {
         if(FIsResourcesLoadCompleted)
         {
            if(param1)
            {
               this.FProcessorWindowLottery.Visible = true;
               this.FProcessorWindowLotteryLog.Visible = true;
               this.FProcessorWindowExchange.Visible = false;
               this.FProcessorWindowLotteryLog.UpdateUI();
            }
            else
            {
               this.FProcessorWindowLottery.Visible = true;
               this.FProcessorWindowLotteryLog.Visible = false;
               this.FProcessorWindowExchange.Visible = false;
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:Boolean) : void
      {
         if(FIsResourcesLoadCompleted)
         {
            if(param1)
            {
               this.FProcessorWindowLottery.Visible = true;
               this.FProcessorWindowLotteryLog.Visible = false;
               this.FProcessorWindowExchange.Visible = true;
               this.FProcessorWindowExchange.UpdateUI();
            }
            else
            {
               this.FProcessorWindowLottery.Visible = true;
               this.FProcessorWindowLotteryLog.Visible = false;
               this.FProcessorWindowExchange.Visible = false;
            }
         }
      }
      
      protected function TipOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function TipOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      protected function ProcessOnClose(param1:MouseEvent) : void
      {
         if(this.FProcessorWindowLottery.IsMovieStart())
         {
            return;
         }
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnMovieEnd(param1:Boolean) : void
      {
         this.SetTabCanClick(param1);
      }
      
      protected function ProcessorOnLockBtn(param1:int) : void
      {
         this.FProcessorWindowLottery.ProcessorOnLockBtn(param1);
      }
      
      protected function LogicsPerform_EffectText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc6_ = "";
         _loc4_ = "";
         if(this.FIsEndPushText)
         {
            if(this.FEffectTexts.length == 0)
            {
               return;
            }
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
            _loc2_ = int(this.FEffectTexts.length);
            _loc3_ = 10;
            _loc5_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc5_ < EffectMulti_DelayTicks)
            {
               return;
            }
            _loc7_ = this.GetEffectText(this.FStringID);
            _loc6_ = _loc7_.split("\\n")[0] + "\n";
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               if(_loc2_ <= _loc1_)
               {
                  break;
               }
               _loc4_ += this.FEffectTexts.shift();
               _loc4_ = _loc4_ + "\n";
               _loc1_++;
            }
            _loc6_ += _loc4_;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            EffectGenerateText(_loc6_);
         }
      }
      
      protected function GetEffectText(param1:uint) : String
      {
         this.FSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.FStringID) as TSystemLanguage;
         if(this.FSystemLanguage != null)
         {
            return this.FSystemLanguage.Desc;
         }
         return "";
      }
      
      protected function ProcessorOnShowHeroInfo(param1:uint, param2:uint) : void
      {
         if(this.FOnShowHeroInfo != null)
         {
            this.FOnShowHeroInfo(this,param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit1(param1:int) : void
      {
         if(param1 < this.FLottery.HeroList.length)
         {
            this.FProcessorWindowRecruit.SetHeroData(this.FLottery.HeroList[param1]);
         }
      }
      
      public function get OnOpenLottery() : Function
      {
         return this.FOnOpenLottery;
      }
      
      public function set OnOpenLottery(param1:Function) : void
      {
         this.FOnOpenLottery = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowLottery.Load();
            this.FProcessorWindowExchange.Load();
            this.FProcessorWindowLotteryLog.Load();
            this.FProcessorWindowRecruit.Load();
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
         this.PerformPacket_CS_LoadItemReq();
         this.PerformPacket_CS_LoadExchangeItemReq();
      }
      
      override public function Unmount() : void
      {
         this.FProcessorWindowLottery.Visible = false;
         this.FProcessorWindowExchange.Visible = false;
         this.FProcessorWindowLotteryLog.Visible = false;
         super.Unmount();
      }
      
      public function DelayNews() : void
      {
         clearTimeout(this.FNewsTimeId);
         this.FProcessorWindowLottery.UpdateNews();
      }
      
      public function DelayReport(param1:Vector.<int>) : void
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         clearTimeout(this.FTimeId);
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1[_loc6_];
            _loc5_ = this.FLottery.getInventoryByIdentify(1,_loc4_);
            _loc3_ = _loc5_.Quantity ? _loc5_.Quantity : 1;
            _loc2_ = this.FLottery.getInventoryByIdentify(1,_loc4_).Name + "*" + _loc3_.toString();
            this.FEffectTexts.push(_loc2_);
            _loc6_++;
         }
         this.FIsEndPushText = true;
      }
      
      public function TestInit() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUnsignedInt(90);
         _loc1_.writeUnsignedInt(90);
         _loc1_.writeUnsignedInt(50);
         _loc1_.writeUnsignedInt(0);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(1);
         _loc1_.writeUnsignedInt(STimingCore.GetServerTime() + 200000);
         _loc1_.writeUnsignedInt(3);
         TUtilityString.FlushUTF(_loc1_,"活动名字");
         TUtilityString.FlushUTF(_loc1_,"活动描述");
         _loc1_.writeUnsignedInt(10);
         _loc1_.writeUnsignedInt(80);
         _loc1_.writeUnsignedInt(400);
         _loc1_.writeUnsignedInt(10);
         _loc1_.writeUnsignedInt(10);
         _loc1_.writeUnsignedInt(10);
         _loc1_.writeUnsignedInt(100);
         _loc1_.writeShort(0);
         _loc1_.writeShort(0);
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function TestInitItem() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:Array = [{
            "identify":16,
            "slotid":1,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100009,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":17,
            "slotid":2,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100010,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":18,
            "slotid":3,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100011,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":19,
            "slotid":4,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100012,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":20,
            "slotid":5,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14800001,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":21,
            "slotid":6,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14800002,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":22,
            "slotid":7,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14800003,
            "count":1,
            "isshine":1,
            "shinecolor":1
         },{
            "identify":23,
            "slotid":8,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100017,
            "count":1,
            "isshine":1,
            "shinecolor":2
         },{
            "identify":24,
            "slotid":9,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100018,
            "count":1,
            "isshine":1,
            "shinecolor":3
         },{
            "identify":25,
            "slotid":10,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14800020,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":26,
            "slotid":11,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14800021,
            "count":4,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":27,
            "slotid":12,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":28,
            "slotid":13,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":29,
            "slotid":14,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14820042,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":30,
            "slotid":15,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14100003,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":31,
            "slotid":16,
            "isinside":1,
            "type":1,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":1,
            "shinecolor":1
         },{
            "identify":32,
            "slotid":1,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":1,
            "shinecolor":3
         },{
            "identify":33,
            "slotid":2,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14100017,
            "count":10,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":34,
            "slotid":3,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14100018,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":35,
            "slotid":4,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14800004,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":36,
            "slotid":5,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14100015,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":37,
            "slotid":6,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":38,
            "slotid":7,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14100005,
            "count":5,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":39,
            "slotid":8,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14800021,
            "count":10,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":40,
            "slotid":9,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":41,
            "slotid":10,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14100028,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":42,
            "slotid":11,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":43,
            "slotid":12,
            "isinside":1,
            "type":2,
            "quality":1,
            "itemid":14840017,
            "count":1,
            "isshine":1,
            "shinecolor":2
         },{
            "identify":44,
            "slotid":13,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14840017,
            "count":5,
            "isshine":1,
            "shinecolor":1
         },{
            "identify":45,
            "slotid":14,
            "isinside":1,
            "type":2,
            "quality":1,
            "itemid":14820007,
            "count":1,
            "isshine":1,
            "shinecolor":1
         },{
            "identify":46,
            "slotid":15,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14820027,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":47,
            "slotid":16,
            "isinside":1,
            "type":2,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":48,
            "slotid":1,
            "isinside":2,
            "type":1,
            "quality":2,
            "itemid":14800005,
            "count":1,
            "isshine":1,
            "shinecolor":1
         },{
            "identify":49,
            "slotid":2,
            "isinside":2,
            "type":1,
            "quality":1,
            "itemid":14100029,
            "count":1,
            "isshine":1,
            "shinecolor":2
         },{
            "identify":50,
            "slotid":3,
            "isinside":2,
            "type":1,
            "quality":2,
            "itemid":14840017,
            "count":1,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":51,
            "slotid":4,
            "isinside":2,
            "type":1,
            "quality":2,
            "itemid":14100005,
            "count":3,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":52,
            "slotid":5,
            "isinside":2,
            "type":1,
            "quality":1,
            "itemid":14840017,
            "count":1,
            "isshine":1,
            "shinecolor":1
         },{
            "identify":53,
            "slotid":6,
            "isinside":2,
            "type":1,
            "quality":2,
            "itemid":14800021,
            "count":5,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":54,
            "slotid":1,
            "isinside":2,
            "type":2,
            "quality":2,
            "itemid":14820007,
            "count":2,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":55,
            "slotid":2,
            "isinside":2,
            "type":2,
            "quality":2,
            "itemid":14820027,
            "count":2,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":56,
            "slotid":3,
            "isinside":2,
            "type":2,
            "quality":1,
            "itemid":14840017,
            "count":1,
            "isshine":1,
            "shinecolor":3
         },{
            "identify":57,
            "slotid":4,
            "isinside":2,
            "type":2,
            "quality":2,
            "itemid":14100028,
            "count":50,
            "isshine":0,
            "shinecolor":0
         },{
            "identify":58,
            "slotid":5,
            "isinside":2,
            "type":2,
            "quality":1,
            "itemid":14100029,
            "count":1,
            "isshine":1,
            "shinecolor":2
         },{
            "identify":59,
            "slotid":6,
            "isinside":2,
            "type":2,
            "quality":1,
            "itemid":14840017,
            "count":1,
            "isshine":1,
            "shinecolor":1
         }];
         _loc1_.writeShort(_loc2_.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].identify);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].slotid);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].isinside);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].type);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].itemid);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].count);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].isshine);
            _loc1_.writeUnsignedInt(_loc2_[_loc3_].shinecolor);
            _loc3_++;
         }
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function TestLottery() : ByteArray
      {
         var _loc6_:int = 0;
         var _loc1_:ByteArray = new ByteArray();
         var _loc2_:Vector.<int> = Vector.<int>([47]);
         var _loc3_:Vector.<int> = Vector.<int>([35,36,37,38,39,40,41,42,43,44]);
         var _loc4_:Vector.<int> = Vector.<int>([35,36,37,38,39,40,41,42,43,44,35,36,37,38,39,40,41,42,43,44,35,36,37,38,39,40,41,42,43,44,35,36,37,38,39,40,41,42,43,44,35,36,37,38,39,40,41,42,43,44]);
         _loc1_.writeUnsignedInt(0);
         var _loc5_:Vector.<int> = new Vector.<int>();
         if(this.FChangeTabIndex == TAB_TYPE_FREE_LOTTERY)
         {
            _loc1_.writeUnsignedInt(31);
         }
         else
         {
            if(this.FLotteryType == TYPE_ONE)
            {
               _loc5_ = _loc2_;
            }
            else if(this.FLotteryType == TYPE_TEN)
            {
               _loc5_ = _loc3_;
            }
            else
            {
               _loc5_ = _loc4_;
            }
            _loc1_.writeShort(_loc5_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc1_.writeUnsignedInt(_loc5_[_loc6_]);
               _loc6_++;
            }
         }
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function TestInsideLottery() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUnsignedInt(0);
         var _loc2_:Vector.<int> = Vector.<int>([55]);
         if(this.FChangeTabIndex == TAB_TYPE_FREE_LOTTERY)
         {
            _loc1_.writeUnsignedInt(49);
         }
         else
         {
            _loc1_.writeShort(1);
            _loc1_.writeUnsignedInt(55);
         }
         _loc1_.position = 0;
         return _loc1_;
      }
   }
}

