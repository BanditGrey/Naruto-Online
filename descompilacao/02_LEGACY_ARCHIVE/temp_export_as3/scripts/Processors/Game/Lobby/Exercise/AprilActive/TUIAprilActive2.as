package Processors.Game.Lobby.Exercise.AprilActive
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.AprilActive.TAprilActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIAprilActive2 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const SALE_ITEM:int = 8;
      
      protected static const LOG_COUNT:int = 5;
      
      protected static const EXCHANGE_BOX_COUNT:int = 4;
      
      protected static const SEED_COUNT:int = 3;
      
      protected static const TOOL_COUNT:int = 2;
      
      protected static const GIFT_COUNT:int = 4;
      
      protected static const SHOP_COUNT:int = 6;
      
      public static const MOVIE_OF_SUCCEED:int = 1;
      
      public static const MOVIE_OF_FAILED:int = 2;
      
      public static const MOVIE_OF_FRESH:int = 3;
      
      protected var FAprilActive2:TAprilActive2;
      
      protected var FTF_Time:TextField;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FSaleItems:Vector.<MovieClip>;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FSeedIndex:int;
      
      protected var FToolIndex:int;
      
      public function TUIAprilActive2(param1:TUIComponent)
      {
         super(param1);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FSaleItems = new Vector.<MovieClip>(SALE_ITEM);
         this.FSeedIndex = -1;
         this.FToolIndex = -1;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene["MC_Item" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            this.FExchangeList[_loc2_] = _loc4_;
            FMC_Scene["MC_Item" + _loc2_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SALE_ITEM)
         {
            _loc5_ = FMC_Scene["MC_Sale" + _loc2_];
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnSaleItemUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSaleOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSaleOut);
            this.FSaleItems[_loc2_] = _loc5_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SEED_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Seed" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_Icon.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnSeedUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSeedOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TOOL_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Tool" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.gotoAndStop(_loc2_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnToolUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnToolOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            _loc5_ = FMC_Scene["MC_Box" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < SHOP_COUNT)
         {
            param1 = FMC_Scene.MC_Shop["MC_Item" + _loc2_];
            param1.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         this.FTF_Time = FMC_Scene.TF_Time;
         FMC_Scene.MC_Shop.visible = false;
         FMC_Scene.MC_Movie0.visible = false;
         FMC_Scene.MC_Movie1.visible = false;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Play,true);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.CLICK,this.ProcessorOnPlayUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GoldFresh,true);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldFresh);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoldBtnOver);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Free,true);
         FMC_Scene.BTN_Free.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreeFresh);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_HeroDesc,true);
         FMC_Scene.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Shop,true);
         FMC_Scene.BTN_Shop.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowShopDesc);
         FMC_Scene.MC_Shop.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideShopDesc);
      }
      
      protected function UpdateSaleItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < SALE_ITEM)
         {
            _loc4_ = this.FSaleItems[_loc1_];
            if(_loc1_ < this.FAprilActive2.SaleItems.length)
            {
               _loc4_.visible = true;
               _loc3_ = this.FAprilActive2.SaleItems[_loc1_];
               _loc2_ = _loc3_.Type - 1;
               _loc4_.MC_Item.MC_Icon.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FAprilActive2.AllItems[_loc2_].Inventories.GetInventoryByIndex(0);
               _loc4_.TF_Name.text = "*" + _loc5_.Quantity;
               _loc4_.TF_CurPrice.text = this.FAprilActive2.AllItems[_loc2_].Price;
               _loc4_.MC_Tip.visible = false;
               if(_loc3_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.filters = [TGameUtil.GaryColorFilters];
               }
               else
               {
                  _loc4_.filters = [];
               }
               if(this.FAprilActive2.AllItems[_loc2_].Level == 0)
               {
                  _loc4_.MC_Item.MC_Effect.visible = false;
               }
               else
               {
                  _loc4_.MC_Item.MC_Effect.visible = true;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FAprilActive2.Hero;
         FMC_Scene.TF_Price.text = _loc1_.Price.toString();
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Exchange.visible = false;
         }
         else if(this.FAprilActive2.MyScore >= _loc1_.Price)
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc3_ = _loc1_;
            if(_loc3_ < this.FAprilActive2.ExchangeItems.length)
            {
               this.FExchangeList[_loc1_].SetVisible(true);
               _loc5_ = this.FAprilActive2.ExchangeItems[_loc3_];
               this.FExchangeList[_loc1_].UpdateUI(_loc5_.Inventories);
               this.FExchangeList[_loc1_].Identify = _loc3_;
               _loc4_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.LimitCount.toString());
               this.FExchangeList[_loc1_].SetLimitText(_loc4_);
               _loc4_ = _loc5_.Price.toString();
               this.FExchangeList[_loc1_].SetPriceText(_loc4_);
               if(_loc5_.Type == 0)
               {
                  if(this.FAprilActive2.MyScore < _loc5_.Price || _loc5_.LimitCount <= 0)
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
                  }
                  this.FExchangeList[_loc1_].MC_Tag.visible = false;
               }
               else
               {
                  if(this.FAprilActive2.MyScore < _loc5_.Price || _loc5_.LimitCount <= 0)
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
                  }
                  if(this.FAprilActive2.Hero.Status == TBaseActivity.STATUS_GETED)
                  {
                     this.FExchangeList[_loc1_].MC_Tag.visible = false;
                  }
                  else
                  {
                     this.FExchangeList[_loc1_].MC_Tag.visible = true;
                  }
               }
               if(_loc5_.LimitCount == 0)
               {
                  this.FExchangeList[_loc1_].SetMCIsVisible("MC_Got",true);
                  this.FExchangeList[_loc1_].SetMCIsVisible("BTN_Exchange",false);
               }
               else
               {
                  this.FExchangeList[_loc1_].SetMCIsVisible("MC_Got",false);
                  this.FExchangeList[_loc1_].SetMCIsVisible("BTN_Exchange",true);
               }
            }
            else
            {
               this.FExchangeList[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FAprilActive2.FreshTime > STimingCore.GetServerTick())
         {
            FMC_Scene.BTN_GoldFresh.visible = true;
            FMC_Scene.BTN_Free.visible = false;
         }
         else
         {
            FMC_Scene.BTN_GoldFresh.visible = false;
            FMC_Scene.BTN_Free.visible = true;
         }
      }
      
      protected function UpdateSeed() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < SEED_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Seed" + _loc1_];
            _loc2_.TF_Count.text = "*" + this.FAprilActive2.SeedList[_loc1_];
            if(_loc1_ == this.FSeedIndex)
            {
               _loc2_.MC_Icon.MC_Select.visible = true;
            }
            else
            {
               _loc2_.MC_Icon.MC_Select.visible = false;
            }
            if(this.FAprilActive2.SeedList[_loc1_] > 0)
            {
               _loc3_ = true;
            }
            _loc1_++;
         }
         if(_loc3_)
         {
            FMC_Scene.BTN_Play.visible = true;
            FMC_Scene.MC_Context.visible = false;
         }
         else
         {
            FMC_Scene.BTN_Play.visible = false;
            FMC_Scene.MC_Context.visible = true;
         }
         if(this.FSeedIndex == -1)
         {
            FMC_Scene.MC_Arrow0.visible = true;
         }
         else
         {
            FMC_Scene.MC_Arrow0.visible = false;
         }
      }
      
      protected function UpdateTool() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < TOOL_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Tool" + _loc1_];
            _loc2_.TF_Count.text = "*" + this.FAprilActive2.ToolList[_loc1_].Count;
            if(_loc1_ == this.FToolIndex)
            {
               _loc2_.gotoAndStop(_loc1_ + TOOL_COUNT + 1);
            }
            else
            {
               _loc2_.gotoAndStop(_loc1_ + 1);
            }
            _loc1_++;
         }
         if(this.FToolIndex == -1)
         {
            FMC_Scene.MC_Arrow1.visible = true;
         }
         else
         {
            FMC_Scene.MC_Arrow1.visible = false;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_ = this.FAprilActive2.BoxList[_loc1_];
            _loc2_.TF_Count.text = "*" + _loc3_.Count;
            _loc2_.TF_Desc.text = TUtilityString.Format(this.FAprilActive2.DescListNew[16 + _loc1_],_loc3_.BuyCount % _loc3_.Price,_loc3_.Price);
            if(_loc1_ == GIFT_COUNT - 1)
            {
               if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc2_.MC_Got.visible = false;
               }
               else
               {
                  _loc2_.MC_Got.visible = true;
               }
            }
            if(_loc3_.Count > 0)
            {
               _loc2_.MC_Click.visible = true;
            }
            else
            {
               _loc2_.MC_Click.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateLog() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         var _loc3_:TLotteryNews = null;
         var _loc4_:int = 0;
         var _loc5_:TBaseBox = null;
         var _loc6_:String = null;
         _loc4_ = 0;
         while(_loc4_ < LOG_COUNT)
         {
            if(_loc4_ < this.FAprilActive2.AllLogs.length)
            {
               FMC_Scene["TF_Log" + _loc4_].visible = true;
               _loc3_ = this.FAprilActive2.AllLogs[_loc4_];
               _loc6_ = STRING_COMMON.GetItemNameByType(_loc3_.Identifier0,_loc3_.Identifier1);
               _loc1_ = TUtilityString.Format(this.FAprilActive2.DescListNew[2],_loc3_.PlayerNick,_loc6_);
               FMC_Scene["TF_Log" + _loc4_].text = _loc1_;
            }
            else
            {
               FMC_Scene["TF_Log" + _loc4_].visible = false;
            }
            _loc4_++;
         }
      }
      
      protected function UpdateShop() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < SHOP_COUNT)
         {
            _loc2_ = FMC_Scene.MC_Shop["MC_Item" + _loc1_];
            _loc2_.TF_Desc.text = this.FAprilActive2.DescListNew[_loc1_ + 22];
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FAprilActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FAprilActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FAprilActive2.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FAprilActive2.MyScore.toString();
      }
      
      protected function ProcessorOnFreeFresh(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && this.FAprilActive2) && Boolean(!FIsPlaying) && this.FAprilActive2.FreshTime <= STimingCore.GetServerTick())
         {
            if(this.FAprilActive2.HaveExpensive())
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_FREE_FRESH,0,0,0,this.FAprilActive2.DescListNew[29]);
            }
            else
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_FREE_FRESH);
            }
         }
      }
      
      protected function ProcessorOnGoldFresh(param1:MouseEvent) : void
      {
         if(Boolean(FOnBuyBox != null) && Boolean(this.FAprilActive2) && !FIsPlaying)
         {
            if(this.FAprilActive2.HaveExpensive())
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_GOLD_FRESH,this.FAprilActive2.FreshCost,0,0,this.FAprilActive2.DescListNew[29]);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_GOLD_FRESH,this.FAprilActive2.FreshCost);
            }
         }
      }
      
      protected function ProcessorOnSeedUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FAprilActive2.SeedList[_loc3_] <= 0)
         {
            FOnShowFlowText(this.FAprilActive2.DescListNew[20]);
            return;
         }
         this.FSeedIndex = _loc3_;
         this.UpdateUI();
      }
      
      protected function ProcessorOnToolUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = int(String(param1.currentTarget.name).slice(7));
         this.FToolIndex = this.FToolIndex == _loc3_ ? -1 : _loc3_;
         this.UpdateUI();
      }
      
      protected function ProcessorOnPlayUp(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this.FSeedIndex < 0)
         {
            FOnShowFlowText(this.FAprilActive2.DescListNew[21]);
            return;
         }
         _loc3_ = this.FSeedIndex;
         if(this.FAprilActive2.SeedList[_loc3_] <= 0)
         {
            FOnShowFlowText(this.FAprilActive2.DescListNew[20]);
            return;
         }
         if(Boolean(FOnBuyBox != null) && Boolean(this.FAprilActive2) && !FIsPlaying)
         {
            if(this.FToolIndex >= 0)
            {
               if(this.FAprilActive2.ToolList[this.FToolIndex].Count > 0)
               {
                  FOnGetBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_PLAY_GAME,this.FSeedIndex + 1,this.FToolIndex + 1);
               }
               else
               {
                  _loc4_ = this.FAprilActive2.ToolList[this.FToolIndex].Price;
                  _loc2_ = this.FAprilActive2.DescListNew[7 + this.FToolIndex];
                  FOnBuyBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_PLAY_GAME,_loc4_,this.FSeedIndex + 1,0,_loc2_,this.FToolIndex + 1);
               }
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_PLAY_GAME,0,this.FSeedIndex + 1,0,this.FAprilActive2.DescListNew[28],0,1);
            }
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(FOnGetBox != null && _loc2_ < this.FAprilActive2.BoxList.length && this.FAprilActive2.BoxList[_loc2_].Count > 0)
         {
            if(_loc2_ < 3)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_GET_BOX,_loc2_ + 1);
            }
            else
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_GET_SPECIAL_BOX,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnGoldBtnOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(FOnShowHtmlTip != null)
         {
            _loc2_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_COST_GOLD,this.FAprilActive2.FreshCost);
            FOnShowHtmlTip(_loc2_);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FAprilActive2))
         {
            _loc2_ = this.FAprilActive2.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FAprilActive2.MyScore >= _loc2_.Price)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_EXCHANGE_HERO);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(!FIsPlaying && FOnGetBox != null && this.FAprilActive2 && _loc3_ < this.FAprilActive2.ExchangeItems.length) && Boolean(this.FAprilActive2.ExchangeItems[_loc3_].LimitCount > 0) && this.FAprilActive2.MyScore >= this.FAprilActive2.ExchangeItems[_loc3_].Price)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_EXCHANGE_ITEM,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnSaleItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(FOnBuyBox != null && _loc2_ < this.FAprilActive2.SaleItems.length && this.FAprilActive2.SaleItems[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            _loc3_ = this.FAprilActive2.SaleItems[_loc2_].Type - 1;
            FOnBuyBox(ACTIVITY_2_ID,TProcessorAprilActive.ACTIVITY_2_BUY_SEED,this.FAprilActive2.AllItems[_loc3_].Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSaleOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(this.FAprilActive2) && Boolean(_loc2_ < this.FAprilActive2.SaleItems.length) && this.FAprilActive2.SaleItems[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            this.FSaleItems[_loc2_].filters = [TGameUtil.highLightFilters];
            this.FSaleItems[_loc2_].MC_Tip.visible = true;
         }
      }
      
      protected function ProcessorOnSaleOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(this.FAprilActive2) && Boolean(_loc2_ < this.FAprilActive2.SaleItems.length) && this.FAprilActive2.SaleItems[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            this.FSaleItems[_loc2_].filters = [];
            this.FSaleItems[_loc2_].MC_Tip.visible = false;
         }
      }
      
      protected function ProcessorOnSaleItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FAprilActive2.SaleItems.length && this.FAprilActive2.SaleItems[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            _loc3_ = this.FAprilActive2.SaleItems[_loc2_].Type - 1;
            FOnNewBoxOver(this.FAprilActive2.AllItems[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnAllItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FAprilActive2.SaleItems.length && this.FAprilActive2.SaleItems[_loc2_].Status != TBaseActivity.STATUS_GETED)
         {
            _loc3_ = this.FAprilActive2.SaleItems[_loc2_].Type - 1;
            FOnNewBoxOver(this.FAprilActive2.AllItems[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnSeedOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FAprilActive2.SeedList.length)
         {
            FOnShowHtmlTip(this.FAprilActive2.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnToolOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FAprilActive2.ToolList.length)
         {
            FOnShowHtmlTip(this.FAprilActive2.DescListNew[12 + _loc2_]);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(FOnNewBoxOver != null && _loc2_ < this.FAprilActive2.BoxList.length)
         {
            if(_loc2_ == this.FAprilActive2.BoxList.length - 1)
            {
               FOnShowHtmlTip(this.FAprilActive2.DescListNew[14]);
            }
            else
            {
               FOnNewBoxOver(this.FAprilActive2.BoxList[_loc2_].Inventories);
            }
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(FOnNewBoxOver != null && _loc2_ < this.FAprilActive2.BoxList.length)
         {
            if(_loc2_ == this.FAprilActive2.BoxList.length - 1)
            {
               FOnHideHtmlTip();
            }
            else
            {
               FOnNewBoxOut();
            }
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FAprilActive2) && Boolean(this.FAprilActive2.Hero))
         {
            _loc2_ = this.FAprilActive2.Hero;
            FOnShowRecruit(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null && Boolean(this.FAprilActive2))
         {
            FOnShowHtmlTip(this.FAprilActive2.DescListNew[15]);
         }
      }
      
      protected function ProcessorOnShowShopDesc(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Shop.visible = true;
      }
      
      protected function ProcessorOnHideShopDesc(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Shop.visible = false;
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
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
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FTF_Time)
            {
               this.FTF_Time.text = TGameUtil.fomatTime(this.FAprilActive2.FreshTime - STimingCore.GetServerTick());
               if(this.FAprilActive2.FreshTime <= STimingCore.GetServerTick())
               {
                  this.UpdateBtn();
               }
            }
            _loc1_ = 0;
            while(_loc1_ < EXCHANGE_BOX_COUNT)
            {
               if(this.FExchangeList[_loc1_])
               {
                  this.FExchangeList[_loc1_].LogicsPerform();
               }
               _loc1_++;
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_SUCCEED:
                     CurFrame = FMC_Scene.MC_Movie0.currentFrame;
                     break;
                  case MOVIE_OF_FAILED:
                     CurFrame = FMC_Scene.MC_Movie1.currentFrame;
                     break;
                  case MOVIE_OF_FRESH:
                     CurFrame = this.FSaleItems[FDoneIndex].currentFrame;
               }
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FAprilActive2 = SLogicsCore.AprilActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TAprilActive2;
         this.UpdateSaleItem();
         this.UpdateHero();
         this.UpdateExchange();
         this.UpdateBtn();
         this.UpdateLog();
         this.UpdateSeed();
         this.UpdateTool();
         this.UpdateGift();
         this.UpdateShop();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_SUCCEED)
         {
            _loc3_ = FMC_Scene.MC_Movie0;
            _loc3_.visible = true;
            FTotalFrame = _loc3_.totalFrames;
            _loc3_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_FAILED)
         {
            _loc3_ = FMC_Scene.MC_Movie1;
            _loc3_.visible = true;
            FTotalFrame = _loc3_.totalFrames;
            _loc3_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_FRESH)
         {
            _loc4_ = 0;
            while(_loc4_ < this.FSaleItems.length)
            {
               _loc3_ = FMC_Scene["MC_Sale" + _loc4_];
               FTotalFrame = _loc3_.totalFrames;
               _loc3_.gotoAndPlay(1);
               _loc4_++;
            }
            FDoneIndex = _loc4_ - 1;
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_SUCCEED)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FAILED)
         {
            FMC_Scene.MC_Movie1.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_FRESH)
         {
            _loc2_ = 0;
            while(_loc2_ < this.FSaleItems.length)
            {
               _loc1_ = FMC_Scene["MC_Sale" + _loc2_];
               _loc1_.gotoAndStop(1);
               _loc2_++;
            }
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         FDoneIndex = param1;
      }
   }
}

