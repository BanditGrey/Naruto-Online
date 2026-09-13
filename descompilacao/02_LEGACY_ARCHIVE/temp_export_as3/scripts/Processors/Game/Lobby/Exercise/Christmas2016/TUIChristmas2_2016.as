package Processors.Game.Lobby.Exercise.Christmas2016
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas2016.TChristmas2_2016;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.BaseActivity.TProcessorBaseActivity;
   import Processors.Game.Lobby.Exercise.FebActive.TProcessorFebActiveShop;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIChristmas2_2016 extends TUIBaseWindow
   {
      
      protected static const MAX_BOX:int = 40;
      
      protected static const SHOW_ITEM_COUNT:int = 2;
      
      protected static const TITLE_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      public static const MOVIE_OPEN_POINT:int = 0;
      
      public static const MOVIE_RESET:int = 1;
      
      public static const MOVIE_OPEN_ALL_POINT:int = 2;
      
      public static const MOVIE_TYPE_OPEN_CARD:int = 1;
      
      public static const MOVIE_TYPE_OPEN_ALL_CARD:int = 2;
      
      public static const MOVIE_TYPE_RESET:int = 3;
      
      public static const MOVIE_TYPE_CLEAR:int = 4;
      
      public static const MOVIE_TYPE_CLOSE_CARD:int = 5;
      
      protected var FChristmas2_2016:TChristmas2_2016;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FBTN_OpenAll:MovieClip;
      
      protected var FMC_Hammer:MovieClip;
      
      protected var FPointList:Vector.<MovieClip>;
      
      protected var FShowItems:TUIShowItem;
      
      protected var FProcessorFebActiveShop:TProcessorFebActiveShop;
      
      protected var FCurIndex:int;
      
      protected var FCurType:int;
      
      protected var FLastIndex:int;
      
      public function TUIChristmas2_2016(param1:TUIComponent)
      {
         super(param1);
         this.FPointList = new Vector.<MovieClip>(MAX_BOX);
         this.FShowItems = new TUIShowItem(this,SHOW_ITEM_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FBTN_OpenAll = FMC_Scene["BTN_OpenAll"];
         this.FMC_Hammer = FMC_Scene["MC_Hammer"];
         this.FMC_Hammer.mouseEnabled = false;
         this.FMC_Hammer.visible = false;
         this.FShowItems.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItems.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItems.OnOut = this.ProcessorOnItemOut;
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
         while(_loc2_ < TITLE_COUNT)
         {
            FMC_Scene["MC_Title" + _loc2_].buttonMode = true;
            FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnTitleUp);
            FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTitleOver);
            FMC_Scene["MC_Title" + _loc2_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideTitleTip);
            _loc2_++;
         }
         FMC_Scene.MC_Gift.MC_Box.buttonMode = true;
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftUp);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.CLICK,this.ProcessorOnGiftOver);
         FMC_Scene.MC_Gift.MC_Box.addEventListener(MouseEvent.CLICK,ProcessorOnHideHtmlTip);
         this.FProcessorFebActiveShop = new TProcessorFebActiveShop(this.Parent);
         this.FProcessorFebActiveShop.Visible = false;
         this.FProcessorFebActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorFebActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorFebActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorFebActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorFebActiveShop.X = 0;
         this.FProcessorFebActiveShop.y = 0;
         TGameUtil.setButtonMode(this.FBTN_OpenAll,true);
         this.FBTN_OpenAll.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyAllUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Reset,true);
         FMC_Scene.BTN_Reset.addEventListener(MouseEvent.CLICK,this.ProcessorOnResetUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         TGameUtil.setButtonMode(FMC_Scene.BTN_PetDesc,true);
         FMC_Scene.BTN_PetDesc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowPet);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmas2_2016.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmas2_2016.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FChristmas2_2016.DescListNew[1];
         FMC_Scene.TF_TotalScore.text = this.FChristmas2_2016.TotalScore.toString();
         FMC_Scene.TF_LimitTime.text = this.FChristmas2_2016.FreeCount.toString();
      }
      
      protected function UpdatePoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         TGameUtil.setButtonMode(this.FBTN_OpenAll,this.FChristmas2_2016.CanOpenAll());
         _loc1_ = 0;
         while(_loc1_ < MAX_BOX)
         {
            if(_loc1_ < this.FChristmas2_2016.RewardsIndex.length)
            {
               _loc5_ = int(this.FChristmas2_2016.RewardsIndex[_loc1_]);
               if(_loc5_ == TBaseActivity.STATUS_GETED)
               {
                  this.FPointList[_loc1_].visible = false;
               }
               else if(_loc5_ == 0)
               {
                  this.FPointList[_loc1_].visible = true;
                  this.FPointList[_loc1_].MC_Smoke.visible = false;
                  this.FPointList[_loc1_].gotoAndStop(1);
               }
               else
               {
                  this.FPointList[_loc1_].visible = true;
                  this.FPointList[_loc1_].MC_Smoke.visible = false;
                  this.FPointList[_loc1_].gotoAndStop(2);
                  this.FPointList[_loc1_].MC_Icon.gotoAndStop(_loc5_);
               }
            }
            _loc1_++;
         }
         this.FMC_Hammer.visible = false;
      }
      
      protected function UpdateGift() : void
      {
         var _loc1_:TBaseBox = null;
         var _loc2_:MovieClip = null;
         _loc2_ = FMC_Scene.MC_Gift;
         _loc1_ = this.FChristmas2_2016.RechargeGift;
         if(_loc1_.Count > 0)
         {
            _loc2_.MC_Click.visible = true;
            _loc2_.MC_Box.gotoAndPlay(1);
         }
         else
         {
            _loc2_.MC_Click.visible = false;
            _loc2_.MC_Box.stop();
         }
         _loc2_.TF_Count.text = "x" + _loc1_.Count;
         _loc2_.TF_Desc.text = TUtilityString.Format(this.FChristmas2_2016.DescListNew[2],this.FChristmas2_2016.TotalRechargeGold % _loc1_.Price,_loc1_.Price);
         this.FShowItems.UpdateUI(this.FChristmas2_2016.Equipments);
      }
      
      protected function UpdateTitle() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < this.FChristmas2_2016.TitleList.length)
         {
            _loc3_ = FMC_Scene["MC_Title" + _loc1_];
            _loc2_ = this.FChristmas2_2016.TitleList[_loc1_];
            _loc3_.TF_Desc.text = TUtilityString.Format(this.FChristmas2_2016.DescListNew[5],_loc2_.Price);
            if(_loc2_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_Click.visible = true;
               _loc3_.MC_Got.visible = false;
            }
            else if(_loc2_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = true;
            }
            else
            {
               _loc3_.MC_Click.visible = false;
               _loc3_.MC_Got.visible = false;
            }
            _loc1_++;
         }
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
         if(Boolean(FOnBuyBox != null) && Boolean(this.FChristmas2_2016) && this.FChristmas2_2016.RewardsIndex[_loc2_] == 0)
         {
            if(this.FChristmas2_2016.FreeCount > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_OPEN_POINT,_loc2_ + 1);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_OPEN_POINT,this.FChristmas2_2016.BoxPrice,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnBuyAllUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnBuyBox != null && Boolean(this.FChristmas2_2016))
         {
            FOnBuyBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_OPEN_ALL_POINT,this.FChristmas2_2016.TotalBoxPrice);
         }
      }
      
      protected function ProcessorOnResetUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode || FIsPlaying)
         {
            return;
         }
         if(FOnGetBox != null && Boolean(this.FChristmas2_2016))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_RESET);
         }
      }
      
      override protected function ProcessorOnAcceptTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_GET_TASK,_loc3_.Identify);
         }
      }
      
      override protected function ProcessorOnFinishTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < FActTaskData.TaskList.length && !FIsPlaying)
         {
            _loc3_ = FActTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnGiftUp(param1:MouseEvent) : void
      {
         if(!FIsPlaying && this.FChristmas2_2016.RechargeGift.Count > 0)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_GET_GIFT,0);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         if(this.FChristmas2_2016)
         {
            FOnShowHtmlTip(this.FChristmas2_2016.DescListNew[6]);
         }
      }
      
      protected function ProcessorOnTitleUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(!FIsPlaying && this.FChristmas2_2016.TitleList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_GET_TITLE,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnTitleOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(FOnShowTitleTip != null && Boolean(this.FChristmas2_2016))
         {
            FOnShowTitleTip(this.FChristmas2_2016.TitleList[_loc2_].Identify);
         }
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(!FIsPlaying && FOnGetBox != null && Boolean(this.FChristmas2_2016))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas2016.ACTIVITY_2_EXCHANGE_BOX,param1 + 1);
         }
      }
      
      override protected function ProcessorOnShowEquipDesc(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorBaseActivity.WINDOW_EQUIPMENT_DESC,this.FChristmas2_2016);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorFebActiveShop.Visible = true;
         this.FProcessorFebActiveShop.UpdateUI(this.FChristmas2_2016);
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorFebActiveShop.Visible = false;
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
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_2_ID);
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
      
      protected function ProcessorOnShowPet(param1:MouseEvent) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(this.FChristmas2_2016.PetID,TBaseBox.TYPE_IS_PET);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            if(this.FShowItems)
            {
               this.FShowItems.LogicsPerform();
            }
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OPEN_POINT:
                     CurFrame = this.FPointList[this.FCurIndex].MC_Smoke.currentFrame;
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
         this.FChristmas2_2016 = SLogicsCore.ChristmasDatas_2016.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmas2_2016;
         this.UpdateText();
         UpdateTaskView();
         this.UpdatePoint();
         this.UpdateGift();
         this.UpdateTitle();
         if(FIsFirstLoad)
         {
            FIsFirstLoad = false;
            this.FProcessorFebActiveShop.Load();
         }
         if(this.FProcessorFebActiveShop.Visible)
         {
            this.FProcessorFebActiveShop.UpdateUI(this.FChristmas2_2016);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         this.FMovieType = param1;
         FIsPlaying = true;
         switch(this.FMovieType)
         {
            case MOVIE_OPEN_POINT:
               this.FPointList[this.FCurIndex].gotoAndStop(2);
               this.FPointList[this.FCurIndex].MC_Icon.gotoAndStop(this.FCurType);
               this.FChristmas2_2016.RewardsIndex[this.FCurIndex] = this.FCurType;
               this.FPointList[this.FCurIndex].MC_Smoke.visible = true;
               this.FPointList[this.FCurIndex].MC_Smoke.gotoAndPlay(1);
               FTotalFrame = this.FPointList[this.FCurIndex].MC_Smoke.totalFrames;
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
                  this.FPointList[_loc3_].gotoAndStop(2);
                  this.FPointList[_loc3_].MC_Icon.gotoAndStop(this.FChristmas2_2016.RewardsIndex[_loc3_]);
                  _loc3_++;
               }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         FIsPlaying = false;
         switch(this.FMovieType)
         {
            case MOVIE_OPEN_POINT:
               this.FPointList[this.FCurIndex].MC_Smoke.visible = false;
               if(this.FLastIndex == -1)
               {
                  this.UpdateUI();
               }
               else if(this.FCurType == this.FChristmas2_2016.RewardsIndex[this.FLastIndex])
               {
                  this.FChristmas2_2016.RewardsIndex[this.FCurIndex] = TBaseActivity.STATUS_GETED;
                  this.FChristmas2_2016.RewardsIndex[this.FLastIndex] = TBaseActivity.STATUS_GETED;
                  this.UpdateUI();
               }
               else
               {
                  this.FChristmas2_2016.RewardsIndex[this.FCurIndex] = TBaseActivity.STATUS_CANNOTGET;
                  this.FChristmas2_2016.RewardsIndex[this.FLastIndex] = TBaseActivity.STATUS_CANNOTGET;
                  this.UpdateUI();
               }
               break;
            case MOVIE_RESET:
               break;
            case MOVIE_OPEN_ALL_POINT:
               this.FMC_Hammer.visible = false;
               this.FChristmas2_2016.ResetPoint();
               this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FCurIndex = param1;
         this.FCurType = param2;
         this.FLastIndex = param3;
         this.PlayMovie(MOVIE_OPEN_POINT);
      }
   }
}

