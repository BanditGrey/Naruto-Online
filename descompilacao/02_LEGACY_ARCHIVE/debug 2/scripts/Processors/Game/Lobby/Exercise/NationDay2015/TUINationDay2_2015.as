package Processors.Game.Lobby.Exercise.NationDay2015
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.NationalDay_2015.TNationalDay2_2015;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUINationDay2_2015 extends TUIBaseWindow
   {
      
      public static const SHOW_ITEM_COUNT:int = 26;
      
      public static const DICE_COUNT:int = 6;
      
      public static const LOG_COUNT:int = 7;
      
      public static const HOUSE_COUNT:int = 2;
      
      public static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_DICE:int = 0;
      
      public static const MOVIE_PLAYER_MOVE:int = 1;
      
      public static const MOVIE_ATTACK_BOSS:int = 2;
      
      public static const MOVIE_WAIT:int = 3;
      
      protected static const MOVIE_TIMES:int = 10;
      
      protected var FNationalDay2_2015:TNationalDay2_2015;
      
      protected var FShowItem:Vector.<TUIShowItem>;
      
      protected var FIsMoviePlay:Boolean;
      
      protected var FSelectIndex:int;
      
      protected var FUpgradeCost:int;
      
      protected var FProcessorFebActiveShop:TProcessorNationActiveShop_2015;
      
      protected var FMovieType:int;
      
      protected var FStep:int;
      
      protected var FFrameCount:int;
      
      protected var FMoveIndex:int;
      
      protected var FEndIndex:int;
      
      protected var FMovieTimeID:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TUINationDay2_2015(param1:TUIComponent)
      {
         super(param1);
         this.FIsMoviePlay = true;
         this.FSelectIndex = -1;
         this.FShowItem = new Vector.<TUIShowItem>(SHOW_ITEM_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:TUIShowItem = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < SHOW_ITEM_COUNT)
         {
            _loc6_ = new TUIShowItem(this,1);
            _loc6_.Perform_UIDispatch(FMC_Scene["MC_Slot" + _loc2_]);
            _loc6_.OnOverlay = this.ProcessorOnItemOver;
            _loc6_.OnOut = this.ProcessorOnItemOut;
            this.FShowItem[_loc2_] = _loc6_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < DICE_COUNT)
         {
            _loc5_ = FMC_Scene.MC_SelectUI["MC_Dice" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.MC_Dice.gotoAndStop(_loc2_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnDiceUp);
            _loc2_++;
         }
         FMC_Scene.MC_SelectUI.visible = false;
         FMC_Scene.MC_UpgradeUI.visible = false;
         FMC_Scene.MC_Dice.visible = false;
         FMC_Scene.MC_Attack.visible = false;
         this.FProcessorFebActiveShop = new TProcessorNationActiveShop_2015(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = -180;
         this.FProcessorFebActiveShop.y = -24;
         if(FMC_Scene.MC_Bar)
         {
            this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.MC_Box.MC_BoxPic.buttonMode = true;
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Box.MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Start,true);
         FMC_Scene.BTN_Start.addEventListener(MouseEvent.CLICK,this.ProcessorOnStartUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Select,true);
         FMC_Scene.BTN_Select.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectUp);
         FMC_Scene.BTN_Skip.buttonMode = true;
         FMC_Scene.BTN_Skip.addEventListener(MouseEvent.CLICK,this.ProcessorOnSkipUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_UpgradeUI.BTN_OK,true);
         FMC_Scene.MC_UpgradeUI.BTN_OK.addEventListener(MouseEvent.CLICK,this.ProcessorOnUpgradeOKUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_UpgradeUI.BTN_Cancel,true);
         FMC_Scene.MC_UpgradeUI.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.ProcessorOnUpgradeCancelUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_SelectUI.BTN_OK,true);
         FMC_Scene.MC_SelectUI.BTN_OK.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectOKUp);
         TGameUtil.setButtonMode(FMC_Scene.MC_SelectUI.BTN_Cancel,true);
         FMC_Scene.MC_SelectUI.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.ProcessorOnSelectCancelUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Back,true);
         FMC_Scene.BTN_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
      }
      
      protected function UpdateShowItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < SHOW_ITEM_COUNT)
         {
            _loc2_ = FMC_Scene["MC_Slot" + _loc1_];
            _loc3_ = this.FNationalDay2_2015.ItemList[_loc1_];
            if(_loc1_ == this.FNationalDay2_2015.StepIndex)
            {
               _loc2_.MC_Effect.visible = true;
            }
            else
            {
               _loc2_.MC_Effect.visible = false;
            }
            if(_loc3_.Type == TNationalDay2_2015.TYPE_ITEM)
            {
               _loc2_.MC_Slot0.visible = true;
               _loc2_.MC_Home.visible = false;
               _loc2_.MC_Attack.visible = false;
               _loc2_.MC_Double.visible = false;
               this.FShowItem[_loc1_].UpdateUI(_loc3_.Inventories);
            }
            else if(_loc3_.Type == TNationalDay2_2015.TYPE_HOME)
            {
               _loc2_.MC_Slot0.visible = false;
               _loc2_.MC_Home.visible = true;
               _loc2_.MC_Attack.visible = false;
               _loc2_.MC_Double.visible = false;
               _loc2_.MC_Home.gotoAndStop(_loc3_.Level);
            }
            else if(_loc3_.Type == TNationalDay2_2015.TYPE_HURT)
            {
               _loc2_.MC_Slot0.visible = false;
               _loc2_.MC_Home.visible = false;
               _loc2_.MC_Attack.visible = true;
               _loc2_.MC_Double.visible = false;
               _loc2_.MC_Attack.TF_Count.text = _loc3_.Count.toString();
            }
            else
            {
               _loc2_.MC_Slot0.visible = false;
               _loc2_.MC_Home.visible = false;
               _loc2_.MC_Attack.visible = false;
               _loc2_.MC_Double.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         if(this.FIsMoviePlay)
         {
            FMC_Scene.BTN_Skip.gotoAndStop(2);
         }
         else
         {
            FMC_Scene.BTN_Skip.gotoAndStop(1);
         }
         if(this.FSelectIndex == -1)
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_SelectUI.BTN_OK,false);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.MC_SelectUI.BTN_OK,true);
         }
         _loc1_ = 0;
         while(_loc1_ < DICE_COUNT)
         {
            _loc2_ = FMC_Scene.MC_SelectUI["MC_Dice" + _loc1_];
            if(_loc1_ == this.FSelectIndex)
            {
               _loc2_.MC_Select.visible = true;
            }
            else
            {
               _loc2_.MC_Select.visible = false;
            }
            _loc1_++;
         }
         FMC_Scene.MC_Double.gotoAndStop(this.FNationalDay2_2015.DoubleStatus + 1);
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:MovieClip = null;
         _loc1_ = this.FNationalDay2_2015.Gift;
         _loc2_ = FMC_Scene.MC_Box;
         _loc2_.TF_Count.text = "*" + _loc1_.Count;
         _loc2_.TF_Desc.text = this.FNationalDay2_2015.DescListNew[2];
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
      
      protected function UpdateLog() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:TLotteryNews = null;
         var _loc4_:String = null;
         var _loc5_:TSystemLanguage = null;
         var _loc6_:String = null;
         _loc1_ = 0;
         while(_loc1_ < LOG_COUNT)
         {
            _loc2_ = FMC_Scene["TF_Log" + _loc1_];
            if(_loc1_ < this.FNationalDay2_2015.NewsList.length)
            {
               _loc3_ = this.FNationalDay2_2015.NewsList[_loc1_];
               _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,_loc3_.SoureID) as TSystemLanguage;
               if(_loc5_ == null)
               {
                  throw new Error("SystemLanguage表未配置 " + _loc3_.SoureID);
               }
               _loc4_ = _loc5_.Desc;
               if(_loc3_.GetTime > 0)
               {
                  _loc6_ = TUtilityDate.FormatDateChineseNew(new Date(_loc3_.GetTime * 1000));
                  _loc4_ = _loc4_.split("%when%").join(_loc6_);
               }
               if(Boolean(_loc3_.PlayerNick) && _loc3_.PlayerNick != "")
               {
                  _loc4_ = _loc4_.split("%who%").join(_loc3_.PlayerNick);
               }
               _loc2_.text = _loc4_;
            }
            else
            {
               _loc2_.text = "";
            }
            _loc1_++;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.TF_Desc.text = this.FNationalDay2_2015.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FNationalDay2_2015.ShopExchangePoint.toString();
         FMC_Scene.TF_TotalScore.text = this.FNationalDay2_2015.RankPoint.toString();
         FMC_Scene.TF_FreeCount.text = this.FNationalDay2_2015.Count.toString();
         FMC_Scene.MC_SelectUI.TF_Price.text = this.FNationalDay2_2015.DicePrice.toString();
         if(FMC_Scene.MC_Bar)
         {
            FMC_Scene.MC_Bar.TF_Count.text = this.FNationalDay2_2015.BossHp + "/" + this.FNationalDay2_2015.BossMaxHp;
            _loc1_ = Number(this.FNationalDay2_2015.BossHp / this.FNationalDay2_2015.BossMaxHp) * this.FBarMaxWidth;
            _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
            this.FMC_Mask.width = _loc2_;
         }
      }
      
      protected function UpdateUpgradeUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         if(this.FNationalDay2_2015.StepIndex < 0)
         {
            return;
         }
         _loc3_ = this.FNationalDay2_2015.ItemList[this.FNationalDay2_2015.StepIndex];
         if(_loc3_.Level > 0 && _loc3_.Level <= this.FNationalDay2_2015.UpgradePrice.length && this.FNationalDay2_2015.UpgradeStatus == 1)
         {
            FMC_Scene.MC_UpgradeUI.visible = true;
            _loc2_ = FMC_Scene.MC_UpgradeUI["MC_House0"];
            _loc2_.MC_House.gotoAndStop(_loc3_.Level);
            _loc2_.TF_Desc.text = this.FNationalDay2_2015.DescListNew[10 + _loc3_.Level];
            _loc2_ = FMC_Scene.MC_UpgradeUI["MC_House1"];
            _loc2_.MC_House.gotoAndStop(_loc3_.Level + 1);
            _loc2_.TF_Desc.text = this.FNationalDay2_2015.DescListNew[11 + _loc3_.Level];
            FMC_Scene.MC_UpgradeUI.TF_Level.text = _loc3_.Level.toString();
            FMC_Scene.MC_UpgradeUI.TF_Price.text = this.FNationalDay2_2015.UpgradePrice[_loc3_.Level - 1].toString();
         }
         else
         {
            FMC_Scene.MC_UpgradeUI.visible = false;
            this.FNationalDay2_2015.UpgradeStatus = 0;
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(!FIsPlaying && FOnGetBox != null) && Boolean(this.FNationalDay2_2015) && this.FNationalDay2_2015.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_GET_BOX);
         }
      }
      
      protected function ProcessorOnStartUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null && this.FNationalDay2_2015) && Boolean(this.FNationalDay2_2015.UpgradeStatus == 0) && !FIsPlaying)
         {
            if(this.FNationalDay2_2015.Count > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_PLAY_GAME);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_PLAY_GAME,this.FNationalDay2_2015.Price);
            }
         }
      }
      
      protected function ProcessorOnSelectUp(param1:MouseEvent) : void
      {
         FMC_Scene.MC_SelectUI.visible = true;
      }
      
      protected function ProcessorOnDiceUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this.FSelectIndex = int(String(param1.currentTarget.name).slice(7));
         this.UpdateBtn();
      }
      
      protected function ProcessorOnSelectOKUp(param1:MouseEvent) : void
      {
         if(Boolean(!FIsPlaying && FOnBuyBox != null) && Boolean(this.FNationalDay2_2015) && this.FSelectIndex != -1)
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_BUY_DICE,this.FNationalDay2_2015.DicePrice,this.FSelectIndex + 1);
         }
      }
      
      protected function ProcessorOnSelectCancelUp(param1:MouseEvent) : void
      {
         if(this.FNationalDay2_2015)
         {
            FMC_Scene.MC_SelectUI.visible = false;
         }
      }
      
      protected function ProcessorOnUpgradeOKUp(param1:MouseEvent) : void
      {
         var _loc2_:TBaseBox = null;
         if(!FIsPlaying && FOnBuyBox != null && Boolean(this.FNationalDay2_2015))
         {
            _loc2_ = this.FNationalDay2_2015.ItemList[this.FNationalDay2_2015.StepIndex];
            this.FUpgradeCost = this.FNationalDay2_2015.UpgradePrice[_loc2_.Level - 1];
            FOnBuyBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_UPGRADE,this.FUpgradeCost,this.FNationalDay2_2015.StepIndex + 1);
         }
      }
      
      protected function ProcessorOnUpgradeCancelUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && Boolean(this.FNationalDay2_2015))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_UPGRADE_CANCEL);
            FMC_Scene.MC_UpgradeUI.visible = false;
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FNationalDay2_2015))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorNationDay2015.ACTIVITY_2_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnSkipUp(param1:MouseEvent) : void
      {
         if(this.FIsMoviePlay)
         {
            this.FIsMoviePlay = false;
            FMC_Scene.BTN_Skip.gotoAndStop(1);
         }
         else
         {
            this.FIsMoviePlay = true;
            FMC_Scene.BTN_Skip.gotoAndStop(2);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FNationalDay2_2015))
         {
            FOnNewBoxOver(this.FNationalDay2_2015.Gift.Inventories);
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
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FNationalDay2_2015);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnBackUp(param1:MouseEvent) : void
      {
         if(!FIsPlaying && FOnShowWindow != null)
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
               _loc1_ = 0;
               while(_loc1_ < this.FShowItem.length)
               {
                  this.FShowItem[_loc1_].LogicsPerform();
                  _loc1_++;
               }
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_DICE:
                     CurFrame = FMC_Scene.MC_Dice.currentFrame;
                     break;
                  case MOVIE_PLAYER_MOVE:
                     this.PlayHeroMove();
                     return;
                  case MOVIE_ATTACK_BOSS:
                     CurFrame = FMC_Scene.MC_Attack.currentFrame;
                     break;
                  case MOVIE_WAIT:
                     return;
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
         this.FNationalDay2_2015 = SLogicsCore.NationalDayDatas_2015.GetActivityByIdentify(ACTIVITY_2_ID) as TNationalDay2_2015;
         this.UpdateShowItem();
         this.UpdateBtn();
         this.UpdateGift();
         this.UpdateLog();
         this.UpdateText();
         this.UpdateUpgradeUI();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FNationalDay2_2015);
         }
      }
      
      public function PlayHeroMove() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:int = 0;
         if(this.FIsMoviePlay)
         {
            this.FMovieType = MOVIE_PLAYER_MOVE;
            ++this.FFrameCount;
            if(this.FFrameCount < MOVIE_TIMES)
            {
               return;
            }
            FMC_Scene.MC_Dice.visible = false;
            this.FFrameCount = 0;
            _loc1_ = 0;
            while(_loc1_ < SHOW_ITEM_COUNT)
            {
               FMC_Scene["MC_Slot" + _loc1_].MC_Effect.visible = false;
               _loc1_++;
            }
            ++this.FMoveIndex;
            this.FMoveIndex %= SHOW_ITEM_COUNT;
            FMC_Scene["MC_Slot" + this.FMoveIndex].MC_Effect.visible = true;
            if(this.FMoveIndex == this.FEndIndex)
            {
               this.HeroMoveEnd();
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < SHOW_ITEM_COUNT)
            {
               FMC_Scene["MC_Slot" + _loc1_].MC_Effect.visible = false;
               _loc1_++;
            }
            FMC_Scene["MC_Slot" + this.FEndIndex].MC_Effect.visible = true;
            this.HeroMoveEnd();
            FMC_Scene.MC_Dice.visible = false;
         }
      }
      
      public function HeroMoveEnd() : void
      {
         FIsPlaying = false;
         if(this.FNationalDay2_2015.ItemList[this.FNationalDay2_2015.TargetIndex % SHOW_ITEM_COUNT].Type != TNationalDay2_2015.TYPE_HURT)
         {
            FOnShowFlowText(this.FNationalDay2_2015.GameFlowText());
            this.FNationalDay2_2015.StepIndex = this.FNationalDay2_2015.TargetIndex;
            this.FNationalDay2_2015.DoubleStatus = this.FNationalDay2_2015.NextDoubleStatus;
            this.UpdateUI();
         }
         else
         {
            this.PlayMovie(MOVIE_ATTACK_BOSS);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_DICE)
         {
            if(this.FIsMoviePlay)
            {
               FMC_Scene.MC_SelectUI.visible = false;
               _loc4_ = FMC_Scene.MC_Dice;
               _loc4_.visible = true;
               FTotalFrame = _loc4_.totalFrames;
               _loc4_.gotoAndPlay(1);
            }
            else
            {
               FMC_Scene.MC_Dice.gotoAndStop(11);
               FMC_Scene.MC_Dice.visible = true;
               _loc4_ = FMC_Scene.MC_Dice.MC_Last;
               _loc4_.gotoAndStop(this.FNationalDay2_2015.Step);
               this.FMoveIndex = this.FNationalDay2_2015.StepIndex;
               this.FEndIndex = this.FNationalDay2_2015.TargetIndex;
               FIsPlaying = true;
               this.FMovieType = MOVIE_WAIT;
               if(this.FMovieTimeID != 0)
               {
                  clearTimeout(this.FMovieTimeID);
               }
               this.FMovieTimeID = setTimeout(this.PlayHeroMove,500);
            }
         }
         else if(this.FMovieType == MOVIE_ATTACK_BOSS)
         {
            _loc4_ = FMC_Scene.MC_Attack;
            _loc4_.visible = true;
            FTotalFrame = _loc4_.totalFrames;
            _loc4_.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:String = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_DICE)
         {
            FMC_Scene.MC_Dice.gotoAndStop(11);
            _loc1_ = FMC_Scene.MC_Dice.MC_Last;
            _loc1_.gotoAndStop(this.FNationalDay2_2015.Step);
            this.FMoveIndex = this.FNationalDay2_2015.StepIndex;
            this.FEndIndex = this.FNationalDay2_2015.TargetIndex;
            FIsPlaying = true;
            this.FMovieType = MOVIE_WAIT;
            if(this.FMovieTimeID != 0)
            {
               clearTimeout(this.FMovieTimeID);
            }
            this.FMovieTimeID = setTimeout(this.PlayHeroMove,1000);
         }
         else if(this.FMovieType == MOVIE_ATTACK_BOSS)
         {
            FMC_Scene.MC_Attack.visible = false;
            FOnShowFlowText(this.FNationalDay2_2015.GameFlowText());
            this.FNationalDay2_2015.StepIndex = this.FNationalDay2_2015.TargetIndex;
            this.FNationalDay2_2015.DoubleStatus = this.FNationalDay2_2015.NextDoubleStatus;
            this.UpdateUI();
         }
      }
      
      override public function Unmount() : void
      {
         TweenUtil.removeAllTween();
         FIsPlaying = false;
         this.FMovieType = -1;
         FMC_Scene.MC_SelectUI.visible = false;
         FMC_Scene.MC_UpgradeUI.visible = false;
         FMC_Scene.MC_Dice.visible = false;
         FMC_Scene.MC_Attack.visible = false;
      }
   }
}

