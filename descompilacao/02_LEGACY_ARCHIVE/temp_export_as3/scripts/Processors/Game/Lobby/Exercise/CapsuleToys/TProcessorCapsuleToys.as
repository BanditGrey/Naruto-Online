package Processors.Game.Lobby.Exercise.CapsuleToys
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
   import Logics.Exercise.CapsuleToys.TCapsuleToys;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerCapsuleToys;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlowTwo;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorWindowEquipDesc;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorCapsuleToys extends TProcessorBaseActivity
   {
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const SHOW_ALL_ITEM_COUNT:int = 8;
      
      protected static const EGG_COUNT:int = 9;
      
      protected static const BADGE_COUNT:int = 6;
      
      protected static const SHEAR_COUNT:int = 3;
      
      protected static const BAR_COUNT:int = 5;
      
      protected static const SOCK_COUNT:int = 10;
      
      protected static const REQ_RESET:int = 1;
      
      protected static const REQ_GOLD_RESET:int = 2;
      
      protected static const REQ_PLAY:int = 3;
      
      protected static const REQ_AUTO_PLAY:int = 4;
      
      protected static const REQ_GET_GIFT:int = 5;
      
      protected static const REQ_EXCHANGE:int = 6;
      
      public static const ACTIVITY_3_START_GAME:int = 7;
      
      public static const ACTIVITY_3_CHOICE_SHEAR:int = 8;
      
      public static const ACTIVITY_3_CUT_SOCK:int = 9;
      
      public static const MOVIE_OF_RESET:int = 1;
      
      public static const MOVIE_OF_PLAY:int = 2;
      
      public static const MOVIE_OF_AUTOPLAY:int = 3;
      
      public static const MOVIE_OF_SHEAR:int = 5;
      
      public static const MOVIE_OF_CHOICE_SHEAR:int = 6;
      
      public static const MOVIE_OF_USE_SHEAR:int = 7;
      
      public static const MOVIE_OF_SOCK_NULL:int = 8;
      
      public static const MOVIE_OF_SOCK_FALL:int = 9;
      
      public static const MOVIE_OF_GAME_WIN:int = 10;
      
      public static const MOVIE_OF_GAME_LOSE:int = 11;
      
      public static const FilterColor:uint = 15911245;
      
      public static const FilterGlowWidth:int = 10;
      
      public static const FilterGlowStrength:int = 10;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FCapsuleToys:TCapsuleToys;
      
      protected var FUnstreamizerCapsuleToys:TUnstreamizerCapsuleToys;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsShopShow:Boolean;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FAllItem:TUIShowItem;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FEggItem:Vector.<TUIShowItem>;
      
      protected var FProcessorWindowEquipDesc:TProcessorWindowEquipDesc;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FGlowFilter:TEffectBaseGlowTwo;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FCutShearIndex:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxHeight:int;
      
      public function TProcessorCapsuleToys(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FCapsuleToys = SLogicsCore.CapsuleToys;
         this.FUnstreamizerCapsuleToys = new TUnstreamizerCapsuleToys();
         this.FBuyBoxDate = new Object();
         this.FProcessorWindowEquipDesc = new TProcessorWindowEquipDesc(this.Parent);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FEggItem = new Vector.<TUIShowItem>(EGG_COUNT);
         this.FUIPage = new TUIPage(this);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIShowItem = null;
         super.ResourcesPerform_UIDispatch();
         FMC_Scene.MC_Shop.visible = false;
         FMC_Scene.MC_RefreshMovie.visible = false;
         FMC_Scene.MC_Movie0.visible = false;
         this.FAllItem = new TUIShowItem(this,SHOW_ALL_ITEM_COUNT);
         this.FAllItem.Perform_UIDispatch(FMC_Scene.MC_Shop);
         this.FAllItem.OnOverlay = UIComponentsHintOnOver;
         this.FAllItem.OnOut = UIComponentsHintOnOut;
         this.FAllItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItems);
         this.FShowItem.OnOverlay = UIComponentsHintOnOver;
         this.FShowItem.OnOut = UIComponentsHintOnOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         _loc1_ = 0;
         while(_loc1_ < EGG_COUNT)
         {
            _loc6_ = new TUIShowItem(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene.MC_Laba["MC_Slot" + _loc1_]);
            _loc6_.OnOverlay = UIComponentsHintOnOver;
            _loc6_.OnOut = UIComponentsHintOnOut;
            _loc6_.OnShowRecruit = this.ProcessorOnShowRecruit;
            this.FEggItem[_loc1_] = _loc6_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < EGG_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Egg" + _loc1_];
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnEggUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnEggOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnEggOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SHEAR_COUNT)
         {
            FMC_Scene.MC_Desc["MC_Shear" + _loc1_].buttonMode = true;
            FMC_Scene.MC_Desc["MC_Shear" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnChoiceShear);
            FMC_Scene.MC_Desc["MC_Shear" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnShearOver);
            FMC_Scene.MC_Desc["MC_Shear" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < SOCK_COUNT)
         {
            _loc5_ = FMC_Scene.MC_Game["MC_Sock" + _loc1_];
            _loc5_.buttonMode = true;
            _loc5_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnSockUp);
            _loc1_++;
         }
         this.FProcessorWindowEquipDesc.OnCloseUp = this.ProcessorOnHideWindow;
         this.FProcessorWindowEquipDesc.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowEquipDesc.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowEquipDesc.Visible = false;
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorFebActiveShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = 4;
         this.FProcessorFebActiveShop.y = -15;
         FMC_Scene.MC_RechargeBox.MC_GoldPic.buttonMode = true;
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnRechargeBoxUp);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRechargeBoxOver);
         FMC_Scene.MC_RechargeBox.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_RechargeBox.BTN_Left;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_RechargeBox.BTN_Right;
         this.FUIPage.PageSize = 1;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         FMC_Scene.mc_lost.visible = false;
         FMC_Scene.MC_DropMovie.visible = false;
         FMC_Scene.MC_Game.MC_Win.visible = false;
         FMC_Scene.MC_Game.MC_Lose.visible = false;
         FMC_Scene.MC_Desc.MC_Movie.visible = false;
         FMC_Scene.MC_Desc.visible = false;
         FMC_Scene.MC_Game.visible = false;
         this.FMC_Mask = FMC_Scene.MC_Game.MC_Bar.MC_Mask;
         this.FBarMaxHeight = this.FMC_Mask.height;
         this.FGlowFilter = new TEffectBaseGlowTwo();
         this.FGlowFilter.SetParameters(FMC_Scene.BTN_Enter,FilterColor,FilterGlowWidth,FilterGlowStrength);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.BTN_Shop,true);
         FMC_Scene.BTN_Shop.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowShopDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_AutoPlay,true);
         FMC_Scene.BTN_AutoPlay.addEventListener(MouseEvent.CLICK,this.ProcessorOnAutoPlayUp);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Enter,true);
         FMC_Scene.BTN_Enter.addEventListener(MouseEvent.CLICK,this.ProcessorOnEnterUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,true);
         FMC_Scene.MC_Desc.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         FMC_Scene.MC_Desc.BTN_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseGameDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.PerformPacket_CS_LoadLogReq);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(FTF_Time)
            {
               FTF_Time.text = TGameUtil.fomatTime(this.FCapsuleToys.FreshTime - STimingCore.GetServerTick());
               this.UpdateBtn();
            }
            if(this.FAllItem)
            {
               this.FAllItem.LogicsPerform();
            }
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FEggItem)
            {
               _loc1_ = 0;
               while(_loc1_ < this.FEggItem.length)
               {
                  if(this.FEggItem[_loc1_])
                  {
                     this.FEggItem[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
            }
            if(Boolean(this.FGlowFilter) && !this.FGlowFilter.IsRunOver)
            {
               this.FGlowFilter.Run();
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_RESET:
                     _loc2_ = int(FMC_Scene.MC_RefreshMovie.currentFrame);
                     break;
                  case MOVIE_OF_PLAY:
                     _loc2_ = int(FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Movie.currentFrame);
                     break;
                  case MOVIE_OF_AUTOPLAY:
                     _loc2_ = int(FMC_Scene.MC_Movie0.currentFrame);
                     break;
                  case MOVIE_OF_SHEAR:
                     _loc2_ = int(FMC_Scene.MC_Desc.MC_Shear0.currentFrame);
                     break;
                  case MOVIE_OF_CHOICE_SHEAR:
                     _loc2_ = int(FMC_Scene.MC_Desc.MC_Movie.currentFrame);
                     break;
                  case MOVIE_OF_USE_SHEAR:
                     _loc2_ = int(FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Shear.MC_Shear.currentFrame);
                     break;
                  case MOVIE_OF_SOCK_NULL:
                     _loc2_ = int(FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Smoke.currentFrame);
                     break;
                  case MOVIE_OF_SOCK_FALL:
                     _loc2_ = int(FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].currentFrame);
                     break;
                  case MOVIE_OF_GAME_WIN:
                     _loc2_ = int(FMC_Scene.MC_Game.MC_Win.MC_Movie.currentFrame);
                     break;
                  case MOVIE_OF_GAME_LOSE:
                     _loc2_ = int(FMC_Scene.MC_Game.MC_Lose.currentFrame);
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
         this.FCurPage = this.FUIPage.PageIndex = this.FCapsuleToys.CurBoxIndex;
         this.UpdateBtn();
         this.UpdateItem();
         this.UpdateEgg();
         this.UpdatePlayBtn();
         this.UpdateText();
         this.UpdateBadge();
         this.UpdateGame();
         this.UpdateRechargeBox();
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FCapsuleToys);
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FCapsuleToys.FreshTime <= STimingCore.GetServerTick())
         {
            FMC_Scene.MC_Tag.visible = true;
            FMC_Scene.MC_GoldTip.visible = false;
         }
         else
         {
            FMC_Scene.MC_Tag.visible = false;
            FMC_Scene.MC_GoldTip.visible = true;
         }
      }
      
      protected function UpdatePlayBtn() : void
      {
         if(FMC_Scene.BTN_Reset.MC_Movie)
         {
            FMC_Scene.BTN_Reset.MC_Movie.gotoAndPlay(1);
         }
         if(this.FCapsuleToys.EggList.indexOf(1) != -1)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_AutoPlay,false);
            FMC_Scene.mc_lost.visible = true;
            FMC_Scene.MC_FreeTip.visible = false;
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_AutoPlay,true);
            FMC_Scene.mc_lost.visible = false;
            FMC_Scene.MC_FreeTip.visible = true;
         }
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:TBaseBox = null;
         var _loc8_:MovieClip = null;
         var _loc9_:TInventory = null;
         this.FAllItem.UpdateUI(this.FCapsuleToys.AllItems);
         this.FShowItem.UpdateUI(this.FCapsuleToys.ShowItems);
         _loc1_ = 0;
         while(_loc1_ < EGG_COUNT)
         {
            _loc7_ = this.FCapsuleToys.SaleItems[_loc1_];
            _loc6_ = _loc7_.Type - 1;
            _loc3_ = new TInventories();
            _loc9_ = this.FCapsuleToys.AllItems.GetInventoryByIndex(_loc6_);
            _loc3_.Add(_loc9_);
            this.FEggItem[_loc1_].UpdateUI(_loc3_);
            _loc5_ = this.FCapsuleToys.SaleItems[_loc1_].Status;
            if(_loc5_ == TBaseActivity.STATUS_CANNOTGET)
            {
               this.FEggItem[_loc1_].SetMCVisible("MC_Got",false);
            }
            else
            {
               this.FEggItem[_loc1_].SetMCVisible("MC_Got",true);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateEgg() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < EGG_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Egg" + _loc1_];
            _loc3_.MC_Hammer.visible = false;
            _loc4_ = this.FCapsuleToys.EggList[_loc1_];
            if(_loc4_ == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_Movie.visible = true;
               _loc3_.MC_OpenBox.visible = false;
               _loc3_.MC_Movie.gotoAndStop(1);
            }
            else
            {
               _loc3_.MC_Movie.visible = false;
               _loc3_.MC_OpenBox.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         FMC_Scene.TF_Desc.text = this.FCapsuleToys.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FCapsuleToys.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FCapsuleToys.EndTime) - 1) * 1000)));
         if(this.FCapsuleToys.FreeCount > 0)
         {
            FMC_Scene.MC_Price.visible = false;
            FMC_Scene.MC_Free.visible = true;
            FMC_Scene.MC_Free.TF_Count.text = this.FCapsuleToys.FreeCount.toString();
         }
         else
         {
            FMC_Scene.MC_Price.visible = true;
            FMC_Scene.MC_Free.visible = false;
            FMC_Scene.MC_Price.TF_Gold.text = this.FCapsuleToys.PlayPrice.toString();
         }
         FMC_Scene.MC_AutoPrice.TF_Gold.text = this.FCapsuleToys.AutoPlayPrice.toString();
         FMC_Scene.TF_Point.text = this.FCapsuleToys.ShopExchangePoint.toString();
         FMC_Scene.TF_Desc5.text = this.FCapsuleToys.BadgeCount.toString();
         FMC_Scene.TF_Desc4.text = this.FCapsuleToys.DescListNew[2];
      }
      
      protected function UpdateBadge() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BADGE_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Badge" + _loc1_];
            if(_loc1_ < this.FCapsuleToys.BadgeCount)
            {
               _loc2_.filters = [];
            }
            else
            {
               _loc2_.filters = [TGameUtil.GaryColorFilters];
            }
            _loc1_++;
         }
         if(this.FCapsuleToys.BadgeCount >= this.FCapsuleToys.BadgeCost)
         {
            this.FGlowFilter.IsRunOver = false;
         }
         else
         {
            this.FGlowFilter.Stop();
         }
         if(this.FCapsuleToys.ShearIndex != 0)
         {
            this.UpdateDesc();
         }
      }
      
      protected function UpdateRechargeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         this.FUIPage.TotalQuantity = this.FCapsuleToys.ConsumeGift.length;
         this.FUIPage.Update();
         _loc1_ = this.FCurPage;
         _loc3_ = this.FCapsuleToys.ConsumeGift[_loc1_];
         _loc2_ = FMC_Scene.MC_RechargeBox;
         _loc2_.MC_GoldPic.gotoAndStop(_loc1_ + 1);
         _loc2_.TF_Desc0.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[3],this.FCapsuleToys.TotalConsumeGold);
         _loc2_.TF_Desc1.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[4],_loc3_.Price);
         _loc2_.TF_Count.text = "*" + _loc3_.Inventories.GetInventoryByIndex(0).Quantity;
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
      }
      
      protected function UpdateDesc() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FCapsuleToys.ShearIndex == 0)
         {
            FMC_Scene.MC_Desc.visible = true;
            FMC_Scene.MC_Game.visible = false;
            FMC_Scene.MC_Desc.TF_Desc0.text = this.FCapsuleToys.DescListNew[5];
            FMC_Scene.MC_Desc.TF_Desc1.text = this.FCapsuleToys.DescListNew[6];
            _loc1_ = 0;
            while(_loc1_ < SHEAR_COUNT)
            {
               _loc2_ = FMC_Scene.MC_Desc["MC_Shear" + _loc1_];
               _loc2_.gotoAndStop(1);
               _loc2_.MC_Icon.gotoAndStop(_loc1_ + 1);
               FMC_Scene.MC_Desc["TF_Tip" + _loc1_].text = this.FCapsuleToys.DescListNew[7 + _loc1_];
               _loc1_++;
            }
            if(this.FCapsuleToys.BadgeCount >= this.FCapsuleToys.BadgeCost)
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,false);
            }
         }
         else if(this.FCapsuleToys.ShearIndex < 0)
         {
            FMC_Scene.MC_Desc.visible = true;
            FMC_Scene.MC_Game.visible = false;
            FMC_Scene.MC_Desc.TF_Desc0.text = this.FCapsuleToys.DescListNew[5];
            FMC_Scene.MC_Desc.TF_Desc1.text = this.FCapsuleToys.DescListNew[6];
            _loc1_ = 0;
            while(_loc1_ < SHEAR_COUNT)
            {
               _loc2_ = FMC_Scene.MC_Desc["MC_Shear" + _loc1_];
               _loc2_.gotoAndStop(1);
               _loc2_.MC_Icon.gotoAndStop(4);
               FMC_Scene.MC_Desc["TF_Tip" + _loc1_].text = "";
               _loc1_++;
            }
            TGameUtil.setButtonMode(FMC_Scene.MC_Desc.BTN_Start,false);
         }
         else
         {
            FMC_Scene.MC_Desc.visible = false;
            FMC_Scene.MC_Game.visible = true;
            this.UpdateGame();
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         if(this.FCapsuleToys.LastShear > 0)
         {
            FMC_Scene.MC_Game.visible = true;
            FMC_Scene.MC_Game.MC_Win.visible = false;
            FMC_Scene.MC_Game.MC_Lose.visible = false;
            FMC_Scene.MC_Game.TF_Count.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[10],this.FCapsuleToys.LastShear);
            FMC_Scene.MC_Game.TF_Score.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[11],this.FCapsuleToys.CurSock);
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               _loc5_ = FMC_Scene.MC_Game.MC_Bar["MC_Value" + _loc1_];
               _loc5_.TF_Count.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[12],this.FCapsuleToys.BarList[_loc1_].Price,this.FCapsuleToys.BarList[_loc1_].Count);
               _loc1_++;
            }
            _loc1_ = 0;
            while(_loc1_ < SOCK_COUNT)
            {
               _loc5_ = FMC_Scene.MC_Game["MC_Sock" + _loc1_];
               _loc5_.MC_Shear.visible = false;
               _loc5_.MC_Smoke.visible = false;
               _loc5_.MC_Icon.visible = false;
               _loc5_.MC_Img.visible = true;
               _loc5_.visible = this.FCapsuleToys.SockList[_loc1_] == 0 ? true : false;
               _loc5_.gotoAndStop(1);
               _loc1_++;
            }
            _loc4_ = this.FCapsuleToys.BarList[this.FCapsuleToys.BarList.length - 1].Price;
            _loc2_ = Number(this.FCapsuleToys.CurSock / _loc4_) * this.FBarMaxHeight;
            _loc3_ = Math.min(_loc2_,this.FBarMaxHeight);
            this.FMC_Mask.height = _loc3_;
         }
         else
         {
            FMC_Scene.MC_Game.visible = false;
         }
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
         this.UpdateRechargeBox();
      }
      
      protected function ProcessorOnShowShopDesc(param1:MouseEvent) : void
      {
         this.FIsShopShow = !this.FIsShopShow;
         FMC_Scene.MC_Shop.visible = this.FIsShopShow;
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FCapsuleToys) && !this.FIsPlaying)
         {
            if(this.FCapsuleToys.FreshTime <= STimingCore.GetServerTick())
            {
               this.ProcessorOnGetBoxUp(REQ_RESET);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(REQ_GOLD_RESET,this.FCapsuleToys.FreshCost);
            }
         }
      }
      
      protected function ProcessorOnEggUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FCapsuleToys) && this.FCapsuleToys.EggList[_loc2_] == TBaseActivity.STATUS_CANNOTGET)
         {
            if(this.FCapsuleToys.FreeCount > 0)
            {
               this.ProcessorOnGetBoxUp(REQ_PLAY,_loc2_ + 1);
            }
            else
            {
               this.ProcessorOnBuyBoxUp(REQ_PLAY,this.FCapsuleToys.PlayPrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnAutoPlayUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(this.FCapsuleToys) && Boolean(!this.FBeClicked) && !this.FIsPlaying)
         {
            this.ProcessorOnBuyBoxUp(REQ_AUTO_PLAY,this.FCapsuleToys.AutoPlayPrice,0);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(this.FCapsuleToys)
         {
            this.ProcessorOnGetBoxUp(REQ_EXCHANGE,param1 + 1);
         }
      }
      
      protected function ProcessorOnGetGiftUp(param1:int) : void
      {
         if(this.FCapsuleToys)
         {
            this.ProcessorOnGetBoxUp(REQ_GET_GIFT,param1 + 1);
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FCapsuleToys))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_3_START_GAME);
         }
      }
      
      protected function ProcessorOnChoiceShear(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FCapsuleToys) && this.FCapsuleToys.ShearIndex == -1)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_3_CHOICE_SHEAR,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnSockUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(!this.FIsPlaying) && Boolean(this.FCapsuleToys) && this.FCapsuleToys.SockList[_loc2_] == 0)
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_3_CUT_SOCK,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnRechargeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(!this.FIsPlaying) && Boolean(this.FCapsuleToys) && this.FCapsuleToys.ConsumeGift[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            this.ProcessorOnGetBoxUp(REQ_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnEnterUp(param1:MouseEvent) : void
      {
         this.UpdateDesc();
      }
      
      protected function ProcessorOnCloseGameDesc(param1:MouseEvent) : void
      {
         FMC_Scene.MC_Desc.visible = false;
      }
      
      protected function ProcessorOnRechargeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(this.FCapsuleToys != null)
         {
            ProcessorOnNewBoxOver(this.FCapsuleToys.ConsumeGift[_loc2_].Inventories);
         }
      }
      
      protected function ProcessorOnShearOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FCapsuleToys.ShearIndex == 0)
         {
            ProcessorOnShowHtmlText(this.FCapsuleToys.DescListNew[7 + _loc2_]);
         }
      }
      
      protected function ProcessorOnGetBoxUp(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(this.FBeClicked)
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
      
      protected function ProcessorOnBuyBoxUp(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0) : void
      {
         this.FBuyBoxDate.ActivityType = param1;
         this.FBuyBoxDate.Cost = param2;
         this.FBuyBoxDate.BoxIndex = param3;
         this.FBuyBoxDate.CostType = param4;
         this.FBuyBoxDate.BoxIndex1 = param6;
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
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int = 0) : void
      {
         ProcessorOnShowItemDesc(param1,param2);
      }
      
      protected function ProcessorOnHideWindow(param1:int = 0) : void
      {
         this.FWindowType = 0;
         switch(param1)
         {
            case WINDOW_EQUIPMENT_DESC:
               this.FProcessorWindowEquipDesc.Visible = false;
         }
      }
      
      protected function ProcessorOnEggOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FCapsuleToys)
         {
            FMC_Scene["MC_Egg" + _loc2_].MC_Hammer.visible = true;
         }
      }
      
      protected function ProcessorOnEggOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(this.FCapsuleToys)
         {
            FMC_Scene["MC_Egg" + _loc2_].MC_Hammer.visible = false;
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FCapsuleToys);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FCapsuleToys;
         super.ProcessorOnOpenDesc();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowEquipDesc.Load();
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
         this.FUnstreamizerCapsuleToys.Unstreamize(_loc2_,this.FCapsuleToys,null);
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
         if(this.FCapsuleToys)
         {
            this.FCapsuleToys.TotalConsumeGold = _loc2_.readUnsignedInt();
            this.FCapsuleToys.ChangeStatus();
            ProcessorCheckEffect(FActivityID,this.FCapsuleToys.CheckStatus());
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
         ProcessorUnstreamActivityLog(this.FCapsuleToys,_loc2_);
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
            case REQ_RESET:
            case REQ_GOLD_RESET:
               this.FCapsuleToys.FreshTime = _loc2_.readUnsignedInt();
               _loc5_ = 0;
               while(_loc5_ < this.FCapsuleToys.SaleItems.length)
               {
                  this.FCapsuleToys.SaleItems[_loc5_].Type = _loc2_.readUnsignedInt();
                  this.FCapsuleToys.SaleItems[_loc5_].Status = TBaseActivity.STATUS_CANNOTGET;
                  this.FCapsuleToys.EggList[_loc5_] = TBaseActivity.STATUS_CANNOTGET;
                  _loc5_++;
               }
               _loc4_ = STRING_BASEACTIVITY.FORMAT_REFRESH_SUCCESSED;
               this.FCapsuleToys.ChangeStatus();
               ProcessorEffectText(_loc4_);
               this.PlayMovie(MOVIE_OF_RESET);
               ProcessorCheckEffect(FActivityID,this.FCapsuleToys.CheckStatus());
               break;
            case REQ_PLAY:
               this.FOpenIndex = _loc2_.readUnsignedInt() - 1;
               _loc6_ = _loc2_.readUnsignedInt() - 1;
               _loc17_ = _loc2_.readUnsignedInt() - 1;
               this.FCapsuleToys.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FCapsuleToys.PlayPrice = _loc2_.readUnsignedInt();
               this.FCapsuleToys.BadgeCount = _loc2_.readUnsignedInt();
               if(this.FCapsuleToys.FreeCount > 0)
               {
                  --this.FCapsuleToys.FreeCount;
               }
               this.FCapsuleToys.SaleItems[_loc17_].Status = TBaseActivity.STATUS_CANGET;
               this.FCapsuleToys.EggList[this.FOpenIndex] = TBaseActivity.STATUS_CANGET;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc9_ = this.FCapsuleToys.AllItems.GetInventoryByIndex(_loc6_);
               _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity;
               this.FCapsuleToys.ChangeStatus();
               ProcessorEffectText(_loc4_);
               this.PlayMovie(MOVIE_OF_PLAY);
               ProcessorCheckEffect(FActivityID,this.FCapsuleToys.CheckStatus());
               break;
            case REQ_AUTO_PLAY:
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc5_ = 0;
               while(_loc5_ < EGG_COUNT)
               {
                  this.FCapsuleToys.SaleItems[_loc5_].Status = TBaseActivity.STATUS_CANGET;
                  this.FCapsuleToys.EggList[_loc5_] = TBaseActivity.STATUS_CANGET;
                  _loc6_ = _loc2_.readUnsignedInt() - 1;
                  _loc9_ = this.FCapsuleToys.AllItems.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc5_++;
               }
               this.FCapsuleToys.ShopExchangePoint = _loc2_.readUnsignedInt();
               this.FCapsuleToys.BadgeCount = _loc2_.readUnsignedInt();
               this.FCapsuleToys.ChangeStatus();
               ProcessorEffectText(_loc4_);
               this.PlayMovie(MOVIE_OF_AUTOPLAY);
               ProcessorCheckEffect(FActivityID,this.FCapsuleToys.CheckStatus());
               break;
            case REQ_EXCHANGE:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FCapsuleToys.ShopExchangePoint = _loc2_.readUnsignedInt();
               --this.FCapsuleToys.ShopExchangeItems[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               this.FCapsuleToys.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FCapsuleToys.CheckStatus());
               this.UpdateUI();
               break;
            case REQ_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FCapsuleToys.ConsumeGift[_loc5_].Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET;
               this.FCapsuleToys.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FCapsuleToys.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_3_START_GAME:
               this.FCapsuleToys.ShearIndex = TBaseActivity.STATUS_GETED;
               this.FCapsuleToys.BadgeCount = _loc2_.readUnsignedInt();
               this.PlayMovie(5);
               break;
            case ACTIVITY_3_CHOICE_SHEAR:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FCapsuleToys.ResetGame();
               this.FCapsuleToys.ShearIndex = _loc2_.readUnsignedInt();
               this.FCapsuleToys.LastShear = _loc2_.readUnsignedInt();
               this.PlayMovie(6);
               break;
            case ACTIVITY_3_CUT_SOCK:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               _loc12_ = _loc2_.readUnsignedInt();
               this.FCapsuleToys.CurSock += _loc12_;
               this.FCapsuleToys.SockList[_loc5_] = _loc2_.readUnsignedInt();
               this.FCapsuleToys.LastShear = _loc2_.readUnsignedInt();
               this.FCapsuleToys.IsEnd = _loc2_.readUnsignedInt();
               this.FCapsuleToys.Amount = _loc2_.readUnsignedInt();
               this.FCapsuleToys.ShopExchangePoint += this.FCapsuleToys.Amount;
               this.FCutShearIndex = _loc5_;
               this.PlayMovie(7);
               if(this.FCapsuleToys.SockList[_loc5_] == TCapsuleToys.TYPE_SOCK_NULL)
               {
                  ProcessorEffectText(this.FCapsuleToys.DescListNew[16]);
               }
               else
               {
                  _loc4_ = TUtilityString.Format(this.FCapsuleToys.DescListNew[17],_loc12_);
                  ProcessorEffectText(_loc4_);
               }
         }
      }
      
      public function PlayMovie(param1:int = 0) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_OF_RESET)
         {
            _loc2_ = FMC_Scene.MC_RefreshMovie;
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
            FMC_Scene.MC_Hero.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_PLAY)
         {
            _loc2_ = FMC_Scene["MC_Egg" + this.FOpenIndex].MC_Movie;
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_AUTOPLAY)
         {
            _loc2_ = FMC_Scene.MC_Movie0;
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
            FMC_Scene.MC_Hero.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SHEAR)
         {
            _loc3_ = 0;
            while(_loc3_ < SHEAR_COUNT)
            {
               _loc2_ = FMC_Scene.MC_Desc["MC_Shear" + _loc3_];
               this.FTotalFrame = _loc2_.totalFrames;
               _loc2_.gotoAndPlay(1);
               _loc3_++;
            }
         }
         else if(this.FMovieType == MOVIE_OF_CHOICE_SHEAR)
         {
            _loc2_ = FMC_Scene.MC_Desc.MC_Movie;
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.MC_Icon.gotoAndStop(this.FCapsuleToys.ShearIndex);
            _loc2_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_USE_SHEAR)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Shear.visible = true;
            FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Shear.gotoAndStop(this.FCapsuleToys.ShearIndex);
            _loc2_ = FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Shear.MC_Shear;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_NULL)
         {
            _loc2_ = FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Smoke;
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_FALL)
         {
            _loc2_ = FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex];
            _loc2_.visible = true;
            _loc2_.MC_Icon.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_GAME_LOSE)
         {
            _loc2_ = FMC_Scene.MC_Game.MC_Lose;
            _loc2_.MC_Text.TF_Text.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[14],this.FCapsuleToys.Amount);
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
         else if(this.FMovieType == MOVIE_OF_GAME_WIN)
         {
            FMC_Scene.MC_Game.MC_Win.visible = true;
            _loc2_ = FMC_Scene.MC_Game.MC_Win.MC_Movie;
            FMC_Scene.MC_Game.MC_Win.TF_Text.text = TUtilityString.Format(this.FCapsuleToys.DescListNew[15],this.FCapsuleToys.Amount);
            _loc2_.visible = true;
            this.FTotalFrame = _loc2_.totalFrames;
            _loc2_.gotoAndPlay(1);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FIsPlaying = false;
         if(this.FMovieType == MOVIE_OF_RESET)
         {
            FMC_Scene.MC_RefreshMovie.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_PLAY)
         {
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_AUTOPLAY)
         {
            FMC_Scene.MC_Movie0.visible = false;
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_SHEAR)
         {
            _loc2_ = 0;
            while(_loc2_ < SHEAR_COUNT)
            {
               FMC_Scene.MC_Desc["MC_Shear" + _loc2_].stop();
               _loc2_++;
            }
            this.UpdateUI();
            this.UpdateDesc();
         }
         else if(this.FMovieType == MOVIE_OF_CHOICE_SHEAR)
         {
            FMC_Scene.MC_Desc.MC_Movie.visible = false;
            this.UpdateDesc();
         }
         else if(this.FMovieType == MOVIE_OF_USE_SHEAR)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Shear.visible = false;
            FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].MC_Img.visible = false;
            if(this.FCapsuleToys.SockList[this.FCutShearIndex] == TCapsuleToys.TYPE_SOCK_NULL)
            {
               this.PlayMovie(MOVIE_OF_SOCK_NULL);
            }
            else
            {
               this.PlayMovie(MOVIE_OF_SOCK_FALL);
            }
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_NULL)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].visible = false;
            this.UpdateGame();
            if(this.FCapsuleToys.IsEnd == TCapsuleToys.TYPE_IS_LOSE)
            {
               this.PlayMovie(MOVIE_OF_GAME_LOSE);
            }
         }
         else if(this.FMovieType == MOVIE_OF_SOCK_FALL)
         {
            FMC_Scene.MC_Game["MC_Sock" + this.FCutShearIndex].visible = false;
            this.UpdateGame();
            if(this.FCapsuleToys.IsEnd == TCapsuleToys.TYPE_IS_WIN)
            {
               this.PlayMovie(MOVIE_OF_GAME_WIN);
            }
         }
         else if(this.FMovieType == MOVIE_OF_GAME_LOSE)
         {
            FMC_Scene.MC_Game.MC_Lose.visible = false;
            this.FCapsuleToys.ResetGame();
            this.UpdateUI();
         }
         else if(this.FMovieType == MOVIE_OF_GAME_WIN)
         {
            FMC_Scene.MC_Game.MC_Win.visible = false;
            this.FCapsuleToys.ResetGame();
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
         _loc3_.writeShort(7);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(STimingCore.GetServerTick() + 500);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(9);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_.writeInt(1);
            _loc1_++;
         }
         _loc3_.writeShort(20);
         _loc1_ = 0;
         while(_loc1_ < 20)
         {
            _loc3_.writeUnsignedInt(_loc1_ % 5);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(9);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(_loc1_ % 9 + 1);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeUnsignedInt(3);
            _loc3_.writeUnsignedInt(0);
            _loc3_.writeUnsignedInt(1);
            _loc3_.writeUnsignedInt(14100001 + _loc1_);
            _loc3_.writeUnsignedInt(5);
            _loc1_++;
         }
         _loc3_.writeShort(5);
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc3_.writeInt(1);
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeInt(1);
            _loc3_.writeShort(3);
            _loc2_ = 0;
            while(_loc2_ < 3)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(_loc1_);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

