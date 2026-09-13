package Processors.Game.Lobby.InviteCode.Components
{
   import Foundation.Utilities.TUtilityReflection;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TInviteCodeUser extends Sprite
   {
      
      protected var FSubstrate:MovieClip;
      
      protected var TF_UserName:TextField;
      
      public function TInviteCodeUser(param1:Sprite)
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
         this.FSubstrate = TUtilityReflection.CreateDisplayObjectInstance("InviteCodeUser_Item") as MovieClip;
         addChild(this.FSubstrate);
         this.TF_UserName = this.FSubstrate["TF_UserName"];
      }
      
      public function SetCodeInfo(param1:Object) : void
      {
         this.TF_UserName.text = param1.UserName;
      }
   }
}

