package Processors.Game.Lobby.TacticalDeployment
{
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityCartisian;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class THeroList extends TUIComponent
   {
      
      protected static const MAX_COUNT:int = 6;
      
      protected var FScene:MovieClip;
      
      protected var FHerosData:THeros;
      
      protected var FShowHeroInfoTip:Function;
      
      protected var FHideHeroInfoTip:Function;
      
      protected var FSetSelectHero:Function;
      
      protected var FOnEffectText:Function;
      
      protected var FRoleModel:TBins;
      
      protected var FDragEnable:Boolean = true;
      
      public function THeroList(param1:TUIComponent, param2:MovieClip)
      {
         super(param1);
         this.FScene = param2;
         this.InitHeroList();
      }
      
      protected function InitHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Bitmap = null;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FScene.mc_playHead["mc_hero_" + _loc1_];
            _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.OnShowHeroTip);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.OnHideHeroTip);
            _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.OnSelectHero);
            _loc3_ = new Bitmap();
            _loc2_.mc_head["heroHead"] = _loc3_;
            _loc2_.mc_head.addChild(_loc3_);
            _loc2_.mc_over.visible = false;
            _loc2_.mc_over.mouseEnabled = false;
            _loc1_++;
         }
         this.FRoleModel = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RoleModel);
      }
      
      protected function OnShowHeroTip(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         if(param1.currentTarget.mc_over)
         {
            param1.currentTarget.mc_over.visible = true;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FShowHeroInfoTip != null)
         {
            if(_loc2_ >= this.FHerosData.Count)
            {
               return;
            }
            _loc3_ = this.FHerosData.GetHeroByIndex(_loc2_);
            if(_loc3_ != null)
            {
               this.FShowHeroInfoTip(this,_loc3_);
            }
         }
      }
      
      protected function OnHideHeroTip(param1:MouseEvent = null) : void
      {
         if(Boolean(param1) && Boolean(param1.currentTarget.mc_over))
         {
            param1.currentTarget.mc_over.visible = false;
         }
         if(this.FHideHeroInfoTip != null)
         {
            this.FHideHeroInfoTip(this);
         }
      }
      
      protected function OnSelectHero(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:THero = null;
         var _loc4_:TSystemLanguage = null;
         var _loc5_:String = null;
         if(!this.FDragEnable)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.TACTICALDEPLOYMENT_STRING_10) as TSystemLanguage;
            _loc5_ = _loc4_.Desc;
            this.FOnEffectText(_loc5_);
            return;
         }
         _loc2_ = int(String(param1.currentTarget.name).slice(8));
         if(this.FSetSelectHero != null)
         {
            _loc3_ = this.FHerosData.GetHeroByIndex(_loc2_);
            if(_loc3_ != null)
            {
               if(_loc3_.FightPosition <= 0)
               {
                  this.FSetSelectHero(_loc3_);
                  this.OnHideHeroTip();
               }
            }
            else
            {
               this.FSetSelectHero();
            }
         }
      }
      
      public function get ShowHeroInfoTip() : Function
      {
         return this.FShowHeroInfoTip;
      }
      
      public function set ShowHeroInfoTip(param1:Function) : void
      {
         this.FShowHeroInfoTip = param1;
      }
      
      public function get HideHeroInfoTip() : Function
      {
         return this.FHideHeroInfoTip;
      }
      
      public function set HideHeroInfoTip(param1:Function) : void
      {
         this.FHideHeroInfoTip = param1;
      }
      
      public function get SetSelectHero() : Function
      {
         return this.FSetSelectHero;
      }
      
      public function set SetSelectHero(param1:Function) : void
      {
         this.FSetSelectHero = param1;
      }
      
      public function set DragEnable(param1:Boolean) : void
      {
         this.FDragEnable = param1;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function SetHerosData(param1:THeros) : void
      {
         this.FHerosData = param1;
         this.FHerosData.Sort();
         this.FScene.gotoAndPlay(1);
      }
      
      public function UpdataHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:THero = null;
         var _loc4_:TRoleModel = null;
         if(this.FHerosData == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FScene.mc_playHead["mc_hero_" + _loc1_];
            if(_loc1_ < this.FHerosData.Count)
            {
               _loc3_ = this.FHerosData.GetHeroByIndex(_loc1_);
               _loc4_ = this.FRoleModel.GetDatebaseByIdentifier(_loc3_.Identifier) as TRoleModel;
               _loc2_.visible = true;
               _loc2_.mc_militaryType.gotoAndStop(_loc3_.StandPositionWithProfession);
               _loc2_.mc_outFight.visible = Boolean(_loc3_.FightPosition > 0);
               TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,_loc2_.mc_head["heroHead"],CONST_MODULES.MODULE_TacticalDeployment,_loc4_.RoleHead);
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc1_++;
         }
      }
      
      public function GetHeroPoint(param1:uint) : TCoordinate
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:THero = null;
         var _loc5_:TCoordinate = null;
         _loc2_ = 0;
         while(_loc2_ < this.FHerosData.Count)
         {
            _loc4_ = this.FHerosData.GetHeroByIndex(_loc2_);
            if(_loc4_.Identifier == param1)
            {
               break;
            }
            _loc2_++;
         }
         _loc3_ = this.FScene.mc_playHead["mc_hero_" + int(_loc2_ % MAX_COUNT)];
         if(_loc3_ != null)
         {
            _loc5_ = TUtilityCartisian.GetScreenCoordinateByDisplayObject(_loc3_);
         }
         return _loc5_;
      }
   }
}

