package Processors.Game.Lobby.Exercise.JanActive2016
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
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.JanActive_2016.TJanActive1_2016;
   import Logics.Exercise.JanActive_2016.TJanActive2_2016;
   import Logics.Exercise.JanActive_2016.TJanActive3_2016;
   import Logics.Exercise.JanActive_2016.TJanActiveDatas_2016;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerJanActive2016;
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
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorJanActive2016 extends TProcessorBaseActivity
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const ACTIVITY_3_ID:int = 3;
      
      public static const ACTIVITY_1_SIGN:int = 1;
      
      public static const ACTIVITY_1_BUY_SIGN:int = 2;
      
      public static const ACTIVITY_1_GET_BOX:int = 3;
      
      public static const ACTIVITY_1_GET_ITEM:int = 4;
      
      public static const ACTIVITY_1_GET_RECHARGE_GIFT:int = 5;
      
      public static const ACTIVITY_1_GET_CONSUME_GIFT:int = 6;
      
      public static const ACTIVITY_2_WISH:int = 1;
      
      public static const ACTIVITY_2_GET_FRUIT:int = 2;
      
      public static const ACTIVITY_2_UPGRADE:int = 3;
      
      public static const ACTIVITY_2_RESET:int = 4;
      
      public static const ACTIVITY_2_GET_RECHARGE_GIFT:int = 5;
      
      public static const ACTIVITY_2_EXCHANGE_BOX:int = 6;
      
      public static const ACTIVITY_2_GET_CONSUME_GIFT:int = 7;
      
      public static const ACTIVITY_2_GET_TASK:int = 8;
      
      public static const ACTIVITY_2_FINISH_TASK:int = 9;
      
      public static const ACTIVITY_3_OPEN_BOX:int = 1;
      
      public static const ACTIVITY_3_OPEN_ALL_BOX:int = 2;
      
      public static const ACTIVITY_3_EXCHANGE_HERO:int = 3;
      
      public static const ACTIVITY_3_GET_GIFT:int = 4;
      
      public static const ACTIVITY_3_RESET:int = 5;
      
      public static const ACTIVITY_3_EXCHANGE_ITEM:int = 6;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var TAB_COUNT:int = 3;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIJanActive1_2016,TUIJanActive2_2016,TUIJanActive3_2016]);
      
      protected var FBeClicked:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FCost:int;
      
      protected var FTabList:Vector.<MovieClip>;
      
      protected var FChangeTabIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FJanActiveDatas_2016:TJanActiveDatas_2016;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUnstreamizerJanActive2016:TUnstreamizerJanActive2016;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FOverlayerBox:TOverlayerBox;
      
      protected var FBuyBoxDate:Object;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowConfirmation1:TUIWindowConfirmation;
      
      protected var FIsOpen:Boolean;
      
      protected var FWindowType:int;
      
      public function TProcessorJanActive2016(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FJanActiveDatas_2016 = SLogicsCore.JanActiveDatas_2016;
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUnstreamizerJanActive2016 = new TUnstreamizerJanActive2016(param3);
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
            _loc3_ = this.FJanActiveDatas_2016.GetActivityByIndex(_loc1_);
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
            if(this.FJanActiveDatas_2016.Activities[_loc1_].NeedShine == TBaseActivity.STATUS_CANGET)
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
         _loc3_ = this.FJanActiveDatas_2016.GetActivityByIndex(_loc2_);
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
         _loc3_ = this.FJanActiveDatas_2016.GetActivityByIndex(_loc2_);
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
         if(param3 != 0)
         {
            _loc7_.push(param3);
         }
         _loc7_.push(param4);
         PerformPacket_CS_AllReq(param1,_loc7_);
      }
      
      protected function ProcessorOnShowDesc() : void
      {
         var _loc1_:TBaseActivity = null;
         _loc1_ = this.FJanActiveDatas_2016.GetActivityByIndex(this.FChangeTabIndex);
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
         this.FUnstreamizerJanActive2016.Unstreamize(_loc2_,this.FJanActiveDatas_2016,null);
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
         _loc5_ = this.FJanActiveDatas_2016.GetActivityByIdentify(_loc4_) as TBaseActivity;
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
         var _loc9_:TJanActive1_2016 = null;
         var _loc10_:TJanActive2_2016 = null;
         var _loc11_:TJanActive3_2016 = null;
         _loc2_ = param1.Data;
         _loc2_.readShort();
         _loc6_ = _loc2_.readInt();
         switch(_loc6_)
         {
            case ACTIVITY_1_ID:
               _loc9_ = this.FJanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_1_ID) as TJanActive1_2016;
               if(_loc9_)
               {
                  _loc9_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  _loc9_.TotalConsumeGold = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     _loc9_.ChangeStatus();
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_2_ID:
               _loc10_ = this.FJanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_2_ID) as TJanActive2_2016;
               if(_loc10_)
               {
                  _loc5_ = int(_loc2_.readUnsignedInt());
                  if(_loc5_ == 1)
                  {
                     _loc10_.TotalConsumeGold = _loc2_.readUnsignedInt();
                     _loc10_.ConsumeBox.Count = _loc2_.readUnsignedInt();
                  }
                  else if(_loc5_ == 2)
                  {
                     _loc10_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  }
                  if(this.FIsOpen)
                  {
                     _loc10_.ChangeStatus();
                     this.UpdateUI();
                  }
               }
               break;
            case ACTIVITY_3_ID:
               _loc11_ = this.FJanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_3_ID) as TJanActive3_2016;
               if(_loc11_)
               {
                  _loc11_.TotalRechargeGold = _loc2_.readUnsignedInt();
                  if(this.FIsOpen)
                  {
                     _loc11_.ChangeStatus();
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
         var _loc15_:TBaseBox = null;
         var _loc16_:uint = 0;
         var _loc17_:TBins = null;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:Vector.<Object> = null;
         var _loc23_:TConfigValue = null;
         var _loc24_:TJanActive1_2016 = null;
         var _loc25_:TJanActive2_2016 = null;
         var _loc26_:TJanActive3_2016 = null;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:int = 0;
         var _loc32_:Vector.<uint> = null;
         var _loc33_:Vector.<uint> = null;
         var _loc34_:String = null;
         var _loc35_:TDessertHouseTask = null;
         var _loc36_:TSystemLanguage = null;
         var _loc37_:int = 0;
         var _loc38_:TLotteryNews = null;
         var _loc39_:int = 0;
         var _loc40_:Number = NaN;
         this.FBeClicked = false;
         _loc32_ = new Vector.<uint>();
         _loc33_ = new Vector.<uint>();
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
               _loc24_ = this.FJanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_1_ID) as TJanActive1_2016;
               if(_loc10_ == ACTIVITY_1_SIGN)
               {
                  ++_loc24_.TotalSign;
                  _loc24_.CurStatus = TBaseActivity.STATUS_GETED;
                  _loc5_ = _loc24_.CurDay - 1;
                  _loc24_.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc24_.DayList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_BUY_SIGN)
               {
                  ++_loc24_.TotalSign;
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.BuySignDay = _loc2_.readUnsignedInt();
                  _loc24_.TotalConsumeGold = _loc2_.readUnsignedInt();
                  _loc24_.DayList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc24_.DayList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc24_.BoxList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc24_.ItemList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc24_.ItemList[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_RECHARGE_GIFT)
               {
                  _loc24_.RechargeBox.Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc24_.RechargeBox.Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_1_GET_CONSUME_GIFT)
               {
                  _loc24_.ConsumeBox.Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc24_.ConsumeBox.Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  ProcessorEffectText(_loc4_);
                  _loc24_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_1_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_2_ID:
               _loc25_ = this.FJanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_2_ID) as TJanActive2_2016;
               if(_loc10_ == ACTIVITY_2_GET_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc35_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  if(_loc35_ != null)
                  {
                     _loc35_.Status = TBaseActivity.STATUS_CANGET;
                     _loc35_.Process = 0;
                  }
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET_TASK_SUCCESS);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_FINISH_TASK)
               {
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc35_ = this.FActivityTaskData.GetTaskByIdentify(_loc12_);
                  this.FActivityTaskData.NeedShine = _loc2_.readUnsignedInt();
                  if(_loc35_ != null)
                  {
                     _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                     _loc5_ = 0;
                     while(_loc5_ < _loc35_.TaskAward[_loc35_.Step].Count)
                     {
                        _loc9_ = _loc35_.TaskAward[_loc35_.Step].GetInventoryByIndex(_loc5_);
                        _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                        _loc5_++;
                     }
                     ++_loc35_.Step;
                     if(_loc35_.Step >= TActivityTaskData.STEP_COUNT)
                     {
                        _loc35_.Status = TBaseActivity.STATUS_GETED;
                     }
                     else
                     {
                        _loc35_.Process = 0;
                        _loc35_.Status = TBaseActivity.STATUS_CANNOTGET;
                     }
                  }
                  _loc25_.Score = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_WISH)
               {
                  _loc29_ = int(_loc2_.readUnsignedInt());
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc28_ = int(_loc2_.readUnsignedInt());
                  _loc25_.TotalConsumeGold = _loc2_.readUnsignedInt();
                  _loc25_.ConsumeBox.Count = _loc2_.readUnsignedInt();
                  _loc25_.NeedReset = _loc2_.readUnsignedInt();
                  _loc25_.TreeExp = Math.min(_loc25_.TreeExp + _loc27_,_loc25_.TreeExpMax);
                  _loc25_.RankPoint += _loc28_;
                  _loc25_.ShopExchangePoint += _loc28_;
                  _loc4_ = TUtilityString.Format(_loc25_.DescListNew[24 + _loc29_ - 1],_loc27_,_loc28_);
                  _loc25_.Score = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_FRUIT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc27_ = int(_loc2_.readUnsignedInt());
                  _loc25_.FruitList[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc25_.RankPoint += _loc27_;
                  _loc25_.ShopExchangePoint += _loc27_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED + _loc25_.DescListNew[13] + "*" + _loc27_;
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_UPGRADE)
               {
                  ++_loc25_.TreeLevel;
                  _loc25_.TreeExpMax = _loc2_.readUnsignedInt();
                  _loc25_.UpgradeCost = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.FruitList.length)
                  {
                     _loc25_.FruitList[_loc5_].Price = _loc2_.readUnsignedInt();
                     _loc5_++;
                  }
                  _loc25_.ResetTree();
                  _loc25_.TotalConsumeGold = _loc2_.readUnsignedInt();
                  _loc25_.ConsumeBox.Count = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc25_.DescListNew[12]);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_RESET)
               {
                  _loc25_.TreeExpMax = _loc2_.readUnsignedInt();
                  _loc25_.UpgradeCost = _loc2_.readUnsignedInt();
                  _loc5_ = 0;
                  while(_loc5_ < _loc25_.FruitList.length)
                  {
                     _loc25_.FruitList[_loc5_].Price = _loc2_.readUnsignedInt();
                     _loc5_++;
                  }
                  _loc25_.TotalConsumeGold = _loc2_.readUnsignedInt();
                  _loc25_.ConsumeBox.Count = _loc2_.readUnsignedInt();
                  _loc25_.TreeLevel = 1;
                  _loc25_.NeedReset = 0;
                  _loc25_.ResetTree();
                  ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_RESET_TASK_SUCCESS);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_RECHARGE_GIFT)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.RankPoint = _loc2_.readUnsignedInt();
                  _loc25_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  _loc25_.RechargeBox[_loc5_].Status = TBaseActivity.STATUS_GETED;
                  _loc8_ = _loc25_.RechargeBox[_loc5_].Inventories;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc8_.Count)
                  {
                     _loc9_ = _loc8_.GetInventoryByIndex(_loc5_);
                     _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                     _loc5_++;
                  }
                  _loc25_.Score = _loc2_.readUnsignedInt();
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_GET_CONSUME_GIFT)
               {
                  --_loc25_.ConsumeBox.Count;
                  _loc27_ = _loc25_.ConsumeBox.BuyCount;
                  _loc25_.RankPoint += _loc27_;
                  _loc25_.ShopExchangePoint += _loc27_;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED + _loc25_.DescListNew[13] + "*" + _loc27_;
                  ProcessorEffectText(_loc4_);
                  _loc25_.Score = _loc2_.readUnsignedInt();
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_2_EXCHANGE_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc25_.ShopExchangePoint = _loc2_.readUnsignedInt();
                  --_loc25_.ShopExchangeItems[_loc5_].LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  ProcessorEffectText(_loc4_);
                  _loc25_.ChangeStatus();
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_2_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               break;
            case ACTIVITY_3_ID:
               _loc26_ = this.FJanActiveDatas_2016.GetActivityByIdentify(ACTIVITY_3_ID) as TJanActive3_2016;
               if(_loc10_ == ACTIVITY_3_EXCHANGE_HERO)
               {
                  _loc26_.Hero.Status = TBaseActivity.STATUS_GETED;
                  _loc26_.HeroBox.Status = TBaseActivity.STATUS_CANGET;
                  _loc26_.Score -= _loc26_.Hero.Price;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_GET_GIFT)
               {
                  _loc26_.HeroBox.Status = TBaseActivity.STATUS_GETED;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
               else if(_loc10_ == ACTIVITY_3_OPEN_BOX)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.GiftStatus[_loc5_] = TBaseActivity.STATUS_GETED;
                  _loc16_ = _loc2_.readUnsignedInt();
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc18_ = int(_loc2_.readUnsignedInt());
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc4_ = _loc4_ + (STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc18_ + "\n");
                  _loc26_.TipIndex = _loc2_.readUnsignedInt();
                  _loc26_.Score = _loc2_.readUnsignedInt();
                  _loc26_.Price = _loc2_.readUnsignedInt();
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.FUIWindowVect[2].SetMovieParam(_loc5_);
                  this.FUIWindowVect[2].PlayMovie(1);
               }
               else if(_loc10_ == ACTIVITY_3_OPEN_ALL_BOX)
               {
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
                  _loc5_ = 0;
                  while(_loc5_ < _loc26_.GiftStatus.length)
                  {
                     _loc16_ = _loc2_.readUnsignedInt();
                     _loc11_ = _loc2_.readUnsignedInt();
                     _loc18_ = int(_loc2_.readUnsignedInt());
                     _loc4_ += STRING_COMMON.GetItemNameByType(_loc16_,_loc11_) + "*" + _loc18_ + "\n";
                     _loc26_.GiftStatus[_loc5_] = TBaseActivity.STATUS_GETED;
                     _loc5_++;
                  }
                  _loc26_.TipIndex = _loc2_.readUnsignedInt();
                  _loc26_.Score = _loc2_.readUnsignedInt();
                  _loc26_.Price = 0;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.FUIWindowVect[2].PlayMovie(2);
               }
               else if(_loc10_ == ACTIVITY_3_RESET)
               {
                  _loc26_.Price = _loc2_.readUnsignedInt();
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_RESET_TASK_SUCCESS;
                  _loc26_.ChangeStatus();
                  _loc26_.ResetGame();
                  ProcessorEffectText(_loc4_);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.FUIWindowVect[2].PlayMovie(3);
               }
               else if(_loc10_ == ACTIVITY_3_EXCHANGE_ITEM)
               {
                  _loc5_ = _loc2_.readUnsignedInt() - 1;
                  _loc26_.Score -= _loc26_.ExchangeItems[_loc5_].Price;
                  --_loc26_.ExchangeItems[_loc5_].LimitCount;
                  _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
                  _loc26_.ChangeStatus();
                  ProcessorEffectText(_loc4_);
                  this.FJanActiveDatas_2016.ChangeSingleActivityStatus(ACTIVITY_3_ID);
                  ProcessorCheckEffect(FActivityID,this.FJanActiveDatas_2016.CheckStatus());
                  this.UpdateUI();
               }
         }
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
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
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"累计%0天可领取");
         TUtilityString.FlushUTF(_loc3_,"预留");
         TUtilityString.FlushUTF(_loc3_,"补签花费%0金币,可获得%1月%2日的奖励：%3");
         TUtilityString.FlushUTF(_loc3_,"当前已消费%0金币");
         TUtilityString.FlushUTF(_loc3_,"累计充值%0金币可领");
         TUtilityString.FlushUTF(_loc3_,"当前已充值%0金币");
         TUtilityString.FlushUTF(_loc3_,"累计消费%0金币可领");
         TUtilityString.FlushUTF(_loc3_,"礼包1 XXXX可领");
         TUtilityString.FlushUTF(_loc3_,"礼包2 XXXX可领");
         TUtilityString.FlushUTF(_loc3_,"礼包3 XXXX可领");
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
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
         TUtilityString.FlushUTF(_loc3_,"LV%0");
         TUtilityString.FlushUTF(_loc3_,"当前已充值%0金币");
         TUtilityString.FlushUTF(_loc3_,"累计充值%0金币可领");
         TUtilityString.FlushUTF(_loc3_,"当前已消费%0金币");
         TUtilityString.FlushUTF(_loc3_,"累计消费%0金币可领");
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit2() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
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

