package Processors.Game.Lobby.Shortcuts.Window
{
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Characters.*;
   import Logics.Characters.MoveRole.*;
   import Logics.SLogicsCore;
   import Logics.Spaces.*;
   import Processors.Game.Lobby.MainScene.Role.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   use namespace LogicsSpace;
   
   public class TWindowHeroInfor extends TUIComponent
   {
      
      protected var FHeroAvatar:Sprite;
      
      protected var FAvatarHeroLevel:TextField;
      
      protected var FAvatarHeroName:TextField;
      
      protected var FAvatarGuideText:Vector.<TextField>;
      
      protected var FMC_Family:MovieClip;
      
      protected var FMC_Head:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FCharacterDigest:TFriendDigest;
      
      protected var FDigest:TDigest;
      
      protected var FHeroInforOnClick:Function;
      
      public function TWindowHeroInfor(param1:TUIComponent)
      {
         super(param1);
      }
      
      public function Perform_UIDispatch() : void
      {
         this.AvatarUIDispatch();
         this.FCharacterDigest = new TFriendDigest(0,0);
         this.FDigest = new TDigest(0,0);
         this.Perform_UILocation();
      }
      
      public function Perform_UILocation() : void
      {
         this.AvatarUILocation();
      }
      
      protected function AvatarUIDispatch() : void
      {
         var _loc1_:int = 0;
         this.FHeroAvatar = TUtilityReflection.CreateDisplayObjectInstance("HeroAvatar") as Sprite;
         addChild(this.FHeroAvatar);
         this.FAvatarHeroLevel = this.FHeroAvatar["HeroLevel"];
         this.FAvatarHeroName = this.FHeroAvatar["HeroName"];
         this.FMC_Family = this.FHeroAvatar["MC_Country"];
         this.FMC_Head = this.FHeroAvatar["HeroHead"];
         this.FBTN_Close = this.FHeroAvatar["BT_Close"];
         this.FAvatarGuideText = new Vector.<TextField>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.FAvatarGuideText.push(this.FHeroAvatar["Guide" + (_loc1_ + 1)]);
            _loc1_++;
         }
      }
      
      protected function AvatarUILocation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:String = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.FAvatarGuideText[_loc1_];
            _loc3_ = TUtilityString.Format(STRING_SHORTCUTS.AvatarInforStrings[_loc1_],STRING_SHORTCUTS.AvatarInforCommands[_loc1_]);
            _loc2_.htmlText = _loc3_;
            _loc2_.addEventListener(TextEvent.LINK,this.GuideStringClick);
            _loc1_++;
         }
         if(this.FBTN_Close != null)
         {
            this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnClose);
         }
      }
      
      protected function UpdateAvaterInfor(param1:TUIRoleCanMovePlayerRole) : void
      {
         var _loc2_:TRoleCanControl = null;
         var _loc3_:String = null;
         _loc2_ = param1.RoleData;
         _loc3_ = "ID" + _loc2_.RoleTemplateID.toString();
         this.FMC_Head.gotoAndStop(_loc3_);
         this.FAvatarHeroLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc2_.Level);
         this.FAvatarHeroName.text = _loc2_.RoleName;
         if(_loc2_.FamilyID == 0)
         {
            this.FMC_Family.visible = false;
         }
         else
         {
            this.FMC_Family.gotoAndStop("Family" + _loc2_.FamilyID);
            this.FMC_Family.visible = true;
         }
      }
      
      protected function GuideStringClick(param1:TextEvent) : void
      {
         if(this.FHeroInforOnClick != null)
         {
            this.FHeroInforOnClick(this,param1.text,this.FDigest,this.FCharacterDigest);
         }
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         this.Visible = false;
      }
      
      public function set HeroInforOnClick(param1:Function) : void
      {
         this.FHeroInforOnClick = param1;
      }
      
      public function get ShortcutWidth() : int
      {
         return this.width;
      }
      
      public function ShowHeroInforPanle(param1:TUIRoleCanMovePlayerRole) : void
      {
         this.FDigest.Coerce(param1.RoleData.Identifier0,param1.RoleData.Identifier1);
         this.FDigest.Name = param1.RoleData.RoleName;
         this.FCharacterDigest.Coerce(param1.RoleData.Identifier0,param1.RoleData.Identifier1);
         this.FCharacterDigest.Name = param1.RoleData.RoleName;
         this.UpdateAvaterInfor(param1);
         this.Visible = true;
      }
      
      public function HideHeroInforPanle() : void
      {
         this.Visible = false;
      }
   }
}

