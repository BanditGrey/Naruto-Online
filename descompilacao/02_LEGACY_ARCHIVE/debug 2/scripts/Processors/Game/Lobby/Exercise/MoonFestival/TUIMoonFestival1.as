package Processors.Game.Lobby.Exercise.MoonFestival
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MoonFestival.TMoonFestival1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIMoonFestival1 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const FRUIT_COUNT:int = 10;
      
      protected static const GIFT_COUNT:int = 2;
      
      public static const MOVIE_TYPE_WATER:int = 1;
      
      public static const MOVIE_TYPE_TREE:int = 2;
      
      protected var FMoonFestival1:TMoonFestival1;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FFruitList:TUIShowItem;
      
      protected var FTF_CDTime:TextField;
      
      protected var FIsCD:Boolean;
      
      public function TUIMoonFestival1(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FFruitList = new TUIShowItem(this,FRUIT_COUNT);
         this.FFruitList.Perform_UIDispatch(FMC_Scene.MC_Fruits);
         this.FFruitList.OnOverlay = this.ProcessorOnItemOver;
         this.FFruitList.OnOut = this.ProcessorOnItemOut;
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_End.visible = false;
         this.FTF_CDTime = FMC_Scene.TF_Time;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Water,true);
         FMC_Scene.BTN_Water.addEventListener(MouseEvent.CLICK,this.ProcessorOnWaterUp);
         FMC_Scene.BTN_Water.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnWaterOver);
         FMC_Scene.BTN_Water.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GotoRecharge,true);
         FMC_Scene.BTN_GotoRecharge.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
         _loc1_ = 0;
         while(_loc1_ < FRUIT_COUNT)
         {
            FMC_Scene.MC_Fruits["MC_Slot" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnFruitUp);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < GIFT_COUNT)
         {
            FMC_Scene["MC_Gift" + _loc1_].MC_BoxPic.buttonMode = true;
            FMC_Scene["MC_Gift" + _loc1_].MC_BoxPic.gotoAndStop(_loc1_ + 1);
            FMC_Scene["MC_Gift" + _loc1_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGiftOver);
            FMC_Scene["MC_Gift" + _loc1_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            TGameUtil.setButtonMode(FMC_Scene["MC_Gift" + _loc1_].BTN_Get,true);
            FMC_Scene["MC_Gift" + _loc1_].BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnLotteryUp);
            _loc1_++;
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
            _loc3_ = this.FMoonFestival1.GiftList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               _loc2_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,true);
            }
            else if(_loc3_.Status == TBaseActivity.STATUS_GETED)
            {
               _loc2_.MC_Got.visible = true;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
            }
            else
            {
               _loc2_.MC_Got.visible = false;
               TGameUtil.setButtonMode(_loc2_.BTN_Get,false);
            }
            _loc1_++;
         }
      }
      
      protected function UpdateShowItem() : void
      {
         this.FShowItem.UpdateUI(this.FMoonFestival1.ShowItems);
      }
      
      protected function UpdateFruitList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FFruitList.UpdateUI(this.FMoonFestival1.FruitList);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Water,this.FIsCD);
         _loc1_ = 0;
         while(_loc1_ < FRUIT_COUNT)
         {
            if(_loc1_ < this.FMoonFestival1.FruitStatus.length)
            {
               _loc2_ = FMC_Scene.MC_Fruits["MC_Slot" + _loc1_];
               if(this.FIsCD)
               {
                  _loc2_.MC_Got.visible = false;
                  _loc2_.MC_Click.visible = false;
               }
               else if(this.FMoonFestival1.FruitStatus[_loc1_] == TBaseActivity.STATUS_GETED)
               {
                  _loc2_.MC_Got.visible = true;
                  _loc2_.MC_Click.visible = false;
               }
               else
               {
                  _loc2_.MC_Got.visible = false;
                  _loc2_.MC_Click.visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FMoonFestival1.TreeLevel == -1)
         {
            FMC_Scene.MC_Tree.gotoAndStop(5);
            FMC_Scene.MC_End.visible = true;
            FMC_Scene.TF_Level.text = this.FMoonFestival1.DescListNew[3];
         }
         else
         {
            FMC_Scene.MC_Tree.gotoAndStop(int((this.FMoonFestival1.TreeLevel - 1) / 2) + 1);
            FMC_Scene.MC_End.visible = false;
            FMC_Scene.TF_Level.text = this.FMoonFestival1.TreeLevel.toString();
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FMoonFestival1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FMoonFestival1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FMoonFestival1.DescListNew[1];
         FMC_Scene.TF_GiftDesc0.text = this.FMoonFestival1.DescListNew[4];
         FMC_Scene.TF_GiftDesc1.text = this.FMoonFestival1.DescListNew[5];
         FMC_Scene.TF_WaterCount.text = this.FMoonFestival1.WaterCount.toString();
         FMC_Scene.TF_RechargeGold.text = this.FMoonFestival1.CurGold % this.FMoonFestival1.MaxGold + "/" + this.FMoonFestival1.MaxGold;
      }
      
      protected function ProcessorOnLotteryUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMoonFestival.ACTIVITY_1_GET_GIFT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnGiftOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(this.FMoonFestival1.DescListNew[6 + _loc2_]);
         }
      }
      
      protected function ProcessorOnWaterUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(FOnGetBox != null) && Boolean(this.FMoonFestival1) && this.FMoonFestival1.TreeLevel != TBaseActivity.STATUS_GETED)
         {
            if(this.FMoonFestival1.WaterCount > 0)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorMoonFestival.ACTIVITY_1_WATER_UP);
            }
            else
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorMoonFestival.ACTIVITY_1_WATER_UP,this.FMoonFestival1.WaterPrice);
            }
         }
      }
      
      protected function ProcessorOnWaterOver(param1:MouseEvent) : void
      {
         if(FOnShowHtmlTip != null)
         {
         }
      }
      
      protected function ProcessorOnFruitUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FMoonFestival1 && _loc2_ < this.FMoonFestival1.FruitStatus.length) && Boolean(this.FMoonFestival1.FruitStatus[_loc2_] != TBaseActivity.STATUS_GETED) && !this.FIsCD)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorMoonFestival.ACTIVITY_1_GET_FRUIT,_loc2_ + 1);
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
            FOnLoadLog(ACTIVITY_1_ID);
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
         var _loc1_:int = 0;
         if(FInitialized && this.visible && Boolean(this.FMoonFestival1))
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FFruitList)
            {
               this.FFruitList.LogicsPerform();
            }
            _loc1_ = this.FMoonFestival1.NextTime - STimingCore.GetServerTick();
            this.FTF_CDTime.text = TGameUtil.FomatDayAndTime(_loc1_);
            if(_loc1_ <= 0 && this.FIsCD || _loc1_ > 0 && !this.FIsCD)
            {
               this.FIsCD = _loc1_ <= 0 ? false : true;
               this.FMoonFestival1.ChangeStatus();
               this.UpdateFruitList();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FMoonFestival1 = SLogicsCore.MoonFestivalDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TMoonFestival1;
         this.UpdateGift();
         this.UpdateShowItem();
         this.UpdateFruitList();
         this.UpdateTree();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         switch(param1)
         {
            case MOVIE_TYPE_WATER:
               FMC_Scene.MC_Effect.gotoAndPlay(1);
               break;
            case MOVIE_TYPE_TREE:
               FMC_Scene.MC_Movie.visible = true;
               FMC_Scene.MC_Movie.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
      }
      
      override public function Unmount() : void
      {
         TweenUtil.removeAllTween();
         FIsPlaying = false;
      }
   }
}

