package Processors.Game.Lobby.Exercise.JuneActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JuneActive.TJuneActive1;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.JuneActive.TProcessorJuneActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIJuneActive1 extends TUIBaseWindow
   {
      
      public static const ACTIVITY_1_ID:int = 1;
      
      public static const ROAD_COUNT:int = 25;
      
      public static const MOVIE_ROTATION_DISK:int = 1;
      
      public static const MOVIE_PLAYER_MOVE:int = 2;
      
      public static const ROTATION_COUNT:int = 2;
      
      public static const RANDOM_COUNT:int = 2;
      
      public static const EVERY_DEGREE:Vector.<int> = Vector.<int>([350,320,240,50,125,165]);
      
      protected static const MOVIE_TIMES:int = 10;
      
      protected var FJuneActive1:TJuneActive1;
      
      protected var FRoadList:Vector.<TUIBaseBox>;
      
      protected var FNextBox:TUIBaseBox;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FMovieType:int;
      
      protected var FStep:int;
      
      protected var FFrameCount:int;
      
      protected var FMoveIndex:int;
      
      protected var FEndIndex:int;
      
      public function TUIJuneActive1(param1:TUIComponent)
      {
         super(param1);
         this.FRoadList = new Vector.<TUIBaseBox>(ROAD_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         super.Resources_UIDispatch(param1);
         this.FNextBox = new TUIBaseBox(this,1);
         this.FNextBox.Perform_UIDispatch(FMC_Scene.MC_NextBox);
         this.FNextBox.OnOverlay = this.SlotsOnOver;
         this.FNextBox.OnOut = this.SlotsOnOut;
         _loc2_ = 0;
         while(_loc2_ < ROAD_COUNT)
         {
            _loc4_ = new TUIBaseBox(this,1);
            _loc4_.Perform_UIDispatch(FMC_Scene.MC_Road["MC_Slot" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            _loc4_.SetMCIsVisible("MC_Effect",false);
            _loc4_.SetMCIsMouseEnabled("MC_Effect",false);
            this.FRoadList[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = FMC_Scene.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = FMC_Scene.MC_PageRight;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = ROAD_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
         FMC_Scene.BTN_Sign.addEventListener(MouseEvent.CLICK,this.ProcessorOnSignUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLogUp);
         FMC_Scene.MC_Road.MC_LastBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLasdBoxOver);
         FMC_Scene.MC_Road.MC_LastBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnLasdBoxOut);
         FMC_Scene.MC_LastBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLasdBoxOver);
         FMC_Scene.MC_LastBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnLasdBoxOut);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
         FMC_Scene.MC_SurpriseBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnSurpriseBoxOver);
         FMC_Scene.MC_SurpriseBox.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnSurpriseBoxOut);
      }
      
      protected function UpdateRoad() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBaseBox = null;
         var _loc5_:TUIBaseBox = null;
         this.FUIPage.TotalQuantity = TJuneActive1.MAX_COUNT;
         this.FUIPage.Update();
         if(this.FJuneActive1.CurIndex == -1 && this.FCurPage == 0)
         {
            FMC_Scene.MC_Head.visible = true;
            FMC_Scene.MC_HeadEnd.visible = false;
            FMC_Scene.MC_Road.MC_LastBox.MC_Got.visible = false;
         }
         else if(this.FJuneActive1.CurIndex == TJuneActive1.MAX_COUNT - 1 && this.FCurPage == 1)
         {
            FMC_Scene.MC_Head.visible = false;
            FMC_Scene.MC_HeadEnd.visible = true;
            FMC_Scene.MC_Road.MC_LastBox.MC_Got.visible = true;
         }
         else
         {
            FMC_Scene.MC_Head.visible = false;
            FMC_Scene.MC_HeadEnd.visible = false;
            FMC_Scene.MC_Road.MC_LastBox.MC_Got.visible = false;
         }
         if(this.FJuneActive1.CurIndex == TJuneActive1.MAX_COUNT - 1)
         {
            FMC_Scene.MC_LastBox.MC_Got.visible = true;
         }
         else
         {
            FMC_Scene.MC_LastBox.MC_Got.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < ROAD_COUNT)
         {
            _loc5_ = this.FRoadList[_loc1_];
            _loc3_ = ROAD_COUNT * this.FCurPage + _loc1_;
            _loc4_ = this.FJuneActive1.BoxList[_loc3_];
            _loc5_.UpdateUI(_loc4_.Inventories);
            if(Boolean(_loc4_) && _loc4_.Type == 2)
            {
               _loc5_.SetMCIsVisible("MC_Fire",true);
            }
            else
            {
               _loc5_.SetMCIsVisible("MC_Fire",false);
            }
            if(_loc3_ == this.FJuneActive1.CurIndex)
            {
               _loc5_.SetMCIsVisible("MC_Effect",true);
            }
            else
            {
               _loc5_.SetMCIsVisible("MC_Effect",false);
            }
            _loc1_++;
         }
         if(this.FCurPage == 0)
         {
            FMC_Scene.MC_Start.visible = true;
            FMC_Scene.MC_End.visible = false;
            this.FRoadList[24].SetVisible(true);
            FMC_Scene.MC_Road.MC_LastBox.visible = false;
         }
         else
         {
            FMC_Scene.MC_Start.visible = false;
            FMC_Scene.MC_End.visible = true;
            this.FRoadList[24].SetVisible(false);
            FMC_Scene.MC_Road.MC_LastBox.visible = true;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FJuneActive1.SignStatus == TBaseActivity.STATUS_CANGET)
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,true);
            FMC_Scene.MC_Sign.gotoAndStop(1);
         }
         else
         {
            TGameUtil.setButtonMode(FMC_Scene.BTN_Sign,false);
            FMC_Scene.MC_Sign.gotoAndStop(2);
         }
         if(this.FJuneActive1.SurpriseStatus == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_SurpriseBox.gotoAndStop(2);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_SurpriseBox.gotoAndStop(1);
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TInventories = null;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJuneActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJuneActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FJuneActive1.DescListNew[1];
         _loc1_ = this.FJuneActive1.GetNextBoxIndex();
         if(_loc1_ != -1)
         {
            _loc2_ = this.FJuneActive1.BoxList[_loc1_].Inventories;
            this.FNextBox.UpdateUI(_loc2_);
            FMC_Scene.TF_NextBox.text = TUtilityString.Format(this.FJuneActive1.DescListNew[2],_loc1_ - this.FJuneActive1.CurIndex);
         }
         FMC_Scene.TF_LastBox.text = TUtilityString.Format(this.FJuneActive1.DescListNew[2],this.FJuneActive1.BoxList.length - 1 - this.FJuneActive1.CurIndex);
         FMC_Scene.TF_SurpriseDesc.text = this.FJuneActive1.DescListNew[3];
      }
      
      protected function ProcessorOnSignUp(param1:MouseEvent) : void
      {
         if(FOnGetBox != null && this.FJuneActive1.SignStatus == TBaseActivity.STATUS_CANGET && !FIsPlaying)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorJuneActive.ACTIVITY_1_SIGN);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateWindow();
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(this,param2);
         }
      }
      
      protected function ProcessorOnLasdBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(FOnItemOver != null) && Boolean(this.FJuneActive1) && this.FJuneActive1.BoxList.length > 0)
         {
            _loc3_ = this.FJuneActive1.BoxList.length - 1;
            _loc2_ = this.FJuneActive1.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc2_);
         }
      }
      
      protected function ProcessorOnLasdBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         if(Boolean(FOnItemOut != null) && Boolean(this.FJuneActive1) && this.FJuneActive1.BoxList.length > 0)
         {
            _loc3_ = this.FJuneActive1.BoxList.length - 1;
            _loc2_ = this.FJuneActive1.BoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc2_);
         }
      }
      
      protected function ProcessorOnSurpriseBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJuneActive1) && this.FJuneActive1.DescList.length >= 5)
         {
            FOnShowHtmlTip(this.FJuneActive1.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnSurpriseBoxOut(param1:MouseEvent) : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ProcessorOnLogUp(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            if(this.FJuneActive1)
            {
               FMC_Scene.TF_Time.text = TGameUtil.fomatTime(this.FJuneActive1.EndTime - STimingCore.GetServerTick());
               _loc1_ = 0;
               while(_loc1_ < ROAD_COUNT)
               {
                  if(this.FRoadList[_loc1_])
                  {
                     this.FRoadList[_loc1_].LogicsPerform();
                  }
                  _loc1_++;
               }
               if(this.FNextBox)
               {
                  this.FNextBox.LogicsPerform();
               }
            }
            if(FIsPlaying)
            {
               if(this.FMovieType == MOVIE_PLAYER_MOVE)
               {
                  this.PlayMovie(MOVIE_PLAYER_MOVE);
               }
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FJuneActive1 = SLogicsCore.JuneActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TJuneActive1;
         this.UpdatePage();
         this.UpdateWindow();
      }
      
      public function UpdatePage() : void
      {
         if(this.FJuneActive1.CurIndex >= ROAD_COUNT)
         {
            this.FUIPage.PageIndex = 1;
            this.ProcessorPageOnChange(null,1);
         }
         else
         {
            this.FUIPage.PageIndex = 0;
            this.ProcessorPageOnChange(null,0);
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateRoad();
         this.UpdateBtn();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         FIsPlaying = true;
         this.FMovieType = param1;
         if(this.FMovieType == MOVIE_ROTATION_DISK)
         {
            _loc6_ = EVERY_DEGREE[this.FStep - 1] + (ROTATION_COUNT + int(Math.random() * RANDOM_COUNT)) * 360;
            TweenUtil.to(FMC_Scene.MC_Round,3000,{
               "rotation":_loc6_,
               "ease":Expo.easeOut,
               "onComplete":this.MovieEnd
            });
         }
         else if(this.FMovieType == MOVIE_PLAYER_MOVE)
         {
            ++this.FFrameCount;
            if(this.FFrameCount < MOVIE_TIMES)
            {
               return;
            }
            this.FFrameCount = 0;
            _loc3_ = 0;
            while(_loc3_ < ROAD_COUNT)
            {
               this.FRoadList[_loc3_].SetMCIsVisible("MC_Effect",false);
               _loc3_++;
            }
            ++this.FMoveIndex;
            if(this.FMoveIndex >= ROAD_COUNT && this.FCurPage != 1)
            {
               this.FUIPage.PageIndex = 1;
               this.ProcessorPageOnChange(null,1);
            }
            _loc7_ = this.FMoveIndex % ROAD_COUNT;
            this.FRoadList[_loc7_].SetMCIsVisible("MC_Effect",true);
            if(this.FMoveIndex == this.FEndIndex)
            {
               this.MovieEnd();
            }
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:TInventory = null;
         if(this.FMovieType == MOVIE_ROTATION_DISK)
         {
            this.FMoveIndex = this.FJuneActive1.CurIndex;
            this.FEndIndex = Math.min(TJuneActive1.MAX_COUNT - 1,this.FJuneActive1.CurIndex + this.FStep);
            if(this.FMoveIndex < ROAD_COUNT)
            {
               if(this.FCurPage != 0)
               {
                  this.FUIPage.PageIndex = 0;
                  this.ProcessorPageOnChange(null,0);
               }
            }
            else if(this.FMoveIndex >= ROAD_COUNT)
            {
               if(this.FCurPage != 1)
               {
                  this.FUIPage.PageIndex = 1;
                  this.ProcessorPageOnChange(null,1);
               }
            }
            this.PlayMovie(MOVIE_PLAYER_MOVE);
         }
         else if(this.FMovieType == MOVIE_PLAYER_MOVE)
         {
            FIsPlaying = false;
            this.FJuneActive1.CurIndex = this.FEndIndex;
            if(Boolean(this.FJuneActive1.BoxList[this.FEndIndex]) && Boolean(this.FJuneActive1.BoxList[this.FEndIndex].Type > 0) && FOnShowFlowText != null)
            {
               _loc2_ = this.FJuneActive1.BoxList[this.FEndIndex].Inventories.GetInventoryByIndex(0);
               _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
               _loc1_ += _loc2_.Name + "*" + _loc2_.Quantity + "\n";
               FOnShowFlowText(_loc1_);
            }
            this.UpdateUI();
         }
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
         this.FStep = param1;
      }
      
      override public function Unmount() : void
      {
         FMC_Scene.MC_Round.rotation = 0;
      }
   }
}

