package Processors.Game.Lobby.Exercise.NinjaCrystal
{
   import Components.Standard.TUITab;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.NinjaCrystal.TNinjaCrystal;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerNinjaCrystal;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorNinjaCrystal extends TProcessorBaseActivity
   {
      
      protected static const LOTTERY_COUNT:int = 12;
      
      protected static const TAB_COUNT:int = 4;
      
      protected static const GIFT_COUNT:int = 4;
      
      protected static const EXCHANGE_BOX_COUNT:int = 6;
      
      protected static const ACT_TASK_COUNT:int = 5;
      
      protected static const ACT_TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      public static const ACTIVITY_1_PLAY_GAME:int = 1;
      
      public static const ACTIVITY_1_GET_GIFT:int = 2;
      
      public static const ACTIVITY_1_EXCHANGE_ITEM:int = 3;
      
      public static const ACTIVITY_1_EXCHANGE_HERO:int = 4;
      
      protected static const ROTATE_MOVIE:int = 1;
      
      protected static const SHINE_MOVIE:int = 2;
      
      protected static const BAR_MOVIE:int = 3;
      
      protected static const GET_MOVIE:int = 4;
      
      protected static const ADD_ROUND:int = 1;
      
      protected static const RANDOM_ROUND:int = 2;
      
      protected var FBeClicked:Boolean;
      
      protected var FIsOpen:Boolean;
      
      protected var FBuyBoxDate:Object;
      
      protected var FCost:int;
      
      protected var FIsPlaying:Boolean;
      
      protected var FWindowType:int;
      
      protected var FMovieType:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FTotalFrame:int;
      
      protected var FPlayMovie:MovieClip;
      
      protected var FNinjaCrystal:TNinjaCrystal;
      
      protected var FUnstreamizerNinjaCrystal:TUnstreamizerNinjaCrystal;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FLotteryItem:TUIShowItem;
      
      protected var FExchangeList:Vector.<TUIBaseBox>;
      
      protected var FMC_LittlePetEffect:Sprite;
      
      protected var FLittlePetBmp:Bitmap;
      
      protected var FTargetIndex:int;
      
      protected var FCurIndex:int;
      
      protected var FTargetStep:int;
      
      protected var FCurStep:int;
      
      protected var FTimeid:int;
      
      public function TProcessorNinjaCrystal(param1:TUIComponent, param2:TLobbyParameters, param3:uint)
      {
         super(param1,param2,param3);
         FActivityID = param3;
         this.FNinjaCrystal = SLogicsCore.NinjaCrystal;
         this.FUnstreamizerNinjaCrystal = new TUnstreamizerNinjaCrystal();
         this.FBuyBoxDate = new Object();
         this.FUITab = new TUITab(this);
         this.FExchangeList = new Vector.<TUIBaseBox>(EXCHANGE_BOX_COUNT);
         this.FLittlePetBmp = new Bitmap();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TUIBaseBox = null;
         super.ResourcesPerform_UIDispatch();
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc4_ = FMC_Scene.MC_Gifts["MC_Box" + _loc1_];
            _loc4_.MC_Reward.gotoAndStop(_loc1_ + 1);
            TGameUtil.setButtonMode(_loc4_.BTN_Get,true);
            _loc4_.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc4_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            _loc4_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc5_ = new TUIBaseBox(this,1);
            _loc5_.Perform_UIDispatch(FMC_Scene.MC_Items["MC_Item" + _loc1_]);
            _loc5_.OnOverlay = UIComponentsHintOnOver;
            _loc5_.OnOut = UIComponentsHintOnOut;
            this.FExchangeList[_loc1_] = _loc5_;
            FMC_Scene.MC_Items["MC_Item" + _loc1_].BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.ChangeTabOnSwitch;
         this.FUITab.Init();
         this.FLotteryItem = new TUIShowItem(this,LOTTERY_COUNT);
         this.FLotteryItem.Perform_UIDispatch(FMC_Scene.MC_Game);
         this.FLotteryItem.OnOverlay = UIComponentsHintOnOver;
         this.FLotteryItem.OnOut = UIComponentsHintOnOut;
         this.FMC_LittlePetEffect = FMC_Scene.MC_Hero["MC_LittlePetEffect"];
         this.FMC_LittlePetEffect.addChild(this.FLittlePetBmp);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
         TGameUtil.setButtonMode(FMC_Scene.MC_Game.BTN_Start,true);
         FMC_Scene.MC_Game.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Exchange,true);
         FMC_Scene.MC_Hero.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_HeroDesc,true);
         FMC_Scene.MC_Hero.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroDescUp);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
         FMC_Scene.MC_Hero.MC_LittlePetEffect.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.MC_LittlePetEffect.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(Boolean(FMC_Scene) && FMC_Scene.visible)
         {
            if(Boolean(this.FNinjaCrystal) && Boolean(this.FNinjaCrystal.Hero) && this.FNinjaCrystal.Hero.Type == TBaseBox.TYPE_IS_PET)
            {
               this.UpdateLittlePetEffect();
            }
            if(this.FLotteryItem)
            {
               this.FLotteryItem.LogicsPerform();
            }
            _loc1_ = 0;
            while(_loc1_ < this.FExchangeList.length)
            {
               this.FExchangeList[_loc1_].LogicsPerform();
               _loc1_++;
            }
            if(this.FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case ROTATE_MOVIE:
                     this.PlayMovie(ROTATE_MOVIE);
               }
            }
         }
      }
      
      override protected function UpdateUI() : void
      {
         this.UpdateBox();
         this.UpdateGame();
         this.UpdateExchange();
         this.UpdateText();
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         FMC_Scene.MC_Gifts.TF_Count.text = this.FNinjaCrystal.GiftCount.toString();
         FMC_Scene.MC_Gifts.TF_Gold.text = this.FNinjaCrystal.GiftPrice.toString();
         FMC_Scene.MC_Gifts.TF_RechargeGold.text = this.FNinjaCrystal.TotalRechargeGold.toString();
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc3_ = FMC_Scene.MC_Gifts["MC_Box" + _loc1_];
            _loc3_.TF_Count.text = this.FNinjaCrystal.RechargeList[_loc1_].Count.toString();
            if(this.FNinjaCrystal.GiftCount > 0)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         var _loc5_:TInventory = null;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            FMC_Scene["MC_Tab" + _loc1_].TF_Price.text = TUtilityString.Format(this.FNinjaCrystal.DescListNew[2],this.FNinjaCrystal.LotteryPrice[_loc1_]);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < LOTTERY_COUNT)
         {
            _loc2_ = FMC_Scene.MC_Game["MC_Slot" + _loc1_];
            _loc2_.MC_Selected.visible = false;
            _loc2_.MC_Get.visible = false;
            _loc1_++;
         }
         this.FLotteryItem.UpdateUI(this.FNinjaCrystal.LotteryItems[this.FChangeTabIndex]);
         _loc4_ = this.FNinjaCrystal.LotteryPrice[this.FChangeTabIndex];
         FMC_Scene.MC_Game.TF_Price.text = _loc4_.toString();
         if(this.FNinjaCrystal.MyScore >= _loc4_)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_Game.BTN_Start,true);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_Game.BTN_Start,false);
         }
      }
      
      protected function UpdateExchange() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         if(this.FNinjaCrystal.ShopExchangeItems.length == 0)
         {
            FMC_Scene.MC_Hero.visible = true;
            FMC_Scene.MC_Items.visible = false;
            this.UpdateExchangeHero();
         }
         else
         {
            FMC_Scene.MC_Hero.visible = false;
            FMC_Scene.MC_Items.visible = true;
            this.UpdateExchangeItem();
         }
      }
      
      protected function UpdateExchangeHero() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FNinjaCrystal.Hero;
         FMC_Scene.MC_Hero.TF_Price.text = _loc1_.Price.toString();
         if(_loc1_.Type == TBaseBox.TYPE_IS_HERO)
         {
            FMC_Scene.MC_Hero.MC_Hero.visible = true;
            FMC_Scene.MC_Hero.MC_LittlePetEffect.visible = false;
         }
         else
         {
            FMC_Scene.MC_Hero.MC_Hero.visible = false;
            FMC_Scene.MC_Hero.MC_LittlePetEffect.visible = true;
         }
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Hero.MC_Got.visible = true;
            FMC_Scene.MC_Hero.BTN_Exchange.visible = false;
         }
         else if(this.FNinjaCrystal.MyScore >= _loc1_.Price)
         {
            FMC_Scene.MC_Hero.MC_Got.visible = false;
            FMC_Scene.MC_Hero.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Exchange,true);
         }
         else
         {
            FMC_Scene.MC_Hero.MC_Got.visible = false;
            FMC_Scene.MC_Hero.BTN_Exchange.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Exchange,false);
         }
      }
      
      protected function UpdateExchangeItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc4_ = this.FNinjaCrystal.ShopExchangeItems[_loc1_];
            this.FExchangeList[_loc1_].UpdateUI(_loc4_.Inventories);
            this.FExchangeList[_loc1_].Identify = _loc1_;
            _loc3_ = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc4_.LimitCount.toString());
            this.FExchangeList[_loc1_].SetLimitText(_loc3_);
            _loc3_ = _loc4_.Price.toString();
            this.FExchangeList[_loc1_].SetPriceText(_loc3_);
            if(this.FNinjaCrystal.MyScore < _loc4_.Price || _loc4_.LimitCount <= 0)
            {
               this.FExchangeList[_loc1_].SetExchangeBtnMode(false);
            }
            else
            {
               this.FExchangeList[_loc1_].SetExchangeBtnMode(true);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.TF_Desc.text = this.FNinjaCrystal.DescListNew[1];
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNinjaCrystal.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNinjaCrystal.EndTime) - 1) * 1000)));
         FMC_Scene.MC_MyScore.TF_Score.text = this.FNinjaCrystal.MyScore.toString();
      }
      
      protected function UpdateLittlePetEffect() : void
      {
         if(Boolean(this.FNinjaCrystal) && this.FNinjaCrystal.Hero.Identify != 0)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FLittlePetBmp,CONST_MODULES.ACTIVE_Test,this.FNinjaCrystal.Hero.Identify,2);
         }
         else
         {
            this.FLittlePetBmp.bitmapData = null;
         }
      }
      
      override protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         super.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ChangeTabOnSwitch(param1:Object) : void
      {
         var _loc2_:int = param1 as int;
         if(_loc2_ == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = _loc2_;
         if(this.FIsPlaying)
         {
            this.FMovieType = GET_MOVIE;
            this.MovieEnd();
         }
         else
         {
            this.UpdateGame();
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FNinjaCrystal))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_PLAY_GAME,this.FChangeTabIndex + 1);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!this.FIsPlaying && Boolean(this.FNinjaCrystal))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(!this.FIsPlaying && Boolean(this.FNinjaCrystal))
         {
            _loc3_ = this.FNinjaCrystal.RechargeList[_loc2_].Inventories;
            ProcessorOnNewBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!this.FIsPlaying && Boolean(this.FNinjaCrystal))
         {
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_ITEM,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FIsPlaying && Boolean(this.FNinjaCrystal))
         {
            _loc2_ = this.FNinjaCrystal.Hero;
            this.ProcessorOnGetBoxUp(ACTIVITY_1_EXCHANGE_HERO);
         }
      }
      
      protected function ProcessorOnHeroDescUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(Boolean(this.FNinjaCrystal) && Boolean(this.FNinjaCrystal.Hero))
         {
            _loc2_ = this.FNinjaCrystal.Hero;
            ProcessorOnShowItemDesc(_loc2_.Identify,_loc2_.Type);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(this.FNinjaCrystal)
         {
            ProcessorOnShowHtmlText(this.FNinjaCrystal.DescListNew[3]);
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
      
      override protected function ProcessorOnOpenDesc(param1:MouseEvent = null) : void
      {
         FProcessorWindowDesc.BaseActivity = this.FNinjaCrystal;
         super.ProcessorOnOpenDesc();
      }
      
      override protected function PerformPacket_CS_LoadLogReq(param1:MouseEvent = null) : void
      {
         PerformPacket_CS_AcitivityThird_LoadLogReq(1,null);
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
      
      override public function Unmount() : void
      {
         super.Unmount();
         this.visible = false;
         this.FIsOpen = false;
         TweenUtil.removeAllTween();
         clearTimeout(this.FTimeid);
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
         this.FUnstreamizerNinjaCrystal.Unstreamize(_loc2_,this.FNinjaCrystal,null);
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
         if(this.FNinjaCrystal)
         {
            this.FNinjaCrystal.TotalRechargeGold = _loc2_.readUnsignedInt();
            this.FNinjaCrystal.GiftCount = _loc2_.readUnsignedInt();
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
         ProcessorUnstreamActivityLog(this.FNinjaCrystal,_loc2_);
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
         var _loc24_:TDessertHouseTask = null;
         var _loc25_:int = 0;
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
            case ACTIVITY_1_PLAY_GAME:
               this.FTargetIndex = _loc2_.readUnsignedInt() - 1;
               this.FNinjaCrystal.MyScore = _loc2_.readUnsignedInt();
               this.FIsPlaying = true;
               _loc25_ = int(Math.random() * RANDOM_ROUND) + ADD_ROUND;
               this.FTargetStep = LOTTERY_COUNT * _loc25_ + this.FTargetIndex;
               this.PlayMovie(ROTATE_MOVIE);
               break;
            case ACTIVITY_1_GET_GIFT:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               --this.FNinjaCrystal.GiftCount;
               this.FNinjaCrystal.MyScore = _loc2_.readUnsignedInt();
               _loc4_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc6_ = 0;
               while(_loc6_ < this.FNinjaCrystal.RechargeList[_loc5_].Inventories.Count)
               {
                  _loc9_ = this.FNinjaCrystal.RechargeList[_loc5_].Inventories.GetInventoryByIndex(_loc6_);
                  _loc4_ += _loc9_.Name + "*" + _loc9_.Quantity + "\n";
                  _loc6_++;
               }
               ProcessorEffectText(_loc4_);
               this.FNinjaCrystal.ChangeStatus();
               ProcessorCheckEffect(FActivityID,this.FNinjaCrystal.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_ITEM:
               _loc5_ = _loc2_.readUnsignedInt() - 1;
               this.FNinjaCrystal.MyScore = _loc2_.readUnsignedInt();
               --this.FNinjaCrystal.ShopExchangeItems[_loc5_].LimitCount;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               this.FNinjaCrystal.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FNinjaCrystal.CheckStatus());
               this.UpdateUI();
               break;
            case ACTIVITY_1_EXCHANGE_HERO:
               this.FNinjaCrystal.MyScore = _loc2_.readUnsignedInt();
               this.FNinjaCrystal.Hero.Status = TBaseActivity.STATUS_GETED;
               _loc4_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               this.FNinjaCrystal.ChangeStatus();
               ProcessorEffectText(_loc4_);
               ProcessorCheckEffect(FActivityID,this.FNinjaCrystal.CheckStatus());
               this.UpdateUI();
         }
      }
      
      public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:TInventory = null;
         var _loc7_:String = null;
         this.FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == ROTATE_MOVIE)
         {
            this.FLotteryItem.SetSelected(false,this.FCurIndex);
            if(this.FCurStep == this.FTargetStep)
            {
               this.MovieEnd();
            }
            else
            {
               ++this.FCurStep;
               this.FCurIndex = this.FCurIndex < LOTTERY_COUNT - 1 ? int(this.FCurIndex + 1) : 0;
            }
         }
         else if(this.FMovieType == GET_MOVIE)
         {
            this.FTimeid = setTimeout(this.MovieEnd,1500);
            this.FLotteryItem.SetGetCount(true,this.FTargetIndex);
            _loc6_ = this.FNinjaCrystal.LotteryItems[this.FChangeTabIndex].GetInventoryByIndex(this.FTargetIndex);
            _loc7_ = _loc6_.Name + "*" + _loc6_.Quantity;
            ProcessorEffectText(_loc7_);
         }
      }
      
      public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.FIsPlaying = false;
         if(this.FMovieType == ROTATE_MOVIE)
         {
            this.PlayMovie(GET_MOVIE);
         }
         else if(this.FMovieType == GET_MOVIE)
         {
            clearTimeout(this.FTimeid);
            this.FIsPlaying = false;
            this.UpdateUI();
            this.FCurIndex = 0;
            this.FCurStep = 0;
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
         _loc3_.writeShort(4);
         TUtilityString.FlushUTF(_loc3_,"活动详情长");
         TUtilityString.FlushUTF(_loc3_,"活动详情短");
         TUtilityString.FlushUTF(_loc3_,"%0积分");
         TUtilityString.FlushUTF(_loc3_,"宠物或忍者TIPS");
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeInt(3);
            _loc3_.writeShort(1);
            _loc2_ = 0;
            while(_loc2_ < 1)
            {
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeUnsignedInt(10 + _loc1_);
            _loc1_++;
         }
         _loc3_.writeShort(4);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc3_.writeShort(12);
            _loc2_ = 0;
            while(_loc2_ < 12)
            {
               _loc3_.writeUnsignedInt(_loc1_ % 2);
               _loc3_.writeUnsignedInt(1);
               _loc3_.writeUnsignedInt(14100001 + _loc1_ + _loc2_);
               _loc3_.writeUnsignedInt(5);
               _loc2_++;
            }
            _loc1_++;
         }
         _loc3_.writeInt(1);
         _loc3_.writeInt(0);
         _loc3_.writeUnsignedInt(100);
         _loc3_.writeUnsignedInt(11210009);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeUnsignedInt(1);
         _loc3_.writeShort(0);
         _loc1_ = 0;
         while(_loc1_ < 0)
         {
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeInt(_loc1_ + 2);
            _loc3_.writeInt(1);
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
         _loc3_.position = 0;
         return _loc3_;
      }
   }
}

