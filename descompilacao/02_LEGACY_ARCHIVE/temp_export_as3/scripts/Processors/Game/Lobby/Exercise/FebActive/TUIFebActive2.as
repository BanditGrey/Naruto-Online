package Processors.Game.Lobby.Exercise.FebActive
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FebActive.TFebActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIFebActive2 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const TREE_MAX_LEVEL:int = 4;
      
      public static const MOVIE_OF_PLAY_GAME:int = 0;
      
      protected var FFebActive2:TFebActive2;
      
      protected var FIsFirst:Boolean;
      
      protected var FMovieType:int;
      
      protected var FFrameCount:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TUIFebActive2(param1:TUIComponent)
      {
         super(param1);
         this.FIsFirst = true;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIShowItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < TREE_MAX_LEVEL)
         {
            _loc5_ = FMC_Scene["MC_Tree" + _loc2_];
            _loc5_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTreeOver);
            _loc5_.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
            _loc2_++;
         }
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_Movie.mouseEnabled = false;
         this.FMC_Mask = FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Water,true);
         FMC_Scene.BTN_Water.addEventListener(MouseEvent.CLICK,this.ProcessorOnWaterUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnReturnUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Back,true);
         FMC_Scene.BTN_Back.addEventListener(MouseEvent.CLICK,this.ProcessorOnBackUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_AllLog,true);
         FMC_Scene.BTN_AllLog.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenAllLog);
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         FMC_Scene.MC_Tree.gotoAndStop(this.FFebActive2.CurTreeLevel);
         _loc3_ = this.FFebActive2.TreeList[this.FFebActive2.CurTreeLevel - 1];
         if(this.FFebActive2.CurTreeLevel == 1)
         {
            FMC_Scene.MC_Buff.TF_Desc.text = this.FFebActive2.DescListNew[5];
            FMC_Scene.TF_Level.text = this.FFebActive2.DescListNew[11];
         }
         else
         {
            FMC_Scene.MC_Buff.TF_Desc.text = TUtilityString.Format(this.FFebActive2.DescListNew[4],_loc3_.Count);
            FMC_Scene.TF_Level.text = "LV" + (this.FFebActive2.CurTreeLevel - 1);
         }
         FMC_Scene.MC_Bar.TF_Count.text = this.FFebActive2.CurTreeValue + "/" + _loc3_.Max;
         _loc1_ = Number(this.FFebActive2.CurTreeValue / _loc3_.Max) * this.FBarMaxWidth;
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc2_;
         if(this.FFebActive2.GameStatus == TFebActive2.STATUS_OF_PLANT)
         {
            FMC_Scene.MC_End.visible = false;
            if(this.FFebActive2.CurTreeLevel == TREE_MAX_LEVEL)
            {
               FMC_Scene.MC_MaxLevel.visible = true;
               FMC_Scene.BTN_Water.visible = false;
               FMC_Scene.TF_WaterCount.text = "";
            }
            else
            {
               FMC_Scene.MC_MaxLevel.visible = false;
               FMC_Scene.BTN_Water.visible = true;
               FMC_Scene.TF_WaterCount.text = this.FFebActive2.WaterCount > 0 ? "*" + this.FFebActive2.WaterCount : "";
               if(this.FFebActive2.WaterCount > 0)
               {
                  FMC_Scene.TF_WaterCount.text = "*" + this.FFebActive2.WaterCount;
                  TGameUtil.setButtonMode(FMC_Scene.BTN_Water,true);
               }
               else
               {
                  FMC_Scene.TF_WaterCount.text = "*" + this.FFebActive2.WaterCount;
                  TGameUtil.setButtonMode(FMC_Scene.BTN_Water,false);
               }
            }
         }
         else
         {
            FMC_Scene.MC_End.visible = true;
            FMC_Scene.MC_MaxLevel.visible = false;
            FMC_Scene.BTN_Water.visible = false;
            FMC_Scene.TF_WaterCount.text = "";
         }
      }
      
      protected function UpdateTreeList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < TREE_MAX_LEVEL)
         {
            _loc3_ = FMC_Scene["MC_Tree" + _loc1_];
            _loc2_ = this.FFebActive2.TreeList[_loc1_];
            _loc3_.gotoAndStop(_loc1_ + 1);
            if(_loc1_ == this.FFebActive2.CurTreeLevel - 1)
            {
               _loc3_.MC_Select.visible = true;
            }
            else
            {
               _loc3_.MC_Select.visible = false;
            }
            _loc1_++;
         }
         _loc2_ = this.FFebActive2.TreeList[this.FFebActive2.CurTreeLevel - 1];
         if(this.FFebActive2.CurTreeLevel == 1)
         {
            FMC_Scene.MC_TreeStatus.TF_Level.text = this.FFebActive2.DescListNew[11];
            FMC_Scene.MC_TreeStatus.TF_Desc.text = this.FFebActive2.DescListNew[12];
         }
         else
         {
            FMC_Scene.MC_TreeStatus.TF_Level.text = "LV" + (this.FFebActive2.CurTreeLevel - 1);
            FMC_Scene.MC_TreeStatus.TF_Desc.text = TUtilityString.Format(this.FFebActive2.DescListNew[13],_loc2_.Count);
         }
      }
      
      protected function UpdateReturn() : void
      {
         if(this.FFebActive2.CurTreeLevel == 1)
         {
            if(this.FFebActive2.GameStatus == TFebActive2.STATUS_OF_RETURN)
            {
               FMC_Scene.MC_PlantEnd.visible = true;
               FMC_Scene.MC_Mask.visible = false;
            }
            else
            {
               FMC_Scene.MC_PlantEnd.visible = false;
               FMC_Scene.MC_Mask.visible = true;
            }
         }
         else
         {
            FMC_Scene.MC_Mask.visible = false;
            FMC_Scene.MC_PlantEnd.visible = false;
         }
         if(this.FFebActive2.CurReturn.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.MC_NotBegin.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else if(this.FFebActive2.CurReturn.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = false;
            FMC_Scene.MC_NotBegin.visible = true;
         }
         else
         {
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = true;
            FMC_Scene.MC_NotBegin.visible = false;
         }
         FMC_Scene.TF_GoldDesc.text = TUtilityString.Format(this.FFebActive2.DescListNew[9],this.FFebActive2.TreeList[this.FFebActive2.CurTreeLevel - 1].Count);
         FMC_Scene.TF_DayDesc.text = TUtilityString.Format(this.FFebActive2.DescListNew[10],TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(this.FFebActive2.GetTime) * 1000)));
         FMC_Scene.TF_GoldCount.text = "*" + this.FFebActive2.CurReturn.Count;
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Desc.text = this.FFebActive2.DescListNew[1];
         FMC_Scene.TF_PlantDays.text = this.FFebActive2.DescListNew[2];
         FMC_Scene.TF_GetDays.text = this.FFebActive2.DescListNew[3];
         FMC_Scene.TF_RechargeDesc.text = TUtilityString.Format(this.FFebActive2.DescListNew[6],this.FFebActive2.RechargeGold);
         FMC_Scene.TF_ConsumeDesc.text = TUtilityString.Format(this.FFebActive2.DescListNew[7],this.FFebActive2.ConsumeGold);
         FMC_Scene.TF_ConsumeTip.text = TUtilityString.Format(this.FFebActive2.DescListNew[8],this.FFebActive2.ConsumeAddTimes);
      }
      
      protected function ProcessorOnWaterUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FFebActive2))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorFebActive.ACTIVITY_2_WATER);
         }
      }
      
      protected function ProcessorOnReturnUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null && !FIsPlaying && Boolean(this.FFebActive2))
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorFebActive.ACTIVITY_2_GET);
         }
      }
      
      protected function ProcessorOnBackUp(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorFebActive.WINDOW_HOME);
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
      
      protected function ProcessorOnOpenAllLog(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            FOnShowWindow(TProcessorFebActive.WINDOW_ALL_LOG);
         }
      }
      
      protected function ProcessorOnTreeOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(FOnShowHtmlTip != null)
         {
            _loc4_ = this.FFebActive2.TreeList[_loc2_];
            if(_loc4_.Count == 0)
            {
               _loc3_ = this.FFebActive2.DescListNew[12] + "     ";
            }
            else
            {
               _loc3_ = TUtilityString.Format(this.FFebActive2.DescListNew[13],_loc4_.Count) + "     ";
            }
            FOnShowHtmlTip(_loc3_);
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
            if(FIsPlaying)
            {
               switch(this.FMovieType)
               {
                  case MOVIE_OF_PLAY_GAME:
                     CurFrame = FMC_Scene.MC_Movie.currentFrame;
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
         this.FFebActive2 = SLogicsCore.FebActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TFebActive2;
         this.UpdateTree();
         this.UpdateTreeList();
         this.UpdateReturn();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         FIsPlaying = true;
         this.FMovieType = param1;
         FMC_Scene.MC_Movie.visible = true;
         FMC_Scene.MC_Movie.gotoAndPlay(1);
         FTotalFrame = FMC_Scene.MC_Movie.totalFrames;
         FMC_Scene.BTN_Water.visible = false;
      }
      
      override public function MovieEnd() : void
      {
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_Movie.stop();
         FMC_Scene.BTN_Water.visible = true;
         this.UpdateUI();
      }
      
      override public function Unmount() : void
      {
         var _loc1_:int = 0;
         TweenUtil.removeAllTween();
      }
      
      override public function SetMovieParam(param1:int = 0, param2:int = 0, param3:int = 0) : void
      {
      }
   }
}

