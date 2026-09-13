package Processors.Game.Lobby.Exercise.WorldCup
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.WorldCup.TWorldCup1;
   import Logics.Exercise.WorldCup.TWorldCup2;
   import Logics.Exercise.WorldCup.TWorldCupDatas;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerWorldCup;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Box.TOverlayerBox;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorWorldCup extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_1_BET_CHAMPION:int = 1;
      
      public static const ACTIVITY_2_BET_RESULT:int = 2;
      
      protected var TAB_COUNT:int = 2;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIWorldCup1,TUIWorldCup2]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FWorldCupDatas:TWorldCupDatas;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerWorldCup:TUnstreamizerWorldCup;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowConfirmation1:TUIWindowConfirmation;
      
      protected var FIsOpen:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMainUI:MovieClip;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop2;
      
      public function TProcessorWorldCup(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FWorldCupDatas = SLogicsCore.WorldCupDatas;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerWorldCup = new TUnstreamizerWorldCup(param3);
         this.FTabList = new Vector.<MovieClip>(4);
         this.FChangeTabIndex = 0;
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(this.TAB_COUNT);
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = (CONST_COMMON.STAGE_Width - 390) / 2;
         this.FProcessorWindowRecruit.y = (CONST_COMMON.STAGE_Height - 358) / 2;
         this.FUIWindowConfirmation1 = new TUIWindowConfirmation(this.Parent);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop2(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         this.FMainUI = FMC_Scene.MC_Activity0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.FTabList[_loc1_] = this.FMainUI["MC_Tab" + _loc1_];
            this.FTabList[_loc1_].gotoAndStop(_loc1_ + 1);
            TGameUtil.setButtonMode(this.FTabList[_loc1_].Btn_Goto,true);
            this.FTabList[_loc1_].Btn_Goto.addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + (_loc1_ + 1)]);
            this.FUIWindowVect[_loc1_].OnGetBox = this.ProcessorOnGetBoxUp;
            this.FUIWindowVect[_loc1_].OnBuyBox = this.ProcessorOnBuyBoxUp;
            this.FUIWindowVect[_loc1_].OnNewBoxOver = ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc1_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowDesc = this.ProcessorOnShowDesc;
            this.FUIWindowVect[_loc1_].OnShowFlowText = ProcessorEffectText;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FUIWindowVect[_loc1_].OnLoadLog = this.ProcessorOnLoadLog;
            this.FUIWindowVect[_loc1_].OnLoadRank = this.ProcessorOnLoadRank;
            this.FUIWindowVect[_loc1_].GotoRecharge = ProcessorOnRechargeUp;
            this.FUIWindowVect[_loc1_].OnCloseWindow = this.ProcessorOnCloseWindow;
            this.FUIWindowVect[_loc1_].OnGoto = ProcessorOnGoto;
            this.FUIWindowVect[_loc1_].OnUpdateWindow = this.PerformPacket_CS_LoadInfoReq;
            this.FUIWindowVect[_loc1_].OnShowTitleTip = ProcessorOnTitleEffectOver;
            this.FUIWindowVect[_loc1_].OnHideTitleTip = ProcessorOnTitleEffectOut;
            this.FUIWindowVect[_loc1_].CheckEffect = ProcessorCheckEffect;
            this.FUIWindowVect[_loc1_].OnShowWindow = this.ProcessorOnBackMain;
            this.FUIWindowVect[_loc1_].SetVisible(false);
            _loc1_++;
         }
         this.FUIWindowConfirmation1.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation1.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation1.WindowWidth) / 2;
         this.FUIWindowConfirmation1.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation1.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation1);
         this.FUIWindowConfirmation1.SetCheckBox(true);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(this.FChangeTabIndex > 0 && this.FChangeTabIndex < 3)
            {
               this.FUIWindowVect[this.FChangeTabIndex - 1].LogicsPerform();
            }
            if(this.FProcessorWindowRecruit != null && this.FProcessorWindowRecruit.Visible == true)
            {
               this.FProcessorWindowRecruit.UpdataBitmap();
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseActivity = null;
         super.UpdateUI();
         if(this.FChangeTabIndex == 0)
         {
            this.FMainUI.visible = true;
            _loc1_ = 0;
            while(_loc1_ < this.TAB_COUNT)
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
               _loc1_++;
            }
            this.FTabList[0].TF_Desc.text = this.FWorldCupDatas.DescListNew[1];
            this.FTabList[1].TF_Desc.text = this.FWorldCupDatas.DescListNew[2];
            this.FTabList[2].TF_Desc.text = this.FWorldCupDatas.DescListNew[3];
            this.FTabList[3].TF_Desc.text = this.FWorldCupDatas.DescListNew[4];
            this.FMainUI.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FWorldCupDatas.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FWorldCupDatas.EndTime) - 1) * 1000)));
         }
         else if(this.FChangeTabIndex == 3)
         {
            this.FMainUI.visible = true;
            _loc1_ = 0;
            while(_loc1_ < this.TAB_COUNT)
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
               _loc1_++;
            }
            this.ProcessorOnExchangeUp();
         }
         else if(this.FChangeTabIndex == 4)
         {
            this.FMainUI.visible = true;
            _loc1_ = 0;
            while(_loc1_ < this.TAB_COUNT)
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
               _loc1_++;
            }
         }
         else
         {
            this.FMainUI.visible = false;
            _loc1_ = 0;
            while(_loc1_ < this.TAB_COUNT)
            {
               if(_loc1_ == this.FChangeTabIndex - 1)
               {
                  this.FUIWindowVect[_loc1_].SetVisible(true);
                  this.FUIWindowVect[_loc1_].UpdateUI();
               }
               else
               {
                  this.FUIWindowVect[_loc1_].SetVisible(false);
               }
               _loc1_++;
            }
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         this.FChangeTabIndex = _loc2_ + 1;
         if(this.FChangeTabIndex == 4)
         {
            ProcessorLoadActiveRankNew(this.FChangeTabIndex);
         }
         else
         {
            this.PerformPacket_CS_LoadInfoReq();
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.BoxIndex1 = param4;
         this.FBuyBoxDate.BoxIndex2 = param6;
         this.FBuyBoxDate.BoxIndex3 = param7;
         this.FBuyBoxDate.Cost = param5;
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param5;
            FUIWindowConfirmation.Text = TUtilityString.Format(this.FWorldCupDatas.DescListNew[8 + param1],this.FCost / 100,this.FCost);
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
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= this.FBuyBoxDate.Cost)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1,this.FBuyBoxDate.BoxIndex2,this.FBuyBoxDate.BoxIndex3);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0) : void
      {
         var _loc7_:TPacket = null;
         var _loc8_:int = 0;
         var _loc9_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc9_ = new Vector.<int>();
         _loc9_.push(param3);
         _loc9_.push(param4);
         _loc9_.push(param5);
         _loc9_.push(param6);
         PerformPacket_CS_AllReq(param1,_loc9_);
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         if(this.FChangeTabIndex == 1)
         {
            super.ProcessorOnOpenDescNew(this.FWorldCupDatas.DescListNew[6]);
         }
         else if(this.FChangeTabIndex == 2)
         {
            super.ProcessorOnOpenDescNew(this.FWorldCupDatas.DescListNew[8]);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:int) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(param1,null);
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         if(param2 == TBaseBox.TYPE_IS_HERO)
         {
            this.FProcessorWindowRecruit.SetHeroData(param1);
         }
         else if(param2 == TBaseBox.TYPE_IS_PET)
         {
            FProcessorWindowPetDesc.SetPetData(param1);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:int) : void
      {
         ProcessorLoadActiveRankNew(param1);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnBackMain() : void
      {
         this.FChangeTabIndex = 0;
         this.UpdateUI();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex == 0 ? 1 : uint(this.FChangeTabIndex));
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function ProcessorOnExchangeUp() : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI();
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnExchangeItem(param1:int, param2:int) : void
      {
         this.ProcessorOnGetBoxUp(ACTIVITY_3_ID,0,param1 + 1,1);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FUIWindowConfirmation1.Load();
            this.FProcessorFebActiveShop.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         this.FChangeTabIndex = 0;
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         this.FUIWindowConfirmation1.Visible = false;
         this.FProcessorFebActiveShop.Visible = false;
         TweenUtil.removeAllTween();
         this.FChangeTabIndex = 0;
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerWorldCup.Unstreamize(_loc2_,this.FWorldCupDatas,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorActivityThirdLoadLogRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBaseActivity = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            ProcessorClose();
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc5_ = this.FWorldCupDatas.GetActivityByIdentify(_loc4_) as TBaseActivity;
         ProcessorUnstreamActivityLog(_loc5_,_loc2_);
      }
      
      override public function ProcessorChangeGold(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TWorldCup1 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         this.FWorldCupDatas.giftGold = _loc2_.readUnsignedInt();
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventories = null;
         var _loc9_:TInventory = null;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:TBaseBox = null;
         var _loc17_:uint = 0;
         var _loc18_:TBins = null;
         var _loc19_:int = 0;
         var _loc20_:TConfigValue = null;
         var _loc21_:TWorldCup1 = null;
         var _loc22_:TWorldCup2 = null;
         var _loc23_:Vector.<uint> = null;
         var _loc24_:Vector.<uint> = null;
         var _loc25_:Object = null;
         this.FBeClicked = false;
         _loc23_ = new Vector.<uint>();
         _loc24_ = new Vector.<uint>();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc21_ = this.FWorldCupDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TWorldCup1;
               _loc14_ = int(_loc2_.readUnsignedInt());
               _loc15_ = int(_loc2_.readUnsignedInt());
               _loc5_ = _loc21_.betCountry.indexOf(_loc14_);
               if(_loc5_ == -1)
               {
                  _loc21_.betCountry.push(_loc14_);
                  _loc21_.betValue.push(_loc15_);
               }
               else
               {
                  _loc21_.betValue[_loc5_] = _loc15_;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.UpdateUI();
               break;
            case ACTIVITY_2_ID:
               _loc22_ = this.FWorldCupDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TWorldCup2;
               _loc25_ = new Object();
               _loc25_.id = _loc2_.readUnsignedInt();
               _loc25_.type = _loc2_.readUnsignedInt();
               _loc25_.gold = _loc2_.readUnsignedInt();
               _loc25_.result = _loc2_.readInt();
               _loc22_.BetInfo.push(_loc25_);
               if(_loc25_.type == 1)
               {
                  this.FWorldCupDatas.giftGold -= _loc25_.gold * 100;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.UpdateUI();
               break;
            case ACTIVITY_3_ID:
               _loc14_ = int(_loc2_.readUnsignedInt());
               _loc15_ = int(_loc2_.readUnsignedInt());
               this.FWorldCupDatas.giftGold = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FWorldCupDatas.ShopExchangeItems.length)
               {
                  _loc16_ = this.FWorldCupDatas.ShopExchangeItems[_loc5_];
                  if(_loc14_ == _loc16_.Identify)
                  {
                     --_loc16_.LimitCount;
                     break;
                  }
                  _loc5_++;
               }
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_EXCHANGE);
               this.UpdateUI();
         }
      }
   }
}

