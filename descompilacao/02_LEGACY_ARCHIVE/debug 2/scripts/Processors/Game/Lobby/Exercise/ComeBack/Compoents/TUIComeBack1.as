package Processors.Game.Lobby.Exercise.ComeBack.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.ComeBack.TComeBack;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIComeBack1 extends TUIBaseWindow
   {
      
      protected var FComeBack:TComeBack;
      
      public function TUIComeBack1(param1:TUIComponent)
      {
         super(param1);
         this.FComeBack = SLogicsCore.ComeBack;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.Resources_UIDispatch(param1);
         FMC_Scene.Btn_Close.addEventListener(MouseEvent.CLICK,this.ProcessorOnCloseWindow);
         FMC_Scene.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         FMC_Scene.BTN_Desc0.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         FMC_Scene.BTN_Desc1.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc0,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc1,true);
      }
      
      protected function ProcessorOnShowWindow(param1:MouseEvent) : void
      {
         if(FOnShowWindow != null)
         {
            if(this.FComeBack.IsOld == TComeBack.TYPE_OLD_PLAYER_IN_OLD_SERVER)
            {
               FOnShowWindow(2);
            }
            else if(this.FComeBack.IsOld != TComeBack.TYPE_NONE)
            {
               FOnShowWindow(1);
            }
            else
            {
               FOnShowFlowText(this.FComeBack.DescListNew[10]);
            }
         }
      }
      
      protected function ProcessorOnCloseWindow(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow();
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FComeBack.IsOld == TComeBack.TYPE_OLD_PLAYER_IN_OLD_SERVER)
         {
            if(_loc2_ == 0)
            {
               FOnShowDesc(this.FComeBack.DescListNew[9]);
            }
            else
            {
               FOnShowDesc(this.FComeBack.DescListNew[0]);
            }
         }
         else if(_loc2_ == 0)
         {
            FOnShowDesc(this.FComeBack.DescListNew[0]);
         }
         else
         {
            FOnShowDesc(this.FComeBack.DescListNew[11]);
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
         FMC_Scene.TF_SeverID.text = this.FComeBack.ServerID;
         if(this.FComeBack.IsOld == TComeBack.TYPE_OLD_PLAYER_IN_OLD_SERVER)
         {
            FMC_Scene.TF_Desc.text = this.FComeBack.DescListNew[7];
         }
         else
         {
            FMC_Scene.TF_Desc.text = this.FComeBack.DescListNew[9];
         }
         FMC_Scene.TF_Data.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FComeBack.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FComeBack.EndTime) - 1) * 1000)));
      }
   }
}

