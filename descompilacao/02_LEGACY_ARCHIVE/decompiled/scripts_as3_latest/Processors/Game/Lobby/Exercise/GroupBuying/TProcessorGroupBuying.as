package Processors.Game.Lobby.Exercise.GroupBuying
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.GroupBuying.TGroupBuying;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerGroupBuying;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.GroupBuying.Compoents.TUIGroupBuyingBox;
   import Processors.Game.Lobby.Tavern.TProcessorWindowRecruit;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   
   public class TProcessorGroupBuying extends TProcessorBaseActivity
   {
      
      protected var FGroupBuying:TGroupBuying;
      
      protected var FBeClicked:Boolean;
      
      protected var FMC_Report:MovieClip;
      
      protected var FMC_Buying:MovieClip;
      
      protected var FBTN_Report:MovieClip;
      
      protected var FUIGroupBuyingBox:TUIGroupBuyingBox;
      
      protected var FUIGroupBuyingBox2:TUIGroupBuyingBox;
      
      protected var FTF_CurPeople:TextField;
      
      protected var FTF_Status:TextField;
      
      protected var FTF_LimitTime:TextField;
      
      protected var FTF_Desc1:TextField;
      
      protected var FMC_Buff:MovieClip;
      
      protected var FMC_Arrow:MovieClip;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FInitArrowX:int;
      
      protected var FTF_BuyingTime:TextField;
      
      protected var FTF_Context:TextField;
      
      protected var FTF_Desc2:TextField;
      
      protected var FBTN_Buy:MovieClip;
      
      protected var FProcessorWindowRecruit:TProcessorWindowRecruit;
      
      protected var FUIWindowConfirmationSign:TUIWindowConfirmationSign;
      
      protected var FRefreshTime:int;
      
      protected var FBeginBuyTimeID:int;
      
      protected var FFreshTimeID:int;
      
      protected var FActive:TActive;
      
      protected var FUnstreamizerGroupBuying:TUnstreamizerGroupBuying;
      
      protected var FArticleBins:TBins;
      
      protected var FBeginBuy:Boolean;
      
      public function TProcessorGroupBuying(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,CONST_BASEACTIVITY.TYPE_NewActiveList_GroupBuying);
         FActivityID = CONST_BASEACTIVITY.TYPE_NewActiveList_GroupBuying;
         this.FGroupBuying = SLogicsCore.GroupBuying;
         this.FUnstreamizerGroupBuying = new TUnstreamizerGroupBuying();
         this.FProcessorWindowRecruit = new TProcessorWindowRecruit(this.Parent);
         this.FProcessorWindowRecruit.Visible = false;
         this.FUIWindowConfirmationSign = new TUIWindowConfirmationSign(this.Parent);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         this.FMC_Report = FMC_Scene["MC_Report"];
         this.FBTN_Report = this.FMC_Report["BTN_Report"];
         this.FTF_CurPeople = this.FMC_Report["TF_CurPeople"];
         this.FTF_Status = this.FMC_Report["TF_Status"];
         this.FTF_LimitTime = this.FMC_Report["TF_LimitTime"];
         this.FTF_Desc1 = this.FMC_Report["TF_Desc1"];
         this.FMC_Buff = this.FMC_Report["MC_Buff"];
         this.FMC_Arrow = this.FMC_Report["MC_Arrow"];
         this.FMC_Mask = this.FMC_Report.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FInitArrowX = this.FMC_Arrow.x;
         this.FUIGroupBuyingBox = new TUIGroupBuyingBox(this);
         this.FUIGroupBuyingBox.Perform_UIDispatch(this.FMC_Report.MC_Box);
         this.FUIGroupBuyingBox.OnOverlay = UIComponentsHintOnOver;
         this.FUIGroupBuyingBox.OnOut = UIComponentsHintOnOut;
         this.FUIGroupBuyingBox.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FMC_Buying = FMC_Scene["MC_Buying"];
         this.FMC_Buying.visible = false;
         this.FTF_BuyingTime = this.FMC_Buying["TF_BuyingTime"];
         this.FTF_Context = this.FMC_Buying["TF_Context"];
         this.FTF_Desc2 = this.FMC_Buying["TF_Desc2"];
         this.FBTN_Buy = this.FMC_Buying["BTN_Buy"];
         this.FUIGroupBuyingBox2 = new TUIGroupBuyingBox(this);
         this.FUIGroupBuyingBox2.Perform_UIDispatch(this.FMC_Buying.MC_Box);
         this.FUIGroupBuyingBox2.OnOverlay = UIComponentsHintOnOver;
         this.FUIGroupBuyingBox2.OnOut = UIComponentsHintOnOut;
         this.FUIGroupBuyingBox2.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FProcessorWindowRecruit.OnEffectText = FOnEffectText;
         this.FProcessorWindowRecruit.HintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowRecruit.HintOnOut = ProcessorTipOnOut;
         this.FProcessorWindowRecruit.x = CONST_COMMON.STAGE_Width - 400 >> 1;
         this.FProcessorWindowRecruit.y = CONST_COMMON.STAGE_Height - 367 >> 1;
         this.FUIWindowConfirmationSign.OnOK = this.WindowConfirmationSignOnOK;
         this.FUIWindowConfirmationSign.OnClose = this.WindowConfirmationSignOnOK;
         this.FUIWindowConfirmationSign.Visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         this.FMC_Report.BTN_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FMC_Buying.BTN_Close.addEventListener(MouseEvent.CLICK,OnClose);
         this.FBTN_Report.addEventListener(MouseEvent.CLICK,this.ProcessorOnReportUp);
         this.FBTN_Report.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnReportMove);
         this.FBTN_Report.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnReportOut);
         TGameUtil.setButtonMode(this.FBTN_Report,true);
         this.FBTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
         this.FBTN_Buy.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyMove);
         this.FBTN_Buy.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnBuyOut);
         TGameUtil.setButtonMode(this.FBTN_Buy,true);
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FInitialized)
         {
            if(this.visible)
            {
               if(Boolean(this.FUIGroupBuyingBox) && this.FMC_Report.visible == true)
               {
                  this.FUIGroupBuyingBox.LogicsPerform();
                  if(Boolean(this.FGroupBuying) && Boolean(this.FTF_LimitTime))
                  {
                     this.FTF_LimitTime.text = STRING_BASEACTIVITY.FORMAT_REPORTED_LIMIT_TIME + TGameUtil.fomatTime(this.FGroupBuying.PayEndTime - STimingCore.GetServerTick());
                  }
               }
               if(Boolean(this.FUIGroupBuyingBox2) && this.FMC_Buying.visible == true)
               {
                  this.FUIGroupBuyingBox2.LogicsPerform();
                  if(Boolean(this.FGroupBuying) && Boolean(this.FTF_BuyingTime))
                  {
                     if(this.FGroupBuying.IsBuy == TGroupBuying.IS_BOUGHT || this.FGroupBuying.IsReported == TGroupBuying.NO_REPORTED)
                     {
                        if(this.FGroupBuying.NextTime == 0)
                        {
                           this.FTF_BuyingTime.text = STRING_BASEACTIVITY.Format_Last_Time;
                        }
                        else
                        {
                           this.FTF_BuyingTime.text = TUtilityString.Format(STRING_BASEACTIVITY.Format_Next_LimitTime,TGameUtil.fomatTime(this.FGroupBuying.NextTime - STimingCore.GetServerTick()));
                        }
                     }
                     else
                     {
                        this.FTF_BuyingTime.text = TUtilityString.Format(STRING_BASEACTIVITY.Format_Buy_LimitTime,TGameUtil.fomatTime(this.FGroupBuying.BuyEndTime - STimingCore.GetServerTick()));
                     }
                  }
                  if(!this.FBeginBuy)
                  {
                     if(STimingCore.GetServerTick() >= this.FGroupBuying.PayEndTime + 60 * 10)
                     {
                        this.FBeginBuy = true;
                        this.UpdateBuyText();
                     }
                  }
               }
               if(Boolean(this.FProcessorWindowRecruit) && this.FProcessorWindowRecruit.Visible == true)
               {
                  this.FProcessorWindowRecruit.UpdataBitmap();
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         super.UpdateUI();
         if(STimingCore.GetServerTick() < this.FGroupBuying.PayEndTime)
         {
            this.UpdateText();
            this.UpdateBar();
            this.FMC_Report.visible = true;
            this.FMC_Buying.visible = false;
            this.FUIGroupBuyingBox.UpdateUI();
            this.FUIGroupBuyingBox2.RemoveHero();
         }
         else
         {
            this.UpdateBuyText();
            this.FMC_Report.visible = false;
            this.FMC_Buying.visible = true;
            this.FUIGroupBuyingBox2.UpdateUI();
            this.FUIGroupBuyingBox.RemoveHero();
         }
      }
      
      protected function UpdateText() : void
      {
         this.FTF_CurPeople.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_REPORTED_PEOPLE,this.FGroupBuying.CurPeople);
         if(this.FGroupBuying.IsReported == TGroupBuying.IS_REPORTED)
         {
            this.FTF_Status.text = STRING_BASEACTIVITY.FORMAT_IS_REPORTED;
            TGameUtil.setButtonMode(this.FBTN_Report,false);
         }
         else
         {
            this.FTF_Status.text = STRING_BASEACTIVITY.FORMAT_NO_REPORT;
            TGameUtil.setButtonMode(this.FBTN_Report,true);
         }
         this.FTF_Desc1.text = this.FGroupBuying.ActivityDesc;
         if(this.FGroupBuying.CurPeople >= this.FGroupBuying.MaxPeople)
         {
            this.FMC_Buff.visible = false;
         }
         else
         {
            this.FMC_Buff.visible = true;
            this.FMC_Buff.TF_Buff.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_NEXT_LEVEL_NEED_PEOPLE,this.FGroupBuying.GetNextLevelNeedPeople());
         }
      }
      
      protected function UpdateBuyText() : void
      {
         if(this.FGroupBuying.IsReported == TGroupBuying.NO_REPORTED)
         {
            this.FMC_Buying.TF_Context.text = TUtilityString.Format(STRING_BASEACTIVITY.Format_NO_REPORT_STRING,this.FGroupBuying.BuyPeople);
            TGameUtil.setButtonMode(this.FBTN_Buy,false);
         }
         else if(this.FGroupBuying.IsBuy == TGroupBuying.NO_BUY)
         {
            this.FMC_Buying.TF_Context.text = TUtilityString.Format(STRING_BASEACTIVITY.Format_NO_BUY_STRING,this.FGroupBuying.BuyPeople);
            if(this.FBeginBuy)
            {
               TGameUtil.setButtonMode(this.FBTN_Buy,true);
            }
            else
            {
               TGameUtil.setButtonMode(this.FBTN_Buy,false);
            }
         }
         else
         {
            this.FMC_Buying.TF_Context.text = TUtilityString.Format(STRING_BASEACTIVITY.Format_IS_BUY_STRING,this.FGroupBuying.BuyPeople);
            TGameUtil.setButtonMode(this.FBTN_Buy,false);
         }
         this.FTF_Desc2.text = this.FGroupBuying.ActiveDesc2;
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         _loc1_ = Number(this.FGroupBuying.CurPeople / this.FGroupBuying.MaxPeople) * this.FBarMaxWidth;
         this.FMC_Mask.width = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Arrow.x = this.FInitArrowX + this.FMC_Mask.width;
         this.FMC_Arrow.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_STRING,this.FGroupBuying.CurPrice,this.FGroupBuying.CurPeople);
         if(this.FGroupBuying.CurPeople >= this.FGroupBuying.MaxPeople)
         {
            this.FMC_Arrow.visible = false;
         }
         else
         {
            this.FMC_Arrow.visible = true;
         }
         this.FMC_Report.TF_OrgPeople.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT1,0);
         this.FMC_Report.TF_OrgPrice.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,this.FGroupBuying.OrigPrice);
         this.FMC_Report.TF_MaxPeople.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT1,this.FGroupBuying.MaxPeople);
         this.FMC_Report.TF_MinPrice.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_BAR_TEXT2,this.FGroupBuying.MinPrice);
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         if(this.FGroupBuying)
         {
            FNeedConfig = this.FGroupBuying.NeedConfig;
         }
         if(this.FRefreshTime == 0 || this.FRefreshTime <= STimingCore.GetServerTick())
         {
            super.PerformPacket_CS_LoadInfoReq();
            this.FRefreshTime = STimingCore.GetServerTick() + 1 * 60;
         }
         else if(this.FGroupBuying.ActiveDesc2)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnReportUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FGroupBuying.IsGoldEnough(this.FGroupBuying.CurPrice))
         {
            this.PerformPacket_CS_GetRewardReq();
         }
         else
         {
            ProcessorOnShowGotoRecharge();
         }
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBeClicked)
         {
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            FUIWindowConfirmation.Text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_ConfirmGold,this.FGroupBuying.CurPrice);
            FUIWindowConfirmation.SetCheckBox(true);
            FUIWindowConfirmation.Visible = true;
         }
         else
         {
            this.WindowConfirmationOnOK();
         }
      }
      
      protected function ProcessorOnBuyMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(param1.currentTarget.buttonMode)
         {
            return;
         }
         if(STimingCore.GetServerTick() > this.FGroupBuying.BuyEndTime)
         {
            _loc2_ = STRING_BASEACTIVITY.Format_IS_END_TIP;
         }
         else if(this.FGroupBuying.IsReported == TGroupBuying.NO_REPORTED)
         {
            _loc2_ = STRING_BASEACTIVITY.Format_NO_REPORT_TIP;
         }
         else if(this.FGroupBuying.IsBuy == TGroupBuying.NO_BUY)
         {
            _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.Format_NO_OPEN_TIP,TGameUtil.fomatTime(this.FGroupBuying.PayEndTime + 600 - STimingCore.GetServerTick()));
         }
         else
         {
            _loc2_ = STRING_BASEACTIVITY.Format_IS_BUY_TIP;
         }
         ProcessorOnShowTip(_loc2_);
      }
      
      protected function ProcessorOnBuyOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      protected function ProcessorOnReportMove(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = STRING_BASEACTIVITY.Format_IS_REPORTED_TIP;
         ProcessorOnShowTip(_loc2_);
      }
      
      protected function ProcessorOnReportOut(param1:MouseEvent) : void
      {
         ProcessorOnHideTip();
      }
      
      override protected function WindowConfirmationOnOK(param1:Object = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FGroupBuying.CurPrice;
         if(!this.FGroupBuying.IsGoldEnough(_loc2_))
         {
            FUIWindowRecharge.Visible = true;
            return;
         }
         this.FBeClicked = true;
         this.PerformPacket_CS_BuyBoxReq();
      }
      
      override protected function PerformPacket_CS_BuyBoxReq(param1:MouseEvent = null) : void
      {
         FIdentify = 0;
         super.PerformPacket_CS_BuyBoxReq();
         TGameUtil.setButtonMode(this.FBTN_Buy,false);
      }
      
      override protected function PerformPacket_CS_GetRewardReq(param1:MouseEvent = null) : void
      {
         FIdentify = 0;
         super.PerformPacket_CS_GetRewardReq();
         TGameUtil.setButtonMode(this.FBTN_Report,false);
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_HappyTreasure_LoadLogReq);
         _loc2_.Data.writeUnsignedInt(FActivityID);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ProcessorOnShowRecruit() : void
      {
         this.FProcessorWindowRecruit.SetHeroData(this.FGroupBuying.HeroID);
      }
      
      protected function WindowConfirmationSignOnOK(param1:Object = null) : void
      {
         this.FUIWindowConfirmationSign.Visible = false;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRecruit.Load();
            this.FUIWindowConfirmationSign.Load();
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
         if(this.FFreshTimeID == 0)
         {
            this.FFreshTimeID = setInterval(this.PerformPacket_CS_LoadInfoReq,1 * 60 * 1000);
         }
      }
      
      override public function Unmount() : void
      {
         this.FProcessorWindowRecruit.Visible = false;
         this.FUIWindowConfirmationSign.Visible = false;
         if(this.FUIGroupBuyingBox)
         {
            this.FUIGroupBuyingBox.RemoveHero();
         }
         if(this.FUIGroupBuyingBox2)
         {
            this.FUIGroupBuyingBox2.RemoveHero();
         }
         if(this.FFreshTimeID != 0)
         {
            clearInterval(this.FFreshTimeID);
            this.FFreshTimeID = 0;
         }
         super.Unmount();
      }
      
      override public function ProcessorOnLoadInfoRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerGroupBuying.Unstreamize(_loc2_,this.FGroupBuying,null);
         if(STimingCore.GetServerTick() < this.FGroupBuying.PayEndTime)
         {
            _loc4_ = (this.FGroupBuying.PayEndTime - STimingCore.GetServerTick()) * 1000;
         }
         else
         {
            _loc4_ = (this.FGroupBuying.EndTime - STimingCore.GetServerTick()) * 1000;
         }
         if(_loc4_ > 0 && _loc4_ < int.MAX_VALUE)
         {
            this.FBeginBuyTimeID = setTimeout(this.UpdateUI,_loc4_);
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      override public function ProcessorBuyBoxRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.FBeClicked = false;
            return;
         }
         _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc5_ = this.FGroupBuying.Inventories;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.Count)
         {
            _loc4_ += _loc5_.GetInventoryByIndex(_loc6_).Name + "*" + _loc5_.GetInventoryByIndex(_loc6_).Quantity + "\n";
            _loc6_++;
         }
         ProcessorEffectText(_loc4_);
         ++this.FGroupBuying.BuyPeople;
         this.FGroupBuying.IsBuy = TGroupBuying.IS_BOUGHT;
         this.FBeClicked = false;
         this.UpdateUI();
      }
      
      override public function ProcessorGetRewardRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            this.UpdateUI();
            return;
         }
         this.FUIWindowConfirmationSign.Visible = true;
         ++this.FGroupBuying.CurPeople;
         this.FGroupBuying.IsReported = TGroupBuying.IS_REPORTED;
         this.UpdateUI();
      }
      
      public function TestInit0() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 200);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 10);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 200);
         TUtilityString.FlushUTF(_loc3_,"团购1");
         TUtilityString.FlushUTF(_loc3_,"团购2");
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(10000);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(101);
         _loc3_.writeUnsignedInt(1000);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(5);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(101);
         _loc3_.writeUnsignedInt(0);
         if(!this.FGroupBuying || this.FGroupBuying.NeedConfig)
         {
            _loc3_.writeShort(1);
            _loc1_ = 0;
            while(_loc1_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(4);
               _loc3_.writeUnsignedInt(11210014);
               _loc3_.writeUnsignedInt(1);
               _loc1_++;
            }
         }
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public function TestInit1() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(17);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

