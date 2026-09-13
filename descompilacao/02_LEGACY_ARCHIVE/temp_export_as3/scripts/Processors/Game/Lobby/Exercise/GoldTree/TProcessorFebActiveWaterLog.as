package Processors.Game.Lobby.Exercise.GoldTree
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.GoldTree.TGoldTree;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_COMMON;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TProcessorFebActiveWaterLog extends TProcessorLobbyWindow
   {
      
      protected static const SIZE_Window_Width:uint = 513;
      
      protected static const SIZE_Window_Height:uint = 323;
      
      protected static const CONSUME_COUNT:int = 5;
      
      protected var FMC_Scene:Sprite;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FGoldTree:TGoldTree;
      
      protected var FInitialized:Boolean;
      
      protected var FOnCloseUp:Function;
      
      public function TProcessorFebActiveWaterLog(param1:TUIComponent)
      {
         super(param1);
         this.FGoldTree = SLogicsCore.GoldTree;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(2550137113);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_FebActiveWaterLog") as MovieClip;
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
         var _loc2_:TLotteryNews = null;
         _loc1_ = 0;
         while(_loc1_ < CONSUME_COUNT)
         {
            if(_loc1_ < this.FGoldTree.WaterLogList.length)
            {
               _loc2_ = this.FGoldTree.WaterLogList[_loc1_];
               this.FMC_Scene["TF_Desc" + _loc1_].text = TUtilityString.Format(this.FGoldTree.DescListNew[17],TUtilityDate.FormatDate(new Date(STimingCore.GetClientShowTime(_loc2_.GetTime) * 1000)),_loc2_.Count,_loc2_.Identify);
               this.FMC_Scene["MC_Max" + _loc1_].visible = _loc2_.NewsType == 0 ? false : true;
            }
            else
            {
               this.FMC_Scene["TF_Desc" + _loc1_].text = "";
               this.FMC_Scene["MC_Max" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FMC_Scene["TF_RechargeDesc"].text = TUtilityString.Format(this.FGoldTree.DescListNew[16],this.FGoldTree.TotalRecharge,this.FGoldTree.RechargeAddTimes);
      }
      
      private function ProcessorOnClose(param1:MouseEvent) : void
      {
         if(this.FOnCloseUp != null)
         {
            this.FOnCloseUp(param1);
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
         this.UpdateText();
      }
   }
}

