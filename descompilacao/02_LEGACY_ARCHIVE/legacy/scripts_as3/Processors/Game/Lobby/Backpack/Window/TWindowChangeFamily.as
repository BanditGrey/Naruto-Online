package Processors.Game.Lobby.Backpack.Window
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Inventories.*;
   import Logics.Streamization.Inventories.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TWindowChangeFamily extends TUIComponent
   {
      
      protected static const SIZE_Window_Width:uint = 630;
      
      protected static const SIZE_Window_Height:uint = 427;
      
      protected var FBtn_Joins:Vector.<SimpleButton>;
      
      protected var FPromotWindow:TUIWindowConfirmation;
      
      protected var FSelectFamilyID:int;
      
      protected var FInventory:TInventory;
      
      protected var FOnClickBtn:Function;
      
      protected var FOnEffectGenerateText:Function;
      
      public function TWindowChangeFamily(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.FSelectFamilyID = 0;
         this.InitView();
      }
      
      protected function InitView() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         var _loc4_:Vector.<uint> = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("MC_ChangeFamily") as MovieClip;
         addChild(_loc1_);
         this.FBtn_Joins = new Vector.<SimpleButton>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = _loc1_["BTN_Join" + (_loc2_ + 1)];
            _loc3_.addEventListener(MouseEvent.CLICK,this.OnMouseClick);
            this.FBtn_Joins.push(_loc3_);
            _loc2_++;
         }
         _loc1_.Btn_Close.addEventListener(MouseEvent.CLICK,this.OnMouseCloseClick);
         this.FPromotWindow = new TUIWindowConfirmation(this.Parent);
         this.FPromotWindow.x = (CONST_COMMON.STAGE_Width - this.FPromotWindow.WindowWidth) / 2;
         this.FPromotWindow.y = (CONST_COMMON.STAGE_Height - this.FPromotWindow.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FPromotWindow);
      }
      
      private function OnMouseClick(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleButton = null;
         _loc3_ = param1.currentTarget as SimpleButton;
         _loc2_ = this.FBtn_Joins.indexOf(_loc3_);
         this.FSelectFamilyID = _loc2_ + 1;
         this.FPromotWindow.OnOK = this.PromotWindowOk;
         this.FPromotWindow.Text = TUtilityString.Format(STRING_COMMON.FormatString_FamilyPromotString,STRING_COMMON.FamilyNames[this.FSelectFamilyID]);
         this.FPromotWindow.visible = true;
      }
      
      private function OnMouseCloseClick(param1:Event) : void
      {
         visible = false;
      }
      
      protected function PromotWindowOk(param1:Object) : void
      {
         visible = false;
         if(this.FOnClickBtn != null)
         {
            this.FOnClickBtn(this.FInventory,this.FSelectFamilyID.toString());
         }
      }
      
      public function set OnClickBtn(param1:Function) : void
      {
         this.FOnClickBtn = param1;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         var _loc2_:TPacket = null;
         super.Visible = param1;
      }
      
      public function get WindowWidth() : int
      {
         return SIZE_Window_Width;
      }
      
      public function get WindowHeight() : int
      {
         return SIZE_Window_Height;
      }
      
      public function get OnEffectGenerateText() : Function
      {
         return this.FOnEffectGenerateText;
      }
      
      public function set OnEffectGenerateText(param1:Function) : void
      {
         this.FOnEffectGenerateText = param1;
      }
      
      public function get Inventory() : TInventory
      {
         return this.FInventory;
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
   }
}

