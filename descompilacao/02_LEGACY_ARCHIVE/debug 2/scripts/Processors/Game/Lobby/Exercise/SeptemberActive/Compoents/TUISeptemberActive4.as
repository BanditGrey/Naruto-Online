package Processors.Game.Lobby.Exercise.SeptemberActive.Compoents
{
   import Components.Standard.TUITab;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SeptemberActive.TSeptemberActive4;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.SeptemberActive.TProcessorSeptemberActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUISeptemberActive4 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_4_ID:int = 4;
      
      protected static const BOX_TYPE:int = 5;
      
      protected static const MAX_BOX:int = 60;
      
      protected static const TAB_COUNT:int = 2;
      
      protected static const TAB_HERO:int = 0;
      
      protected static const TAB_GIFT:int = 1;
      
      protected static const GIFT_COUNT:int = 5;
      
      protected static const BAR_COUNT:int = 6;
      
      public static const MOVIE_OPEN_POINT:int = 0;
      
      public static const MOVIE_RESET:int = 1;
      
      public static const MOVIE_OPEN_ALL_POINT:int = 2;
      
      protected var FSeptemberActive4:TSeptemberActive4;
      
      protected var FBTN_OpenAll:MovieClip;
      
      protected var FMC_Hammer:MovieClip;
      
      protected var FPointList:Vector.<MovieClip>;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FBoxLevel:uint;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FOpenIndex:int;
      
      protected var FFrameCount:int;
      
      protected var FMovieType:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FMC_HeroMask:MovieClip;
      
      protected var FBarMaxHeight:int;
      
      public function TUISeptemberActive4(param1:TUIComponent)
      {
         super(param1);
         this.FPointList = new Vector.<MovieClip>(MAX_BOX);
         this.FBoxList = new Vector.<MovieClip>(BOX_TYPE);
         this.FGiftList = new Vector.<MovieClip>(GIFT_COUNT);
         this.FUITab = new TUITab(this);
         this.FChangeTabIndex = 0;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FBTN_OpenAll = FMC_Scene["BTN_OpenAll"];
         this.FMC_Hammer = FMC_Scene["MC_Hammer"];
         this.FMC_Hammer.mouseEnabled = false;
         this.FMC_Hammer.visible = false;
         _loc2_ = 0;
         while(_loc2_ < MAX_BOX)
         {
            _loc5_ = FMC_Scene["MC_Point" + _loc2_];
            _loc5_.mouseEnabled = true;
            _loc5_.buttonMode = true;
            this.FPointList[_loc2_] = _loc5_;
            this.FPointList[_loc2_].MC_Smoke.visible = false;
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BOX_TYPE)
         {
            _loc4_ = FMC_Scene["MC_Box" + _loc2_];
            _loc4_.gotoAndStop(_loc2_ + 1);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            _loc4_.addEventListener(MouseEvent.MOUSE_OUT,ProcessorOnNewBoxOut);
            this.FBoxList[_loc2_] = _loc4_;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            _loc6_ = FMC_Scene.MC_Items["MC_Gift" + _loc2_];
            _loc6_.MC_Icon.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(_loc6_.BTN_Exchange,true);
            _loc6_.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeItemUp);
            _loc6_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeBoxOver);
            _loc6_.addEventListener(MouseEvent.MOUSE_OUT,this.ProcessorOnExchangeBoxOut);
            this.FGiftList[_loc2_] = _loc6_;
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
         this.FMC_Mask = FMC_Scene.MC_AccumBar["MC_Mask"];
         this.FBarMaxHeight = this.FMC_Mask.height;
         this.FMC_Mask.height = 0;
         this.FMC_HeroMask = FMC_Scene.MC_HeroAccumBar["MC_Mask"];
         this.FMC_HeroMask.height = 0;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(this.FBTN_OpenAll,true);
         this.FBTN_OpenAll.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyAllUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_HeroDesc,true);
         FMC_Scene.MC_Hero.BTN_HeroDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowHeroDesc);
         TGameUtil.setButtonMode(FMC_Scene.MC_Hero.BTN_Exchange,true);
         FMC_Scene.MC_Hero.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_OUT,ProcessorOnHideHtmlTip);
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         if(this.FSeptemberActive4.RewardsIndex.indexOf(0) == -1)
         {
            TGameUtil.setButtonMode(this.FBTN_OpenAll,false);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_OpenAll,true);
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_BOX)
         {
            if(_loc1_ < this.FSeptemberActive4.RewardsIndex.length)
            {
               if(this.FSeptemberActive4.RewardsIndex[_loc1_] > 0)
               {
                  this.FPointList[_loc1_].gotoAndStop(2);
                  _loc4_ = int(this.FSeptemberActive4.RewardsIndex[_loc1_]);
                  this.FPointList[_loc1_].MC_Box.gotoAndStop(_loc4_);
                  this.FPointList[_loc1_].MC_Box.buttonMode = false;
                  this.FPointList[_loc1_].MC_Box.mouseEnabled = false;
               }
               else
               {
                  this.FPointList[_loc1_].gotoAndStop(1);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTab() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:int = 0;
         if(this.FChangeTabIndex == TAB_HERO)
         {
            FMC_Scene.MC_Hero.visible = true;
            FMC_Scene.MC_Items.visible = false;
         }
         else
         {
            FMC_Scene.MC_Hero.visible = false;
            FMC_Scene.MC_Items.visible = true;
         }
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc2_ = this.FGiftList[_loc1_];
            _loc3_ = this.FSeptemberActive4.GiftList[_loc1_];
            _loc4_ = this.FSeptemberActive4.GetCurItemPriceByIndex(_loc1_);
            _loc2_.TF_LimitCount.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc3_.LimitCount);
            _loc2_.MC_Count.TF_Count.text = _loc3_.Price.toString();
            _loc2_.MC_CurCount.TF_Count.text = _loc4_.toString();
            if(_loc3_.LimitCount > 0 && this.FSeptemberActive4.CurScore >= _loc4_)
            {
               TGameUtil.setButtonMode(_loc2_.BTN_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(_loc2_.BTN_Exchange,false);
            }
            _loc1_++;
         }
         _loc2_ = FMC_Scene.MC_Hero;
         _loc3_ = this.FSeptemberActive4.Hero;
         _loc2_.TF_Price.text = _loc3_.Price.toString();
         _loc2_.TF_CurPrice.text = this.FSeptemberActive4.GetCurHeroPrice();
         if(_loc3_.Status == TBaseActivity.STATUS_GETED)
         {
            _loc2_.MC_Got.visible = true;
            _loc2_.BTN_Exchange.visible = false;
         }
         else if(this.FSeptemberActive4.CurScore >= this.FSeptemberActive4.GetCurHeroPrice())
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
         if(this.FChangeTabIndex == TAB_HERO)
         {
            FMC_Scene.MC_HeroAccumBar.visible = true;
            FMC_Scene.MC_AccumBar.visible = false;
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               FMC_Scene.MC_HeroAccumBar["TF_Count" + _loc1_].text = this.FSeptemberActive4.HeroGold[_loc1_].toString();
               FMC_Scene.MC_HeroAccumBar["TF_Num" + _loc1_].text = this.FSeptemberActive4.HeroScore[_loc1_].toString();
               _loc1_++;
            }
            _loc3_ = Number(this.FSeptemberActive4.RechargeGold / this.FSeptemberActive4.HeroGold[this.FSeptemberActive4.HeroGold.length - 1]) * this.FBarMaxHeight;
            _loc4_ = Math.min(_loc3_,this.FBarMaxHeight);
            if(_loc4_ != this.FMC_HeroMask.height)
            {
               TweenUtil.to(this.FMC_HeroMask,1000,{"height":_loc4_});
            }
         }
         else
         {
            FMC_Scene.MC_HeroAccumBar.visible = false;
            FMC_Scene.MC_AccumBar.visible = true;
            _loc1_ = 0;
            while(_loc1_ < BAR_COUNT)
            {
               FMC_Scene.MC_AccumBar["TF_Count" + _loc1_].text = this.FSeptemberActive4.GiftGold[_loc1_].toString();
               FMC_Scene.MC_AccumBar["TF_Num" + _loc1_].text = this.FSeptemberActive4.GiftScore[_loc1_].toString();
               _loc1_++;
            }
            _loc3_ = Number(this.FSeptemberActive4.RechargeGold / this.FSeptemberActive4.GiftGold[this.FSeptemberActive4.GiftGold.length - 1]) * this.FBarMaxHeight;
            _loc4_ = Math.min(_loc3_,this.FBarMaxHeight);
            if(_loc4_ != this.FMC_Mask.height)
            {
               TweenUtil.to(this.FMC_Mask,1000,{"height":_loc4_});
            }
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSeptemberActive4.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSeptemberActive4.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSeptemberActive4.DescListNew[1];
         FMC_Scene.TF_Desc2.text = this.FSeptemberActive4.DescListNew[7];
         FMC_Scene.MC_Count.TF_Count.text = this.FSeptemberActive4.CurScore.toString();
         FMC_Scene.TF_FreeCount.text = this.FSeptemberActive4.FreeCount.toString();
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
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         _loc2_ = int(param1.currentTarget.name.slice(8));
         if(Boolean(FOnBuyBox != null && this.FSeptemberActive4) && Boolean(_loc2_ < this.FSeptemberActive4.RewardsIndex.length) && this.FSeptemberActive4.RewardsIndex[_loc2_] == 0)
         {
            if(this.FSeptemberActive4.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_OPEN_POINT,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_OPEN_POINT,this.FSeptemberActive4.BoxPrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBuyAllUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FSeptemberActive4))
         {
            _loc3_ = this.FSeptemberActive4.GetNotOpenCount() - this.FSeptemberActive4.FreeCount;
            if(_loc3_ <= 0)
            {
               FOnGetBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_OPEN_ALL_POINT);
            }
            else
            {
               _loc4_ = _loc3_ * this.FSeptemberActive4.TotalBoxPrice;
               _loc5_ = TUtilityString.Format(this.FSeptemberActive4.DescListNew[13],_loc4_,_loc3_,this.FSeptemberActive4.BoxPrice);
               FOnBuyBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_OPEN_ALL_POINT,_loc4_,0,0,_loc5_);
            }
         }
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FSeptemberActive4))
         {
            FOnGetBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_RESET);
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
         if(Boolean(FOnBuyBox != null) && Boolean(this.FSeptemberActive4) && Boolean(this.FSeptemberActive4.Hero))
         {
            _loc2_ = this.FSeptemberActive4.Hero;
            if(_loc2_.Status != TBaseActivity.STATUS_GETED && this.FSeptemberActive4.CurScore >= this.FSeptemberActive4.GetCurHeroPrice())
            {
               _loc3_ = TUtilityString.Format(this.FSeptemberActive4.DescListNew[5],this.FSeptemberActive4.GetCurHeroPrice());
               _loc4_ = this.FSeptemberActive4.GetCurHeroLevel();
               if(_loc4_ < this.FSeptemberActive4.HeroGold.length - 1)
               {
                  _loc3_ += "\n" + TUtilityString.Format(this.FSeptemberActive4.DescListNew[6],this.FSeptemberActive4.RechargeGold,this.FSeptemberActive4.HeroGold[_loc4_ + 1] - this.FSeptemberActive4.RechargeGold,this.FSeptemberActive4.Hero.Price - this.FSeptemberActive4.HeroScore[_loc4_ + 1]);
               }
               FOnBuyBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_EXCHANGE_HERO,0,0,0,_loc3_);
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
         if(Boolean(FOnBuyBox != null && this.FSeptemberActive4 && _loc2_ < this.FSeptemberActive4.GiftList.length) && Boolean(this.FSeptemberActive4.GiftList[_loc2_].LimitCount > 0) && this.FSeptemberActive4.CurScore >= this.FSeptemberActive4.GetCurItemPriceByIndex(_loc2_))
         {
            _loc3_ = TUtilityString.Format(this.FSeptemberActive4.DescListNew[5],this.FSeptemberActive4.GetCurItemPriceByIndex(_loc2_));
            _loc4_ = this.FSeptemberActive4.GetCurGiftLevelByIndex();
            if(_loc4_ < this.FSeptemberActive4.GiftGold.length - 1)
            {
               _loc3_ += "\n" + TUtilityString.Format(this.FSeptemberActive4.DescListNew[6],this.FSeptemberActive4.RechargeGold,this.FSeptemberActive4.GiftGold[_loc4_ + 1] - this.FSeptemberActive4.RechargeGold,this.FSeptemberActive4.GiftList[_loc2_].Price - this.FSeptemberActive4.GiftScore[_loc4_ + 1]);
            }
            FOnBuyBox(ACTIVITY_4_ID,TProcessorSeptemberActive.ACTIVITY_4_EXCHANGE_ITEM,0,_loc2_ + 1,0,_loc3_);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FSeptemberActive4) && this.FSeptemberActive4.DescList.length > 2)
         {
            FOnShowHtmlTip(this.FSeptemberActive4.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnExchangeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnItemOver != null) && Boolean(this.FSeptemberActive4) && _loc2_ < this.FSeptemberActive4.GiftList.length)
         {
            FOnItemOver(this,this.FSeptemberActive4.GiftList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      protected function ProcessorOnExchangeBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnItemOut != null) && Boolean(this.FSeptemberActive4) && _loc2_ < this.FSeptemberActive4.GiftList.length)
         {
            FOnItemOut(this,this.FSeptemberActive4.GiftList[_loc2_].Inventories.GetInventoryByIndex(0));
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnNewBoxOver != null && this.FSeptemberActive4) && Boolean(this.FSeptemberActive4.DescList.length > 14) && _loc2_ < this.FSeptemberActive4.Rewards.length)
         {
            FOnNewBoxOver(this.FSeptemberActive4.Rewards[_loc2_],this.FSeptemberActive4.DescListNew[14]);
         }
      }
      
      protected function ProcessorOnShowHeroDesc(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FSeptemberActive4) && Boolean(this.FSeptemberActive4.Hero))
         {
            FOnShowRecruit(this.FSeptemberActive4.Hero.Identify);
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
            FOnLoadLog(ACTIVITY_4_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         if(FInitialized && this.visible)
         {
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OPEN_POINT:
                     CurFrame = this.FPointList[this.FOpenIndex].MC_Smoke.currentFrame;
                     break;
                  case MOVIE_RESET:
                     break;
                  case MOVIE_OPEN_ALL_POINT:
                     CurFrame = this.FMC_Hammer.currentFrame;
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
         this.FSeptemberActive4 = SLogicsCore.SeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_4_ID) as TSeptemberActive4;
         this.UpdatePoint();
         this.UpdateTab();
         this.UpdateBar();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         this.FMovieType = param1;
         FIsPlaying = true;
         switch(this.FMovieType)
         {
            case MOVIE_OPEN_POINT:
               this.FPointList[this.FOpenIndex].MC_Smoke.visible = true;
               this.FPointList[this.FOpenIndex].MC_Smoke.gotoAndPlay(1);
               FTotalFrame = this.FPointList[this.FOpenIndex].MC_Smoke.totalFrames;
               break;
            case MOVIE_RESET:
               break;
            case MOVIE_OPEN_ALL_POINT:
               this.FMC_Hammer.visible = true;
               this.FMC_Hammer.gotoAndPlay(1);
               FTotalFrame = this.FMC_Hammer.totalFrames;
               _loc3_ = 0;
               while(_loc3_ < MAX_BOX)
               {
                  this.FPointList[_loc3_].MC_Smoke.visible = true;
                  this.FPointList[_loc3_].MC_Smoke.gotoAndPlay(1);
                  _loc3_++;
               }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         switch(this.FMovieType)
         {
            case MOVIE_OPEN_POINT:
               this.FPointList[this.FOpenIndex].MC_Smoke.visible = false;
               this.FPointList[this.FOpenIndex].gotoAndStop(2);
               this.FPointList[this.FOpenIndex].MC_Box.gotoAndStop(this.FSeptemberActive4.RewardsIndex[this.FOpenIndex]);
               this.UpdateUI();
               break;
            case MOVIE_RESET:
               break;
            case MOVIE_OPEN_ALL_POINT:
               _loc1_ = 0;
               while(_loc1_ < MAX_BOX)
               {
                  if(_loc1_ < this.FSeptemberActive4.RewardsIndex.length)
                  {
                     this.FPointList[_loc1_].MC_Smoke.visible = false;
                     this.FPointList[_loc1_].gotoAndStop(2);
                     this.FPointList[_loc1_].MC_Box.gotoAndStop(this.FSeptemberActive4.RewardsIndex[_loc1_]);
                  }
                  _loc1_++;
               }
               this.FMC_Hammer.visible = false;
               this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIndex = param1;
      }
   }
}

