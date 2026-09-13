package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.UI.TUICore;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Resources.Constants.CONST_DATEBASEVO;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.events.MouseEvent;
   
   public class Tools_Help
   {
      
      protected var FHpelhint:THint;
      
      protected var FTipId:uint;
      
      protected var FBtnHelp:Object;
      
      protected var FRootHelp:TUIComponent;
      
      protected var FTempCore:TUICore;
      
      protected var FOverlayerHelpTips:TOverlayerHelpTips;
      
      public function Tools_Help(param1:TUIComponent, param2:Object, param3:uint, param4:TUICore)
      {
         super();
         this.FRootHelp = param1;
         this.FBtnHelp = param2;
         this.FTipId = param3;
         this.FTempCore = param4;
         this.initiliza();
         this.addEvent();
      }
      
      protected function addEvent() : void
      {
         this.FBtnHelp.addEventListener(MouseEvent.MOUSE_OVER,this.OverEvent);
         this.FBtnHelp.addEventListener(MouseEvent.MOUSE_OUT,this.OutEvent);
         this.FBtnHelp.addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
      }
      
      public function OverEvent(param1:MouseEvent) : void
      {
         this.UIHelpTipsHintOnOver(this.FRootHelp,this.FHpelhint);
      }
      
      public function OutEvent(param1:MouseEvent) : void
      {
         this.UIHelpTipsHintOnOut(this.FRootHelp);
      }
      
      protected function initiliza() : void
      {
         var _loc1_:TSystemLanguage = null;
         this.FHpelhint = new THint();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,this.FTipId) as TSystemLanguage;
         this.FHpelhint.Content = _loc1_.Desc;
         this.FOverlayerHelpTips = new TOverlayerHelpTips(this.FRootHelp);
         this.FOverlayerHelpTips.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips);
      }
      
      protected function UIHelpTipsHintOnOver(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips.Context = param2;
         this.FOverlayerHelpTips.Render(this.FTempCore.MouseCoordinate);
         this.FOverlayerHelpTips.Show();
      }
      
      protected function MoveClick(param1:MouseEvent) : void
      {
         this.FOverlayerHelpTips.Render(this.FTempCore.MouseCoordinate);
      }
      
      protected function UIHelpTipsHintOnOut(param1:Object) : void
      {
         this.FOverlayerHelpTips.Hide();
      }
   }
}

