package Processors.Game.Lobby.InviteCode.Components
{
   import Foundation.Utilities.TUtilityReflection;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TInviteCodeList extends Sprite
   {
      
      protected var FSubstrate:MovieClip;
      
      protected var Tf_InviteCode:TextField;
      
      public function TInviteCodeList(param1:Sprite)
      {
         super();
         if(param1 != null)
         {
            param1.addChild(this);
         }
         this.Inititation();
      }
      
      private function Inititation() : void
      {
         this.FSubstrate = TUtilityReflection.CreateDisplayObjectInstance("InviteCode_Item") as MovieClip;
         addChild(this.FSubstrate);
         this.Tf_InviteCode = this.FSubstrate["TF_InviteCode"];
         this.Tf_InviteCode.selectable = true;
      }
      
      public function SetCodeInfo(param1:Object) : void
      {
         this.Tf_InviteCode.text = param1.InviteCode;
      }
   }
}

