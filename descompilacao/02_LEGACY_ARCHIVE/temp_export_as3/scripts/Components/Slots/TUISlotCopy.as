package Components.Slots
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   
   public class TUISlotCopy extends TUISlot
   {
      
      protected var FContextType:int;
      
      protected var FDateTaboo:TabooDataCell = null;
      
      public function TUISlotCopy(param1:TUIComponent, param2:uint)
      {
         super(param1);
         FModuleId = param2;
      }
      
      override public function set Context(param1:Object) : void
      {
         if(param1 is TInventory)
         {
            this.FContextType = 0;
         }
         else if(param1 is TabooDataCell)
         {
            this.FContextType = 1;
            this.FDateTaboo = param1 as TabooDataCell;
         }
         FSequenceContext = null;
         if(FMC_AdvancedEquip != null)
         {
            FMC_AdvancedEquip.visible = false;
         }
         if(FMC_SelectedBox != null)
         {
            FMC_SelectedBox.visible = false;
         }
         if(FLayerSubscript != null)
         {
            FLayerSubscript.text = "";
         }
         if(FEquipLevel != null)
         {
            FEquipLevel.text = "";
         }
         FBmpIcon.bitmapData = null;
         FContext = param1;
      }
      
      override protected function RenderingPerform_AdvancedEquip() : void
      {
         var _loc1_:Boolean = false;
         if(FContext == null)
         {
            return;
         }
         if(this.FContextType)
         {
            return;
         }
         if(FOnQueryAdvancedEquip != null)
         {
            FQueryAdvancedEquip.Value = false;
            FOnQueryAdvancedEquip(this,FContext,FQueryAdvancedEquip);
            _loc1_ = FQueryAdvancedEquip.Value;
            if(FMC_AdvancedEquip != null)
            {
               FMC_AdvancedEquip.visible = _loc1_;
            }
            return;
         }
      }
      
      override protected function RenderingPerform_Subscript() : void
      {
         var _loc1_:String = null;
         if(FContext == null)
         {
            return;
         }
         if(FOnQuerySubscript != null)
         {
            FQuerySubscript.Value = "";
            FOnQuerySubscript(this,FContext,FQuerySubscript);
            _loc1_ = FQuerySubscript.Value;
            if(TUtilityString.Empty(_loc1_))
            {
               return;
            }
            if(FLayerSubscript != null)
            {
               FLayerSubscript.text = _loc1_;
            }
            return;
         }
      }
      
      override protected function RenderingPerform_EquipLevel() : void
      {
         var _loc1_:String = null;
         if(FContext == null)
         {
            return;
         }
         if(this.FContextType)
         {
            return;
         }
         if(FOnQueryEuqipLevel != null)
         {
            FQueryLevel.Value = "";
            FOnQueryEuqipLevel(this,FContext,FQueryLevel);
            _loc1_ = FQueryLevel.Value;
            if(TUtilityString.Empty(_loc1_))
            {
               FEquipLevel.text = "";
               return;
            }
            if(FEquipLevel != null)
            {
               FEquipLevel.text = _loc1_;
            }
            return;
         }
      }
      
      override public function Update() : void
      {
         if(this.FContextType)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Inventory,FBmpIcon,FModuleId,this.FDateTaboo.ConfigureConfig.Icon);
            this.RenderingPerform_Subscript();
         }
         else
         {
            UpdateRenderingState();
            RenderingPerform();
         }
      }
   }
}

