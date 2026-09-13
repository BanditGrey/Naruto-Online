package Processors.Game.Lobby.Exercise.NinjaFund
{
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.NinjaFund.TNinjaFund;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNinjaFund;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjaFund extends TProcessorBaseActivity
   {
      
      public static const FUND_TYPE:int = 3;
      
      public static const FUND_COUNT:int = 5;
      
      public static const FOOD_COUNT:int = 4;
      
      public static const SALE_COUNT:int = 4;
      
      public static const ACTIVITY_1_GET_RECHARGE_BOX:int = 1;
      
      public static const ACTIVITY_1_FEED:int = 2;
      
      public static const ACTIVITY_1_BUY_ITEM:int = 3;
      
      public static const ACTIVITY_1_FREE_FRESH:int = 4;
      
      public static const ACTIVITY_1_GOLD_FRESH:int = 5;
      
      public static const ACTIVITY_1_GET_GIFT:int = 6;
      
      public static const MOVIE_FOOD:int = 1;
      
      public static const MOVIE_UPGRADE_SUCCESS:int = 2;
      
      public static const MOVIE_UPGRADE_FAIL:int = 3;
      
      public static const MOVIE_TOUCH:int = 4;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FNinjaFund:TNinjaFund;
      
      protected var FUnstreamizerNinjaFund:TUnstreamizerNinjaFund;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FIsCD:Boolean;
      
      protected var FFoodIndex:int;
      
      protected var FFundIndex:int;
      
      public function TProcessorNinjaFund(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNinjaFund = SLogicsCore.NinjaFund;
         this.FUnstreamizerNinjaFund = new TUnstreamizerNinjaFund(param3);
         this.FBuyBoxDate = new Object();
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FFoodIndex = -1;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < FUND_TYPE)
         {
            TGameUtil.setButtonMode(FMC_Scene["MC_Fund" + _loc1_].BTN_Feed,true);
            FMC_Scene["MC_Fund" + _loc1_].BTN_Feed.addEventListener(MouseEvent.CLICK,this.ProcessorOnFeedUp);
            _loc1_++;
         }
         this.FMC_Mask = FMC_Scene.MC_Fund0.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         _loc1_ = 0;
         while(_loc1_ < FOOD_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Food" + _loc1_];
            _loc4_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc4_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFoodOver);
            _loc4_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            TGameUtil.setButtonMode(_loc4_.BTN_Select,true);
            _loc4_.BTN_Select.addEventListener(MouseEvent.CLICK,this.ProcessorOnFoodUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SALE_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Item" + _loc1_];
            TGameUtil.setButtonMode(_loc4_.BTN_Buy,true);
            _loc4_.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyItemUp);
            _loc4_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnItemOver);
            _loc4_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FUND_TYPE)
         {
            _loc4_ = FMC_Scene.MC_Desc["MC_Fund" + _loc1_];
            _loc4_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc2_ = 0;
            while(_loc2_ < FUND_COUNT)
            {
               _loc5_ = _loc4_["MC_Box" + _loc2_];
               _loc5_.MC_Level.gotoAndStop(_loc1_ + 1);
               _loc5_.MC_Icon.gotoAndStop(_loc2_ + FUND_COUNT * _loc1_ + 1);
               _loc5_.MC_Icon.addEventListener(MouseEvent.CLICK,this.ProcessorOnFundGiftUp);
               _loc5_.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFundGiftOver);
               _loc5_.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
               _loc2_++;
            }
            _loc1_++;
         }
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeBoxOver);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_FreeFresh,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GoldFresh,true);
         FMC_Scene.BTN_FreeFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnFreeFreshAllUp);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoldFreshAllUp);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGoldFreshOver);
         FMC_Scene.BTN_GoldFresh.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Desc.visible = false;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         FMC_Scene.BTN_FundDesc.buttonMode = true;
         FMC_Scene.BTN_FundDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnFundDescUp);
         FMC_Scene.MC_Desc.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnHideFundDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(Boolean(FTF_Time) && Boolean(this.FNinjaFund))
            {
               _loc3_ = this.FNinjaFund.NextTime - STimingCore.GetServerTick();
               FTF_Time.text = TGameUtil.fomatTime(_loc3_);
               if(_loc3_ <= 0 && this.FIsCD || _loc3_ > 0 && !this.FIsCD)
               {
                  this.FIsCD = _loc3_ <= 0 ? false : true;
                  this.UpdateBtn();
               }
            }
            if(this.FIsPlaying)
            {
               _loc2_ = int(FMC_Scene["MC_Fund" + this.FFundIndex]["MC_Movie" + this.FMovieType].currentFrame);
               if(_loc2_ == this.FTotalFrame)
               {
                  this.FIsPlaying = false;
                  this.FFrameCount = 0;
                  this.MovieEnd();
               }
               else
               {
                  ++this.FFrameCount;
                  if(this.FFrameCount > 100)
                  {
                     this.FIsPlaying = false;
                     this.FFrameCount = 0;
                     this.UpdateUI();
                  }
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateRechargeBox();
         this.UpdateFund();
         this.UpdateFood();
         this.UpdateSales();
         this.UpdateBtn();
         this.UpdateFundDesc();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FNinjaFund);
         }
      }
      
      protected function UpdateRechargeBox() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         _loc1_ = FMC_Scene.MC_Box;
         _loc1_.TF_Count.text = "*" + this.FNinjaFund.RechargeGift.Count;
         _loc1_.TF_Desc.text = TUtilityString.Format(this.FNinjaFund.DescListNew[2],this.FNinjaFund.TotalRechargeGold % this.FNinjaFund.RechargeGift.Price,this.FNinjaFund.RechargeGift.Price);
         if(this.FNinjaFund.RechargeGift.Count > 0)
         {
            _loc1_.MC_Click.visible = true;
            _loc1_.MC_Click.play();
         }
         else
         {
            _loc1_.MC_Click.visible = false;
            _loc1_.MC_Click.stop();
         }
      }
      
      protected function UpdateFund() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:TInventory = null;
         _loc4_ = 0;
         while(_loc4_ < FUND_TYPE)
         {
            _loc1_ = FMC_Scene["MC_Fund" + _loc4_];
            _loc1_.MC_Movie0.visible = false;
            _loc1_.MC_Movie1.visible = false;
            _loc1_.MC_Movie2.visible = false;
            _loc2_ = this.FNinjaFund.Funds[_loc4_];
            _loc5_ = _loc2_.Level;
            _loc3_ = this.FNinjaFund.GetFundDataByIndex(_loc5_,_loc4_);
            _loc8_ = _loc3_.Inventories.GetInventoryByIndex(0);
            _loc6_ = _loc3_.Count;
            _loc1_.TF_Desc0.text = TUtilityString.Format(this.FNinjaFund.DescListNew[3],_loc8_.Name,_loc8_.Quantity);
            _loc1_.TF_Desc1.text = TUtilityString.Format(this.FNinjaFund.DescListNew[4],_loc6_,_loc8_.Name,_loc8_.Quantity * _loc6_);
            _loc1_.TF_Level.text = TUtilityString.Format(this.FNinjaFund.DescListNew[5],_loc5_);
            _loc1_.TF_Return.text = TUtilityString.Format(this.FNinjaFund.DescListNew[6],_loc3_.Discount);
            _loc1_.MC_Icon.gotoAndStop(_loc5_ + FUND_COUNT * _loc4_);
            if(_loc2_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc1_.MC_Tag.visible = true;
               _loc1_.MC_Tag.TF_Text.text = TUtilityString.Format(this.FNinjaFund.DescListNew[7],_loc2_.Price);
               _loc1_.MC_Icon.filters = [TGameUtil.GaryColorFilters];
               TGameUtil.setButtonMode(_loc1_.BTN_Feed,false);
            }
            else
            {
               _loc1_.MC_Tag.visible = false;
               _loc1_.MC_Icon.filters = [];
               TGameUtil.setButtonMode(_loc1_.BTN_Feed,true);
            }
            _loc1_.MC_Bar.TF_Count.text = _loc3_.Min + "/" + _loc3_.Max;
            _loc7_ = Number(_loc3_.Min / _loc3_.Max) * this.FBarMaxWidth;
            _loc1_.MC_Bar.MC_Mask.width = Math.min(_loc7_,this.FBarMaxWidth);
            if(_loc3_.Max == 0)
            {
               _loc1_.MC_Max.visible = true;
               _loc1_.BTN_Feed.visible = false;
            }
            else
            {
               _loc1_.MC_Max.visible = false;
               _loc1_.BTN_Feed.visible = true;
            }
            _loc4_++;
         }
      }
      
      public function UpdateFood() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         if(this.FFoodIndex >= 0 && this.FNinjaFund.FoodList[this.FFoodIndex] <= 0)
         {
            this.FFoodIndex = -1;
         }
         _loc4_ = 0;
         while(_loc4_ < FOOD_COUNT)
         {
            _loc1_ = FMC_Scene["MC_Food" + _loc4_];
            _loc1_.TF_Count.text = "*" + this.FNinjaFund.FoodList[_loc4_];
            if(this.FNinjaFund.FoodList[_loc4_] > 0)
            {
               TGameUtil.setButtonMode(_loc1_.BTN_Select,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc1_.BTN_Select,false);
            }
            _loc1_.MC_Select.visible = _loc4_ == this.FFoodIndex ? true : false;
            _loc4_++;
         }
      }
      
      public function UpdateSales() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < SALE_COUNT)
         {
            _loc1_ = FMC_Scene["MC_Item" + _loc3_];
            _loc2_ = this.FNinjaFund.SaleItems[_loc3_];
            _loc1_.TF_Count.text = "*" + _loc2_.Count;
            _loc1_.TF_Price.text = _loc2_.Price.toString();
            _loc1_.MC_Icon.gotoAndStop(_loc2_.Type);
            if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc1_.BTN_Buy.visible = false;
               _loc1_.MC_Got.visible = true;
            }
            else
            {
               _loc1_.BTN_Buy.visible = true;
               _loc1_.MC_Got.visible = false;
            }
            _loc3_++;
         }
         FMC_Scene.TF_RefreshCount.text = TUtilityString.Format(this.FNinjaFund.DescListNew[14],this.FNinjaFund.FreshCount);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GoldFresh,this.FNinjaFund.FreshCount > 0 ? true : false);
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FIsCD)
         {
            FMC_Scene.BTN_FreeFresh.visible = false;
            FMC_Scene.BTN_GoldFresh.visible = true;
         }
         else
         {
            FMC_Scene.BTN_FreeFresh.visible = true;
            FMC_Scene.BTN_GoldFresh.visible = false;
         }
      }
      
      protected function UpdateFundDesc() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         var _loc6_:TBaseBox = null;
         var _loc7_:TInventory = null;
         var _loc8_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FUND_TYPE)
         {
            _loc3_ = FMC_Scene.MC_Desc["MC_Fund" + _loc1_];
            _loc5_ = this.FNinjaFund.Funds[_loc1_];
            _loc3_.TF_Return.text = this.FNinjaFund.TotalFundDatas[(_loc1_ + 1) * FUND_COUNT - 1].Discount + "%";
            _loc2_ = 0;
            while(_loc2_ < FUND_COUNT)
            {
               _loc6_ = this.FNinjaFund.GetFundDataByIndex(_loc2_ + 1,_loc1_);
               _loc7_ = _loc6_.Inventories.GetInventoryByIndex(0);
               _loc8_ = _loc6_.Count;
               _loc4_ = _loc3_["MC_Box" + _loc2_];
               _loc4_.TF_Desc0.text = TUtilityString.Format(this.FNinjaFund.DescListNew[3],_loc7_.Name,_loc7_.Quantity);
               _loc4_.TF_Desc1.text = TUtilityString.Format(this.FNinjaFund.DescListNew[4],_loc8_,_loc7_.Name,_loc7_.Quantity * _loc8_);
               if(_loc3_["TF_Exp" + _loc2_])
               {
                  _loc3_["TF_Exp" + _loc2_].text = TUtilityString.Format(this.FNinjaFund.DescListNew[16],_loc6_.Min,_loc6_.Max);
               }
               if(_loc6_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_Click.visible = true;
                  _loc4_.MC_Got.visible = false;
               }
               else if(_loc6_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.MC_Click.visible = false;
                  _loc4_.MC_Got.visible = false;
               }
               else
               {
                  _loc4_.MC_Click.visible = false;
                  _loc4_.MC_Got.visible = true;
               }
               if(_loc4_.MC_Level)
               {
                  _loc4_.MC_Level.visible = _loc5_.Level == _loc2_ + 1 ? true : false;
               }
               _loc2_++;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaFund.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaFund.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FNinjaFund.DescListNew[1];
         FMC_Scene.TF_RechargeGold.text = this.FNinjaFund.TotalRechargeGold.toString();
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(!this.FIsPlaying) && Boolean(this.FNinjaFund) && this.FNinjaFund.RechargeGift.Count > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_RECHARGE_BOX);
         }
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         if(this.FNinjaFund)
         {
            ProcessorOnShowHtmlText(this.FNinjaFund.DescListNew[17]);
         }
      }
      
      protected function ProcessorOnFeedUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FFoodIndex == -1)
         {
            ProcessorEffectText(this.FNinjaFund.DescListNew[8]);
            return;
         }
         if(Boolean(!this.FIsPlaying) && Boolean(this.FNinjaFund) && this.FNinjaFund.FoodList[this.FFoodIndex] > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_FEED,this.FFoodIndex + 1,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnFoodUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         this.FFoodIndex = _loc2_;
         this.UpdateFood();
      }
      
      protected function ProcessorOnFoodOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FNinjaFund)
         {
            ProcessorOnShowHtmlText(this.FNinjaFund.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnBuyItemUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FNinjaFund)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_ITEM,this.FNinjaFund.SaleItems[_loc2_].Price,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnItemOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(this.FNinjaFund)
         {
            _loc2_ = this.FNinjaFund.SaleItems[_loc2_].Type - 1;
            ProcessorOnShowHtmlText(this.FNinjaFund.DescListNew[9 + _loc2_]);
         }
      }
      
      protected function ProcessorOnFreeFreshAllUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FNinjaFund)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_FREE_FRESH);
         }
      }
      
      protected function ProcessorOnGoldFreshAllUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FNinjaFund)
         {
            _loc2_ = this.FNinjaFund.FreshPrice;
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_GOLD_FRESH,_loc2_);
         }
      }
      
      protected function ProcessorOnGoldFreshOver(param1:MouseEvent) : void
      {
         if(this.FNinjaFund)
         {
            ProcessorOnShowHtmlText(this.FNinjaFund.DescListNew[13]);
         }
      }
      
      protected function ProcessorOnFundGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
         if(Boolean(this.FNinjaFund) && this.FNinjaFund.TotalFundDatas[_loc2_ + _loc3_ * FUND_COUNT].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_GIFT,_loc3_ + 1,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnFundGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         _loc3_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
         if(this.FNinjaFund)
         {
            _loc4_ = this.FNinjaFund.TotalFundDatas[_loc2_ + _loc3_ * FUND_COUNT].Items;
            ProcessorOnNewBoxOver(_loc4_);
         }
      }
      
      protected function ProcessorOnFundDescUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Desc.visible = true;
      }
      
      protected function ProcessorOnHideFundDesc(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Desc.visible = false;
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
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FNinjaFund);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
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
         FProcessorWindowDesc.BaseActivity = this.FNinjaFund;
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
            this.FProcessorFebActiveShop.Load();
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
         this.FUnstreamizerNinjaFund.Unstreamize(_loc2_,this.FNinjaFund,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
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
         if(this.FNinjaFund)
         {
            _loc4_ = 0;
            while(_loc4_ < this.FNinjaFund.Funds.length)
            {
               this.FNinjaFund.Funds[_loc4_].Status = _loc2_.readInt();
               _loc4_++;
            }
            this.FNinjaFund.TotalRechargeGold = _loc2_.readUnsignedInt();
            this.FNinjaFund.RechargeGift.Count = _loc2_.readUnsignedInt();
            this.FNinjaFund.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FNinjaFund.CheckStatus());
            if(this.FIsOpen)
            {
               this.UpdateUI();
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
         ProcessorUnstreamActivityLog(this.FNinjaFund,_loc2_);
      }
      
      override public function ProcessorAllRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TInventories = null;
         var _loc10_:TInventory = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:TBaseBox = null;
         var _loc15_:uint = 0;
         var _loc16_:TBins = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:uint = 0;
         var _loc22_:Vector.<uint> = null;
         var _loc23_:Vector.<uint> = null;
         var _loc24_:String = null;
         _loc16_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Article);
         this.FBeClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc8_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc8_)
         {
            case ACTIVITY_1_GET_RECHARGE_BOX:
               --this.FNinjaFund.RechargeGift.Count;
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < _loc17_)
               {
                  _loc11_ = _loc2_.readUnsignedInt();
                  _loc12_ = _loc2_.readUnsignedInt();
                  _loc13_ = _loc2_.readUnsignedInt();
                  _loc4_ += STRING_COMMON.GetItemNameByType(_loc11_,_loc12_) + "*" + _loc13_ + "\n";
                  _loc11_ = _loc2_.readUnsignedInt();
                  if(_loc11_ != 0)
                  {
                     this.FNinjaFund.FoodList[_loc11_ - 1] += _loc13_;
                  }
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FNinjaFund.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNinjaFund.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FEED:
               this.FFundIndex = _loc2_.readUnsignedInt() - 1;
               --this.FNinjaFund.FoodList[this.FFoodIndex];
               _loc11_ = uint(this.FFoodIndex);
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc14_ = this.FNinjaFund.GetFundDataByIndex(this.FNinjaFund.Funds[this.FFundIndex].Level,this.FFundIndex);
               _loc14_.Min = _loc2_.readUnsignedInt();
               this.FNinjaFund.Funds[this.FFundIndex].Level = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FNinjaFund.TotalFundDatas.length)
               {
                  this.FNinjaFund.TotalFundDatas[_loc5_].Status = _loc2_.readInt();
                  _loc5_++;
               }
               _loc4_ = TUtilityString.Format(this.FNinjaFund.DescListNew[15],_loc17_);
               ProcessorEffectText(_loc4_);
               this.FNinjaFund.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNinjaFund.CheckStatus());
               if(_loc11_ == 0)
               {
                  this.UpdateUI();
               }
               else
               {
                  this.PlayMovie(this.FFundIndex,_loc11_ - 1);
               }
               break;
            case ACTIVITY_1_BUY_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNinjaFund.SaleItems[_loc5_].Status = TBaseActivity.STATUS_GETED;
               this.FNinjaFund.AddItem(_loc5_);
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.FNinjaFund.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNinjaFund.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FREE_FRESH:
            case ACTIVITY_1_GOLD_FRESH:
               this.FNinjaFund.SaleItems.length = 0;
               _loc5_ = 0;
               while(_loc5_ < SALE_COUNT)
               {
                  _loc14_ = new TBaseBox();
                  _loc14_.Status = TBaseActivity.STATUS_CANNOTGET;
                  _loc14_.Price = _loc2_.readInt();
                  _loc14_.Type = _loc2_.readInt();
                  _loc14_.Count = _loc2_.readUnsignedInt();
                  this.FNinjaFund.SaleItems[_loc5_] = _loc14_;
                  _loc5_++;
               }
               this.FNinjaFund.NextTime = _loc2_.readInt();
               this.FNinjaFund.FreshCount = _loc2_.readUnsignedInt();
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED);
               this.FNinjaFund.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNinjaFund.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_GIFT:
               _loc6_ = _loc2_.readUnsignedInt() - 1;
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNinjaFund.TotalFundDatas[_loc5_ + _loc6_ * FUND_COUNT].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc7_ = 0;
               while(_loc7_ < this.FNinjaFund.TotalFundDatas[_loc5_ + _loc6_ * FUND_COUNT].Items.Count)
               {
                  _loc10_ = this.FNinjaFund.TotalFundDatas[_loc5_ + _loc6_ * FUND_COUNT].Items.GetInventoryByIndex(_loc7_);
                  _loc4_ += _loc10_.Name + "*" + _loc10_.Quantity + "\n";
                  _loc7_++;
               }
               ProcessorEffectText(_loc4_);
               this.FNinjaFund.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNinjaFund.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:int = 0) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param2;
         _loc3_ = FMC_Scene["MC_Fund" + param1]["MC_Movie" + this.FMovieType];
         _loc3_.visible = true;
         this.FTotalFrame = _loc3_.totalFrames;
         _loc3_.gotoAndPlay(1);
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         this.FIsPlaying = false;
         _loc3_ = FMC_Scene["MC_Fund" + this.FFundIndex]["MC_Movie" + this.FMovieType];
         _loc3_.visible = false;
         _loc3_.stop();
         this.UpdateUI();
      }
      
      public function Test() : ByteArray
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeUnsignedInt(1371571200);
         _loc3_.writeUnsignedInt(1401571200);
         _loc3_.writeShort(38);
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

