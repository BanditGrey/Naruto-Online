package Processors.Game.Lobby.RechageCashBack
{
   import Externals.SExternalCore;
   import Foundation.Common.TBounds;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_ACTIVITY_MODE;
   import Resources.Constants.CONST_RECHARGECASHBACK;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorRechargeCashback extends TProcessorLobbyWindows
   {
      
      public static const KEY_Activity_RechargeCashback:uint = CONST_ACTIVITY_MODE.Activity_RechageCashback;
      
      protected static const SIZE_WindowRechargeCashback_Width:Number = 569;
      
      protected static const SIZE_WindowRechargeCashback_Height:Number = 433;
      
      protected var FMC:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_GotoRecharge:MovieClip;
      
      protected var FWindowRechargeCashbackBounds:TBounds;
      
      public function TProcessorRechargeCashback(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FWindowRechargeCashbackBounds = new TBounds();
         this.FWindowRechargeCashbackBounds.Width = SIZE_WindowRechargeCashback_Width;
         this.FWindowRechargeCashbackBounds.Height = SIZE_WindowRechargeCashback_Height;
         ComponentBoundsCenter(this,this.FWindowRechargeCashbackBounds);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_RECHARGECASHBACK.RESOURCE_SWF_RECHARGECASHBACK);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_RECHARGECASHBACK.RESOURCE_ClassName_MC_RECHARGECASHBACK) as Sprite;
         addChild(this.FMC);
         this.FBTN_Close = this.FMC[CONST_RECHARGECASHBACK.RESOURCE_Link_BTN_Close];
         this.FBTN_GotoRecharge = this.FMC[CONST_RECHARGECASHBACK.RESOURCE_Link_BTN_GotoRecharge];
         TGameUtil.setButtonMode(this.FBTN_GotoRecharge,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnProcessorWindowClose);
         this.FBTN_GotoRecharge.addEventListener(MouseEvent.CLICK,this.OnGotoRechargeClick);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function OnProcessorWindowClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      protected function OnGotoRechargeClick(param1:Object) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
      }
   }
}

