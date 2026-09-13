package Processors.Game.Lobby.Exercise.Christmas2016
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.Christmas2016.TChristmas1_2016;
   import Logics.Exercise.Christmas2016.TChristmas2_2016;
   import Logics.Exercise.Christmas2016.TChristmas3_2016;
   import Logics.Exercise.Christmas2016.TChristmas4_2016;
   import Logics.Exercise.Christmas2016.TChristmasDatas_2016;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerChristmas2016;
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
   
   public class TProcessorChristmas2016 extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_4_ID:int = 4;
      
      public static const ACTIVITY_1_SIGN:int = 1;
      
      public static const ACTIVITY_1_BUY_SIGN:int = 2;
      
      public static const ACTIVITY_1_GET_SIGN_GIFT:int = 3;
      
      public static const ACTIVITY_1_GET_BOX:int = 4;
      
      public static const ACTIVITY_1_BUY_BOX:int = 5;
      
      public static const ACTIVITY_2_OPEN_POINT:int = 1;
      
      public static const ACTIVITY_2_OPEN_ALL_POINT:int = 2;
      
      public static const ACTIVITY_2_RESET:int = 3;
      
      public static const ACTIVITY_2_GET_TITLE:int = 4;
      
      public static const ACTIVITY_2_EXCHANGE_BOX:int = 5;
      
      public static const ACTIVITY_2_GET_TASK:int = 6;
      
      public static const ACTIVITY_2_FINISH_TASK:int = 7;
      
      public static const ACTIVITY_2_GET_GIFT:int = 8;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 1;
      
      public static const ACTIVITY_3_EXCHANGE_HERO:int = 2;
      
      public static const ACTIVITY_3_GET_SWEET:int = 3;
      
      public static const ACTIVITY_3_GET_TEN:int = 4;
      
      public static const ACTIVITY_3_GET_BOX:int = 5;
      
      public static const ACTIVITY_3_EXCHANGE_PET:int = 6;
      
      public static const ACTIVITY_4_BUY_FUND:int = 1;
      
      public static const ACTIVITY_4_OPEN_EGG:int = 2;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 4;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIChristmas1_2016,TUIChristmas2_2016,TUIChristmas3_2016,TUIChristmas4_2016]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FChristmasDatas_2016:TChristmasDatas_2016;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerChristmas2016:TUnstreamizerChristmas2016;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowConfirmation1:TUIWindowConfirmation;
      
      protected var FIsOpen:Boolean;
      
      protected var FWindowType:int;
      
      public function TProcessorChristmas2016(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FChristmasDatas_2016 = SLogicsCore.ChristmasDatas_2016;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerChristmas2016 = new TUnstreamizerChristmas2016(param3);
         this.FTabList = new Vector.<MovieClip>(this.TAB_COUNT);
         this.FChangeTabIndex = 0;
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(this.TAB_COUNT);
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
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Class = null;
         var _loc5_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            this.FTabList[_loc1_] = FMC_Scene["MC_Tab" + _loc1_];
            this.FTabList[_loc1_].MC_Tab.gotoAndStop(_loc1_ + 1);
            this.FTabList[_loc1_].buttonMode = true;
            this.FTabList[_loc1_].MC_Tab.MC_Selected.visible = false;
            this.FTabList[_loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChangePage);
            this.FTabList[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTabOver);
            this.FTabList[_loc1_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTabOut);
            this.FTabList[_loc1_].MC_ComingSoon.TF_Date.mouseEnabled = false;
            _loc5_ = new TEffectBaseGlowTwo();
            _loc5_.SetParameters(FMC_Scene["MC_Tab" + _loc1_],FilterColor,FilterGlowWidth,FilterGlowStrength);
            this.FGlowsFilter[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc4_ = this.ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc4_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(FMC_Scene["MC_Activity" + _loc1_]);
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
            this.FUIWindowVect[_loc1_].OnShowWindow = ProcessorOnShowOtherWindow;
            this.FUIWindowVect[_loc1_].OnUpdateWindow = this.PerformPacket_CS_LoadInfoReq;
            this.FUIWindowVect[_loc1_].OnShowTitleTip = ProcessorOnTitleEffectOver;
            this.FUIWindowVect[_loc1_].OnHideTitleTip = ProcessorOnTitleEffectOut;
            this.FUIWindowVect[_loc1_].CheckEffect = ProcessorCheckEffect;
            _loc1_++;
         }
         this.FUIWindowConfirmation1.OnOK = this.WindowConfirmationOnOK;
         this.FUIWindowConfirmation1.x = (CONST_COMMON.STAGE_Width - this.FUIWindowConfirmation1.WindowWidth) / 2;
         this.FUIWindowConfirmation1.y = (CONST_COMMON.STAGE_Height - this.FUIWindowConfirmation1.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation1);
         this.FUIWindowConfirmation1.SetCheckBox(true);
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
            this.UpdateTabEffect();
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
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
         _loc1_ = 0;
         while(_loc1_ < this.TAB_COUNT)
         {
            _loc2_ = this.FTabList[_loc1_];
            _loc3_ = this.FChristmasDatas_2016.GetActivityByIndex(_loc1_);
            if(_loc3_.IsOpen == TBaseActivity.IS_NOT_OPEN)
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = true;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_ComingSoon.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_OPEN,TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc3_.BeginTime) * 1000)));
            }
            else if(_loc3_.IsOpen == TBaseActivity.IS_OPEN)
            {
               _loc2_.MC_Title.visible = true;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = false;
               _loc2_.MC_Title.gotoAndStop(_loc1_ + 1);
            }
            else
            {
               _loc2_.MC_Title.visible = false;
               _loc2_.MC_ComingSoon.visible = false;
               _loc2_.MC_Closed.visible = true;
            }
            if(_loc1_ == this.FChangeTabIndex)
            {
               _loc2_.MC_Tab.MC_Selected.visible = true;
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               _loc2_.MC_Tab.MC_Selected.visible = false;
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            if(this.FChristmasDatas_2016.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
            {
               this.FGlowsFilter[_loc1_].IsRunOver = false;
            }
            else
            {
               this.FGlowsFilter[_loc1_].Stop();
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTabEffect() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TEffectBaseGlowTwo = null;
         if(this.FGlowsFilter == null || this.FGlowsFilter[0] == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FGlowsFilter.length)
         {
            _loc2_ = this.FGlowsFilter[_loc1_];
            if(!_loc2_.IsRunOver)
            {
               _loc2_.Run();
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorOnChangePage(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FChristmasDatas_2016.GetActivityByIndex(_loc2_);
         if(_loc3_.IsOpen != TBaseActivity.IS_OPEN || _loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnTabOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseActivity = null;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc3_ = this.FChristmasDatas_2016.GetActivityByIndex(_loc2_);
         if(_loc3_.ActivityTabName)
         {
            _loc4_ = _loc3_.ActivityTabName.split("%n").join("\n");
            ProcessorOnShowTip(_loc4_);
         }
      }
      
      protected function ProcessorOnTabOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0, param6:String = "", param7:int = 0, param8:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxType = param2;
         this.FBuyBoxDate.BoxIndex = param4;
         this.FBuyBoxDate.Cost = param3;
         this.FBuyBoxDate.CostType = param5;
         this.FBuyBoxDate.BoxIndex1 = param7;
         this.FBuyBoxDate.ConfirmType = param8;
         if(param5 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param3;
            if(param6 != "")
            {
               FUIWindowConfirmation.Text = param6;
            }
            else
            {
               FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FCost);
            }
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0) : void
      {
         var _loc5_:TPacket = null;
         var _loc6_:int = 0;
         var _loc7_:Vector.<int> = null;
         if(this.FBeClicked)
         {
            return;
         }
         this.FBeClicked = true;
         _loc7_ = new Vector.<int>();
         _loc7_.push(param2);
         _loc7_.push(param3);
         _loc7_.push(param4);
         PerformPacket_CS_AllReq(param1,_loc7_);
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         var _loc1_:TBaseActivity = null;
         _loc1_ = this.FChristmasDatas_2016.GetActivityByIndex(this.FChangeTabIndex);
         super.ProcessorOnOpenDescNew(_loc1_.DescListNew[0]);
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
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadInfoReq);
         _loc1_.Data.writeUnsignedInt(ActivityID);
         _loc1_.Data.writeUnsignedInt(this.FChangeTabIndex + 1);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FUIWindowConfirmation1.Load();
            return;
         }
         this.visible = true;
         this.alpha = 1;
         this.FIsOpen = true;
         if(FMC_EffectLeft)
         {
            FMC_EffectLeft.play();
         }
         if(FMC_EffectRight)
         {
            FMC_EffectRight.play();
         }
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
         this.FUnstreamizerChristmas2016.Unstreamize(_loc2_,this.FChristmasDatas_2016,null);
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
         _loc5_ = this.FChristmasDatas_2016.GetActivityByIdentify(_loc4_) as TBaseActivity;
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
         var _loc9_:TChristmas1_2016 = null;
         var _loc10_:TChristmas2_2016 = null;
         var _loc11_:TChristmas3_2016 = null;
         var _loc12_:TChristmas4_2016 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_1_ID) as TChristmas1_2016;
               if(_loc9_)
               {
                  _loc9_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  _loc9_.ChangeStatus();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmas2_2016;
               if(_loc10_)
               {
                  _loc10_.TotalConsumeGold = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_3_ID:
               _loc11_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmas3_2016;
               if(_loc11_)
               {
                  _loc11_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     _loc11_.ChangeStatus();
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_4_ID:
               _loc12_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmas4_2016;
               if(_loc12_)
               {
                  _loc12_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     this.UpdateUI();
                  }
               }
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
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:Vector.<Object> = null;
         var _loc24_:TConfigValue = null;
         var _loc25_:TChristmas1_2016 = null;
         var _loc26_:TChristmas2_2016 = null;
         var _loc27_:TChristmas3_2016 = null;
         var _loc28_:TChristmas4_2016 = null;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:int = 0;
         var _loc33_:int = 0;
         var _loc34_:Vector.<uint> = null;
         var _loc35_:Vector.<uint> = null;
         var _loc36_:String = null;
         var _loc37_:TDessertHouseTask = null;
         var _loc38_:TSystemLanguage = null;
         var _loc39_:int = 0;
         var _loc40_:TLotteryNews = null;
         var _loc41_:int = 0;
         var _loc42_:Number = NaN;
         this.FBeClicked = false;
         _loc34_ = new Vector.<uint>();
         _loc35_ = new Vector.<uint>();
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         _loc10_ = _loc2_.readUnsignedInt();
         switch(_loc7_)
         {
            case ACTIVITY_1_ID:
               _loc25_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_1_ID) as TChristmas1_2016;
               if(_loc10_ == ACTIVITY_1_BUY_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  --_loc25_.ShopExchangeItems[_loc6_].Inventories.GetInventoryByIndex(_loc5_).LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_SIGN)
               {
                  _loc25_.TotalSignGift.Status = _loc2_.readInt();
                  ++_loc25_.TotalSign;
                  _loc25_.CurStatus = TBaseActivity.STATUS_GETED;
                  _loc5_ = _loc25_.CurDay - 1;
                  _loc25_.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc25_.DayList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_BUY_SIGN)
               {
                  ++_loc25_.TotalSign;
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.BuySignDay = _loc2_.readUnsignedInt();
                  _loc25_.TotalSignGift.Status = _loc2_.readInt();
                  _loc25_.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc25_.DayList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc25_.GiftList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_SIGN_GIFT)
               {
                  _loc25_.TotalSignGift.Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc25_.TotalSignGift.Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc26_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmas2_2016;
               if(_loc10_ == ACTIVITY_2_GET_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc37_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  if(_loc37_ != null)
                  {
                     _loc37_.Status = TBaseActivity.STATUS_CANGET;
                     _loc37_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_FINISH_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc37_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc37_ != null)
                  {
                     this.FActivityTaskData.Score += _loc37_.TaskPoint[_loc37_.Step];
                     this.FActivityTaskData.ChangeStatus();
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc37_.TaskAward[_loc37_.Step].Count)
                     {
                        _loc9_ = _loc37_.TaskAward[_loc37_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        _loc5_++;
                     }
                     ++_loc37_.Step;
                     if(_loc37_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc37_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc37_.Process = 0;
                        _loc37_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  _loc26_.TotalScore = _loc2_.readUnsignedInt();
                  _loc26_.FreeCount = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_TITLE)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.TitleList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  _loc26_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_GIFT)
               {
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  _loc26_.TotalScore = _loc2_.readUnsignedInt();
                  _loc26_.FreeCount = _loc2_.readUnsignedInt();
                  --_loc26_.RechargeGift.Count;
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
                  _loc26_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_OPEN_POINT)
               {
                  if(_loc26_.FreeCount > 0)
                  {
                     --_loc26_.FreeCount;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc29_ = _loc2_.readInt();
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc30_ = int(_loc2_.readUnsignedInt());
                  _loc26_.ShopExchangePoint += _loc30_;
                  _loc26_.TotalScore += _loc30_;
                  if(_loc30_ > 0)
                  {
                     _loc4_ = TUtilityString.Format(_loc26_.DescListNew[7],_loc30_);
                     ProcessorEffectText(_loc4_);
                  }
                  _loc26_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.FUIWindowVect[1].SetMovieParam(_loc5_,_loc29_,_loc6_);
               }
               else if(_loc10_ == ACTIVITY_2_OPEN_ALL_POINT)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc26_.RewardsIndex.length)
                  {
                     _loc26_.RewardsIndex[_loc5_] = _loc2_.readUnsignedInt();
                     _loc5_++;
                  }
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = TUtilityString.Format(_loc26_.DescListNew[7],_loc29_);
                  _loc26_.ShopExchangePoint += _loc29_;
                  _loc26_.TotalScore += _loc29_;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.FUIWindowVect[1].PlayMovie(TUIChristmas2_2016.MOVIE_OPEN_ALL_POINT);
               }
               else if(_loc10_ == ACTIVITY_2_RESET)
               {
                  _loc26_.ResetPoint();
                  ProcessorEffectText(_loc26_.DescListNew[3]);
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc26_.ShopExchangeItems[_loc5_].LimitCount;
                  --_loc26_.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(0).LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED;
                  ProcessorEffectText(_loc4_);
                  _loc26_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc27_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmas3_2016;
               if(_loc10_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  --_loc27_.ItemList[_loc5_].LimitCount;
                  _loc27_.Score = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.ItemList[_loc5_].Inventories.Count)
                  {
                     _loc9_ = _loc27_.ItemList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  _loc27_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_HERO)
               {
                  _loc27_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc27_.Score = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_PET)
               {
                  _loc27_.Pet.Status = TBaseActivity.STATUS_GETED;
                  _loc27_.Score = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_SWEET)
               {
                  if(_loc27_.Count > 0)
                  {
                     --_loc27_.Count;
                  }
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc14_ = int(_loc2_.readUnsignedInt());
                  _loc15_ = int(_loc2_.readUnsignedInt());
                  _loc27_.Score += _loc14_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + TUtilityString.Format(_loc27_.DescListNew[9],_loc14_,_loc15_);
                  _loc5_ = 0;
                  while(_loc5_ < _loc27_.SweetList.length)
                  {
                     _loc27_.SweetList[_loc5_].Status = _loc2_.readInt();
                     _loc5_++;
                  }
                  _loc27_.PoolValue = _loc2_.readUnsignedInt();
                  _loc27_.Gift.Count = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_TEN)
               {
                  _loc27_.AmountList.length = 0;
                  _loc27_.IndexList.length = 0;
                  _loc27_.StatusList.length = 0;
                  _loc5_ = 0;
                  while(_loc5_ < 10)
                  {
                     _loc27_.AmountList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc27_.AmountList2[_loc5_] = _loc2_.readUnsignedInt();
                     _loc27_.IndexList[_loc5_] = _loc2_.readUnsignedInt();
                     _loc27_.StatusList[_loc5_] = _loc2_.readInt();
                     _loc27_.Score += _loc27_.AmountList[_loc5_];
                     _loc5_++;
                  }
                  _loc27_.PoolValue = _loc2_.readUnsignedInt();
                  _loc27_.Gift.Count = _loc2_.readUnsignedInt();
                  if(Boolean(FMC_Scene) && Boolean(this.visible) && this.FIsOpen)
                  {
                     this.FUIWindowVect[2].PlayMovie();
                  }
               }
               else if(_loc10_ == ACTIVITY_3_GET_BOX)
               {
                  --_loc27_.Gift.Count;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc6_ = 0;
                  while(_loc6_ < _loc27_.Gift.Inventories.Count)
                  {
                     _loc9_ = _loc27_.Gift.Inventories.GetInventoryByIndex(_loc6_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc6_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc27_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_4_ID:
               _loc28_ = this.FChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_4_ID) as TChristmas4_2016;
               if(_loc10_ == ACTIVITY_4_BUY_FUND)
               {
                  _loc28_.CurFund = _loc2_.readUnsignedInt();
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
                  _loc28_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_4_OPEN_EGG)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc28_.EggList[_loc5_] = TBaseActivity.STATUS_GETED;
                  _loc17_ = _loc2_.readUnsignedInt();
                  _loc14_ = int(_loc2_.readUnsignedInt());
                  _loc28_.LimitCount = _loc2_.readUnsignedInt();
                  _loc28_.IsEnd = _loc2_.readUnsignedInt();
                  _loc28_.Price = _loc2_.readUnsignedInt();
                  this.FUIWindowVect[3].SetMovieParam(_loc5_);
                  if(_loc17_ == TChristmas4_2016.TYPE_GOLD)
                  {
                     _loc4_ = TUtilityString.Format(_loc28_.DescListNew[13],_loc14_);
                     this.FUIWindowVect[3].FlowStr = _loc4_;
                     this.FUIWindowVect[3].PlayMovie(1);
                  }
                  else
                  {
                     _loc4_ = TUtilityString.Format(_loc28_.DescListNew[14],_loc14_);
                     this.FUIWindowVect[3].FlowStr = _loc4_;
                     this.FUIWindowVect[3].PlayMovie(2);
                  }
                  _loc28_.ChangeStatus();
                  this.FChristmasDatas_2016.ChangeSingleActivityStatus(ACTIVITY_4_ID);
                  ProcessorCheckEffect(FActivityID,this.FChristmasDatas_2016.CheckStatus());
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(18);
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(2);
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc3_.writeInt(_loc1_ + 1);
            TUtilityString.FlushUTF(_loc3_,"描述1");
            _loc3_.writeInt(1);
            _loc3_.writeUnsignedInt(STimingCore.GetServerTime());
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(22);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"每充值%0/%1金币可领取");
         TUtilityString.FlushUTF(_loc3_,"重置成功");
         TUtilityString.FlushUTF(_loc3_,"预留");
         TUtilityString.FlushUTF(_loc3_,"圣诞积分达到%0可领取");
         TUtilityString.FlushUTF(_loc3_,"充值奖励礼包TIPS");
         TUtilityString.FlushUTF(_loc3_,"恭喜你挖到了%0个圣诞积分");
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit2() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"礼包描述");
         TUtilityString.FlushUTF(_loc3_,"十连抽TIPS");
         TUtilityString.FlushUTF(_loc3_,"TIPS1");
         TUtilityString.FlushUTF(_loc3_,"TIPS2");
         TUtilityString.FlushUTF(_loc3_,"TIPS3");
         TUtilityString.FlushUTF(_loc3_,"TIPS4");
         TUtilityString.FlushUTF(_loc3_,"TIPS5");
         TUtilityString.FlushUTF(_loc3_,"活动道具名称");
         TUtilityString.FlushUTF(_loc3_,"兑换需要消耗收集物%0个");
         TUtilityString.FlushUTF(_loc3_,"当前充值%0金币,再充值%1金币,仅需消耗%2个收集物");
         TUtilityString.FlushUTF(_loc3_,"忍者TIPS");
         TUtilityString.FlushUTF(_loc3_,"充值活动详情");
         TUtilityString.FlushUTF(_loc3_,"宠物TIPS");
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit3() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

