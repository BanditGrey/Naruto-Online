package Processors.Game.Lobby.Exercise.SpringFestival.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SpringFestival.TSpringFestivalFireworks;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBar;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.SpringFestival.TProcessorSpringFestival;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUISpringFestivalFirework extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 4;
      
      protected static const FISH_COUNT:int = 5;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FFishList:Vector.<MovieClip>;
      
      protected var FUIBar:TUIBaseBar;
      
      protected var FSpringFestivalFireworks:TSpringFestivalFireworks;
      
      public function TUISpringFestivalFirework(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
         this.FFishList = new Vector.<MovieClip>(FISH_COUNT);
         this.FUIBar = new TUIBaseBar(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Box" + _loc2_];
            TGameUtil.setButtonMode(this.FBoxList[_loc2_].BTN_Get,true);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
            this.FBoxList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
            this.FBoxList[_loc2_].BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < FISH_COUNT)
         {
            this.FFishList[_loc2_] = FMC_Scene["MC_Fish" + _loc2_];
            this.FFishList[_loc2_].MC_BoxPic.buttonMode = true;
            this.FFishList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFishOver);
            this.FFishList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnFishOut);
            this.FFishList[_loc2_].MC_BoxPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetFishUp);
            _loc2_++;
         }
         this.FUIBar.Perform_UIDispatch(FMC_Scene.MC_AccumBar,TUIBaseBar.OPPOSITE_DIRECTION);
         FMC_Scene.MC_Click.mouseEnabled = false;
         FMC_Scene.MC_Click.TF_Text.mouseEnabled = false;
         FMC_Scene.MC_Firework.buttonMode = true;
         FMC_Scene.MC_Firework.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnFireworkOver);
         FMC_Scene.MC_Firework.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnFireworkOut);
         FMC_Scene.MC_Firework.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetFireworkUp);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyFireworkUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.MC_Effect.visible = false;
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = this.FBoxList[_loc1_];
            if(_loc1_ < this.FSpringFestivalFireworks.BoxList.length)
            {
               _loc4_ = this.FSpringFestivalFireworks.BoxList[_loc1_];
               _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
               _loc3_.TF_Desc.text = _loc4_.Desc1;
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,true);
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_BoxPic.gotoAndStop(1);
                  _loc3_.MC_Got.visible = false;
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
               }
               else
               {
                  _loc3_.MC_BoxPic.gotoAndStop(1);
                  _loc3_.MC_Got.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Get,false);
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateFish() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TBaseBox = null;
         _loc1_ = 0;
         while(_loc1_ < FISH_COUNT)
         {
            _loc3_ = this.FFishList[_loc1_];
            if(_loc1_ < this.FSpringFestivalFireworks.FishList.length)
            {
               _loc4_ = this.FSpringFestivalFireworks.FishList[_loc1_];
               _loc3_.TF_Desc.text = _loc4_.Desc1;
               if(_loc4_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
                  _loc3_.MC_BoxPic.gotoAndPlay(1);
                  _loc3_.MC_Got.visible = false;
                  _loc3_.BTN_Get.visible = true;
               }
               else if(_loc4_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1 + FISH_COUNT);
                  _loc3_.MC_BoxPic.gotoAndStop(1);
                  _loc3_.MC_Got.visible = false;
                  _loc3_.BTN_Get.visible = false;
               }
               else
               {
                  _loc3_.MC_BoxPic.MC_Icon.gotoAndStop(_loc1_ + 1);
                  _loc3_.MC_BoxPic.gotoAndStop(1);
                  _loc3_.MC_Got.visible = true;
                  _loc3_.BTN_Get.visible = false;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateFirework() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         _loc1_ = Math.max(0,this.FSpringFestivalFireworks.FireworkDays - this.FSpringFestivalFireworks.ContiueDays);
         this.FUIBar.UpdateUI(_loc1_,0,this.FSpringFestivalFireworks.FireworkDays);
         if(this.FSpringFestivalFireworks.ContiueDays < this.FSpringFestivalFireworks.FireworkDays)
         {
            this.FUIBar.SetArrowVisible(true);
            _loc2_ = TUtilityString.Format(this.FSpringFestivalFireworks.ActivityDesc2,this.FSpringFestivalFireworks.ContiueDays,this.FSpringFestivalFireworks.FireworkDays - this.FSpringFestivalFireworks.ContiueDays);
            this.FUIBar.SetFArrowText(_loc2_);
         }
         else
         {
            this.FUIBar.SetArrowVisible(false);
         }
         if(this.FSpringFestivalFireworks.FireworkStatus == TBaseActivity.STATUS_CANGET)
         {
            this.FUIBar.SetVisible(false);
            FMC_Scene.MC_Firework.visible = true;
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.MC_Click.visible = true;
            FMC_Scene.BTN_Buy.visible = false;
         }
         else if(this.FSpringFestivalFireworks.FireworkStatus == TBaseActivity.STATUS_CANNOTGET)
         {
            this.FUIBar.SetVisible(true);
            FMC_Scene.MC_Firework.visible = true;
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.MC_Click.visible = false;
            FMC_Scene.BTN_Buy.visible = true;
         }
         else
         {
            this.FUIBar.SetVisible(false);
            FMC_Scene.MC_Firework.visible = false;
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.MC_Click.visible = false;
            FMC_Scene.BTN_Buy.visible = false;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSpringFestivalFireworks.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSpringFestivalFireworks.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSpringFestivalFireworks.ActivityDesc;
         FMC_Scene.TF_Days.text = TUtilityString.Format(this.FSpringFestivalFireworks.ActivityName,this.FSpringFestivalFireworks.TotalDays);
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnGetBox != null) && Boolean(this.FSpringFestivalFireworks) && _loc2_ < this.FSpringFestivalFireworks.BoxList.length)
         {
            if(this.FSpringFestivalFireworks.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorSpringFestival.FIREWORK_GET_BOX,_loc2_ + 1);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(6));
         if(Boolean(FOnBoxOver != null) && Boolean(this.FSpringFestivalFireworks) && _loc2_ < this.FSpringFestivalFireworks.BoxList.length)
         {
            _loc3_ = this.FSpringFestivalFireworks.BoxList[_loc2_].Inventories;
            FOnBoxOver(_loc3_);
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
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnGetBox != null) && Boolean(this.FSpringFestivalFireworks) && _loc2_ < this.FSpringFestivalFireworks.FishList.length)
         {
            if(this.FSpringFestivalFireworks.FishList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorSpringFestival.FIREWORK_GET_FISH,_loc2_ + 1);
            }
         }
      }
      
      protected function ProcessorOnFishOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(Boolean(FOnBoxOver != null) && Boolean(this.FSpringFestivalFireworks) && _loc2_ < this.FSpringFestivalFireworks.FishList.length)
         {
            _loc3_ = this.FSpringFestivalFireworks.FishList[_loc2_].Inventories;
            FOnBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnFishOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnGetFireworkUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null)
         {
            if(this.FSpringFestivalFireworks.FireworkStatus == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorSpringFestival.FIREWORK_GET_FIREWORK);
            }
         }
      }
      
      protected function ProcessorOnFireworkOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(FOnBoxOver != null && Boolean(this.FSpringFestivalFireworks))
         {
            _loc2_ = this.FSpringFestivalFireworks.Inventories;
            FOnBoxOver(_loc2_);
         }
      }
      
      protected function ProcessorOnFireworkOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
         }
      }
      
      protected function ProcessorOnBuyFireworkUp(param1:MouseEvent) : void
      {
         if(FOnBuyBox != null && Boolean(this.FSpringFestivalFireworks))
         {
            if(this.FSpringFestivalFireworks.FireworkStatus == TBaseActivity.STATUS_CANNOTGET)
            {
               FOnBuyBox(ACTIVITY_1_ID,TProcessorSpringFestival.FIREWORK_BUY_FIREWORK,this.FSpringFestivalFireworks.FireworkCost);
            }
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
               CurFrame = FMC_Scene.MC_Effect.MC_Effect.currentFrame;
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
         this.FSpringFestivalFireworks = SLogicsCore.SpringFestivalDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TSpringFestivalFireworks;
         this.UpdateBox();
         this.UpdateFish();
         this.UpdateFirework();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         _loc5_ = FMC_Scene.MC_Effect;
         if(_loc5_)
         {
            this.FUIBar.SetVisible(false);
            FMC_Scene.MC_Firework.visible = false;
            FIsPlaying = true;
            _loc5_.visible = true;
            FTotalFrame = _loc5_.MC_Effect.totalFrames;
            _loc5_.MC_Effect.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FMC_Scene.MC_Effect.MC_Effect.stop();
         FMC_Scene.MC_Effect.visible = false;
         this.UpdateUI();
      }
   }
}

