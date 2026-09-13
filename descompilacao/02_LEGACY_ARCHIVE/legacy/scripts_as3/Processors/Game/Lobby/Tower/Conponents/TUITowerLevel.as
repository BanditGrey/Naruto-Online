package Processors.Game.Lobby.Tower.Conponents
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TEnchantBattle;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.SLogicsCore;
   import Logics.Tower.TTower;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_TOWER;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUITowerLevel extends TProcessorGame
   {
      
      protected var FTF_Level:TextField;
      
      protected var FMC_Role:MovieClip;
      
      protected var FUIHero:TUIHero;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FIsWin:Boolean;
      
      protected var FTower:TTower;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      public function TUITowerLevel(param1:TUIComponent)
      {
         super(param1);
         this.FIsWin = false;
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Parent.Visible)
         {
            return;
         }
         this.FUIHero.Update();
         if(this.FIsWin)
         {
            if(this.FMC_Effect.currentFrame == this.FMC_Effect.totalFrames)
            {
               this.FUIHero.Context = SLogicsCore.Character.GetMainHero();
               this.FMC_Effect.gotoAndStop(1);
               this.FIsWin = false;
            }
         }
         if(this.FMC_Effect.currentFrame == this.FMC_Effect.totalFrames)
         {
            this.FUIHero.Context = null;
            this.FMC_Effect.gotoAndStop(1);
         }
         super.LogicsPerform();
      }
      
      protected function UIDispatch() : void
      {
         this.FTF_Level = this.FResource["TF_Level"];
         this.FMC_Role = this.FResource["MC_Role"];
         this.FMC_Effect = this.FResource["MC_Effect"];
         this.FUIHero = new TUIHero(this);
         this.FMC_Role.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
      }
      
      protected function UILocations() : void
      {
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TEnchantBattle = null;
         _loc1_ = this.FContext as TEnchantBattle;
         if(_loc1_ != null)
         {
            this.FTF_Level.text = TUtilityString.Format(STRING_TOWER.FORMAT_Level,_loc1_.Stageid);
         }
         if(this.FTower.TowerID == FTag || this.FTower.StageClear == 1 && _loc1_.StageClear == 1 || this.FTower.TowerID + 1 == _loc1_.Identifier)
         {
            if(this.FIsWin)
            {
               this.FMC_Effect.play();
            }
            else
            {
               this.FUIHero.Context = SLogicsCore.Character.GetMainHero();
            }
         }
         else
         {
            this.FUIHero.Context = null;
         }
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Tower);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      public function get Resource() : MovieClip
      {
         return this.FResource;
      }
      
      public function set Resource(param1:MovieClip) : void
      {
         this.FResource = param1;
      }
      
      public function get Context() : Object
      {
         return this.FContext;
      }
      
      public function set Context(param1:Object) : void
      {
         this.FContext = param1;
      }
      
      public function get UIHeroContext() : Object
      {
         return this.FUIHero.Context;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function Update(param1:TTower, param2:Boolean) : void
      {
         this.FTower = param1;
         this.FIsWin = param2;
         this.UpdateUI();
      }
      
      public function PlayEffect() : void
      {
         this.FMC_Effect.play();
      }
   }
}

