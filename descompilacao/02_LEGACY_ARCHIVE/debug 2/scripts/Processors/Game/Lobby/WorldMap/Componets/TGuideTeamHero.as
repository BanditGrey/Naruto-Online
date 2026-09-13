package Processors.Game.Lobby.WorldMap.Componets
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.DatebaseVO.VO.TGuideHero;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_WORLDMAP;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TGuideTeamHero
   {
      
      protected static const MAX_COUNT:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FGuideHero1:TGuideHero;
      
      protected var FGuideHero2:TGuideHero;
      
      protected var FGuideHero3:TGuideHero;
      
      protected var FSelectHero:TGuideHero;
      
      protected var FOnSelectHero:Function;
      
      public function TGuideTeamHero(param1:MovieClip)
      {
         super();
         this.FScene = param1;
         this.InitGuideTeamHero();
      }
      
      protected function InitGuideTeamHero() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FScene["MC_HeroIcon_" + _loc1_].addEventListener(MouseEvent.CLICK,this.OnHeroSelect);
            _loc1_++;
         }
      }
      
      protected function OnHeroSelect(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TGuideHero = null;
         if(SLogicsCore.Character.GetMainLevel() < this.FGuideHero1.OpenLV)
         {
            return;
         }
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(12)));
         switch(_loc2_)
         {
            case 0:
               _loc3_ = this.FGuideHero1;
               break;
            case 1:
               _loc3_ = this.FGuideHero2;
               break;
            case 2:
               _loc3_ = this.FGuideHero3;
         }
         if(this.FOnSelectHero != null)
         {
            this.FOnSelectHero(this,_loc3_);
         }
      }
      
      public function get OnSelectHero() : Function
      {
         return this.FOnSelectHero;
      }
      
      public function set OnSelectHero(param1:Function) : void
      {
         this.FOnSelectHero = param1;
      }
      
      public function get OpenLevel() : uint
      {
         return this.FGuideHero1.OpenLV;
      }
      
      public function get FirstHero() : TGuideHero
      {
         return this.FGuideHero1;
      }
      
      public function SetInfo(param1:TGuideHero, param2:TGuideHero, param3:TGuideHero) : void
      {
         var _loc4_:uint = 0;
         this.FGuideHero1 = param1;
         this.FGuideHero2 = param2;
         this.FGuideHero3 = param3;
         this.FScene["TF_OpenLevel"].text = TUtilityString.Format(STRING_WORLDMAP.STRING_OPENLEVEL,this.FGuideHero1.OpenLV);
         this.FScene["MC_HeroIcon_0"]["TF_Text"].text = this.GetNamebyId(this.FGuideHero1.BaseheroID);
         this.FScene["MC_HeroIcon_1"]["TF_Text"].text = this.GetNamebyId(this.FGuideHero2.BaseheroID);
         this.FScene["MC_HeroIcon_2"]["TF_Text"].text = this.GetNamebyId(this.FGuideHero3.BaseheroID);
      }
      
      protected function GetNamebyId(param1:uint) : String
      {
         var _loc2_:TBaseHero = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1) as TBaseHero;
         return _loc2_.Name;
      }
      
      public function SetSelectHero(param1:TGuideHero) : void
      {
         this.FSelectHero = param1;
         this.FScene["MC_HeroIcon_0"]["MC_Select"].visible = Boolean(this.FSelectHero.Identifier == this.FGuideHero1.Identifier);
         this.FScene["MC_HeroIcon_1"]["MC_Select"].visible = Boolean(this.FSelectHero.Identifier == this.FGuideHero2.Identifier);
         this.FScene["MC_HeroIcon_2"]["MC_Select"].visible = Boolean(this.FSelectHero.Identifier == this.FGuideHero3.Identifier);
      }
   }
}

