package Processors.Game.Lobby.Exercise.SpringFestival.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SpringFestival.TSpringFestivalFish;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.SpringFestival.TProcessorSpringFestival;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class TUISpringFestivalFish extends TUIBaseWindow
   {
      
      protected static const FISH_COUNT:int = 5;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected var FFishList:Vector.<MovieClip>;
      
      protected var FSpringFestivalFish:TSpringFestivalFish;
      
      public function TUISpringFestivalFish(param1:TUIComponent)
      {
         super(param1);
         this.FFishList = new Vector.<MovieClip>(FISH_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < FISH_COUNT)
         {
            this.FFishList[_loc2_] = FMC_Scene["MC_Fish" + _loc2_];
            this.FFishList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFishOver);
            this.FFishList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnFishOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.MC_Box.BTN_Recharge,true);
         FMC_Scene.MC_Box.BTN_Recharge.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
         TGameUtil.setButtonMode(FMC_Scene.MC_Box.BTN_Get,true);
         FMC_Scene.MC_Box.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         FMC_Scene.MC_Box.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         FMC_Scene.MC_Box.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
         FMC_Scene.MC_PoolTip.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetFishUp);
         FMC_Scene.MC_PoolTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnGetFishOver);
         FMC_Scene.MC_PoolTip.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnGetFishOut);
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_Net.visible = false;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         var _loc5_:int = 0;
         _loc5_ = this.FSpringFestivalFish.GetCurLevel();
         _loc3_ = FMC_Scene.MC_Box;
         if(_loc5_ < this.FSpringFestivalFish.BoxList.length)
         {
            _loc3_.MC_Got.visible = false;
            _loc4_ = this.FSpringFestivalFish.BoxList[_loc5_];
            _loc3_.TF_Desc1.text = _loc4_.Desc1;
            _loc3_.TF_Desc2.text = _loc4_.Desc2;
            if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
               _loc3_.MC_Box.gotoAndPlay(1);
            }
            else
            {
               TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
               _loc3_.MC_Box.gotoAndStop(1);
            }
         }
         else
         {
            _loc3_.MC_Got.visible = true;
            TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
         }
      }
      
      protected function UpdateBtn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSpringFestivalFish.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSpringFestivalFish.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSpringFestivalFish.ActivityDesc;
         FMC_Scene.TF_Count.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_AMOUNT,this.FSpringFestivalFish.Count);
         FMC_Scene.TF_Money.text = TUtilityString.Format(this.FSpringFestivalFish.ActivityDesc2,this.FSpringFestivalFish.TotalMoney);
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            _loc2_ = this.FSpringFestivalFish.GetCurLevel();
            FOnGetBox(ACTIVITY_2_ID,TProcessorSpringFestival.FISH_GET_BOX,_loc2_ + 1);
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         var _loc3_:int = 0;
         if(Boolean(FOnBoxOver != null) && Boolean(this.FSpringFestivalFish) && this.FSpringFestivalFish.BoxList.length > 0)
         {
            _loc3_ = this.FSpringFestivalFish.GetCurLevel();
            _loc2_ = this.FSpringFestivalFish.BoxList[_loc3_].Inventories;
            FOnBoxOver(_loc2_);
         }
      }
      
      override protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnGetFishUp(param1:MouseEvent) : void
      {
         if(!this.FSpringFestivalFish)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorSpringFestival.FISH_GET_FISH);
         }
      }
      
      protected function ProcessorOnGetFishOver(param1:MouseEvent) : void
      {
         Mouse.hide();
         FMC_Scene.MC_Net.visible = true;
         FMC_Scene.MC_Net.x = param1.localX + 260;
         FMC_Scene.MC_Net.y = param1.localY + 170;
         if(Boolean(this.FSpringFestivalFish) && this.FSpringFestivalFish.Count > 0)
         {
            FMC_Scene.MC_Net.gotoAndStop(1);
         }
         else
         {
            FMC_Scene.MC_Net.gotoAndStop(2);
         }
      }
      
      protected function ProcessorOnGetFishOut(param1:MouseEvent) : void
      {
         Mouse.show();
         FMC_Scene.MC_Net.visible = false;
      }
      
      protected function ProcessorOnFishOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnSpecialOver != null) && Boolean(this.FSpringFestivalFish) && this.FSpringFestivalFish.FishList.length > 0)
         {
            FOnSpecialOver(0,this.FSpringFestivalFish.FishList[_loc2_]);
         }
      }
      
      protected function ProcessorOnFishOut(param1:MouseEvent) : void
      {
         if(FOnSpecialOut != null)
         {
            FOnSpecialOut(0);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
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
               CurFrame = FMC_Scene.MC_Movie.currentFrame;
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
         this.FSpringFestivalFish = SLogicsCore.SpringFestivalDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TSpringFestivalFish;
         this.UpdateBox();
         this.UpdateBtn();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         _loc5_ = FMC_Scene.MC_Movie;
         if(_loc5_)
         {
            FIsPlaying = true;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.totalFrames;
            _loc5_.gotoAndPlay(1);
            _loc5_.MC_Icon.gotoAndStop(param1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FMC_Scene.MC_Movie.gotoAndStop(1);
         FMC_Scene.MC_Movie.visible = false;
      }
   }
}

