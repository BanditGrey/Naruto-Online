package Processors.Game.Lobby.LostShenqi.OtherPanel
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMazeconfig;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MiGongSinglenGeZi
   {
      
      protected var FThisMc:MovieClip;
      
      protected var FMC_Image:MovieClip;
      
      protected var FBmp:Bitmap;
      
      protected var FCurImageId:uint;
      
      protected var FMC_CanZhou:MovieClip;
      
      protected var FMC_Nimei:MovieClip;
      
      protected var FMC_Cao:MovieClip;
      
      protected var FCurX:uint;
      
      protected var FCurY:uint;
      
      protected var FCurFream:uint;
      
      protected var FCurShiJianId:uint;
      
      protected var FIsCanClick:Boolean;
      
      protected var FBackFucntion:Function;
      
      protected var FCurDate:TMazeconfig;
      
      public function MiGongSinglenGeZi()
      {
         super();
         this.FBmp = new Bitmap();
      }
      
      public function set ThisMc(param1:MovieClip) : void
      {
         this.FThisMc = param1;
         this.IniliZation();
      }
      
      public function get ThisMc() : MovieClip
      {
         return this.FThisMc;
      }
      
      protected function IniliZation() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         this.FMC_Image = this.FThisMc["MC_Image"];
         this.FMC_Image.addChild(this.FBmp);
         this.FMC_Image.mouseEnabled = false;
         this.FMC_Image.mouseChildren = false;
         this.FThisMc.mouseEnabled = false;
         this.FMC_CanZhou = this.FThisMc["MC_CanZhou"];
         this.FMC_CanZhou.mouseEnabled = false;
         this.FMC_CanZhou.mouseChildren = false;
         this.FMC_Nimei = this.FThisMc["MC_Nimei"];
         this.FMC_Nimei.mouseEnabled = false;
         this.FMC_Nimei.mouseChildren = false;
         this.FMC_Cao = this.FThisMc["MC_Cao"];
         _loc1_ = this.FThisMc.name;
         _loc2_ = _loc1_.split("_");
         this.FCurX = _loc2_[1];
         this.FCurY = _loc2_[2];
         this.FMC_Cao.buttonMode = true;
         this.FMC_Cao.addEventListener(MouseEvent.CLICK,this.ThisClick);
      }
      
      public function UpdateImage() : void
      {
         if(!this.FCurDate)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Lostsacred,this.FBmp,CONST_MODULES.MODULE_LostShenQi,this.FCurDate.Icon);
      }
      
      public function set CurImageId(param1:uint) : void
      {
         this.FCurImageId = param1;
      }
      
      public function get CurImageId() : uint
      {
         return this.FCurImageId;
      }
      
      public function get MC_CanZhou() : MovieClip
      {
         return this.FMC_CanZhou;
      }
      
      public function get CurX() : uint
      {
         return this.FCurX;
      }
      
      public function get CurY() : uint
      {
         return this.FCurY;
      }
      
      public function set CurShiJianId(param1:uint) : void
      {
         this.FCurDate = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Mazeconfig,param1) as TMazeconfig;
         if(!this.FCurDate)
         {
            this.FBmp.bitmapData = null;
         }
         this.FCurShiJianId = param1;
      }
      
      public function get CurShiJianId() : uint
      {
         return this.FCurShiJianId;
      }
      
      public function set CurFream(param1:uint) : void
      {
         this.FThisMc.gotoAndStop(param1);
         this.FCurFream = param1;
      }
      
      public function get CurFream() : uint
      {
         return this.FCurFream;
      }
      
      protected function ThisClick(param1:MouseEvent) : void
      {
         if(!this.FIsCanClick)
         {
            return;
         }
         if(this.FBackFucntion != null)
         {
            this.FBackFucntion(this.CurX,this.CurY);
         }
      }
      
      public function set BackFucntion(param1:Function) : void
      {
         this.FBackFucntion = param1;
      }
      
      public function set IsCanClick(param1:Boolean) : void
      {
         this.FMC_CanZhou.visible = param1;
         this.FIsCanClick = param1;
      }
      
      public function get IsCanClick() : Boolean
      {
         return this.FIsCanClick;
      }
   }
}

