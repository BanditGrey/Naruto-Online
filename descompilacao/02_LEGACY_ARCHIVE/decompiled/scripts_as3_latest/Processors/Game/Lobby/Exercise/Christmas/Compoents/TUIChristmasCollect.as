package Processors.Game.Lobby.Exercise.Christmas.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Christmas.TChristmasCollect;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.Christmas.TProcessorChristmas;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIChristmasCollect extends TUIChristmasBase
   {
      
      protected static const BOX_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = TProcessorChristmas.ACTIVITY_2_ID;
      
      protected var FBoxList:Vector.<MovieClip>;
      
      protected var FChristmasCollect:TChristmasCollect;
      
      public function TUIChristmasCollect(param1:TUIComponent)
      {
         super(param1);
         this.FBoxList = new Vector.<MovieClip>(BOX_COUNT);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < BOX_COUNT)
         {
            this.FBoxList[_loc2_] = FMC_Scene["MC_Tree" + _loc2_];
            this.FBoxList[_loc2_].MC_BoxPic.buttonMode = true;
            this.FBoxList[_loc2_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTreeOver);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTreeOut);
            this.FBoxList[_loc2_].addEventListener(MouseEvent.CLICK,this.ProcessorOnGetNumBoxUp);
            _loc2_++;
         }
         FMC_Scene.BTN_Get.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetBoxUp);
         FMC_Scene.BTN_Collect.addEventListener(MouseEvent.CLICK,this.ProcessorOnCollectUp);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBoxOver);
         FMC_Scene.MC_Box.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnBoxOut);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < BOX_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Tree" + _loc1_];
            _loc3_.MC_Icon.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Gold.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_NEED_COLLECT_NUM,this.FChristmasCollect.BoxList[_loc1_].Price);
            if(this.FChristmasCollect.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANGET)
            {
               _loc3_.MC_BoxPic.visible = true;
               _loc3_.MC_BoxPic.gotoAndPlay(1);
               _loc3_.MC_Icon.MC_Effect.visible = true;
               _loc3_.MC_Icon.MC_Effect.gotoAndStop(_loc1_ + 1);
               _loc3_.MC_Icon.MC_Effect.filters = [];
            }
            else if(this.FChristmasCollect.BoxList[_loc1_].Status == TBaseActivity.STATUS_CANNOTGET)
            {
               _loc3_.MC_BoxPic.visible = false;
               _loc3_.MC_Icon.MC_Effect.visible = true;
               _loc3_.MC_Icon.MC_Effect.gotoAndStop(_loc1_ + 1);
               _loc3_.MC_Icon.MC_Effect.filters = [TGameUtil.GaryColorFilters];
            }
            else
            {
               _loc3_.MC_BoxPic.visible = false;
               _loc3_.MC_Icon.MC_Effect.visible = true;
               _loc3_.MC_Icon.MC_Effect.gotoAndStop(_loc1_ + 1);
               _loc3_.MC_Icon.MC_Effect.filters = [];
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FChristmasCollect.Status == TBaseActivity.STATUS_CANNOTGET)
         {
            FMC_Scene.BTN_Collect.visible = true;
            FMC_Scene.BTN_Get.visible = false;
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Collect,true);
         }
         else if(this.FChristmasCollect.Status == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.BTN_Collect.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,true);
         }
         else
         {
            FMC_Scene.BTN_Collect.visible = false;
            FMC_Scene.BTN_Get.visible = true;
            FMC_Scene.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Get,false);
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FChristmasCollect.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FChristmasCollect.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Count.text = this.FChristmasCollect.CollectNum.toString();
      }
      
      override protected function ProcessorOnCollectUp(param1:MouseEvent) : void
      {
         if(FOnCollectUp != null)
         {
            FOnCollectUp();
         }
      }
      
      override protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            if(this.FChristmasCollect.Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas.CHRISTMAS_COLLECT_BOX);
            }
         }
      }
      
      protected function ProcessorOnGetNumBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FOnGetBox != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(7));
            if(this.FChristmasCollect.BoxList[_loc2_].Status == TBaseActivity.STATUS_CANGET)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorChristmas.CHRISTMAS_COLLECT_NUM_BOX,_loc2_ + 1);
            }
         }
      }
      
      override protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:TInventories = null;
         if(FOnBoxOver != null)
         {
            _loc2_ = this.FChristmasCollect.Inventories;
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
      
      protected function ProcessorOnTreeOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TInventories = null;
         if(FOnBoxOver != null)
         {
            _loc2_ = int(String(param1.currentTarget.name).slice(7));
            _loc3_ = this.FChristmasCollect.BoxList[_loc2_].Inventories;
            FOnBoxOver(_loc3_);
         }
      }
      
      protected function ProcessorOnTreeOut(param1:MouseEvent) : void
      {
         if(FOnBoxOut != null)
         {
            FOnBoxOut();
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
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FChristmasCollect = SLogicsCore.ChristmasDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TChristmasCollect;
         this.UpdateBox();
         this.UpdateBtn();
         this.UpdateText();
      }
   }
}

