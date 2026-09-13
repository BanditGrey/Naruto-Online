package Processors.Game.Lobby.Arena
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Arena.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.SLogicsCore;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TProcessorWindowArenaList extends TUIComponent
   {
      
      protected var HEROLIST_Count:uint = 10;
      
      protected var FScene:MovieClip;
      
      protected var FArenaHeros:TArenaHeros;
      
      protected var FCurPage:int;
      
      protected var FTotlePage:int;
      
      protected var FMilitaryBins:TBins;
      
      protected var FShowOtherHeroInfor:Function;
      
      public function TProcessorWindowArenaList(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:uint = 0;
         super(param1);
         this.FScene = param2;
         this.FScene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeft);
         this.FScene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRight);
         _loc3_ = 0;
         while(_loc3_ < this.HEROLIST_Count)
         {
            this.FScene["mc_hero_" + _loc3_].buttonMode = true;
            this.FScene["mc_hero_" + _loc3_].mouseChildren = false;
            this.FScene["mc_hero_" + _loc3_].addEventListener(MouseEvent.CLICK,this.OnLookHero);
            _loc3_++;
         }
      }
      
      protected function SetHeroData(param1:TArenaHero, param2:MovieClip) : void
      {
         var _loc3_:TMilitary = null;
         if(param2 == null || param1 == null)
         {
            return;
         }
         param2.tf_ranking.text = param1.Ranking.toString();
         param2.tf_name.text = param1.PlayerNick;
         param2.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(param1.PlayerLevel);
         _loc3_ = this.FMilitaryBins.GetDatebaseByIdentifier(param1.Military) as TMilitary;
         param2.tf_militaryRank.text = _loc3_.Name;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.HEROLIST_Count)
         {
            if(_loc1_ + (this.FCurPage - 1) * this.HEROLIST_Count < this.FArenaHeros.Count)
            {
               this.SetHeroData(this.FArenaHeros.GetHeroByIndex(_loc1_ + (this.FCurPage - 1) * this.HEROLIST_Count),this.FScene["mc_hero_" + _loc1_]);
               this.FScene["mc_hero_" + _loc1_].visible = true;
            }
            else
            {
               this.FScene["mc_hero_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function CheckBtn() : void
      {
         TGameUtil.setButtonMode(this.FScene.btn_left,this.FCurPage > 1);
         TGameUtil.setButtonMode(this.FScene.btn_right,this.FCurPage < this.FTotlePage);
         this.FScene.tf_page.text = this.FCurPage + "/" + this.FTotlePage;
      }
      
      protected function OnLeft(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnRight(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnLookHero(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TArenaHero = null;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(8)));
         _loc3_ = this.FArenaHeros.GetHeroByIndex(_loc2_ + (this.FCurPage - 1) * this.HEROLIST_Count);
         if(this.FShowOtherHeroInfor != null)
         {
            this.FShowOtherHeroInfor(this,_loc3_.Identifier0,_loc3_.Identifier1);
         }
      }
      
      public function set ShowOtherHeroInfor(param1:Function) : void
      {
         this.FShowOtherHeroInfor = param1;
      }
      
      public function get ShowOtherHeroInfor() : Function
      {
         return this.FShowOtherHeroInfor;
      }
      
      public function SetArenaHeroPanel(param1:TArenaHeros) : void
      {
         this.FArenaHeros = param1;
         this.FCurPage = 1;
         this.FTotlePage = Math.max(int(this.FArenaHeros.Count - 1) / this.HEROLIST_Count + 1,1);
         if(this.FMilitaryBins == null)
         {
            this.FMilitaryBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Military);
         }
         this.UpdataUI();
         this.CheckBtn();
      }
   }
}

