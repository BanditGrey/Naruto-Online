package Processors.Game.Lobby.Exercise.DecActive.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DecActive.TDecActive3;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.DecActive.TProcessorDecActive;
   import Processors.Game.Lobby.Exercise.NovActive.TProcessorNovActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIDecActive3 extends TUIBaseWindow
   {
      
      protected static const SHOW_ITEM_COUNT:int = 6;
      
      protected static const BALL_COUNT:int = 3;
      
      protected static const BOSS_COUNT:int = 3;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected static const MOVIE_THROW_BALL:int = 0;
      
      protected var FDecActive3:TDecActive3;
      
      protected var FIsFirst:Boolean;
      
      protected var FMovieType:int;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FBossIndex:int;
      
      protected var FBallIndex:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxHeight:int;
      
      protected var FBallList:Vector.<MovieClip>;
      
      protected var FIsMiss:Boolean;
      
      protected var FProcessorNovActiveShop:TProcessorNovActiveShop;
      
      public function TUIDecActive3(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
         this.FBallList = new Vector.<MovieClip>(BALL_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         _loc2_ = 0;
         while(_loc2_ < BOSS_COUNT)
         {
            _loc5_ = FMC_Scene.MC_Game["MC_Icon" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.gotoAndStop(_loc2_ + 1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnBossUp);
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < BALL_COUNT)
         {
            _loc5_ = FMC_Scene.MC_Game["MC_Ball" + _loc2_];
            _loc5_.buttonMode = true;
            _loc5_.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc5_.MC_Bomb.gotoAndStop(1);
            _loc5_.addEventListener(MouseEvent.CLICK,this.ProcessorOnBallUp);
            this.FBallList[_loc2_] = _loc5_;
            _loc2_++;
         }
         FMC_Scene.MC_Game.MC_Box.buttonMode = true;
         FMC_Scene.MC_Game.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Game.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Game.MC_Box.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip0Over);
         FMC_Scene.MC_Tip0.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTip1Over);
         FMC_Scene.MC_Tip1.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         this.FProcessorNovActiveShop = new TProcessorNovActiveShop(this.Parent);
         this.FProcessorNovActiveShop.Visible = false;
         this.FProcessorNovActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorNovActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorNovActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorNovActiveShop.OnGetBox = this.ProcessorOnGetReward;
         this.FProcessorNovActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorNovActiveShop.X = -150;
         this.FProcessorNovActiveShop.y = -8;
         FMC_Scene.MC_Game.MC_Boss.MC_Attack.gotoAndStop(1);
         FMC_Scene.MC_Game.MC_Boss.MC_Miss.gotoAndStop(1);
         this.FMC_Mask = FMC_Scene.MC_AccumBar["MC_Mask"];
         this.FBarMaxHeight = this.FMC_Mask.height;
         this.FMC_Mask.height = 0;
      }
      
      protected function UpdateGame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         FMC_Scene.MC_Game.MC_Boss.MC_Icon.gotoAndStop(this.FBossIndex + 1);
         _loc1_ = 0;
         while(_loc1_ < BOSS_COUNT)
         {
            _loc2_ = FMC_Scene.MC_Game["MC_Icon" + _loc1_];
            if(_loc1_ == this.FBossIndex)
            {
               _loc2_.MC_Select.visible = true;
            }
            else
            {
               _loc2_.MC_Select.visible = false;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < BALL_COUNT)
         {
            _loc2_ = this.FBallList[_loc1_];
            _loc3_ = this.FDecActive3.NeedScore[_loc1_];
            _loc2_.TF_Price.text = TUtilityString.Format(this.FDecActive3.DescListNew[2],_loc3_.ExchangeVect[this.FBossIndex]);
            _loc2_.TF_Desc.text = this.FDecActive3.DescListNew[15 + _loc1_ + this.FBossIndex * BALL_COUNT];
            _loc1_++;
         }
         _loc2_ = FMC_Scene.MC_Game.MC_Box;
         _loc3_ = this.FDecActive3.Gift;
         _loc2_.TF_Count.text = "*" + _loc3_.Count;
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FDecActive3.DescListNew[3],this.FDecActive3.ConsumeScore);
         if(_loc3_.Count > 0)
         {
            _loc2_.MC_Click.visible = true;
            _loc2_.MC_Icon.gotoAndPlay(1);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Icon.gotoAndStop(1);
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FDecActive3.RechargeAdd.length)
         {
            _loc3_ = this.FDecActive3.RechargeAdd[_loc1_];
            FMC_Scene.MC_AccumBar["TF_Num" + _loc1_].text = _loc3_.gold;
            FMC_Scene.MC_AccumBar["TF_Count" + _loc1_].text = _loc3_.count;
            _loc1_++;
         }
         _loc6_ = this.FDecActive3.RechargeAdd[this.FDecActive3.RechargeAdd.length - 1].gold - this.FDecActive3.BarGold;
         _loc4_ = Number((this.FDecActive3.RechargeGold - this.FDecActive3.BarGold) / _loc6_) * this.FBarMaxHeight;
         _loc5_ = Math.min(_loc4_,this.FBarMaxHeight);
         if(_loc5_ != this.FMC_Mask.height)
         {
            TweenUtil.to(this.FMC_Mask,1000,{"height":_loc5_});
         }
      }
      
      protected function UpdateItem() : void
      {
         this.FShowItem.UpdateUI(this.FDecActive3.ShowItems);
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDecActive3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FDecActive3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FDecActive3.DescListNew[1];
         FMC_Scene.TF_Score.text = this.FDecActive3.RankPoint.toString();
         FMC_Scene.TF_Count.text = this.FDecActive3.MyScore.toString();
         FMC_Scene.TF_RechargeGold.text = this.FDecActive3.RechargeGold.toString();
      }
      
      protected function ProcessorOnBossUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(this.FBossIndex != _loc2_)
         {
            this.FBossIndex = _loc2_;
            this.UpdateGame();
         }
      }
      
      protected function ProcessorOnBallUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnBuyBox != null) && Boolean(this.FDecActive3) && _loc2_ < this.FDecActive3.NeedScore.length)
         {
            _loc5_ = this.FDecActive3.NeedScore[_loc2_].ExchangeVect[this.FBossIndex];
            if(this.FDecActive3.MyScore >= _loc5_)
            {
               FOnGetBox(ACTIVITY_3_ID,TProcessorDecActive.ACTIVITY_3_PLAY_GAME,this.FBossIndex + 1,_loc2_ + 1);
            }
            else
            {
               _loc3_ = (_loc5_ - this.FDecActive3.MyScore) * this.FDecActive3.ScorePrice;
               _loc4_ = TUtilityString.Format(this.FDecActive3.DescListNew[4],_loc5_,_loc3_,_loc5_ - this.FDecActive3.MyScore);
               FOnBuyBox(ACTIVITY_3_ID,TProcessorDecActive.ACTIVITY_3_PLAY_GAME,_loc3_,this.FBossIndex + 1,0,_loc4_,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(Boolean(this.FDecActive3) && this.FDecActive3.Gift.Count > 0)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorDecActive.ACTIVITY_3_GET_GAME_BOX);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FDecActive3))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorDecActive.ACTIVITY_3_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnGetReward(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FDecActive3))
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorDecActive.ACTIVITY_3_GET_REWARD,param1 + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(FOnNewBoxOver != null && Boolean(this.FDecActive3))
         {
            FOnNewBoxOver(this.FDecActive3.Gift.Inventories);
         }
      }
      
      protected function ProcessorOnBossOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FDecActive3) && this.FDecActive3.DescList.length > 12)
         {
            _loc3_ = this.FDecActive3.NeedScore[_loc2_].ExchangeVect[0];
            _loc4_ = TUtilityString.Format(this.FDecActive3.DescListNew[10 + _loc2_],_loc3_);
            FOnShowHtmlTip(_loc4_);
         }
      }
      
      protected function ProcessorOnTip0Over(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FDecActive3) && this.FDecActive3.DescList.length > 13)
         {
            FOnShowHtmlTip(this.FDecActive3.DescListNew[13]);
         }
      }
      
      protected function ProcessorOnTip1Over(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FDecActive3) && this.FDecActive3.DescList.length > 14)
         {
            FOnShowHtmlTip(this.FDecActive3.DescListNew[14]);
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
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorNovActiveShop.Visible = true;
         this.FProcessorNovActiveShop.UpdateUI(this.FDecActive3);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorNovActiveShop.Visible = false;
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(3);
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
      
      override protected function ProcessorOnShowEquipDesc(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorDecActive.WINDOW_EQUIPMENT_DESC_2);
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
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FDecActive3 = SLogicsCore.DecActiveDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TDecActive3;
         this.UpdateGame();
         this.UpdateBar();
         this.UpdateItem();
         this.UpdateText();
         if(this.FIsFirst)
         {
            this.FIsFirst = false;
            this.FProcessorNovActiveShop.Load();
         }
         if(this.FProcessorNovActiveShop.Visible)
         {
            this.FProcessorNovActiveShop.UpdateUI(this.FDecActive3);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_THROW_BALL)
         {
            _loc3_ = this.FDecActive3.BallIndex;
            this.FBallList[_loc3_].MC_Bomb.gotoAndPlay(1);
            if(param2)
            {
               FMC_Scene.MC_Game.MC_Boss.MC_Attack.gotoAndPlay(1);
            }
            else
            {
               FMC_Scene.MC_Game.MC_Boss.MC_Miss.gotoAndPlay(1);
            }
            this.UpdateUI();
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         FIsPlaying = false;
         if(this.FMovieType == MOVIE_THROW_BALL)
         {
         }
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
         FIsPlaying = false;
      }
   }
}

