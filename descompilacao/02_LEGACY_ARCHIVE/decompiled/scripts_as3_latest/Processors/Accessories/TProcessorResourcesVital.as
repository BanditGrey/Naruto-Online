package Processors.Accessories
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Processors.TProcessor;
   import Resources.Constants.CONST_LOADING;
   import Resources.Constants.CONST_MODULES;
   
   public class TProcessorResourcesVital extends TProcessor
   {
      
      protected var FLoadingPictureId:uint;
      
      public function TProcessorResourcesVital(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfVital.LoadPrimary(CONST_LOADING.RESOURCESID_SwfVital_Loading);
         SResourcesCore.TexturesLobby.LoadPrimary(this.FLoadingPictureId,CONST_MODULES.MODULE_Loading);
         super.ResourcesPerform_UIRequest();
      }
      
      public function set LoadingPictureId(param1:uint) : void
      {
         this.FLoadingPictureId = param1;
      }
      
      public function get LoadingPictureId() : uint
      {
         return this.FLoadingPictureId;
      }
   }
}

