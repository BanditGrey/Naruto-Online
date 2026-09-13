package Processors.Game.Lobby.Exercise.Nov
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
   import Logics.Exercise.Nov.TNov;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNov;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNov extends TProcessorBaseActivity
   {
      
      public static const SHOW_ITEM_COUNT:int = 3;
      
      public static const GIFT_COUNT:int = 3;
      
      public static const SWEET_COUNT:int = 5;
      
      public static const MOVIE_COUNT:int = 9;
      
      public static const ACTIVITY_1_ACTIVE_RECHARGE_BOX:int = 1;
      
      public static const ACTIVITY_1_FOOD:int = 2;
      
      public static const ACTIVITY_1_TOUGH:int = 3;
      
      public static const ACTIVITY_1_UPGRADE:int = 4;
      
      public static const ACTIVITY_1_GET_UPGRADE_GIFT:int = 5;
      
      public static const ACTIVITY_1_GET_CONSUME_BOX:int = 6;
      
      public static const ACTIVITY_1_GET_DAILY_BOX:int = 7;
      
      public static const ACTIVITY_1_CLEAR_TIME:int = 8;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 9;
      
      public static const ACTIVITY_1_BUY_RECHARGE_BOX:int = 10;
      
      public static const MOVIE_FOOD:int = 1;
      
      public static const MOVIE_UPGRADE_SUCCESS:int = 2;
      
      public static const MOVIE_UPGRADE_FAIL:int = 3;
      
      public static const MOVIE_TOUCH:int = 4;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 2;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FNov:TNov;
      
      protected var FUnstreamizerNov:TUnstreamizerNov;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FSweetList:Vector.<MovieClip>;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FUIPage_Upgrade:TUIPage;
      
      protected var FTotalPage_Upgrade:int;
      
      protected var FCurPage_Upgrade:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FIsCD:Boolean;
      
      protected var FFoodIndex:int;
      
      protected var FGlowsFilter:Vector.<TEffectBaseGlowTwo>;
      
      public function TProcessorNov(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNov = SLogicsCore.Nov;
         this.FUnstreamizerNov = new TUnstreamizerNov();
         this.FBuyBoxDate = new Object();
         this.FUIPage = new TUIPage(this);
         this.FUIPage_Upgrade = new TUIPage(this);
         this.FSweetList = new Vector.<MovieClip>(SWEET_COUNT);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FGlowsFilter = new Vector.<TEffectBaseGlowTwo>(2);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TEffectBaseGlowTwo = null;
         super.ResourcesPerform_UIDispatch();
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = ProcessorOnShowItemDesc;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            FMC_Scene["MC_Gift" + _loc1_].MC_BoxPic.gotoAndStop(_loc1_ + 1);
            FMC_Scene["MC_Gift" + _loc1_].MC_BoxPic.buttonMode = true;
            TGameUtil.setButtonMode(FMC_Scene["MC_Gift" + _loc1_].BTN_Active,true);
            FMC_Scene["MC_Gift" + _loc1_].BTN_Active.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            TGameUtil.setButtonMode(FMC_Scene["MC_Gift" + _loc1_].BTN_Buy,true);
            FMC_Scene["MC_Gift" + _loc1_].BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftBuyUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SWEET_COUNT)
         {
            this.FSweetList[_loc1_] = FMC_Scene["MC_Sweet" + _loc1_];
            this.FSweetList[_loc1_].buttonMode = true;
            this.FSweetList[_loc1_].MC_Icon.gotoAndStop(_loc1_ + 1);
            this.FSweetList[_loc1_].MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnIconOver);
            this.FSweetList[_loc1_].MC_Icon.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            TGameUtil.setButtonMode(this.FSweetList[_loc1_].BTN_Food,true);
            TGameUtil.setButtonMode(this.FSweetList[_loc1_].BTN_Gold,true);
            TGameUtil.setButtonMode(this.FSweetList[_loc1_].MC_Coin.BTN_Coin,true);
            TGameUtil.setButtonMode(this.FSweetList[_loc1_].MC_Free.BTN_Free,true);
            this.FSweetList[_loc1_].BTN_Gold.addEventListener(MouseEvent.CLICK,this.ProcessorOnFoodUp);
            this.FSweetList[_loc1_].BTN_Gold.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFoodOver);
            this.FSweetList[_loc1_].BTN_Gold.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            this.FSweetList[_loc1_].MC_Coin.BTN_Coin.addEventListener(MouseEvent.CLICK,this.ProcessorOnFoodUp);
            this.FSweetList[_loc1_].MC_Coin.BTN_Coin.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFoodOver);
            this.FSweetList[_loc1_].MC_Coin.BTN_Coin.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            this.FSweetList[_loc1_].MC_Free.BTN_Free.addEventListener(MouseEvent.CLICK,this.ProcessorOnFoodUp);
            this.FSweetList[_loc1_].MC_Free.BTN_Free.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFoodOver);
            this.FSweetList[_loc1_].MC_Free.BTN_Free.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            this.FSweetList[_loc1_].BTN_Food.addEventListener(MouseEvent.CLICK,this.ProcessorOnFoodUp);
            this.FSweetList[_loc1_].BTN_Food.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFoodOver);
            this.FSweetList[_loc1_].BTN_Food.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MOVIE_COUNT)
         {
            FMC_Scene["MC_Movie" + _loc1_].visible = false;
            _loc1_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_ConsumeBox.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_ConsumeBox.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         _loc6_ = new TEffectBaseGlowTwo();
         _loc6_.SetParameters(FMC_Scene.MC_ConsumeBox.BTN_Left,FilterColor,FilterGlowWidth,FilterGlowStrength);
         this.FGlowsFilter[0] = _loc6_;
         _loc6_ = new TEffectBaseGlowTwo();
         _loc6_.SetParameters(FMC_Scene.MC_ConsumeBox.BTN_Right,FilterColor,FilterGlowWidth,FilterGlowStrength);
         this.FGlowsFilter[1] = _loc6_;
         FMC_Scene.MC_UpgradeGift.MC_BoxPic.buttonMode = true;
         FMC_Scene.MC_UpgradeGift.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnUpgradeGiftUp);
         FMC_Scene.MC_UpgradeGift.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnUpgradeGiftOver);
         FMC_Scene.MC_UpgradeGift.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FTF_Time = FMC_Scene.MC_Box.TF_Time;
         FMC_Scene.MC_Box.MC_BoxPic.buttonMode = true;
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnDailyBoxUp);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnDailyBoxOver);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Box.BTN_ClearTime.addEventListener(MouseEvent.CLICK,this.ProcessorOnClearTimeUp);
         FMC_Scene.MC_Box.BTN_ClearTime.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnClearTimeOver);
         FMC_Scene.MC_Box.BTN_ClearTime.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_ConsumeBox.MC_GoldPic.buttonMode = true;
         FMC_Scene.MC_ConsumeBox.MC_GoldPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnConsumeBoxUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Upgrade,true);
         FMC_Scene.BTN_Upgrade.addEventListener(MouseEvent.CLICK,this.ProcessorOnUpgradeUp);
         FMC_Scene.BTN_Upgrade.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnUpgradeOver);
         FMC_Scene.BTN_Upgrade.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Play,true);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.CLICK,this.ProcessorOnToughUp);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnToughOver);
         FMC_Scene.BTN_Play.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -21;
         this.FProcessorFebActiveShop.y = 15;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
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
            this.UpdateTabEffect();
            if(Boolean(FTF_Time) && Boolean(this.FNov) && this.FNov.DescList.length > 0)
            {
               _loc3_ = this.FNov.NextTime - STimingCore.GetServerTick();
               FTF_Time.text = TUtilityString.Format(this.FNov.DescListNew[6],TGameUtil.fomatTime(_loc3_));
               if(_loc3_ <= 0 && this.FIsCD || _loc3_ > 0 && !this.FIsCD)
               {
                  this.FIsCD = _loc3_ <= 0 ? false : true;
                  this.UpdateDailyBox();
               }
            }
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_FOOD:
                     _loc2_ = int(FMC_Scene["MC_Movie" + this.FFoodIndex].currentFrame);
                     break;
                  case MOVIE_UPGRADE_SUCCESS:
                     _loc2_ = int(FMC_Scene.MC_Movie6.currentFrame);
                     break;
                  case MOVIE_UPGRADE_FAIL:
                     _loc2_ = int(FMC_Scene.MC_Movie7.currentFrame);
                     break;
                  case MOVIE_TOUCH:
                     _loc2_ = int(FMC_Scene.MC_Movie8.currentFrame);
               }
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
         this.UpdateGift();
         this.UpdateDailyBox();
         this.UpdatePet();
         this.UpdateConsumeBox();
         this.UpdateItem();
         this.UpdateText();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FNov);
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
            _loc2_ = FMC_Scene["MC_Gift" + _loc1_];
            _loc3_ = this.FNov.GiftList[_loc1_];
            _loc2_.TF_Desc0.text = TUtilityString.Format(this.FNov.DescListNew[2],_loc3_.Price);
            _loc2_.TF_Desc1.text = TUtilityString.Format(this.FNov.DescListNew[3],_loc3_.Count,_loc3_.BuyCount);
            _loc2_.TF_Desc2.text = TUtilityString.Format(this.FNov.DescListNew[4],_loc3_.Count * _loc3_.BuyCount);
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc2_.BTN_Active.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Active,false);
               _loc2_.BTN_Buy.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.BTN_Active.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Active,true);
               _loc2_.BTN_Buy.visible = false;
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_IS_GOT)
            {
               _loc2_.BTN_Active.visible = false;
               _loc2_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Active,true);
            }
            else
            {
               _loc2_.BTN_Active.visible = false;
               _loc2_.BTN_Buy.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Buy,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateDailyBox() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:TBaseBox = null;
         var _loc3_:int = 0;
         FMC_Scene.MC_Box.TF_Count.text = TUtilityString.Format(this.FNov.DescListNew[5],this.FNov.DailyTimes);
         if(this.FIsCD)
         {
            _loc3_ = this.FNov.NextTime - STimingCore.GetServerTick();
            FTF_Time.text = TUtilityString.Format(this.FNov.DescListNew[6],TGameUtil.fomatTime(_loc3_));
            FMC_Scene.MC_Box.BTN_ClearTime.visible = true;
            FMC_Scene.MC_Box.MC_Click.visible = false;
         }
         else
         {
            FTF_Time.text = "";
            FMC_Scene.MC_Box.BTN_ClearTime.visible = false;
            if(this.FNov.DailyTimes > 0)
            {
               FMC_Scene.MC_Box.MC_Got.visible = false;
               FMC_Scene.MC_Box.MC_Click.visible = true;
            }
            else
            {
               FMC_Scene.MC_Box.MC_Got.visible = true;
               FMC_Scene.MC_Box.MC_Click.visible = false;
            }
         }
      }
      
      protected function UpdatePet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TBaseBox = null;
         var _loc7_:int = 0;
         var _loc8_:TBaseBox = null;
         FMC_Scene.TF_Count0.text = this.FNov.FreeTime.toString();
         FMC_Scene.TF_Count1.text = this.FNov.LimitTime.toString();
         FMC_Scene.TF_Level.text = TUtilityString.Format(this.FNov.DescListNew[11],this.FNov.PetLevel);
         FMC_Scene.MC_Pet.gotoAndStop(this.FNov.PetLevel);
         if(this.FNov.PetIsMaxLevel == 1)
         {
            FMC_Scene.TF_Exp.text = this.FNov.DescListNew[30];
            FMC_Scene.BTN_Upgrade.visible = false;
            FMC_Scene.TF_Buff.text = TUtilityString.Format(this.FNov.DescListNew[38],this.FNov.PetLevel,this.FNov.PetBuff);
            FMC_Scene.TF_UpgradeTip.text = "";
         }
         else
         {
            FMC_Scene.TF_Exp.text = this.FNov.PetMin + "/" + this.FNov.PetMax;
            FMC_Scene.TF_UpgradeTip.text = TUtilityString.Format(this.FNov.DescListNew[39],this.FNov.PetLevel + 1,this.FNov.PetFailValue);
            FMC_Scene.BTN_Upgrade.visible = true;
            if(this.FNov.PetMin == 0)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Upgrade,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Upgrade,false);
            }
            FMC_Scene.TF_Buff.text = TUtilityString.Format(this.FNov.DescListNew[29],this.FNov.PetLevel,this.FNov.PetBuff,this.FNov.PetNextBuff);
         }
         _loc2_ = 0;
         while(_loc2_ < SWEET_COUNT)
         {
            _loc5_ = this.FSweetList[_loc2_];
            _loc6_ = this.FNov.FoodList[_loc2_];
            _loc5_.TF_Name.text = this.FNov.DescListNew[12 + _loc2_];
            _loc5_.TF_Count.text = _loc6_.Count.toString();
            if(_loc6_.Type == TNov.TYPE_FREE)
            {
               if(_loc6_.Min > 0)
               {
                  _loc5_.BTN_Gold.visible = false;
                  _loc5_.MC_Coin.visible = false;
                  _loc5_.MC_Free.visible = true;
                  _loc5_.BTN_Food.visible = false;
                  _loc5_.MC_Free.TF_Desc.text = _loc6_.Min + "/" + _loc6_.Max;
               }
               else if(_loc6_.Count > 0)
               {
                  _loc5_.BTN_Gold.visible = false;
                  _loc5_.MC_Coin.visible = false;
                  _loc5_.MC_Free.visible = false;
                  _loc5_.BTN_Food.visible = true;
               }
               else
               {
                  _loc5_.BTN_Gold.visible = true;
                  _loc5_.MC_Coin.visible = false;
                  _loc5_.MC_Free.visible = false;
                  _loc5_.BTN_Food.visible = false;
               }
            }
            else if(_loc6_.Type == TNov.TYPE_COIN)
            {
               if(_loc6_.Count > 0)
               {
                  _loc5_.BTN_Gold.visible = false;
                  _loc5_.MC_Coin.visible = false;
                  _loc5_.MC_Free.visible = false;
                  _loc5_.BTN_Food.visible = true;
               }
               else if(_loc6_.Min > 0)
               {
                  _loc5_.BTN_Gold.visible = false;
                  _loc5_.MC_Coin.visible = true;
                  _loc5_.MC_Free.visible = false;
                  _loc5_.BTN_Food.visible = false;
                  _loc5_.MC_Coin.TF_Desc.text = _loc6_.Min + "/" + _loc6_.Max;
               }
               else
               {
                  _loc5_.BTN_Gold.visible = true;
                  _loc5_.MC_Coin.visible = false;
                  _loc5_.MC_Free.visible = false;
                  _loc5_.BTN_Food.visible = false;
               }
            }
            else if(_loc6_.Count > 0)
            {
               _loc5_.BTN_Gold.visible = false;
               _loc5_.MC_Coin.visible = false;
               _loc5_.MC_Free.visible = false;
               _loc5_.BTN_Food.visible = true;
            }
            else
            {
               _loc5_.BTN_Gold.visible = true;
               _loc5_.MC_Coin.visible = false;
               _loc5_.MC_Free.visible = false;
               _loc5_.BTN_Food.visible = false;
            }
            _loc2_++;
         }
         if(this.FNov.FreeTime > 0 || this.FNov.LimitTime > 0)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Play,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Play,false);
         }
         _loc1_ = this.FNov.GetGiftIndex();
         _loc5_ = FMC_Scene.MC_UpgradeGift;
         _loc5_.MC_BoxPic.gotoAndStop(_loc1_ + 1);
         if(_loc1_ >= this.FNov.UpgradeGift.length)
         {
            _loc5_.MC_Got.visible = true;
            _loc5_.MC_Click.visible = false;
         }
         else
         {
            _loc8_ = this.FNov.UpgradeGift[_loc1_];
            _loc5_.MC_Got.visible = false;
            if(_loc8_.Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc5_.MC_Click.visible = false;
            }
            else if(_loc8_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc5_.MC_Click.visible = true;
            }
         }
      }
      
      protected function UpdateConsumeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FUIPage.TotalQuantity = this.FNov.ConsumeBox.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FNov.ConsumeBox[_loc1_];
         _loc2_ = FMC_Scene.MC_ConsumeBox;
         _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         _loc2_.TF_Desc0.text = TUtilityString.Format(this.FNov.DescListNew[7],this.FNov.TotalConsumeGold);
         _loc2_.TF_Desc1.text = TUtilityString.Format(this.FNov.DescListNew[8],_loc3_.Price);
         _loc2_.TF_Count.text = "*" + _loc3_.Count;
         if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = false;
         }
         else if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
         {
            _loc2_.MC_Got.visible = false;
            _loc2_.MC_Click.visible = true;
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Got.visible = true;
         }
         _loc5_ = this.FNov.GetConsumeGiftIndex();
         if(_loc5_ == -1 || _loc5_ == _loc1_)
         {
            this.FGlowsFilter[0].Stop();
            this.FGlowsFilter[1].Stop();
         }
         else if(_loc5_ < _loc1_)
         {
            this.FGlowsFilter[0].IsRunOver = false;
            this.FGlowsFilter[1].Stop();
         }
         else
         {
            this.FGlowsFilter[1].IsRunOver = false;
            this.FGlowsFilter[0].Stop();
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
      
      protected function UpdateItem() : void
      {
         this.FShowItem.UpdateUI(this.FNov.ShowItems);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNov.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNov.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FNov.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FNov.RankPoint.toString();
         FMC_Scene.TF_Recharge.text = this.FNov.TotalRechargeGold.toString();
         FMC_Scene.TF_ShopPoint.text = this.FNov.ShopExchangePoint.toString();
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
         this.UpdateConsumeBox();
      }
      
      protected function ProcessorPageOnChange_Upgrade(param1:Object, param2:int) : void
      {
         this.FCurPage_Upgrade = param2;
         this.UpdatePet();
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && Boolean(this.FNov))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_ACTIVE_RECHARGE_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && Boolean(this.FNov))
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_BUY_RECHARGE_BOX,this.FNov.GiftList[_loc2_].CurPrice,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnDailyBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(!this.FIsPlaying && this.FNov) && Boolean(!this.FIsCD) && this.FNov.DailyTimes > 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_DAILY_BOX);
         }
      }
      
      protected function ProcessorOnClearTimeUp(param1:MouseEvent) : void
      {
         if(Boolean(!this.FIsPlaying) && Boolean(this.FNov) && this.FIsCD)
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_CLEAR_TIME,this.FNov.ClearTimePrice);
         }
      }
      
      protected function ProcessorOnFoodUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:String = null;
         switch(param1.currentTarget.name)
         {
            case "BTN_Food":
               _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
               break;
            case "BTN_Gold":
               _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
               break;
            case "BTN_Free":
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(8));
               break;
            case "BTN_Coin":
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(8));
         }
         if(!this.FIsPlaying && Boolean(this.FNov))
         {
            _loc3_ = this.FNov.FoodList[_loc2_];
            if(_loc3_.Min > 0 || _loc3_.Count > 0)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_FOOD,_loc2_ + 1);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_FOOD,_loc3_.CurPrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnUpgradeGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FNov.GetGiftIndex();
         if(Boolean(!this.FIsPlaying && this.FNov && _loc2_ < this.FNov.UpgradeGift.length) && Boolean(_loc2_ < this.FNov.UpgradeGift.length) && this.FNov.UpgradeGift[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_UPGRADE_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnUpgradeUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FNov))
         {
            this.ProcessorOnBuyBoxUp(ACTIVITY_1_UPGRADE,this.FNov.PetUpgradePrice);
         }
      }
      
      protected function ProcessorOnToughUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FNov))
         {
            if(this.FNov.FreeTime > 0)
            {
               this.ProcessorOnGetBoxUp(ACTIVITY_1_TOUGH);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(ACTIVITY_1_TOUGH,this.FNov.ToughCost);
            }
         }
      }
      
      protected function ProcessorOnConsumeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(!this.FIsPlaying && this.FNov) && Boolean(_loc2_ < this.FNov.ConsumeBox.length) && this.FNov.ConsumeBox[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_CONSUME_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(this.FNov)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnDailyBoxOver(param1:MouseEvent) : void
      {
         if(this.FNov)
         {
            ProcessorOnShowHtmlText(this.FNov.DescListNew[9]);
         }
      }
      
      protected function ProcessorOnClearTimeOver(param1:MouseEvent) : void
      {
         if(this.FNov)
         {
            ProcessorOnShowHtmlText(this.FNov.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnUpgradeGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = this.FNov.GetGiftIndex();
         if(this.FNov)
         {
            if(_loc2_ >= this.FNov.UpgradeGift.length)
            {
               _loc3_ = this.FNov.UpgradeGift[_loc2_ - 1];
               ProcessorOnShowHtmlText(TUtilityString.Format(this.FNov.DescListNew[28],_loc2_,_loc2_ + 1,this.FNov.UpgradeGift[_loc2_ - 1].Count));
            }
            else
            {
               _loc3_ = this.FNov.UpgradeGift[_loc2_];
               ProcessorOnShowHtmlText(TUtilityString.Format(this.FNov.DescListNew[28],_loc2_ + 1,_loc2_ + 2,this.FNov.UpgradeGift[_loc2_].Count));
            }
         }
      }
      
      protected function ProcessorOnUpgradeOver(param1:MouseEvent) : void
      {
         if(this.FNov)
         {
            ProcessorOnShowHtmlText(TUtilityString.Format(this.FNov.DescListNew[26],this.FNov.PetUpgradePrice));
         }
      }
      
      protected function ProcessorOnToughOver(param1:MouseEvent) : void
      {
         if(Boolean(this.FNov) && this.FNov.FreeTime <= 0)
         {
            ProcessorOnShowHtmlText(this.FNov.DescListNew[34]);
         }
      }
      
      protected function ProcessorOnIconOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
         if(this.FNov)
         {
            ProcessorOnShowHtmlText(this.FNov.DescListNew[17 + _loc2_]);
         }
      }
      
      protected function ProcessorOnFoodOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         var _loc4_:String = null;
         switch(param1.currentTarget.name)
         {
            case "BTN_Food":
               _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
               break;
            case "BTN_Gold":
               _loc2_ = int(String(param1.currentTarget.parent.name).slice(8));
               break;
            case "BTN_Free":
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(8));
               break;
            case "BTN_Coin":
               _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(8));
         }
         if(this.FNov)
         {
            _loc3_ = this.FNov.FoodList[_loc2_];
            if(_loc3_.Type == TNov.TYPE_FREE)
            {
               if(_loc3_.Min > 0)
               {
                  _loc4_ = this.FNov.DescListNew[22];
               }
               else if(_loc3_.Count > 0)
               {
                  _loc4_ = TUtilityString.Format(this.FNov.DescListNew[25],this.FNov.DescListNew[12 + _loc2_]);
               }
               else
               {
                  _loc4_ = TUtilityString.Format(this.FNov.DescListNew[24],_loc3_.CurPrice);
               }
            }
            else if(_loc3_.Type == TNov.TYPE_COIN)
            {
               if(_loc3_.Count > 0)
               {
                  _loc4_ = TUtilityString.Format(this.FNov.DescListNew[25],this.FNov.DescListNew[12 + _loc2_]);
               }
               else if(_loc3_.Min > 0)
               {
                  _loc4_ = TUtilityString.Format(this.FNov.DescListNew[23],_loc3_.Price);
               }
               else
               {
                  _loc4_ = TUtilityString.Format(this.FNov.DescListNew[24],_loc3_.CurPrice);
               }
            }
            else if(_loc3_.Count > 0)
            {
               _loc4_ = TUtilityString.Format(this.FNov.DescListNew[25],this.FNov.DescListNew[12 + _loc2_]);
            }
            else
            {
               _loc4_ = TUtilityString.Format(this.FNov.DescListNew[24],_loc3_.CurPrice);
            }
            ProcessorOnShowHtmlText(_loc4_);
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
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FNov);
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
         FProcessorWindowDesc.BaseActivity = this.FNov;
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
         this.FUnstreamizerNov.Unstreamize(_loc2_,this.FNov,null);
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
         if(this.FNov)
         {
            this.FNov.TotalRechargeGold = _loc2_.readUnsignedInt();
            this.FNov.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
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
         ProcessorUnstreamActivityLog(this.FNov,_loc2_);
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
            case ACTIVITY_1_ACTIVE_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNov.TotalRechargeGold = _loc2_.readUnsignedInt();
               this.FNov.GiftList[_loc5_].Status = TBaseActivity.STATUS_IS_GOT;
               ProcessorEffectText(this.FNov.DescListNew[31]);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_BUY_RECHARGE_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNov.GiftList[_loc5_].Status = TBaseActivity.STATUS_GETED;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_BUY_SUCCESSED);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_DAILY_BOX:
               --this.FNov.DailyTimes;
               _loc17_ = _loc2_.readUnsignedInt() - 1;
               _loc18_ = int(_loc2_.readUnsignedInt());
               this.FNov.NextTime = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc4_ = _loc4_ + (this.FNov.DescListNew[12 + _loc17_] + "*" + _loc18_);
               this.FNov.FoodList[_loc17_].Count += _loc18_;
               ProcessorEffectText(_loc4_);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_CLEAR_TIME:
               this.FNov.NextTime = 0;
               this.FNov.TotalConsumeGold = _loc2_.readUnsignedInt();
               ProcessorEffectText(this.FNov.DescListNew[32]);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_FOOD:
               this.FFoodIndex = _loc2_.readUnsignedInt() - 1;
               _loc17_ = int(_loc2_.readUnsignedInt());
               _loc18_ = int(_loc2_.readUnsignedInt());
               _loc19_ = int(_loc2_.readUnsignedInt());
               this.FNov.FoodList[this.FFoodIndex].Count = _loc2_.readUnsignedInt();
               this.FNov.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FNov.FoodList[this.FFoodIndex].Min = _loc2_.readUnsignedInt();
               this.FNov.PetMin = Math.max(0,this.FNov.PetMin - _loc17_);
               this.FNov.RankPoint += _loc18_ + _loc19_;
               this.FNov.ShopExchangePoint += _loc18_ + _loc19_;
               _loc4_ = TUtilityString.Format(this.FNov.DescListNew[33],_loc17_,_loc18_,_loc19_);
               ProcessorEffectText(_loc4_);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.PlayMovie(MOVIE_FOOD);
               break;
            case ACTIVITY_1_TOUGH:
               if(this.FNov.FreeTime > 0)
               {
                  --this.FNov.FreeTime;
               }
               else
               {
                  --this.FNov.LimitTime;
               }
               _loc17_ = int(_loc2_.readUnsignedInt());
               this.FNov.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FNov.ToughCost = _loc2_.readUnsignedInt();
               this.FNov.PetMin = Math.max(0,this.FNov.PetMin - _loc17_);
               _loc4_ = TUtilityString.Format(this.FNov.DescListNew[35],_loc17_);
               ProcessorEffectText(_loc4_);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.PlayMovie(MOVIE_TOUCH);
               break;
            case ACTIVITY_1_UPGRADE:
               _loc17_ = int(_loc2_.readUnsignedInt());
               this.FNov.TotalConsumeGold = _loc2_.readUnsignedInt();
               this.FNov.PetLevel = _loc2_.readUnsignedInt();
               this.FNov.PetBuff = _loc2_.readUnsignedInt();
               this.FNov.PetMax = _loc2_.readUnsignedInt();
               this.FNov.PetMin = _loc2_.readUnsignedInt();
               this.FNov.PetUpgradePrice = _loc2_.readUnsignedInt();
               this.FNov.PetIsMaxLevel = _loc2_.readUnsignedInt();
               this.FNov.PetFailValue = _loc2_.readUnsignedInt();
               this.FNov.PetNextBuff = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FNov.UpgradeGift.length)
               {
                  this.FNov.UpgradeGift[_loc5_].Status = _loc2_.readUnsignedInt();
                  _loc5_++;
               }
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               if(_loc17_ == 0)
               {
                  ProcessorEffectText(this.FNov.DescListNew[37]);
                  this.PlayMovie(MOVIE_UPGRADE_FAIL);
               }
               else
               {
                  ProcessorEffectText(this.FNov.DescListNew[36]);
                  this.PlayMovie(MOVIE_UPGRADE_SUCCESS);
               }
               break;
            case ACTIVITY_1_GET_UPGRADE_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc17_ = int(_loc2_.readUnsignedInt());
               this.FNov.UpgradeGift[_loc5_].Status = TBaseActivity.STATUS_GETED;
               this.FNov.RankPoint += _loc17_;
               this.FNov.ShopExchangePoint += _loc17_;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_GET_CONSUME_BOX:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc17_ = int(_loc2_.readUnsignedInt());
               this.FNov.ConsumeBox[_loc5_].Status = TBaseActivity.STATUS_GETED;
               this.FNov.RankPoint += _loc17_;
               this.FNov.ShopExchangePoint += _loc17_;
               ProcessorEffectText(STRING_BASEACTIVITY.FORMAT_GET);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FNov.ShopExchangeItems[_loc5_].LimitCount;
               this.FNov.ShopExchangePoint = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FNov.ShopExchangeItems[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FNov.ShopExchangeItems[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FNov.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNov.CheckStatus());
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
         if(this.FMovieType == MOVIE_FOOD)
         {
            _loc4_ = FMC_Scene["MC_Movie" + this.FFoodIndex];
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_TOUCH)
         {
            _loc4_ = FMC_Scene.MC_Movie8;
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_UPGRADE_SUCCESS)
         {
            _loc4_ = FMC_Scene.MC_Movie6;
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_UPGRADE_FAIL)
         {
            _loc4_ = FMC_Scene.MC_Movie7;
            _loc4_.visible = true;
            this.FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_FOOD)
         {
            _loc3_ = FMC_Scene["MC_Movie" + this.FFoodIndex];
            _loc3_.visible = false;
            _loc3_.stop();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_TOUCH)
         {
            _loc3_ = FMC_Scene.MC_Movie8;
            _loc3_.visible = false;
            _loc3_.stop();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_UPGRADE_SUCCESS)
         {
            _loc3_ = FMC_Scene.MC_Movie6;
            _loc3_.visible = false;
            _loc3_.stop();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_UPGRADE_FAIL)
         {
            _loc3_ = FMC_Scene.MC_Movie7;
            _loc3_.visible = false;
            _loc3_.stop();
            this.UpdateUI();
         }
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
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"充值%0金币可激活");
         TUtilityString.FlushUTF(_loc3_,"每天可获得%0金币,持续%1天");
         TUtilityString.FlushUTF(_loc3_,"一共获得:%0金币");
         TUtilityString.FlushUTF(_loc3_,"今日剩余次数：%0");
         TUtilityString.FlushUTF(_loc3_,"下次领取时间：%0");
         TUtilityString.FlushUTF(_loc3_,"当前累计消费%0金币");
         TUtilityString.FlushUTF(_loc3_,"累计消费达到%0金币可领");
         TUtilityString.FlushUTF(_loc3_,"感恩大礼包TIP");
         TUtilityString.FlushUTF(_loc3_,"加速花费XXX金币");
         TUtilityString.FlushUTF(_loc3_,"LV.%0");
         TUtilityString.FlushUTF(_loc3_,"饲料A");
         TUtilityString.FlushUTF(_loc3_,"饲料B");
         TUtilityString.FlushUTF(_loc3_,"饲料C");
         TUtilityString.FlushUTF(_loc3_,"饲料D");
         TUtilityString.FlushUTF(_loc3_,"饲料E");
         TUtilityString.FlushUTF(_loc3_,"饲料A TIP");
         TUtilityString.FlushUTF(_loc3_,"饲料B TIP");
         TUtilityString.FlushUTF(_loc3_,"饲料C TIP");
         TUtilityString.FlushUTF(_loc3_,"饲料D TIP");
         TUtilityString.FlushUTF(_loc3_,"饲料E TIP");
         TUtilityString.FlushUTF(_loc3_,"本次喂养免费");
         TUtilityString.FlushUTF(_loc3_,"本次喂养消耗%0银币");
         TUtilityString.FlushUTF(_loc3_,"本次喂养消耗%0金币");
         TUtilityString.FlushUTF(_loc3_,"本次喂养消耗1个%0");
         TUtilityString.FlushUTF(_loc3_,"本次升级花费%0金币");
         TUtilityString.FlushUTF(_loc3_,"排行收集物名字");
         TUtilityString.FlushUTF(_loc3_,"Lv.%0升级礼包:收集物x%1");
         TUtilityString.FlushUTF(_loc3_,"当前等级Lv%0,可额外获得%1%感恩之心,下级可额外获得%2%");
         TUtilityString.FlushUTF(_loc3_,"MAX");
         TUtilityString.FlushUTF(_loc3_,"激活成功");
         TUtilityString.FlushUTF(_loc3_,"加速成功");
         TUtilityString.FlushUTF(_loc3_,"喂食成功,成长值+%0,获得感恩之心*%1,额外奖励%2个");
         TUtilityString.FlushUTF(_loc3_,"抚摸TIPS");
         TUtilityString.FlushUTF(_loc3_,"抚摸成功,成长值+%0");
         TUtilityString.FlushUTF(_loc3_,"升级成功");
         TUtilityString.FlushUTF(_loc3_,"升级失败");
         TUtilityString.FlushUTF(_loc3_,"当前等级Lv%0,可额外获得%1%感恩之心");
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(110);
         _loc3_.writeUnsignedInt(110);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeUnsignedInt(2);
         _loc3_.writeShort(3);
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(_loc1_ + 1);
            _loc3_.writeInt(1);
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeUnsignedInt(3);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(10);
         _loc3_.writeUnsignedInt(0);
         _loc3_.writeShort(10);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(10 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_.writeUnsignedInt(_loc2_);
            _loc3_.writeUnsignedInt(10);
            _loc3_.writeUnsignedInt(10);
            _loc3_.writeUnsignedInt(10);
            _loc3_.writeUnsignedInt(10);
            _loc3_.writeUnsignedInt(10);
            _loc2_++;
         }
         _loc3_.writeShort(5);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(_loc2_);
            _loc3_.writeUnsignedInt(10);
            _loc2_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(_loc1_ + 1);
            _loc3_.writeShort(1);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(6);
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

