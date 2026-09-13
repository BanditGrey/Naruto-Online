package Processors.Game.SocketLoading
{
   import Foundation.Resources.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Affairs.*;
   import Processors.*;
   import Processors.Game.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.text.*;
   
   public class TProcessorWindowSocketLoading extends TProcessorGame
   {
      
      protected var FMC_SocketLoading:Sprite;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FMC_NarutoAnim:MovieClip;
      
      protected var FTF_Lable:TextField;
      
      public function TProcessorWindowSocketLoading(param1:TUIComponent)
      {
         super(param1);
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfVital.LoadPrimary(CONST_LOADING.RESOURCESID_SwfVital_SocketLoading);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIWait() : void
      {
         if(SResourcesCore.TexturesSwfVital.Loading)
         {
            return;
         }
         FResourcesState = RESOURCESSTATE_UIDispatch;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_SocketLoading = TUtilityReflection.CreateDisplayObjectInstance(CONST_LOADING.RESOURCE_ClassName_MC_SocketLoading) as Sprite;
         addChild(this.FMC_SocketLoading);
         this.FMC_SocketLoading.x = (CONST_COMMON.STAGE_Width - this.FMC_SocketLoading.width) / 2;
         this.FMC_SocketLoading.y = (CONST_COMMON.STAGE_Height - this.FMC_SocketLoading.height) / 2;
         this.FMC_Effect = this.FMC_SocketLoading[CONST_LOADING.RESOURCE_Link_MC_Effect];
         this.FMC_NarutoAnim = this.FMC_SocketLoading[CONST_LOADING.RESOURCE_Link_MC_NarutoAnim];
         this.FTF_Lable = this.FMC_SocketLoading[CONST_LOADING.RESOURCE_Link_TF_Lable];
         this.PlayEffects();
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function PlayEffects(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.FMC_Effect.play();
            this.FMC_NarutoAnim.play();
         }
         else
         {
            this.FMC_Effect.stop();
            this.FMC_NarutoAnim.stop();
         }
      }
      
      public function ShowLoading() : void
      {
         this.PlayEffects();
         Visible = true;
      }
      
      public function HideLoading() : void
      {
         this.PlayEffects(false);
         Visible = false;
      }
   }
}

