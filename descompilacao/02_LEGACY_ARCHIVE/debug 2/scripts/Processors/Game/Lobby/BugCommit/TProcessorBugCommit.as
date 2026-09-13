package Processors.Game.Lobby.BugCommit
{
   import Foundation.Common.TBounds;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Mail.TMail;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_BUGCOMMIT;
   import Resources.Strings.STRING_BUGCOMMIT;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorBugCommit extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WindowBugCommit_Width:uint = 303;
      
      protected static const SIZE_WindowBugCommit_Height:uint = 364;
      
      protected var FProcessorWindowBugCommit:TProcessorWindowBugCommit;
      
      protected var FBounds:TBounds;
      
      protected var FIsInitialization:Boolean;
      
      protected var FOnSendMail:Function;
      
      public function TProcessorBugCommit(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowBugCommit = new TProcessorWindowBugCommit(this);
         this.FProcessorWindowBugCommit.OnClose = this.ProcessorWindowBugCommitOnClose;
         this.FProcessorWindowBugCommit.OnSendMail = this.ProcessorOnSendMail;
         this.FProcessorWindowBugCommit.OnHitOver = ProcessorTipOnOver;
         this.FProcessorWindowBugCommit.OnHitOut = ProcessorTipOnOut;
         this.FBounds = new TBounds();
         this.FBounds.X = this.FProcessorWindowBugCommit.x;
         this.FBounds.Y = this.FProcessorWindowBugCommit.y;
         this.FBounds.Width = SIZE_WindowBugCommit_Width;
         this.FBounds.Height = SIZE_WindowBugCommit_Height;
         ComponentBoundsCenter(this.FProcessorWindowBugCommit,this.FBounds);
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         this.FIsInitialization = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BUGCOMMIT.RESOURCESID_Swf_BugCommit);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FIsInitialization = true;
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function ProcessorOnSendMail(param1:Object, param2:TMail) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(this.FOnSendMail != null)
         {
            this.FOnSendMail(this,param2);
         }
         _loc3_ = STRING_BUGCOMMIT.STRING_BugCommitSuccess;
         _loc4_ = _loc3_.split("\n")[0];
         _loc5_ = _loc3_.split("\n")[1];
         EffectGenerateText(_loc4_);
         EffectGenerateText(_loc5_);
      }
      
      protected function ProcessorWindowBugCommitOnClose(param1:Object) : void
      {
         ProcessorClose();
      }
      
      public function get OnSendMail() : Function
      {
         return this.FOnSendMail;
      }
      
      public function set OnSendMail(param1:Function) : void
      {
         this.FOnSendMail = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowBugCommit.Load();
            return;
         }
         this.FProcessorWindowBugCommit.Visible = true;
         this.FProcessorWindowBugCommit.Reset();
      }
   }
}

