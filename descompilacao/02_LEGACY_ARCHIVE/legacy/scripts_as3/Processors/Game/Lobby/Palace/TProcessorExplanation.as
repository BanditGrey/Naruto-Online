package Processors.Game.Lobby.Palace
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Rendering.Overlayers.HelpTips.TOverlayerHelpTips;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Rendering.Overlayers.Title.TOverlayerTitle;
   import Resources.Constants.CONST_PALACE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.utils.ByteArray;
   
   public class TProcessorExplanation extends TProcessorLobbyWindows
   {
      
      protected var FProcessorWindowPalaceExplanation:TProcessorWindowPalaceExplanation;
      
      protected var FProcessorWindowPalaceRankings:TProcessorWindowPalaceRankings;
      
      protected var FOverlayerHelpTips1:TOverlayerHelpTips;
      
      protected var FOverlayerHint1:TOverlayerHint;
      
      protected var FOverlayerTitle:TOverlayerTitle;
      
      protected var FSender:Object;
      
      protected var FTitles:TTitles;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FPalaceRankingsReq:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorExplanation(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowPalaceExplanation = new TProcessorWindowPalaceExplanation(this);
         this.FProcessorWindowPalaceExplanation.OnClose = this.ProcessorOnClose;
         this.FProcessorWindowPalaceExplanation.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowPalaceExplanation.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FProcessorWindowPalaceExplanation.LookRankingsOnClick = this.ProcessorLookRankingsOnClick;
         this.FProcessorWindowPalaceExplanation.UIHintOnOver = this.UIComponentsHintOnOver1;
         this.FProcessorWindowPalaceExplanation.UIHintOnOut = this.UIComponentsHintOnOut1;
         this.FProcessorWindowPalaceExplanation.TitleHintOnOver = this.UITitleHintOnOver;
         this.FProcessorWindowPalaceExplanation.TitleHintOnOut = this.UITitleHintOnOut;
         this.FProcessorWindowPalaceRankings = new TProcessorWindowPalaceRankings(this);
         this.FProcessorWindowPalaceRankings.OnClose = this.ProcessorOnClose;
         this.FOverlayerHelpTips1 = new TOverlayerHelpTips(this);
         this.FOverlayerHelpTips1.Visible = false;
         this.FOverlayerHint1 = new TOverlayerHint(this);
         this.FOverlayerHint1.Visible = false;
         this.FOverlayerTitle = new TOverlayerTitle(this);
         this.FOverlayerTitle.Visible = false;
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FTitles = new TTitles();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PALACE.RESOURCESID_Swf_Palace);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHelpTips1);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint1);
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerTitle);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FTitles,null);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ProcessorLookRankingsOnClick(param1:Object) : void
      {
         if(this.FPalaceRankingsReq != null)
         {
            this.FPalaceRankingsReq(this);
         }
         this.FSender = param1;
      }
      
      protected function ProcessorOnClose(param1:Object) : void
      {
         if(param1 is TProcessorWindowPalaceExplanation || !this.FProcessorWindowPalaceExplanation.Visible)
         {
            ProcessorClose();
         }
         else
         {
            param1.Visible = false;
         }
      }
      
      protected function UIHelpTipsHintOnOver1(param1:Object, param2:THint) : void
      {
         this.FOverlayerHelpTips1.Context = param2;
         this.FOverlayerHelpTips1.Render(FUICore.MouseCoordinate);
         this.FOverlayerHelpTips1.Show();
      }
      
      protected function UIHelpTipsHintOnOut1(param1:Object) : void
      {
         this.FOverlayerHelpTips1.Hide();
      }
      
      protected function UIComponentsHintOnOver1(param1:Object, param2:THint) : void
      {
         this.FOverlayerHint1.Context = param2;
         this.FOverlayerHint1.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint1.Visible = true;
      }
      
      protected function UIComponentsHintOnOut1(param1:Object) : void
      {
         this.FOverlayerHint1.Visible = false;
      }
      
      protected function UITitleHintOnOver(param1:Object, param2:uint) : void
      {
         var _loc3_:TTitle = null;
         _loc3_ = this.FTitles.GetTitleByIdentifier(param2);
         if(_loc3_ != null)
         {
            this.FOverlayerTitle.Context = _loc3_;
            this.FOverlayerTitle.Render(FUICore.MouseCoordinate);
            this.FOverlayerTitle.Show();
         }
      }
      
      protected function UITitleHintOnOut(param1:Object) : void
      {
         this.FOverlayerTitle.Hide();
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function get PalaceRankingsReq() : Function
      {
         return this.FPalaceRankingsReq;
      }
      
      public function set PalaceRankingsReq(param1:Function) : void
      {
         this.FPalaceRankingsReq = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowPalaceExplanation.Load();
            this.FProcessorWindowPalaceRankings.Load();
            return;
         }
         this.FProcessorWindowPalaceExplanation.Update();
         this.FProcessorWindowPalaceRankings.UpdateRankings();
      }
      
      public function UpdateRankings(param1:Object, param2:uint) : void
      {
         this.FSender = param1;
         if(param2 == 0)
         {
            this.FProcessorWindowPalaceRankings.Visible = false;
            this.FProcessorWindowPalaceExplanation.Visible = true;
         }
         else if(param2 == 1)
         {
            this.FProcessorWindowPalaceExplanation.Visible = this.FSender is TProcessorWindowPalaceExplanation;
            this.FProcessorWindowPalaceRankings.Visible = true;
         }
      }
   }
}

