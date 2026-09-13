package Processors.Game.Lobby.NinJaPractice
{
   import Foundation.Utilities.TGameUtil;
   import Logics.Characters.THero;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class JinJaPracticeUint
   {
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var Root_Con:MovieClip;
      
      protected var Fhero:THero;
      
      protected var headBmp:Bitmap;
      
      protected var Ffunction:Function;
      
      protected var F_name:String = "";
      
      protected var FI_:uint = 0;
      
      protected var Findex:int;
      
      protected var FIsCanSee:int = 0;
      
      public function JinJaPracticeUint()
      {
         super();
         this.headBmp = new Bitmap();
      }
      
      public function initin(param1:MovieClip, param2:THero, param3:int) : void
      {
         this.Root_Con = param1;
         if(this.Root_Con == null)
         {
            this.FI_ = 0;
            this.Findex = 77;
            this.headBmp.bitmapData = null;
            return;
         }
         this.Fhero = param2;
         this.FI_ = param2.Identifier;
         this.Findex = param3;
         this.ini();
      }
      
      protected function ini() : void
      {
         var _loc1_:uint = QUALITYCOLOR_INDEX[this.hero.Quality];
         MovieClip(this.Root_Con["MC_Head"]).addChild(this.headBmp);
         TextField(this.Root_Con["TF_Level"]).textColor = _loc1_;
         TextField(this.Root_Con["TF_Name"]).textColor = _loc1_;
         if(this.Root_Con["xiulevel"])
         {
            TextField(this.Root_Con["xiulevel"]).textColor = _loc1_;
         }
         TextField(this.Root_Con["TF_Level"]).text = this.Fhero.GetLevelStrByLevel(this.Fhero.Level);
         TextField(this.Root_Con["TF_Name"]).text = this.Fhero.Name;
         if(this.Root_Con["xiulevel"])
         {
            TextField(this.Root_Con["xiulevel"]).text = "+" + this.Fhero.GetQianNengOnlyLevelStr(this.hero.PotentialLv);
         }
         if(this.Root_Con["MC_Taboo_Btn"])
         {
            MovieClip(this.Root_Con["MC_Taboo_Btn"]).visible = false;
         }
         if(this.Root_Con["MC_Taboo_Btn"])
         {
            if(this.Fhero.ExpIsInherited)
            {
               MovieClip(this.Root_Con["MC_Taboo_Btn"]).visible = true;
            }
            else
            {
               MovieClip(this.Root_Con["MC_Taboo_Btn"]).visible = false;
            }
         }
         this.Root_Con.addEventListener(MouseEvent.MOUSE_OVER,this.over);
         this.Root_Con.addEventListener(MouseEvent.MOUSE_OUT,this.out);
         this.Root_Con.addEventListener(MouseEvent.CLICK,this.click);
      }
      
      public function SetTabooBtn(param1:int = 1) : void
      {
         if(this.Root_Con["MC_Taboo_Btn"])
         {
            if(param1)
            {
               MovieClip(this.Root_Con["MC_Taboo_Btn"]).visible = false;
            }
            else
            {
               MovieClip(this.Root_Con["MC_Taboo_Btn"]).visible = true;
            }
         }
      }
      
      public function Update() : void
      {
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.headBmp,CONST_MODULES.MODULE_NinJaPractice,this.Fhero.SmallID);
      }
      
      public function dispose() : void
      {
         this.Root_Con.removeEventListener(MouseEvent.MOUSE_OVER,this.over);
         this.Root_Con.removeEventListener(MouseEvent.MOUSE_OVER,this.out);
         this.Root_Con.removeEventListener(MouseEvent.MOUSE_OVER,this.click);
         this.FI_ = 0;
      }
      
      public function click(param1:MouseEvent) : void
      {
         if(this.Root_Con)
         {
            this.Ffunction(this.FI_,this.Findex,this.Fhero);
         }
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      public function over(param1:MouseEvent) : void
      {
         if(this.Root_Con)
         {
            this.Root_Con.gotoAndStop(2);
         }
      }
      
      public function out(param1:MouseEvent) : void
      {
         if(this.Root_Con)
         {
            this.Root_Con.gotoAndStop(1);
         }
      }
      
      public function get index() : int
      {
         return this.Findex;
      }
      
      public function get hero() : THero
      {
         return this.Fhero;
      }
      
      public function set fction(param1:Function) : void
      {
         this.Ffunction = param1;
      }
      
      public function get fction() : Function
      {
         return this.Ffunction;
      }
      
      public function get _id() : uint
      {
         return this.FI_;
      }
      
      public function get root_Con() : MovieClip
      {
         return this.Root_Con;
      }
   }
}

