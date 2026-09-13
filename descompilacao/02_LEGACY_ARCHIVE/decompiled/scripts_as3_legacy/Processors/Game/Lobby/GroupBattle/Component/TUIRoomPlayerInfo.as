package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.MovieClip;
   import flash.events.TextEvent;
   import flash.text.TextField;
   
   public class TUIRoomPlayerInfo extends TProcessorUIResourceTemplate
   {
      
      protected var FMC_Country:MovieClip;
      
      protected var FMC_HeroHead:MovieClip;
      
      protected var FTF_HeroLevel:TextField;
      
      protected var FTF_HeroName:TextField;
      
      protected var FAvatarGuideText:Vector.<TextField>;
      
      protected var FHeroInforOnClick:Function;
      
      public function TUIRoomPlayerInfo(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.FTF_HeroLevel = FResource["TF_HeroLevel"];
         this.FTF_HeroName = FResource["TF_HeroName"];
         this.FMC_Country = FResource["MC_Country"];
         this.FMC_HeroHead = FResource["MC_HeroHead"];
         this.FAvatarGuideText = new Vector.<TextField>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            this.FAvatarGuideText.push(FResource["Guide" + (_loc1_ + 1)]);
            _loc1_++;
         }
      }
      
      override protected function UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:String = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = this.FAvatarGuideText[_loc1_];
            _loc3_ = TUtilityString.Format(STRING_GROUPBATTLE.AvatarInforStrings[_loc1_],STRING_GROUPBATTLE.AvatarInforCommands[_loc1_]);
            _loc2_.htmlText = _loc3_;
            _loc2_.addEventListener(TextEvent.LINK,this.GuideStringClick);
            _loc1_++;
         }
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TRoomPlayer = null;
         if(FContext == null)
         {
            return;
         }
         _loc1_ = FContext as TRoomPlayer;
         this.FTF_HeroLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.PlayerLevel);
         this.FTF_HeroName.text = _loc1_.PlayerName;
         this.FMC_HeroHead.gotoAndStop("ID" + _loc1_.PlayerModelID);
         if(this.FMC_Country != null)
         {
            this.FMC_Country.gotoAndStop(_loc1_.FamilyId);
         }
      }
      
      protected function GuideStringClick(param1:TextEvent) : void
      {
         if(this.FHeroInforOnClick != null)
         {
            this.FHeroInforOnClick(this,param1.text,Context);
         }
      }
      
      public function set HeroInforOnClick(param1:Function) : void
      {
         this.FHeroInforOnClick = param1;
      }
   }
}

