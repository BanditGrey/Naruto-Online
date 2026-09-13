package Processors.Game.Sound
{
   import Debugging.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Sound.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.Agent.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Signals.*;
   import Processors.*;
   import Resources.Constants.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorSounds extends TProcessor
   {
      
      protected static const KEY_UP:uint = CONST_KEYCODE.KEY_UP;
      
      protected static const KEY_DOWN:uint = CONST_KEYCODE.KEY_DOWN;
      
      protected static const FILE_ResourcePath:String = "Resources/Sound/";
      
      protected static const FILE_ResourceSuffix:String = ".mp3";
      
      public static const PLAY_SCENE_MainCity:uint = CONST_MUSIC.PLAY_SCENE_MainCity;
      
      public static const PLAY_SCENE_Nodal:uint = CONST_MUSIC.PLAY_SCENE_Nodal;
      
      public static const PLAY_SCENE_Campaign:uint = CONST_MUSIC.PLAY_SCENE_Campaign;
      
      public static const PLAY_SCENE_KillHeros:uint = CONST_MUSIC.PLAY_SCENE_KillHeros;
      
      public static const PLAY_SCENE_Arena:uint = CONST_MUSIC.PLAY_SCENE_Arena;
      
      protected var FCharacter:TCharacter;
      
      protected var FMusicConfigs:TBins;
      
      protected var FMusicID:int;
      
      protected var FSoundType:int;
      
      protected var FSoundID:uint;
      
      protected var FCdnRoot:String;
      
      protected var FRoleSencePosition:int;
      
      protected var FIsFighting:Boolean;
      
      protected var FResourceConfig:Dictionary;
      
      protected var FTimeID:uint;
      
      public function TProcessorSounds(param1:TUIComponent)
      {
         super(param1);
         this.FCharacter = SLogicsCore.Character;
         this.FResourceConfig = SParametersCore.ResourceVersionConfig;
         this.FRoleSencePosition = -1;
         FUICore.UIStage.addEventListener(KeyboardEvent.KEY_DOWN,this.UIStageOnKeyDown);
         FResourcesState = RESOURCESSTATE_UIRequest;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMusicConfigs = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MusicConfig);
         this.FCdnRoot = SParametersCore.CdnRoot;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.LogicsPerform_Signals();
         this.LogicsPerform_PlaySound();
      }
      
      protected function LogicsPerform_Signals() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:Boolean = false;
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_SOUND);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.UserData as Boolean;
         this.FSoundType = _loc1_.Identifier;
         switch(this.FSoundType)
         {
            case PLAY_SCENE_MainCity:
               this.FSoundID = _loc1_.Value;
               break;
            case PLAY_SCENE_Nodal:
               this.FSoundID = uint(_loc1_.Value / 100) * 100;
               break;
            case PLAY_SCENE_Campaign:
               this.FSoundID = _loc1_.Value;
               break;
            case PLAY_SCENE_KillHeros:
               this.FSoundID = uint(_loc1_.Value / 100) * 100;
               break;
            case PLAY_SCENE_Arena:
               this.FSoundID = _loc1_.Value;
         }
         this.FIsFighting = _loc2_;
      }
      
      protected function LogicsPerform_PlaySound() : void
      {
         if(this.FSoundID != 0 && !SResourcesCore.Loading && this.FTimeID == 0)
         {
            if(this.FTimeID != 0)
            {
               clearTimeout(this.FTimeID);
            }
            this.FTimeID = setTimeout(this.ProcessorPlay,500);
         }
      }
      
      protected function ProcessorPlay() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:TMusicConfig = null;
         var _loc4_:String = null;
         clearTimeout(this.FTimeID);
         this.FTimeID = 0;
         if(this.FSoundID <= 0)
         {
            return;
         }
         _loc3_ = this.FMusicConfigs.GetDatebaseByIdentifier(this.FSoundID) as TMusicConfig;
         if(_loc3_ == null)
         {
            this.FSoundID = 0;
            return;
         }
         this.FSoundID = 0;
         if(this.FIsFighting)
         {
            _loc1_ = _loc3_.Fighting;
         }
         else
         {
            _loc1_ = _loc3_.Background;
         }
         if(this.FMusicID == _loc1_)
         {
            return;
         }
         this.FMusicID = _loc1_;
         _loc2_ = FILE_ResourcePath + this.FMusicID.toString() + FILE_ResourceSuffix;
         if(this.FResourceConfig)
         {
            _loc4_ = this.FResourceConfig[_loc2_];
         }
         if(_loc4_ == null)
         {
            if(SParametersCore.ClientVersion == 0)
            {
               _loc4_ = "";
            }
            else
            {
               _loc4_ = SParametersCore.ClientVersion.toString();
            }
         }
         if(_loc4_.length > 0)
         {
            _loc2_ = _loc4_ + "/" + _loc2_;
         }
         _loc2_ = this.FCdnRoot + _loc2_;
         SMusicPlayer.PlayBgSound(_loc2_);
      }
      
      protected function UIStageOnKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:Number = NaN;
         if(param1.ctrlKey)
         {
            _loc2_ = Number(SMusicPlayer.CurVolume);
            switch(param1.keyCode)
            {
               case KEY_UP:
                  _loc2_ += 0.2;
                  break;
               case KEY_DOWN:
                  _loc2_ -= 0.2;
            }
            if(_loc2_ > 1)
            {
               _loc2_ = 1;
            }
            else if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            SMusicPlayer.SetVolume(_loc2_);
         }
      }
   }
}

