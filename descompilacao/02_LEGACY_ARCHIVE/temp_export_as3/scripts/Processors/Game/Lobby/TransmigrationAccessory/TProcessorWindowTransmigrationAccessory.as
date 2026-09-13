package Processors.Game.Lobby.TransmigrationAccessory
{
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.UI.TUIComponent;
   import Logics.TransmigrationAccessory.TAccessoryCampaign;
   import Processors.Game.TProcessorGame;
   import flash.display.MovieClip;
   
   public class TProcessorWindowTransmigrationAccessory extends TProcessorGame
   {
      
      protected var FCampaignScene:MovieClip;
      
      protected var FStageScene:MovieClip;
      
      protected var FWindowCampaign:TProcessorWindowTransmigrationAccessoryCampaign;
      
      protected var FWindowStage:TProcessorWindowTransmigrationAccessoryStage;
      
      protected var FUIIndex:uint;
      
      protected var FSlotsOnQuerySequenceContext:Function;
      
      protected var FSlotsOnQuerySubscript:Function;
      
      protected var FUIComponentsHintOnOver:Function;
      
      protected var FUIComponentsHintOnOut:Function;
      
      public function TProcessorWindowTransmigrationAccessory(param1:TUIComponent)
      {
         super(param1);
         this.FUIIndex = 0;
      }
      
      protected function OnGotoCampaign(param1:Object) : void
      {
         this.FWindowCampaign.Visible = true;
         this.FWindowStage.Visible = false;
         this.FUIIndex = 0;
         this.FWindowCampaign.Update();
      }
      
      protected function OnGotoStage(param1:Object, param2:TAccessoryCampaign) : void
      {
         this.FWindowCampaign.Visible = false;
         this.FWindowStage.Visible = true;
         this.FWindowStage.SetData(param2);
         this.FUIIndex = 1;
      }
      
      protected function OnSlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence) : void
      {
         if(this.FSlotsOnQuerySequenceContext != null)
         {
            this.FSlotsOnQuerySequenceContext(param1,param2,param3);
         }
      }
      
      protected function OnSlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         if(this.FSlotsOnQuerySubscript != null)
         {
            this.FSlotsOnQuerySubscript(param1,param2,param3);
         }
      }
      
      protected function OnUIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOver != null)
         {
            this.FUIComponentsHintOnOver(param1,param2);
         }
      }
      
      protected function OnUIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         if(this.FUIComponentsHintOnOut != null)
         {
            this.FUIComponentsHintOnOut(param1,param2);
         }
      }
      
      public function get SlotsOnQuerySequenceContext() : Function
      {
         return this.FSlotsOnQuerySequenceContext;
      }
      
      public function set SlotsOnQuerySequenceContext(param1:Function) : void
      {
         this.FSlotsOnQuerySequenceContext = param1;
      }
      
      public function get SlotsOnQuerySubscript() : Function
      {
         return this.FSlotsOnQuerySubscript;
      }
      
      public function set SlotsOnQuerySubscript(param1:Function) : void
      {
         this.FSlotsOnQuerySubscript = param1;
      }
      
      public function get UIComponentsHintOnOver() : Function
      {
         return this.FUIComponentsHintOnOver;
      }
      
      public function set UIComponentsHintOnOver(param1:Function) : void
      {
         this.FUIComponentsHintOnOver = param1;
      }
      
      public function get UIComponentsHintOnOut() : Function
      {
         return this.FUIComponentsHintOnOut;
      }
      
      public function set UIComponentsHintOnOut(param1:Function) : void
      {
         this.FUIComponentsHintOnOut = param1;
      }
      
      public function SetScene(param1:MovieClip, param2:MovieClip) : void
      {
         this.FWindowCampaign = new TProcessorWindowTransmigrationAccessoryCampaign(this);
         this.FWindowCampaign.SetScene(param1);
         this.FWindowCampaign.Visible = true;
         this.FWindowCampaign.GotoStage = this.OnGotoStage;
         this.FWindowStage = new TProcessorWindowTransmigrationAccessoryStage(this);
         this.FWindowStage.SetScene(param2);
         this.FWindowStage.Visible = false;
         this.FWindowStage.GotoCampaign = this.OnGotoCampaign;
         this.FWindowStage.SlotsOnQuerySequenceContext = this.OnSlotsOnQuerySequenceContext;
         this.FWindowStage.SlotsOnQuerySubscript = this.OnSlotsOnQuerySubscript;
         this.FWindowStage.UIComponentsHintOnOver = this.OnUIComponentsHintOnOver;
         this.FWindowStage.UIComponentsHintOnOut = this.OnUIComponentsHintOnOut;
      }
      
      public function Update() : void
      {
         if(this.FUIIndex == 0)
         {
            this.FWindowCampaign.Update();
         }
         else if(this.FUIIndex == 1)
         {
            this.FWindowStage.Update();
         }
      }
      
      public function UpdateView() : void
      {
         if(!Visible)
         {
            return;
         }
         this.FWindowCampaign.UpdateImage();
         this.FWindowStage.UpdateView();
      }
   }
}

