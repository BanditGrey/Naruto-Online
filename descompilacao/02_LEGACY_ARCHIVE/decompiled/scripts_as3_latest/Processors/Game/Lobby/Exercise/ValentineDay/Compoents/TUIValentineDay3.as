package Processors.Game.Lobby.Exercise.ValentineDay.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Exercise.ValentineDay.TValentineDay3;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.ValentineDay.TProcessorValentineDay;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIValentineDay3 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 16;
      
      protected static const ROSE_TYPE:int = 4;
      
      protected static const GIFT_COUNT:int = 5;
      
      protected static const ACTIVITY_3_ID:int = 3;
      
      protected static const ROSE_OPEN:int = 1;
      
      protected static const ROSE_CLEAR:int = 2;
      
      protected static const ROSE_ALL_OPEN:int = 3;
      
      protected static const GAME_AGAIN:int = 1;
      
      protected static const GAME_OVER:int = 2;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FGiftList:Vector.<MovieClip>;
      
      protected var FValentineDay3:TValentineDay3;
      
      protected var FMovieType:int;
      
      protected var FOpenIdx:int;
      
      protected var FClearIdx:int;
      
      protected var FRoseType:int;
      
      protected var FIsClicked:Boolean;
      
      public function TUIValentineDay3(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FGiftList = new Vector.<MovieClip>(GIFT_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Rose" + _loc2_];
            this.FBoxList[_loc2_].MC_Box.buttonMode = true;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GIFT_COUNT)
         {
            this.FGiftList[_loc2_] = FMC_Scene["MC_Gift" + _loc2_];
            this.FGiftList[_loc2_].MC_Tip.buttonMode = true;
            this.FGiftList[_loc2_].MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            this.FGiftList[_loc2_].MC_Tip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGiftOut);
            this.FGiftList[_loc2_].MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < ROSE_TYPE)
         {
            param1 = FMC_Scene["MC_Box" + _loc2_];
            param1.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            _loc2_++;
         }
         FMC_Scene.MC_Title.addEventListener(MouseEvent.CLICK,this.ProcessorOnTitleUp);
         FMC_Scene.MC_Title.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTitleOver);
         FMC_Scene.MC_Title.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTitleOut);
         FMC_Scene.MC_OnceMore.visible = true;
         TGameUtil.setButtonMode(FMC_Scene.MC_OnceMore.BTN_Again,true);
         FMC_Scene.MC_OnceMore.BTN_Again.addEventListener(MouseEvent.CLICK,this.ProcessorOnPlayAgain);
         TGameUtil.setButtonMode(FMC_Scene.BTN_BuyAll,true);
         FMC_Scene.BTN_BuyAll.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyAll);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:TInventory = null;
         var _loc6_:int = 0;
         if(this.FValentineDay3.IsEnd == GAME_AGAIN)
         {
            FMC_Scene.MC_OnceMore.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuyAll,false);
            FMC_Scene.MC_Click.visible = false;
            FMC_Scene.MC_GameOver.visible = false;
         }
         else if(this.FValentineDay3.IsEnd == GAME_OVER)
         {
            FMC_Scene.MC_OnceMore.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuyAll,false);
            FMC_Scene.MC_Click.visible = false;
            FMC_Scene.MC_GameOver.visible = true;
         }
         else
         {
            FMC_Scene.MC_OnceMore.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_BuyAll,true);
            if(this.FIsClicked)
            {
               FMC_Scene.MC_Click.visible = false;
            }
            else
            {
               FMC_Scene.MC_Click.visible = true;
            }
            FMC_Scene.MC_GameOver.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FValentineDay3.RoseStatus.length)
            {
               _loc6_ = this.FValentineDay3.RoseStatus[_loc1_];
               if(_loc6_ == TValentineDay3.ROSE_NONE)
               {
                  _loc3_.gotoAndStop(1);
               }
               else if(_loc6_ < TValentineDay3.ROSE_NONE)
               {
                  _loc3_.gotoAndStop(3);
                  _loc3_.MC_RoseClear.gotoAndStop(_loc3_.MC_RoseClear.totalFrames);
                  _loc3_.MC_RoseClear.MC_Icon.gotoAndStop(-this.FValentineDay3.RoseStatus[_loc1_]);
               }
               else
               {
                  _loc3_.gotoAndStop(2);
                  _loc3_.MC_RoseOpen.MC_Rose.gotoAndStop(this.FValentineDay3.RoseStatus[_loc1_]);
                  _loc3_.MC_RoseOpen.MC_Effect.visible = false;
                  _loc3_.MC_RoseOpen.MC_Rose.visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < ROSE_TYPE)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc3_.gotoAndStop(1);
            _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Count.text = "* " + this.FValentineDay3.RoseList[_loc1_].Price;
            _loc1_++;
         }
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc1_ < this.FValentineDay3.GiftList.length)
            {
               _loc4_ = this.FValentineDay3.GiftList[_loc1_];
               _loc3_.MC_Count.TF_Count.text = "*" + _loc4_.Price;
               _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
               if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_GetBox.visible = false;
                  _loc3_.MC_Got.visible = false;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.MC_GetBox.visible = false;
                  _loc3_.MC_Got.visible = true;
               }
               else
               {
                  _loc3_.MC_GetBox.visible = true;
                  _loc3_.MC_Got.visible = false;
               }
            }
            _loc1_++;
         }
         FMC_Scene.MC_Title.MC_Count.TF_Count.text = "*" + this.FValentineDay3.TitlePrice;
         if(this.FValentineDay3.TitleStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.MC_Title.MC_GetBox0.visible = false;
            FMC_Scene.MC_Title.MC_Got.visible = false;
         }
         else if(this.FValentineDay3.TitleStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Title.MC_GetBox0.visible = true;
            FMC_Scene.MC_Title.MC_Got.visible = false;
         }
         else
         {
            FMC_Scene.MC_Title.MC_GetBox0.visible = false;
            FMC_Scene.MC_Title.MC_Got.visible = true;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FValentineDay3.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FValentineDay3.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FValentineDay3.ActivityDesc;
         FMC_Scene.TF_FreeCount.text = this.FValentineDay3.FreeCount.toString();
         FMC_Scene.TF_Count.text = this.FValentineDay3.Score.toString();
      }
      
      protected function ProcessorOnBuyBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(!this.FValentineDay3 || this.FValentineDay3.IsEnd == GAME_OVER || _loc2_ >= this.FValentineDay3.RoseStatus.length || this.FValentineDay3.RoseStatus[_loc2_] != 0 || FIsPlaying)
         {
            return;
         }
         this.FIsClicked = true;
         if(FOnBuyBox != null)
         {
            if(this.FValentineDay3.FreeCount > 0)
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_GET_ROSE,0,_loc2_ + 1,TBaseActivity.SWEET_TYPE_FREE);
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_GET_ROSE,this.FValentineDay3.RosePrice,_loc2_ + 1,TBaseActivity.SWEET_TYPE_GOLD);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(FOnShowThreeStr != null) && Boolean(this.FValentineDay3) && _loc2_ < this.FValentineDay3.RoseList.length)
         {
            FOnShowThreeStr(this.FValentineDay3.RoseList[_loc2_]);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(FOnHideThreeStr != null)
         {
            FOnHideThreeStr();
         }
      }
      
      protected function ProcessorOnBuyAll(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(!this.FValentineDay3 || this.FValentineDay3.IsEnd != 0 || FIsPlaying)
         {
            return;
         }
         if(FOnBuyBox != null)
         {
            _loc2_ = this.FValentineDay3.GetAllOpenCost();
            _loc3_ = TUtilityString.Format(this.FValentineDay3.ActivityName,this.FValentineDay3.GetAllOpenCost(),this.FValentineDay3.GetNotOpenCount());
            if(_loc2_ > 0)
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_GET_ALL_ROSE,_loc2_,0,TBaseActivity.SWEET_TYPE_GOLD,_loc3_);
            }
            else
            {
               FOnBuyBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_GET_ALL_ROSE,0,0,TBaseActivity.SWEET_TYPE_FREE);
            }
         }
      }
      
      protected function ProcessorOnPlayAgain(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && this.FValentineDay3.IsEnd == GAME_AGAIN)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_RESET);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FValentineDay3) && Boolean(_loc2_ < this.FValentineDay3.GiftList.length) && this.FValentineDay3.GiftList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnShowThreeStr != null) && Boolean(this.FValentineDay3) && _loc2_ < this.FValentineDay3.GiftList.length)
         {
            FOnShowThreeStr(this.FValentineDay3.GiftList[_loc2_]);
         }
      }
      
      protected function ProcessorOnGiftOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FOnHideThreeStr != null)
         {
            FOnHideThreeStr();
         }
      }
      
      protected function ProcessorOnTitleUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null) && Boolean(this.FValentineDay3) && this.FValentineDay3.TitleStatus == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_3_ID,TProcessorValentineDay.ACTIVITY_3_GET_TITLE);
         }
      }
      
      protected function ProcessorOnTitleOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         if(Boolean(FOnShowThreeStr != null) && Boolean(this.FValentineDay3) && Boolean(this.FValentineDay3.TitleDesc1))
         {
            _loc4_ = new TBaseBox();
            _loc4_.Desc1 = this.FValentineDay3.TitleDesc1;
            _loc4_.Desc2 = this.FValentineDay3.TitleDesc2;
            _loc4_.Desc3 = this.FValentineDay3.TitleDesc3;
            FOnShowThreeStr(_loc4_);
         }
      }
      
      protected function ProcessorOnTitleOut(param1:MouseEvent) : void
      {
         if(FOnHideThreeStr != null && Boolean(this.FValentineDay3))
         {
            FOnHideThreeStr();
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
               if(this.FMovieType == ROSE_OPEN)
               {
                  CurFrame = this.FBoxList[this.FOpenIdx].MC_RoseOpen.MC_Effect.currentFrame;
               }
               else if(this.FMovieType == ROSE_CLEAR)
               {
                  CurFrame = this.FBoxList[this.FClearIdx].MC_RoseClear.currentFrame;
               }
               else if(this.FMovieType == ROSE_ALL_OPEN)
               {
                  CurFrame = this.FBoxList[0].MC_RoseClear.currentFrame;
               }
               if(CurFrame == FTotalFrame)
               {
                  FIsPlaying = false;
                  this.MovieEnd();
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FValentineDay3 = SLogicsCore.ValentineDayDatas.GetActivityByIdentify(ACTIVITY_3_ID) as TValentineDay3;
         this.UpdateBox();
         this.UpdateList();
         this.UpdateGift();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:TInventories = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         switch(param1)
         {
            case ROSE_OPEN:
               this.FBoxList[this.FOpenIdx].gotoAndStop(2);
               _loc3_ = this.FBoxList[this.FOpenIdx].MC_RoseOpen.MC_Effect;
               _loc3_.visible = true;
               this.FBoxList[this.FOpenIdx].MC_RoseOpen.MC_Rose.visible = false;
               FTotalFrame = _loc3_.totalFrames;
               _loc3_.gotoAndPlay(1);
               break;
            case ROSE_CLEAR:
               this.FBoxList[this.FOpenIdx].gotoAndStop(3);
               this.FBoxList[this.FClearIdx].gotoAndStop(3);
               this.FBoxList[this.FOpenIdx].MC_RoseClear.gotoAndPlay(1);
               this.FBoxList[this.FClearIdx].MC_RoseClear.gotoAndPlay(1);
               FTotalFrame = this.FBoxList[this.FClearIdx].MC_RoseClear.totalFrames;
               this.FBoxList[this.FOpenIdx].MC_RoseClear.MC_Icon.gotoAndStop(this.FValentineDay3.RoseStatus[this.FOpenIdx]);
               this.FBoxList[this.FClearIdx].MC_RoseClear.MC_Icon.gotoAndStop(this.FValentineDay3.RoseStatus[this.FClearIdx]);
               break;
            case ROSE_ALL_OPEN:
               this.PlayRoseAllOpenMovie();
         }
      }
      
      public function PlayRoseAllOpenMovie() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FValentineDay3.RoseStatus.length)
            {
               _loc4_ = this.FValentineDay3.RoseStatus[_loc1_];
               if(_loc4_ > TValentineDay3.ROSE_NONE)
               {
                  _loc3_.gotoAndStop(3);
                  _loc3_.MC_RoseClear.gotoAndPlay(1);
                  FTotalFrame = _loc3_.MC_RoseClear.totalFrames;
                  _loc3_.MC_RoseClear.MC_Icon.gotoAndStop(_loc4_);
               }
            }
            _loc1_++;
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         if(this.FMovieType == ROSE_OPEN)
         {
            this.FBoxList[this.FOpenIdx].MC_RoseOpen.MC_Effect.visible = false;
            this.FBoxList[this.FOpenIdx].MC_RoseOpen.MC_Rose.visible = true;
            this.FBoxList[this.FOpenIdx].MC_RoseOpen.MC_Rose.gotoAndStop(this.FValentineDay3.RoseStatus[this.FOpenIdx]);
            if(this.FClearIdx != -1)
            {
               this.PlayMovie(ROSE_CLEAR);
            }
            else
            {
               this.UpdateUI();
            }
         }
         else if(this.FMovieType == ROSE_CLEAR)
         {
            this.FValentineDay3.RoseStatus[this.FOpenIdx] = 0 - this.FValentineDay3.RoseStatus[this.FOpenIdx];
            this.FValentineDay3.RoseStatus[this.FClearIdx] = 0 - this.FValentineDay3.RoseStatus[this.FClearIdx];
            this.UpdateUI();
         }
         else if(this.FMovieType == ROSE_ALL_OPEN)
         {
            _loc1_ = 0;
            while(_loc1_ < BOX_COUNT)
            {
               if(_loc1_ < this.FValentineDay3.RoseStatus.length)
               {
                  _loc4_ = this.FValentineDay3.RoseStatus[_loc1_];
                  if(_loc4_ > TValentineDay3.ROSE_NONE)
                  {
                     this.FValentineDay3.RoseStatus[_loc1_] = 0 - this.FValentineDay3.RoseStatus[_loc1_];
                  }
               }
               _loc1_++;
            }
            this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FOpenIdx = param1;
         this.FClearIdx = param2;
      }
   }
}

