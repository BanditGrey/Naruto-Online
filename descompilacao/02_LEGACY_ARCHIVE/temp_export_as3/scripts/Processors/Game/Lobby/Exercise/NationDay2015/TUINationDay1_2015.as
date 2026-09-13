package Processors.Game.Lobby.Exercise.NationDay2015
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.NationalDay_2015.TNationalDay1_2015;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUINationDay1_2015 extends TUIBaseWindow
   {
      
      protected static const SHOW_ITEM_COUNT:int = 8;
      
      protected static const FUND_COUNT:int = 3;
      
      protected static const FUND_ITEM_COUNT:int = 3;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FNationalDay1_2015:TNationalDay1_2015;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FFunds:Vector.<TUIShowItem>;
      
      public function TUINationDay1_2015(param1:TUIComponent)
      {
         super(param1);
         this.FFunds = new Vector.<TUIShowItem>(FUND_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIShowItem = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene.MC_DailyGift.MC_BoxPic.buttonMode = true;
         FMC_Scene.MC_DailyGift.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_DailyGift.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         _loc2_ = 0;
         while(_loc2_ < FUND_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Fund" + _loc2_];
            _loc5_.MC_Background.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(_loc5_.BTN_Buy,true);
            _loc5_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnFundUp);
            _loc2_++;
         }
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         _loc2_ = 0;
         while(_loc2_ < FUND_COUNT)
         {
            _loc6_ = new TUIShowItem(this,FUND_ITEM_COUNT);
            _loc6_.Perform_UIDispatch(FMC_Scene["MC_Fund" + _loc2_]);
            _loc6_.OnOverlay = this.ProcessorOnItemOver;
            _loc6_.OnOut = this.ProcessorOnItemOut;
            this.FFunds[_loc2_] = _loc6_;
            _loc2_++;
         }
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyGiftUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,true);
         FMC_Scene.BTN_Lottery.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Back,true);
         FMC_Scene.BTN_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GotoRecharge,true);
         FMC_Scene.BTN_GotoRecharge.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
      }
      
      protected function UpdateShowItem() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:MovieClip = null;
         _loc2_ = FMC_Scene.MC_DailyGift;
         _loc1_ = this.FNationalDay1_2015.DailyGift;
         if(_loc1_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Got.visible = false;
            FMC_Scene.MC_Got.visible = false;
            _loc2_.gotoAndPlay(1);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else
         {
            _loc2_.MC_Got.visible = true;
            FMC_Scene.MC_Got.visible = true;
            _loc2_.gotoAndStop(1);
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
         if(this.FNationalDay1_2015.FreeCount > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Lottery,false);
         }
         this.FShowItem.UpdateUI(this.FNationalDay1_2015.ShowItem);
      }
      
      protected function UpdateFund() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < FUND_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Fund" + _loc1_];
            _loc3_ = this.FNationalDay1_2015.Funds[_loc1_];
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FNationalDay1_2015.DescListNew[7],_loc3_.Count);
            _loc2_.TF_Gold.text = _loc3_.Price.toString();
            this.FFunds[_loc1_].UpdateUI(_loc3_.Inventories);
            if(this.FNationalDay1_2015.FundStatus == 0)
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,true);
            }
            else if(_loc1_ == this.FNationalDay1_2015.FundStatus - 1)
            {
               _loc2_.MC_Got.visible = true;
               _loc2_.BTN_Buy.visible = false;
            }
            else
            {
               _loc2_.MC_Got.visible = false;
               _loc2_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.text = this.FNationalDay1_2015.DescListNew[1];
         FMC_Scene.TF_Desc1.text = TUtilityString.Format(this.FNationalDay1_2015.DescListNew[5],this.FNationalDay1_2015.LoginDay,this.FNationalDay1_2015.NeedDay);
         FMC_Scene.TF_Desc2.text = this.FNationalDay1_2015.DescListNew[6];
         FMC_Scene.TF_FreeCount.text = this.FNationalDay1_2015.FreeCount.toString();
      }
      
      protected function ProcessorOnDailyGiftUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FNationalDay1_2015))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorNationDay2015.ACTIVITY_1_GET_DAILY_GIFT);
         }
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FNationalDay1_2015))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorNationDay2015.ACTIVITY_1_LOTTERY);
         }
      }
      
      protected function ProcessorOnFundUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnBuyBox != null && Boolean(this.FNationalDay1_2015))
         {
            FOnBuyBox(ACTIVITY_1_ID,TProcessorNationDay2015.ACTIVITY_1_BUY_FUND,this.FNationalDay1_2015.Funds[_loc2_].Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FNationalDay1_2015))
         {
            FOnNewBoxOver(this.FNationalDay1_2015.DailyGift.Inventories);
         }
      }
      
      protected function ProcessorOnFundOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && Boolean(this.FNationalDay1_2015))
         {
            FOnNewBoxOver(this.FNationalDay1_2015.Funds[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnBackUp(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorNationDay2015.WINDOW_HOME);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < this.FFunds.length)
            {
               this.FFunds[_loc1_].LogicsPerform();
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FNationalDay1_2015 = SLogicsCore.NationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_1_ID) as TNationalDay1_2015;
         this.UpdateShowItem();
         this.UpdateFund();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         FIsPlaying = true;
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
         TweenUtil.removeAllTween();
         FIsPlaying = false;
      }
   }
}

