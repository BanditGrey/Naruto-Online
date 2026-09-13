package Processors.Game.Lobby.Exercise.Christmas2016
{
   import Components.Standard.TUITab;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2016.TChristmas3_2016;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIChristmas3_2016 extends TUIBaseWindow
   {
      
      protected static const SWEET_COUNT:int = 5;
      
      protected static const GIFT_COUNT:int = 6;
      
      protected static const BAR_COUNT:int = 6;
      
      protected static const TAB_COUNT:int = 3;
      
      protected static const TAB_HERO:int = 0;
      
      protected static const TAB_PET:int = 1;
      
      protected static const TAB_GIFT:int = 2;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected var FChristmas3_2016:TChristmas3_2016;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FMC_ExchangeMask0:MovieClip;
      
      protected var FMC_ExchangeMask1:MovieClip;
      
      protected var FMC_ExchangeMask2:MovieClip;
      
      protected var FExchangeBarMaxWidth:int;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FItems:Vector.<TUIShowItem>;
      
      public function TUIChristmas3_2016(param1:TUIComponent)
      {
         super(param1);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FGiftList = new Vector.<MovieClip>(GIFT_COUNT);
         this.FItems = new Vector.<TUIShowItem>(GIFT_COUNT);
         this.FUITab = new TUITab(this);
         this.FChangeTabIndex = 0;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene.MC_Box.MC_BoxPic.buttonMode = true;
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         _loc2_ = 0;
         while(_loc2_ < SWEET_COUNT)
         {
            this.FSweetList[_loc2_] = FMC_Scene["MC_Sweet" + _loc2_];
            this.FSweetList[_loc2_].buttonMode = true;
            this.FSweetList[_loc2_].gotoAndStop(_loc2_ + 1);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnSweetUp);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSweetOver);
            this.FSweetList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            FMC_Scene["MC_Icon" + _loc2_].gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            _loc5_ = FMC_Scene.MC_Exchange2["MC_Gift" + _loc2_];
            TGameUtil.setButtonMode(_loc5_.BTN_Exchange,true);
            _loc5_.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeItemUp);
            this.FGiftList[_loc2_] = _loc5_;
            _loc4_ = new TUIShowItem(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_Exchange2["MC_Gift" + _loc2_]);
            _loc4_.OnOverlay = this.ProcessorOnItemOver;
            _loc4_.OnOut = this.ProcessorOnItemOut;
            this.FItems[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         TGameUtil.setButtonMode(FMC_Scene.MC_Exchange0.BTN_Exchange,true);
         FMC_Scene.MC_Exchange0.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Exchange0.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Exchange0.MC_Hero.addEventListener(MouseEvent.MOUSE_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.MC_Exchange1.BTN_Exchange,true);
         FMC_Scene.MC_Exchange1.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangePetUp);
         FMC_Scene.MC_Exchange1.MC_Pet.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnPetOver);
         FMC_Scene.MC_Exchange1.MC_Pet.addEventListener(MouseEvent.MOUSE_OUT,ProcessorOnHideHtmlTip);
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FMC_ExchangeMask0 = FMC_Scene.MC_Exchange0.MC_ExchangeBar["MC_Mask"];
         this.FExchangeBarMaxWidth = this.FMC_ExchangeMask0.width;
         this.FMC_ExchangeMask0.width = 0;
         this.FMC_ExchangeMask1 = FMC_Scene.MC_Exchange1.MC_ExchangeBar["MC_Mask"];
         this.FMC_ExchangeMask1.width = 0;
         this.FMC_ExchangeMask2 = FMC_Scene.MC_Exchange2.MC_ExchangeBar["MC_Mask"];
         this.FMC_ExchangeMask2.width = 0;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,true);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.CLICK,this.ProcessorOnTenUp);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTenOver);
         FMC_Scene.BTN_TenGet.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.MC_Exchange0.BTN_HeroDesc,true);
         FMC_Scene.MC_Exchange0.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowHeroDesc);
         TGameUtil.setButtonMode(FMC_Scene.MC_Exchange1.BTN_HeroDesc,true);
         FMC_Scene.MC_Exchange1.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowPetDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
      }
      
      protected function UpdatePool() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         FMC_Scene.MC_Bar.TF_Count.text = this.FChristmas3_2016.PoolValue + "/" + this.FChristmas3_2016.PoolMax;
         _loc5_ = Number(this.FChristmas3_2016.PoolValue / this.FChristmas3_2016.PoolMax) * this.FBarMaxWidth;
         _loc6_ = Math.min(_loc5_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc6_;
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            _loc3_ = this.FSweetList[_loc1_];
            if(_loc1_ < this.FChristmas3_2016.SweetList.length)
            {
               _loc3_.visible = true;
               _loc4_ = this.FChristmas3_2016.SweetList[_loc1_];
               if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.filters = [];
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.filters = [TGameUtil.highLightFilters];
               }
               else
               {
                  _loc3_.filters = [TGameUtil.GaryColorFilters];
               }
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:MovieClip = null;
         _loc1_ = this.FChristmas3_2016.Gift;
         _loc2_ = FMC_Scene.MC_Box;
         _loc2_.TF_Count.text = "*" + _loc1_.Count;
         if(_loc1_.Count > 0)
         {
            _loc2_.MC_Click.visible = true;
            _loc2_.MC_Click.gotoAndPlay(1);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Click.gotoAndStop(1);
         }
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            FMC_Scene["MC_Exchange" + _loc1_].visible = _loc1_ == this.FChangeTabIndex ? true : false;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc2_ = this.FGiftList[_loc1_];
            _loc3_ = this.FChristmas3_2016.ItemList[_loc1_];
            _loc4_ = this.FChristmas3_2016.GetCurItemPriceByIndex(_loc1_);
            _loc2_.TF_LimitCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc3_.LimitCount);
            _loc2_.MC_Count.TF_Count.text = _loc3_.Price.toString();
            _loc2_.MC_CurCount.TF_Count.text = _loc4_.toString();
            this.FItems[_loc1_].UpdateUI(_loc3_.Inventories);
            if(_loc3_.LimitCount > 0 && this.FChristmas3_2016.Score >= _loc4_)
            {
               TGameUtil.setButtonMode(_loc2_.BTN_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc2_.BTN_Exchange,false);
            }
            _loc1_++;
         }
         _loc2_ = FMC_Scene.MC_Exchange0;
         _loc3_ = this.FChristmas3_2016.Hero;
         _loc2_.TF_Price.text = _loc3_.Price.toString();
         _loc2_.TF_CurPrice.text = this.FChristmas3_2016.GetCurHeroPrice();
         if(_loc3_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc2_.MC_Got.visible = true;
            _loc2_.BTN_Exchange.visible = false;
         }
         else if(this.FChristmas3_2016.Score >= this.FChristmas3_2016.GetCurHeroPrice())
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Exchange,true);
         }
         else
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Exchange,false);
         }
         _loc2_ = FMC_Scene.MC_Exchange1;
         _loc3_ = this.FChristmas3_2016.Pet;
         _loc2_.TF_Price.text = _loc3_.Price.toString();
         _loc2_.TF_CurPrice.text = this.FChristmas3_2016.GetCurPetPrice();
         if(_loc3_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc2_.MC_Got.visible = true;
            _loc2_.BTN_Exchange.visible = false;
         }
         else if(this.FChristmas3_2016.Score >= this.FChristmas3_2016.GetCurPetPrice())
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Exchange,true);
         }
         else
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(_loc2_.BTN_Exchange,false);
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         FMC_Scene.TF_RechargeGold.text = this.FChristmas3_2016.TotalRechargeGold.toString();
         if(this.FChangeTabIndex == TAB_HERO)
         {
            FMC_Scene.MC_Exchange0.MC_ExchangeBar.TF_Count.text = this.FChristmas3_2016.TotalRechargeGold + "/" + this.FChristmas3_2016.HeroGold[this.FChristmas3_2016.HeroGold.length - 1];
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               FMC_Scene.MC_Exchange0.MC_ExchangeBar["TF_Count" + _loc1_].text = this.FChristmas3_2016.HeroGold[_loc1_].toString();
               FMC_Scene.MC_Exchange0.MC_ExchangeBar["TF_Num" + _loc1_].text = this.FChristmas3_2016.HeroScore[_loc1_].toString();
               _loc1_++;
            }
            _loc3_ = Number(this.FChristmas3_2016.TotalRechargeGold / this.FChristmas3_2016.HeroGold[this.FChristmas3_2016.HeroGold.length - 1]) * this.FExchangeBarMaxWidth;
            _loc4_ = Math.min(_loc3_,this.FExchangeBarMaxWidth);
            this.FMC_ExchangeMask0.width = _loc4_;
         }
         else if(this.FChangeTabIndex == TAB_PET)
         {
            FMC_Scene.MC_Exchange1.MC_ExchangeBar.TF_Count.text = this.FChristmas3_2016.TotalRechargeGold + "/" + this.FChristmas3_2016.PetGold[this.FChristmas3_2016.PetGold.length - 1];
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               FMC_Scene.MC_Exchange1.MC_ExchangeBar["TF_Count" + _loc1_].text = this.FChristmas3_2016.PetGold[_loc1_].toString();
               FMC_Scene.MC_Exchange1.MC_ExchangeBar["TF_Num" + _loc1_].text = this.FChristmas3_2016.PetScore[_loc1_].toString();
               _loc1_++;
            }
            _loc3_ = Number(this.FChristmas3_2016.TotalRechargeGold / this.FChristmas3_2016.ItemGold[this.FChristmas3_2016.ItemGold.length - 1]) * this.FExchangeBarMaxWidth;
            _loc4_ = Math.min(_loc3_,this.FExchangeBarMaxWidth);
            this.FMC_ExchangeMask1.width = _loc4_;
         }
         else
         {
            FMC_Scene.MC_Exchange2.MC_ExchangeBar.TF_Count.text = this.FChristmas3_2016.TotalRechargeGold + "/" + this.FChristmas3_2016.ItemGold[this.FChristmas3_2016.ItemGold.length - 1];
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               FMC_Scene.MC_Exchange2.MC_ExchangeBar["TF_Count" + _loc1_].text = this.FChristmas3_2016.ItemGold[_loc1_].toString();
               FMC_Scene.MC_Exchange2.MC_ExchangeBar["TF_Num" + _loc1_].text = this.FChristmas3_2016.ItemScore[_loc1_].toString();
               _loc1_++;
            }
            _loc3_ = Number(this.FChristmas3_2016.TotalRechargeGold / this.FChristmas3_2016.PetGold[this.FChristmas3_2016.PetGold.length - 1]) * this.FExchangeBarMaxWidth;
            _loc4_ = Math.min(_loc3_,this.FExchangeBarMaxWidth);
            this.FMC_ExchangeMask2.width = _loc4_;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmas3_2016.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmas3_2016.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FChristmas3_2016.DescListNew[1];
         FMC_Scene.TF_FreeCount.text = this.FChristmas3_2016.Count.toString();
         FMC_Scene.TF_Score.text = this.FChristmas3_2016.Score.toString();
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         this.UpdateTab();
         this.UpdateBar();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(!FIsPlaying && FOnGetBox != null) && Boolean(this.FChristmas3_2016) && this.FChristmas3_2016.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_GET_BOX);
         }
      }
      
      protected function ProcessorOnSweetUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(_loc2_ >= this.FChristmas3_2016.SweetList.length || this.FChristmas3_2016.SweetList[_loc2_].Status != TBaseActivity.STATUS_CANGET || FIsPlaying)
         {
            return;
         }
         FMC_Scene.MC_Click.visible = false;
         if(FOnBuyBox != null)
         {
            _loc3_ = this.FChristmas3_2016.SweetList[_loc2_];
            if(this.FChristmas3_2016.Count > 0)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_GET_SWEET,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_GET_SWEET,_loc3_.Price,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      protected function ProcessorOnTenUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            FMC_Scene.MC_Click.visible = false;
            FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_GET_TEN,this.FChristmas3_2016.TenPrice,0,TBaseActivity.SWEET_TYPE_GOLD);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(Boolean(FOnBuyBox != null) && Boolean(this.FChristmas3_2016) && Boolean(this.FChristmas3_2016.Hero))
         {
            _loc2_ = this.FChristmas3_2016.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FChristmas3_2016.Score >= this.FChristmas3_2016.GetCurHeroPrice())
            {
               _loc3_ = TUtilityString.Format(this.FChristmas3_2016.DescListNew[10],this.FChristmas3_2016.GetCurHeroPrice());
               _loc4_ = this.FChristmas3_2016.GetCurHeroLevel();
               if(_loc4_ < this.FChristmas3_2016.HeroGold.length - 1)
               {
                  _loc3_ += "\n" + TUtilityString.Format(this.FChristmas3_2016.DescListNew[11],this.FChristmas3_2016.TotalRechargeGold,this.FChristmas3_2016.HeroGold[_loc4_ + 1] - this.FChristmas3_2016.TotalRechargeGold,this.FChristmas3_2016.Hero.Price - this.FChristmas3_2016.HeroScore[_loc4_ + 1]);
               }
               FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_EXCHANGE_HERO,0,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnExchangePetUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(Boolean(FOnBuyBox != null) && Boolean(this.FChristmas3_2016) && Boolean(this.FChristmas3_2016.Pet))
         {
            _loc2_ = this.FChristmas3_2016.Pet;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FChristmas3_2016.Score >= this.FChristmas3_2016.GetCurPetPrice())
            {
               _loc3_ = TUtilityString.Format(this.FChristmas3_2016.DescListNew[10],this.FChristmas3_2016.GetCurPetPrice());
               _loc4_ = this.FChristmas3_2016.GetCurPetLevel();
               if(_loc4_ < this.FChristmas3_2016.PetGold.length - 1)
               {
                  _loc3_ += "\n" + TUtilityString.Format(this.FChristmas3_2016.DescListNew[11],this.FChristmas3_2016.TotalRechargeGold,this.FChristmas3_2016.PetGold[_loc4_ + 1] - this.FChristmas3_2016.TotalRechargeGold,this.FChristmas3_2016.Pet.Price - this.FChristmas3_2016.PetScore[_loc4_ + 1]);
               }
               FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_EXCHANGE_PET,0,0,0,_loc3_);
            }
         }
      }
      
      protected function ProcessorOnExchangeItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnBuyBox != null && this.FChristmas3_2016 && _loc2_ < this.FChristmas3_2016.ItemList.length) && Boolean(this.FChristmas3_2016.ItemList[_loc2_].LimitCount > 0) && this.FChristmas3_2016.Score >= this.FChristmas3_2016.GetCurItemPriceByIndex(_loc2_))
         {
            _loc3_ = TUtilityString.Format(this.FChristmas3_2016.DescListNew[10],this.FChristmas3_2016.GetCurItemPriceByIndex(_loc2_));
            _loc4_ = this.FChristmas3_2016.GetCurGiftLevelByIndex();
            if(_loc4_ < this.FChristmas3_2016.ItemGold.length - 1)
            {
               _loc3_ += "\n" + TUtilityString.Format(this.FChristmas3_2016.DescListNew[11],this.FChristmas3_2016.TotalRechargeGold,this.FChristmas3_2016.ItemGold[_loc4_ + 1] - this.FChristmas3_2016.TotalRechargeGold,this.FChristmas3_2016.ItemList[_loc2_].Price - this.FChristmas3_2016.ItemScore[_loc4_ + 1]);
            }
            FOnBuyBox(ACTIVITY_3_ID,TProcessorChristmas2016.ACTIVITY_3_EXCHANGE_ITEM,0,_loc2_ + 1,0,_loc3_);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FChristmas3_2016))
         {
            FOnShowHtmlTip(this.FChristmas3_2016.DescListNew[12]);
         }
      }
      
      protected function ProcessorOnPetOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FChristmas3_2016))
         {
            FOnShowHtmlTip(this.FChristmas3_2016.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnExchangeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FChristmas3_2016) && _loc2_ < this.FChristmas3_2016.ItemList.length)
         {
            FOnNewBoxOver(this.FChristmas3_2016.ItemList[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnTenOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FChristmas3_2016))
         {
            FOnShowHtmlTip(this.FChristmas3_2016.DescListNew[3]);
         }
      }
      
      protected function ProcessorOnSweetOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnShowHtmlTip != null && Boolean(this.FChristmas3_2016))
         {
            _loc3_ = this.FChristmas3_2016.DescListNew[4 + _loc2_];
            FOnShowHtmlTip(_loc3_);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FChristmas3_2016))
         {
            FOnNewBoxOver(this.FChristmas3_2016.Gift.Inventories);
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
            FOnLoadLog(ACTIVITY_3_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorOnShowHeroDesc(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FChristmas3_2016) && Boolean(this.FChristmas3_2016.Hero))
         {
            FOnShowRecruit(this.FChristmas3_2016.Hero.Identify,this.FChristmas3_2016.Hero.Type);
         }
      }
      
      protected function ProcessorOnShowPetDesc(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FChristmas3_2016) && Boolean(this.FChristmas3_2016.Pet))
         {
            FOnShowRecruit(this.FChristmas3_2016.Pet.Identify,this.FChristmas3_2016.Pet.Type);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < this.FItems.length)
            {
               if(this.FItems[_loc1_])
               {
                  this.FItems[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FChristmas3_2016 = SLogicsCore.ChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_3_ID) as TChristmas3_2016;
         this.UpdatePool();
         this.UpdateTab();
         this.UpdateBar();
         this.UpdateGift();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:MovieClip = null;
         var _loc7_:String = null;
         TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,false);
         _loc5_ = int(this.FChristmas3_2016.StatusList.length);
         if(_loc5_ > 0)
         {
            _loc3_ = this.FChristmas3_2016.IndexList[0] - 1;
            this.FChristmas3_2016.SweetList[_loc3_].Status = this.FChristmas3_2016.StatusList[0];
            _loc7_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
            if(_loc3_ <= 0)
            {
               _loc4_ = 4;
            }
            else
            {
               _loc4_ = _loc3_ - 1;
            }
            if(_loc4_ != 0)
            {
               this.FChristmas3_2016.SweetList[_loc4_].Status = TBaseActivity.STATUS_CANNOTGET;
            }
            if(this.FChristmas3_2016.AmountList[0] > 0)
            {
               this.FChristmas3_2016.ShopExchangePoint += this.FChristmas3_2016.AmountList[0];
               _loc7_ += TUtilityString.Format(this.FChristmas3_2016.DescListNew[9],this.FChristmas3_2016.AmountList[0],this.FChristmas3_2016.AmountList2[0]) + "\n";
               this.FChristmas3_2016.ChangeStatus();
            }
            if(FOnShowFlowText != null)
            {
               FOnShowFlowText(_loc7_);
            }
            this.UpdateUI();
            this.FChristmas3_2016.StatusList.shift();
            this.FChristmas3_2016.IndexList.shift();
            this.FChristmas3_2016.AmountList.shift();
            this.FChristmas3_2016.AmountList2.shift();
            setTimeout(this.PlayMovie,250);
         }
         else
         {
            FIsPlaying = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_TenGet,true);
         }
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
         super.Unmount();
         TweenUtil.removeAllTween();
         FIsPlaying = false;
      }
   }
}

