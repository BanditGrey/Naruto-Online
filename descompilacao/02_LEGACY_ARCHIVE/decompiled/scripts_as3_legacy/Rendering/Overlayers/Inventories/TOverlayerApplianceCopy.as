package Rendering.Overlayers.Inventories
{
   import Foundation.UI.TUIComponent;
   
   public class TOverlayerApplianceCopy extends TOverlayerAppliance
   {
      
      public function TOverlayerApplianceCopy(param1:TUIComponent, param2:uint)
      {
         super(param1,param2);
      }
      
      override public function Show() : void
      {
         this.visible = true;
      }
      
      override public function Hide() : void
      {
         this.visible = false;
      }
   }
}

