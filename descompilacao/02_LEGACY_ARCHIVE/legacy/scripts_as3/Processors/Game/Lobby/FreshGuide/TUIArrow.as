package Processors.Game.Lobby.FreshGuide
{
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Processors.Game.Lobby.Common.*;
   import flash.display.*;
   import flash.text.*;
   
   public class TUIArrow extends TProcessorLobbyWindow
   {
      
      protected static const X_OFFSET:int = 181;
      
      protected static const Y_OFFSET:int = 21;
      
      protected var FTF_MessageText:TextField;
      
      protected var FMC_Arrow:MovieClip;
      
      protected var FFollowObj:DisplayObjectContainer;
      
      protected var FFollowCoordinate:TCoordinate;
      
      public function TUIArrow(param1:TUIComponent)
      {
         super(param1);
         param1.mouseEnabled = false;
         param1.mouseChildren = false;
         this.visible = true;
         Load();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(822083584);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.LoadingSecondary)
         {
            return;
         }
         super.ResourcesPerform_UIWait();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("FreshGuide") as MovieClip;
         this.addChild(_loc1_);
         this.FMC_Arrow = _loc1_["MC_Arrow"];
         this.FMC_Arrow.alpha = 0.9;
         this.FTF_MessageText = this.FMC_Arrow["ArrowInner"]["TF_Message"]["TF_Message"];
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TCoordinate = null;
         super.LogicsPerform();
         if(!this.parent.visible)
         {
            return;
         }
         if(this.FFollowObj != null)
         {
            _loc1_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this.FFollowObj);
            this.FMC_Arrow.x = _loc1_.X + this.FFollowCoordinate.X - X_OFFSET;
            this.FMC_Arrow.y = _loc1_.Y + this.FFollowCoordinate.Y - Y_OFFSET;
         }
      }
      
      public function SetArrowInfor(param1:DisplayObjectContainer, param2:TCoordinate, param3:String) : void
      {
         var _loc4_:TCoordinate = null;
         this.FFollowObj = param1;
         this.FFollowCoordinate = param2;
         _loc4_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(this.FFollowObj);
         if(this.FMC_Arrow == null)
         {
            return;
         }
         this.FMC_Arrow.x = _loc4_.X + this.FFollowCoordinate.X - X_OFFSET;
         this.FMC_Arrow.y = _loc4_.Y + this.FFollowCoordinate.Y - Y_OFFSET;
         this.FTF_MessageText.text = param3;
         this.visible = true;
         this.FMC_Arrow.gotoAndPlay(0);
      }
   }
}

