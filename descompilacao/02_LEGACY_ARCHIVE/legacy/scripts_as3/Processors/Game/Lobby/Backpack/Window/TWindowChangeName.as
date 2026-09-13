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
   import flash.text.TextField;
   
   public class TWindowChangeName extends TUIComponent
   {
      
      protected static const SIZE_Window_Width:uint = 310;
      
      protected static const SIZE_Window_Height:uint = 190;
      
      protected var FTF_UserName0:TextField;
      
      protected var FTF_UserName1:TextField;
      
      protected var FInventory:TInventory;
      
      protected var FOnClickBtn:Function;
      
      protected var FOnEffectGenerateText:Function;
      
      public function TWindowChangeName(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(CONST_COMMON.STAGE_Width / 2),-(CONST_COMMON.STAGE_Height / 2),CONST_COMMON.STAGE_Width * 2,CONST_COMMON.STAGE_Height * 2);
         this.graphics.endFill();
         this.InitView();
      }
      
      protected function InitView() : void
      {
         var _loc1_:MovieClip = null;
         _loc1_ = TUtilityReflection.CreateDisplayObjectInstance("MC_ChangeName") as MovieClip;
         this.addChild(_loc1_);
         this.FTF_UserName0 = _loc1_.TF_UserName0 as TextField;
         this.FTF_UserName0.restrict = STRING_COMMON.EditorStringRestrict;
         this.FTF_UserName0.maxChars = STRING_COMMON.EditorStringRestrict_MaxChars;
         this.FTF_UserName0.text = "";
         TGameUtil.setButtonMode(_loc1_.BTN_OK,true);
         _loc1_.BTN_OK.addEventListener(MouseEvent.CLICK,this.OnMouseOkClick);
         TGameUtil.setButtonMode(_loc1_.BTN_Cancel,true);
         _loc1_.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.OnMouseCancelClick);
      }
      
      private function OnMouseOkClick(param1:Event) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:String = null;
         _loc3_ = this.FTF_UserName0.text;
         while(_loc3_.charAt(0) == " ")
         {
            _loc3_ = _loc3_.slice(1);
            if(_loc3_.length <= 0)
            {
               this.OnMouseOkClick(null);
               return;
            }
         }
         while(_loc3_.charAt(_loc3_.length - 1) == " ")
         {
            _loc3_ = _loc3_.slice(0,_loc3_.length - 1);
            if(_loc3_.length <= 0)
            {
               this.OnMouseOkClick(null);
               return;
            }
         }
         if(this.FTF_UserName0.text.length < STRING_COMMON.CreateChar_NameLength_Min)
         {
            this.FOnEffectGenerateText(this,STRING_COMMON.CreateChar_NameShort);
            return;
         }
         visible = false;
         if(this.FOnClickBtn != null)
         {
            this.FOnClickBtn(this.FInventory,_loc3_);
         }
      }
      
      private function OnMouseCancelClick(param1:Event) : void
      {
         visible = false;
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
      
      public function ResetName() : void
      {
         this.FTF_UserName0.text = "";
      }
   }
}

