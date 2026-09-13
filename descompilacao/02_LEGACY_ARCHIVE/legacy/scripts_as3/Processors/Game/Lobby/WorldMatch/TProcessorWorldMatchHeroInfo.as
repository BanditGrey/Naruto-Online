package Processors.Game.Lobby.WorldMatch
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.SLogicsCore;
   import Logics.WorldMatch.TWorldMatchPlayerInfo;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.NijiaStar.Components.TUIHeroHead;
   import Resources.Constants.CONST_WORLDMATCH;
   import Resources.Strings.STRING_PALACE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWorldMatchHeroInfo extends TProcessorLobbyWindow
   {
      
      protected var CAPACITY_HeroHeads:uint = 4;
      
      protected var FMC_MainUI:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Server:TextField;
      
      protected var FTF_FightPower:TextField;
      
      protected var FTF_PetLevel:TextField;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FMC_HeroVec:Vector.<TUIHeroHead>;
      
      protected var FWorldMatchPlayerInfo:TWorldMatchPlayerInfo;
      
      public function TProcessorWorldMatchHeroInfo(param1:TUIComponent)
      {
         super(param1);
         this.FMC_HeroVec = new Vector.<TUIHeroHead>(this.CAPACITY_HeroHeads);
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         this.FMC_MainUI = TUtilityReflection.CreateDisplayObjectInstance(CONST_WORLDMATCH.RESOURCE_ClassName_MC_HeroInfo) as MovieClip;
         addChild(this.FMC_MainUI);
         TGameUtil.AddWindowMask(this);
         this.FBTN_Close = this.FMC_MainUI["BTN_Close"];
         this.FTF_Name = this.FMC_MainUI["TF_Name"];
         this.FTF_Level = this.FMC_MainUI["TF_Level"];
         this.FTF_Server = this.FMC_MainUI["TF_Server"];
         this.FTF_FightPower = this.FMC_MainUI["TF_FightPower"];
         this.FTF_PetLevel = this.FMC_MainUI["TF_PetLevel"];
         _loc2_ = this.CAPACITY_HeroHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIHeroHead(this);
            _loc3_.Resource = this.FMC_MainUI["MC_Hero_" + _loc1_] as MovieClip;
            _loc3_.SmallHeadSign = true;
            _loc3_.Init();
            this.FMC_HeroVec[_loc1_] = _loc3_;
            _loc1_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateUI() : void
      {
         this.UpdateTextField();
         this.UpdateHeroHead();
      }
      
      protected function UpdateTextField() : void
      {
         var _loc1_:TWorldMatchPlayerInfo = null;
         _loc1_ = this.FWorldMatchPlayerInfo;
         this.FTF_Name.text = _loc1_.PlayerName;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.PlayerLevel);
         this.FTF_Server.text = _loc1_.ServerName;
         this.FTF_FightPower.text = TUtilityString.Format(STRING_PALACE.FORMAT_FightPower,_loc1_.FightPower);
         this.FTF_PetLevel.text = TUtilityString.Format(STRING_PALACE.FORMAT_PetLevel,_loc1_.TargetPetLevel);
      }
      
      protected function UpdateHeroHead() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUIHeroHead = null;
         var _loc4_:THero = null;
         var _loc5_:TWorldMatchPlayerInfo = null;
         _loc5_ = this.FWorldMatchPlayerInfo;
         _loc2_ = this.CAPACITY_HeroHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FMC_HeroVec[_loc1_];
            _loc3_.Resource.visible = false;
            _loc3_.Context = null;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_HeroHeads;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ >= _loc5_.TargetHeros.Count - 1)
            {
               break;
            }
            _loc3_ = this.FMC_HeroVec[_loc1_];
            _loc3_.Resource.visible = true;
            _loc4_ = _loc5_.TargetHeros.GetHeroByIndex(_loc1_ + 1);
            _loc3_.Context = _loc4_;
            _loc1_++;
         }
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      public function Update(param1:TWorldMatchPlayerInfo) : void
      {
         this.FWorldMatchPlayerInfo = param1;
         if(this.FWorldMatchPlayerInfo)
         {
            this.UpdateUI();
         }
      }
      
      public function SetPosition(param1:Number, param2:Number) : void
      {
         this.FMC_MainUI.x = param1 - 184;
         this.FMC_MainUI.y = param2 - 100;
         if(this.FMC_MainUI.x < 10)
         {
            this.FMC_MainUI.x = 10;
         }
         Visible = true;
      }
   }
}

