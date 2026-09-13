package Processors.Game.Lobby.Exercise.MarchConsume
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.MarchConsume.TMarchConsume;
   import Logics.Exercise.TBaseActivity;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorMarchConsumeLog extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 513;
      
      protected static const SIZE_Window_Height:uint = 453;
      
      protected static const CONSUME_COUNT:int = 5;
      
      protected static const LEVEL_COUNT:int = 3;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FMarchConsume:TMarchConsume;
      
      protected var FInitialized:Boolean;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorMarchConsumeLog(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137122);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_MarchConsumeLog") as MovieClip;
         addChild(this.FMC_Scene);
         this.FBtn_Close = this.FMC_Scene["Btn_Close"];
         this.FMC_Scene.x = CONST_COMMON.STAGE_Width - SIZE_Window_Width >> 1;
         this.FMC_Scene.y = CONST_COMMON.STAGE_Height - SIZE_Window_Height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TLotteryNews = null;
         var _loc5_:int = 0;
         this.FMC_Scene["TF_Total"].text = TUtilityString.Format(this.FMarchConsume.DescListNew[4],this.FMarchConsume.TotalConsumeGold);
         _loc1_ = 0;
         while(_loc1_ < CONSUME_COUNT)
         {
            if(_loc1_ < this.FMarchConsume.ConsumeLog.length)
            {
               _loc4_ = this.FMarchConsume.ConsumeLog[_loc1_];
               _loc3_ = this.FMC_Scene["TF_Log" + _loc1_];
               _loc3_.visible = true;
               _loc3_.TF_Desc0.text = TUtilityString.Format(this.FMarchConsume.DescListNew[5],TUtilityDate.FormatMMDDChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.GetTime) * 1000)),_loc4_.Count);
               _loc2_ = 0;
               while(_loc2_ < _loc4_.StatusList.length)
               {
                  _loc3_["TF_Level" + _loc2_].text = TUtilityString.Format(this.FMarchConsume.DescListNew[6],_loc4_.PriceList[_loc2_]);
                  _loc5_ = _loc4_.StatusList[_loc2_];
                  if(_loc5_ == TBaseActivity.STATUS_CANNOTGET)
                  {
                     _loc3_["MC_Status" + _loc2_].gotoAndStop(2);
                  }
                  else if(_loc5_ == TBaseActivity.STATUS_CANGET)
                  {
                     _loc3_["MC_Status" + _loc2_].gotoAndStop(1);
                  }
                  else
                  {
                     _loc3_["MC_Status" + _loc2_].gotoAndStop(3);
                  }
                  _loc2_++;
               }
            }
            else
            {
               this.FMC_Scene["TF_Log" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp();
         }
      }
      
      public function get OnCloseUp() : Function
      {
         return this.FOnCloseUp;
      }
      
      public function set OnCloseUp(param1:Function) : void
      {
         this.FOnCloseUp = param1;
      }
      
      public function UpdateUI() : void
      {
         this.FMarchConsume = SLogicsCore.MarchConsume;
         this.UpdateText();
      }
   }
}

