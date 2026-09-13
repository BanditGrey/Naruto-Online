package Processors.Game.Lobby.Palace.Components
{
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Palace.TTargetFighter;
   import Logics.SLogicsCore;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_PALACE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   
   public class TUIPalaceHero extends TProcessorGame
   {
      
      protected var FTF_Name:TextField;
      
      protected var FTF_Ranking:TextField;
      
      protected var FTF_Level:TextField;
      
      protected var FTF_Server:TextField;
      
      protected var FMC_Look:MovieClip;
      
      protected var FMC_Role:MovieClip;
      
      protected var FUIHero:TUIPalaceHeroModel;
      
      protected var FGlowFilter:GlowFilter;
      
      protected var FResource:MovieClip;
      
      protected var FContext:Object;
      
      protected var FLookHeroInfoOnClick:Function;
      
      protected var FRoleOnClick:Function;
      
      protected var FRoleOnOver:Function;
      
      protected var FRoleOnOut:Function;
      
      public function TUIPalaceHero(param1:TUIComponent)
      {
         super(param1);
         this.FGlowFilter = new GlowFilter();
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Parent.Visible)
         {
            return;
         }
         if(this.FUIHero != null)
         {
            this.FUIHero.Update();
         }
         super.LogicsPerform();
      }
      
      protected function UIDispatch() : void
      {
         this.FTF_Name = this.FResource["TF_Name"];
         this.FTF_Ranking = this.FResource["TF_Ranking"];
         this.FTF_Level = this.FResource["TF_Level"];
         this.FTF_Server = this.FResource["TF_Server"];
         this.FMC_Look = this.FResource["MC_Look"];
         TGameUtil.setButtonMode(this.FMC_Look,true);
         this.FMC_Role = this.FResource["MC_Role"];
         this.FUIHero = new TUIPalaceHeroModel(this);
         this.FMC_Role.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
      }
      
      protected function UILocations() : void
      {
         this.FMC_Look.addEventListener(MouseEvent.CLICK,this.MCLookOnClick,false,0,true);
         this.FMC_Role.addEventListener(MouseEvent.CLICK,this.MCRoleOnClick,false,0,true);
         this.FMC_Role.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRoleOnOver,false,0,true);
         this.FMC_Role.addEventListener(MouseEvent.ROLL_OUT,this.MCRoleOnOut,false,0,true);
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:TTargetFighter = null;
         if(this.FContext == null)
         {
            return;
         }
         if(this.FContext is TTargetFighter)
         {
            _loc1_ = this.FContext as TTargetFighter;
            this.FTF_Name.text = _loc1_.PlayerName;
            this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.Level);
            this.FTF_Ranking.text = TUtilityString.Format(STRING_PALACE.FORMAT_Ranking,_loc1_.RankIndex.toString());
            this.FTF_Server.text = _loc1_.ServerName;
            this.FUIHero.Context = _loc1_.Heros.GetHeroByIndex(0);
            this.FUIHero.WingId = _loc1_.WingID;
            this.FUIHero.TitleId = _loc1_.TitleID;
            if(_loc1_.RankIndex == SLogicsCore.PalaceData.TargetFighters.RoleCurrentRank)
            {
               this.FMC_Look.visible = false;
            }
            else
            {
               this.FMC_Look.visible = true;
            }
         }
      }
      
      protected function ProcessorCheckIdentifier(param1:Object, param2:Object) : void
      {
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
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Palace);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      protected function MCLookOnClick(param1:MouseEvent) : void
      {
         if(this.FLookHeroInfoOnClick != null)
         {
            this.FLookHeroInfoOnClick(this,this.FContext);
         }
      }
      
      protected function MCRoleOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TTargetFighter = null;
         if(this.FContext == null)
         {
            return;
         }
         _loc2_ = this.FContext as TTargetFighter;
         if(_loc2_.RankIndex == SLogicsCore.PalaceData.TargetFighters.RoleCurrentRank)
         {
            return;
         }
         if(this.FRoleOnClick != null)
         {
            this.FRoleOnClick(this,this.FContext);
         }
      }
      
      protected function MCRoleOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TTargetFighter = null;
         if(this.FContext == null)
         {
            return;
         }
         _loc2_ = this.FContext as TTargetFighter;
         if(_loc2_.RankIndex != SLogicsCore.PalaceData.TargetFighters.RoleCurrentRank)
         {
            FUICore.MouseCaptureSet(this.FUIHero);
            this.FUIHero.CursorHovering = true;
         }
         this.FMC_Role.filters = [this.FGlowFilter];
      }
      
      protected function MCRoleOnOut(param1:MouseEvent) : void
      {
         FUICore.MouseCaptureRelease(this.FUIHero);
         this.FUIHero.CursorHovering = false;
         this.FMC_Role.filters = [];
      }
      
      public function get LookHeroInfoOnClick() : Function
      {
         return this.FLookHeroInfoOnClick;
      }
      
      public function set LookHeroInfoOnClick(param1:Function) : void
      {
         this.FLookHeroInfoOnClick = param1;
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
         if(param1 == null)
         {
            this.FUIHero.Context = param1;
         }
         this.FContext = param1;
      }
      
      public function get RoleOnClick() : Function
      {
         return this.FRoleOnClick;
      }
      
      public function set RoleOnClick(param1:Function) : void
      {
         this.FRoleOnClick = param1;
      }
      
      public function get RoleOnOver() : Function
      {
         return this.FRoleOnOver;
      }
      
      public function set RoleOnOver(param1:Function) : void
      {
         this.FRoleOnOver = param1;
      }
      
      public function get RoleOnOut() : Function
      {
         return this.FRoleOnOut;
      }
      
      public function set RoleOnOut(param1:Function) : void
      {
         this.FRoleOnOut = param1;
      }
      
      public function Init() : void
      {
         this.UIDispatch();
         this.UILocations();
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function LightButtonStatus() : void
      {
         this.FMC_Look.mouseEnabled = true;
         TGameUtil.setButtonMode(this.FMC_Look,true);
      }
      
      public function DarkButtonStatus() : void
      {
         this.FMC_Look.mouseEnabled = false;
         TGameUtil.setButtonMode(this.FMC_Look,false);
      }
   }
}

