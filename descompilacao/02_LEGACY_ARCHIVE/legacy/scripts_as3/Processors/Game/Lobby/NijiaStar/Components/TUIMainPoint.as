package Processors.Game.Lobby.NijiaStar.Components
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.NijiaStar.TNijiaStar;
   
   public class TUIMainPoint extends TUINijiaPoint
   {
      
      protected const STARTUS_NoOpen:int = -1;
      
      protected const STARTUS_Open:int = 0;
      
      public function TUIMainPoint(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         super.UIDispatch();
      }
      
      public function SetSubPointInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TNijiaStar = null;
         _loc2_ = FContext as TNijiaStar;
         _loc1_ = _loc2_.Identifier;
         if(_loc1_ == this.STARTUS_NoOpen)
         {
            FResoures.gotoAndStop(1);
            FResoures.buttonMode = false;
            FFirstFrameMC = FResoures["MC_UnOpened"];
            FFirstFrameMC.filters = [TGameUtil.GaryColorFilters];
         }
         else if(!_loc2_.IsLastPoint)
         {
            FResoures.gotoAndStop(2);
            FResoures.buttonMode = true;
            FSencondFrameMC = FResoures["MC_Openning"];
            FSencondFrameMC.play();
         }
         else
         {
            FResoures.gotoAndStop(3);
            FThirdFrameMC = FResoures["MC_Opened"];
            FThirdFrameMC.play();
            FResoures.buttonMode = true;
         }
      }
   }
}

