package Processors.Game.Lobby.Rank
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Logics.Rank.UserRankInfo;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_RANK;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorRankUnit
   {
      
      protected var FMCScene:MovieClip;
      
      protected var FUserRankInfo:Logics.Rank.UserRankInfo;
      
      protected var FT_Rank:TextField;
      
      protected var FT_Name:TextField;
      
      protected var FT_Server:TextField;
      
      protected var FT_Value:TextField;
      
      protected var FBTN_Show:MovieClip;
      
      protected var FT_Hero:TextField;
      
      protected var FBTN_Show_Func:Function;
      
      protected var FBTN_Qiecuo:MovieClip;
      
      protected var FBTN_Qiecuo_Func:Function;
      
      public function TProcessorRankUnit(param1:MovieClip)
      {
         super();
         this.FMCScene = param1;
         this.FBTN_Show = this.FMCScene[CONST_RANK.RESOURCE_Link_Btn_Show];
         this.FBTN_Show.addEventListener(MouseEvent.CLICK,this.OnBtnShowClick);
         this.FBTN_Show.buttonMode = true;
         this.FBTN_Qiecuo = this.FMCScene[CONST_RANK.RESOURCE_Link_Btn_Qiecuo];
         this.FBTN_Qiecuo.addEventListener(MouseEvent.CLICK,this.OnBtnQiecuo);
         this.FBTN_Qiecuo.buttonMode = true;
         this.FT_Rank = this.FMCScene[CONST_RANK.RESOURCE_Link_TF_Rank];
         this.FT_Value = this.FMCScene[CONST_RANK.RESOURCE_Link_TF_Value];
         this.FT_Server = this.FMCScene[CONST_RANK.RESOURCE_Link_TF_Server];
         this.FT_Name = this.FMCScene[CONST_RANK.RESOURCE_Link_TF_Name];
         this.FT_Hero = this.FMCScene[CONST_RANK.RESOURCE_Link_TF_Hero];
      }
      
      public function set UserRankInfo(param1:Logics.Rank.UserRankInfo) : void
      {
         var _loc2_:TBaseHero = null;
         this.FUserRankInfo = param1;
         this.FT_Rank.text = param1 ? param1.rank.toString() : "";
         this.FT_Server.text = param1 ? param1.serverid.toString() : "";
         this.FT_Value.text = param1 ? param1.value.ToString() : "";
         this.FT_Name.text = param1 ? param1.name : "";
         this.FBTN_Show.visible = param1 ? true : false;
         this.FBTN_Qiecuo.visible = param1 ? true : false;
         if(param1)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1.heroId) as TBaseHero;
         }
         this.FT_Hero.text = _loc2_ ? _loc2_.Name : "";
      }
      
      protected function OnBtnShowClick(param1:MouseEvent) : void
      {
         if(this.FBTN_Show_Func != null)
         {
            this.FBTN_Show_Func(this.FUserRankInfo);
         }
      }
      
      public function set BTN_Show_Func(param1:Function) : void
      {
         this.FBTN_Show_Func = param1;
      }
      
      protected function OnBtnQiecuo(param1:MouseEvent) : void
      {
         this.FBTN_Qiecuo_Func && this.FBTN_Qiecuo_Func(this.FUserRankInfo);
      }
      
      public function set BTN_Qiecuo_Func(param1:Function) : void
      {
         this.FBTN_Qiecuo_Func = param1;
      }
   }
}

