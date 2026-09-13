package Processors.Game.Lobby.Exercise.CatWomen
{
   import Components.Pages.TUIPage;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.CatWomen.TCatWomen;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerCatWomen;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TProcessorCatWomen extends TProcessorBaseActivity
   {
      
      public static const BOX_COUNT:int = 3;
      
      public static const EXCHANGE_BOX_COUNT:int = 4;
      
      public static const ACTIVITY_1_GET_DAILY_GIFT:int = 1;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 2;
      
      public static const ACTIVITY_1_GET_TOTAL_RECHARGE_BOX:int = 3;
      
      public static const ACTIVITY_1_EXCHANGE_HERO:int = 4;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 5;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FCatWomen:TCatWomen;
      
      protected var FUnstreamizerCatWomen:TUnstreamizerCatWomen;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FNewTimeID:int;
      
      public function TProcessorCatWomen(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FCatWomen = SLogicsCore.CatWomen;
         this.FUnstreamizerCatWomen = new TUnstreamizerCatWomen(param3);
         this.FBuyBoxDate = new Object();
         this.FUIPage = new TUIPage(this);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyGiftUp);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyGiftOver);
         FMC_Scene.MC_Gift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            FMC_Scene["MC_Box" + _loc1_].MC_BoxPic.buttonMode = true;
            FMC_Scene["MC_Box" + _loc1_].MC_BoxPic.gotoAndStop(_loc1_ + 1);
            TGameUtil.setButtonMode(FMC_Scene["MC_Box" + _loc1_].BTN_Get,true);
            FMC_Scene["MC_Box" + _loc1_].BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyRechargeBoxUp);
            FMC_Scene["MC_Box" + _loc1_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyRechargeBoxOver);
            FMC_Scene["MC_Box" + _loc1_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         FMC_Scene.MC_RechargeGift.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeGiftUp);
         FMC_Scene.MC_RechargeGift.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeGiftOver);
         FMC_Scene.MC_RechargeGift.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_Hero.MC_Icon.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc6_ = new TUIBaseBox(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc1_]);
            _loc6_.OnOverlay = UIComponentsHintOnOver;
            _loc6_.OnOut = UIComponentsHintOnOut;
            _loc6_.OnGetBox = this.ProcessorOnExchangeUp;
            this.FExchangeList[_loc1_] = _loc6_;
            _loc1_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.BTN_Right;
         this.FUIPage.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_BOX_COUNT)
            {
               if(this.FExchangeList[_loc1_])
               {
                  this.FExchangeList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateExchange();
         this.UpdateHero();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Gift;
         _loc3_ = this.FCatWomen.DailyGift;
         if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = false;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
         }
         else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.MC_Click.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_ = this.FCatWomen.BoxList[_loc1_];
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FCatWomen.DescListNew[2],_loc3_.Price);
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.MC_Click.visible = false;
               _loc2_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.MC_Click.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
            }
            else
            {
               _loc2_.MC_Click.visible = false;
               _loc2_.MC_Got.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
            }
            _loc1_++;
         }
         _loc2_ = FMC_Scene.MC_RechargeGift;
         _loc3_ = this.FCatWomen.RechargeGift;
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FCatWomen.DescListNew[3],this.FCatWomen.TotalRechargeGold,_loc3_.Price);
         if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = false;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
         }
         else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.MC_Click.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage.TotalQuantity = this.FCatWomen.SaleItems.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_ + this.FCurPage * EXCHANGE_BOX_COUNT;
            if(_loc3_ < this.FCatWomen.SaleItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FCatWomen.SaleItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Max.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               _loc4_ = _loc5_.Min.toString();
               this.FExchangeList[_loc1_].SetCurPriceText(_loc4_);
               if(this.FCatWomen.RechargeGold >= _loc5_.Price)
               {
                  this.FExchangeList[_loc1_].SetBuff(false);
                  if(_loc5_.LimitCount > 0)
                  {
                     this.FExchangeList[_loc1_].SetBtnMode(true);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetBtnMode(false);
                  }
               }
               else
               {
                  _loc4_ = TUtilityString.Format(this.FCatWomen.DescListNew[4],_loc5_.Price);
                  this.FExchangeList[_loc1_].SetBuff(true,_loc4_);
                  this.FExchangeList[_loc1_].SetBtnMode(false);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:MovieClip = null;
         _loc2_ = FMC_Scene.MC_Hero;
         _loc1_ = this.FCatWomen.Hero;
         _loc2_.MC_Icon.gotoAndStop(_loc1_.Level);
         _loc2_.TF_Price.text = _loc1_.Max.toString();
         _loc2_.TF_CurPrice.text = _loc1_.Min.toString();
         _loc2_.MC_Lock.TF_Desc.text = TUtilityString.Format(this.FCatWomen.DescListNew[4],_loc1_.Price);
         _loc2_.TF_CurDiscount.text = TUtilityString.Format(this.FCatWomen.DescListNew[6],_loc1_.Discount);
         _loc2_.TF_MaxDiscount.text = TUtilityString.Format(this.FCatWomen.DescListNew[7],_loc1_.ReturnMoney);
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc2_.MC_Got.visible = true;
            _loc2_.BTN_Get.visible = false;
            _loc2_.MC_Lock.visible = false;
         }
         else if(this.FCatWomen.RechargeGold >= _loc1_.Price)
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.BTN_Get.visible = true;
            _loc2_.MC_Lock.visible = false;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
         }
         else
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.BTN_Get.visible = false;
            _loc2_.MC_Lock.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCatWomen.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCatWomen.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FCatWomen.DescListNew[1];
         FMC_Scene.TF_Desc2.text = this.FCatWomen.DescListNew[5];
         FMC_Scene.TF_TotalGold.text = this.FCatWomen.ServerRechargeGold.toString();
         FMC_Scene.TF_Discount.text = this.FCatWomen.CurDiscount + "%";
         FMC_Scene.TF_Gold.text = this.FCatWomen.RechargeGold.toString();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateExchange();
      }
      
      protected function ProcessorOnDailyGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FCatWomen) && this.FCatWomen.DailyGift.Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_DAILY_GIFT);
         }
      }
      
      protected function ProcessorOnDailyGiftOver(param1:MouseEvent) : void
      {
         if(this.FCatWomen)
         {
            ProcessorOnNewBoxOver(this.FCatWomen.DailyGift.Inventories);
         }
      }
      
      protected function ProcessorOnDailyRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(this.FCatWomen) && this.FCatWomen.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnDailyRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(this.FCatWomen)
         {
            ProcessorOnNewBoxOver(this.FCatWomen.BoxList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnRechargeGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FCatWomen) && this.FCatWomen.RechargeGift.Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_TOTAL_RECHARGE_BOX);
         }
      }
      
      protected function ProcessorOnRechargeGiftOver(param1:MouseEvent) : void
      {
         if(this.FCatWomen)
         {
            ProcessorOnNewBoxOver(this.FCatWomen.RechargeGift.Inventories);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FCatWomen)
         {
            _loc2_ = this.FCatWomen.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FCatWomen.RechargeGold >= _loc2_.Price)
            {
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_EXCHANGE_HERO,_loc2_.Min);
            }
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(this.FCatWomen) && Boolean(this.FCatWomen.Hero))
         {
            _loc2_ = this.FCatWomen.Hero;
            ProcessorOnShowItemDesc(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * EXCHANGE_BOX_COUNT;
         if(Boolean(this.FCatWomen) && _loc3_ < this.FCatWomen.SaleItems.length)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_EXCHANGE_ITEM,this.FCatWomen.SaleItems[_loc3_].Min,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0) : void
      {
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
         this.FBuyBoxDate.ConfirmType = param7;
         if(param4 != TBaseActivity.SWEET_TYPE_GOLD)
         {
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
            return;
         }
         if(!FUIWindowConfirmation.IsSelected)
         {
            this.FCost = param2;
            if(param5 != "")
            {
               FUIWindowConfirmation.Text = param5;
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
            this.ProcessorOnGetBoxUp(this.FBuyBoxDate.ActivityType,this.FBuyBoxDate.BoxIndex,this.FBuyBoxDate.BoxIndex1);
         }
         else
         {
            FUIWindowRecharge.Visible = true;
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked || this.FIsPlaying)
         {
            return;
         }
         this.FBeClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnCloseWindow() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FCatWomen;
         super.ProcessorOnOpenDesc();
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         ProcessorLoadActiveRankNew(0);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
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
         this.PerformPacket_CS_LoadInfoReq();
         SetInterval();
      }
      
      protected function SetIntervalFiveMinute() : void
      {
         if(this.FNewTimeID != 0)
         {
            clearTimeout(this.FNewTimeID);
            this.FNewTimeID = 0;
         }
         this.FNewTimeID = setTimeout(this.PerformPacket_CS_LoadInfoReq,5 * 60 * 1000);
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
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
         this.FUnstreamizerCatWomen.Unstreamize(_loc2_,this.FCatWomen,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
            this.SetIntervalFiveMinute();
         }
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
         _loc2_ = param1.Data;
         _loc2_.readShort();
         if(this.FCatWomen)
         {
            if(this.FCatWomen)
            {
               this.FCatWomen.TotalRechargeGold = _loc2_.readUnsignedInt();
               this.FCatWomen.RechargeGold = _loc2_.readUnsignedInt();
               this.FCatWomen.ServerRechargeGold = _loc2_.readUnsignedInt();
               this.FCatWomen.CurDiscount = _loc2_.readUnsignedInt();
               ProcessorCheckEffect(FActivityID,this.FCatWomen.CheckStatus());
               if(this.FIsOpen)
               {
                  this.UpdateUI();
               }
            }
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
         ProcessorUnstreamActivityLog(this.FCatWomen,_loc2_);
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
         var _loc13_:TBaseBox = null;
         var _loc14_:uint = 0;
         var _loc15_:TBins = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:uint = 0;
         var _loc21_:Vector.<uint> = null;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:String = null;
         _loc15_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
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
            case ACTIVITY_1_GET_DAILY_GIFT:
               this.FCatWomen.DailyGift.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FCatWomen.DailyGift.Inventories.Count)
               {
                  _loc9_ = this.FCatWomen.DailyGift.Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FCatWomen.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCatWomen.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FCatWomen.BoxList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FCatWomen.BoxList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FCatWomen.BoxList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FCatWomen.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCatWomen.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_TOTAL_RECHARGE_BOX:
               this.FCatWomen.RechargeGift.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FCatWomen.RechargeGift.Inventories.Count)
               {
                  _loc9_ = this.FCatWomen.RechargeGift.Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FCatWomen.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCatWomen.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_HERO:
               this.FCatWomen.Hero.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               ProcessorEffectText(_loc4_);
               this.FCatWomen.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCatWomen.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FCatWomen.SaleItems[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FCatWomen.SaleItems[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FCatWomen.SaleItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FCatWomen.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FCatWomen.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param1;
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
      }
      
      public function Test() : ByteArray
      {
         return null;
      }
   }
}

