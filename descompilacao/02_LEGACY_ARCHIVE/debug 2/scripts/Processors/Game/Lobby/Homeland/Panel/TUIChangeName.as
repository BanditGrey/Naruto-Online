package Processors.Game.Lobby.Homeland.Panel
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class TUIChangeName
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMask:Shape = null;
      
      public function TUIChangeName(param1:MovieClip)
      {
         super();
         this.FMC_Scene = param1;
         this.FMC_Scene.parent.setChildIndex(this.FMC_Scene,this.FMC_Scene.parent.numChildren - 1);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_OK,true);
         this.FMC_Scene.BTN_OK.addEventListener(MouseEvent.CLICK,this.OnMouseOkClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Cancel,true);
         this.FMC_Scene.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.OnMouseCancelClick);
         this.FMask = new Shape();
         this.FMask.graphics.beginFill(0,0.8);
         this.FMask.graphics.drawRect(-this.FMC_Scene.x,-this.FMC_Scene.y,1250,650);
         this.FMask.graphics.endFill();
         this.FMC_Scene.addChildAt(this.FMask,0);
      }
      
      public function UpdateUI() : void
      {
         this.FMC_Scene["TF_HomelandName"].restrict = STRING_COMMON.EditorStringRestrict;
         this.FMC_Scene["TF_HomelandName"].maxChars = STRING_COMMON.EditorStringRestrict_MaxChars;
         this.FMC_Scene["TF_HomelandName"].text = THomelandModel.selfHome.landName;
      }
      
      private function OnMouseOkClick(param1:Event) : void
      {
         var _loc3_:TPacket = null;
         var _loc2_:String = this.FMC_Scene["TF_HomelandName"].text;
         while(_loc2_.charAt(0) == " ")
         {
            _loc2_ = _loc2_.slice(1);
            if(_loc2_.length <= 0)
            {
               this.OnMouseOkClick(null);
               return;
            }
         }
         while(_loc2_.charAt(_loc2_.length - 1) == " ")
         {
            _loc2_ = _loc2_.slice(0,_loc2_.length - 1);
            if(_loc2_.length <= 0)
            {
               this.OnMouseOkClick(null);
               return;
            }
         }
         if(_loc2_.length < STRING_COMMON.CreateChar_NameLength_Min)
         {
            return;
         }
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_ChangeNameReq);
         TUtilityString.FlushUTF(_loc3_.Data,_loc2_);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
         this.visible = false;
      }
      
      private function OnMouseCancelClick(param1:Event) : void
      {
         this.visible = false;
      }
      
      public function get visible() : Boolean
      {
         return this.FMC_Scene.visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
         if(this.FMC_Scene.visible)
         {
            this.UpdateUI();
         }
      }
   }
}

