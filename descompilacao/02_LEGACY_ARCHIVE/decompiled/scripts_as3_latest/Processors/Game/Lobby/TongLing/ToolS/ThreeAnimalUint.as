package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_EvoShope;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ThreeAnimalUint
   {
      
      protected var FThisRoot:MovieClip;
      
      protected var FTbbEvoShope:TBB_EvoShope;
      
      protected var FPicBmp:Bitmap;
      
      protected var FPicId:int = 0;
      
      protected var FName:String;
      
      protected var FBtn:MovieClip;
      
      protected var JinHuaText:TextField;
      
      protected var FOutFunction:Function;
      
      protected var FOverFunction:Function;
      
      protected var FMoverFunction:Function;
      
      protected var FBtnClick:Function;
      
      protected var FStatu:TBB_Status = null;
      
      public function ThreeAnimalUint(param1:MovieClip)
      {
         super();
         this.FThisRoot = param1;
         this.FPicBmp = new Bitmap();
         this.value();
      }
      
      protected function value() : void
      {
         MovieClip(this.FThisRoot[CONST_TONGLINGANIMAL.Shop_Count_Animal_son_Pic]).addChild(this.FPicBmp);
         this.JinHuaText = this.FThisRoot[CONST_TONGLINGANIMAL.Shop_Count_Animal_son_JingYan] as TextField;
         this.FBtn = this.FThisRoot[CONST_TONGLINGANIMAL.Shop_Count_Animal_son_Btn] as MovieClip;
         TGameUtil.setButtonMode(this.FBtn,true);
         MovieClip(this.FThisRoot[CONST_TONGLINGANIMAL.Shop_Count_Animal_son_Pic]).addEventListener(MouseEvent.MOUSE_OVER,this.OverClick);
         MovieClip(this.FThisRoot[CONST_TONGLINGANIMAL.Shop_Count_Animal_son_Pic]).addEventListener(MouseEvent.MOUSE_OUT,this.OutClick);
         MovieClip(this.FThisRoot[CONST_TONGLINGANIMAL.Shop_Count_Animal_son_Pic]).addEventListener(MouseEvent.MOUSE_MOVE,this.MoveClick);
         this.FBtn.addEventListener(MouseEvent.CLICK,this.ClickEvent);
      }
      
      public function SetMsg(param1:TBB_EvoShope) : void
      {
         this.FTbbEvoShope = param1;
         if(this.FTbbEvoShope == null)
         {
            this.FPicId = 0;
            this.FPicBmp.bitmapData = null;
            this.JinHuaText.text = "";
            TextField(this.FThisRoot["tt_name"]).text = "";
            return;
         }
         this.ReadTabel();
      }
      
      public function ReadTabel() : void
      {
         var _loc1_:int = this.FTbbEvoShope.Bbid;
         this.FStatu = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,_loc1_) as TBB_Status;
         this.FPicId = this.FStatu.SmPic;
         this.JinHuaText.text = String(this.FTbbEvoShope.Cost);
         TextField(this.FThisRoot["tt_name"]).text = this.FStatu.Name;
      }
      
      public function update() : void
      {
         if(this.FPicId == 0 || this.FStatu == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FPicBmp,CONST_MODULES.MODULE_TongLing,this.FStatu.SmPic,3);
      }
      
      public function ClickEvent(param1:MouseEvent) : void
      {
         if(this.FTbbEvoShope == null)
         {
            return;
         }
         this.FBtnClick(this.FTbbEvoShope.Bbid,this.FTbbEvoShope.Cost);
      }
      
      public function set BtnClick(param1:Function) : void
      {
         this.FBtnClick = param1;
      }
      
      public function OverClick(param1:MouseEvent) : void
      {
         if(this.FTbbEvoShope == null)
         {
            return;
         }
         this.FOverFunction(this.FTbbEvoShope.Bbid);
      }
      
      public function MoveClick(param1:MouseEvent) : void
      {
         if(this.FTbbEvoShope == null)
         {
            return;
         }
         this.FMoverFunction(param1);
      }
      
      public function OutClick(param1:MouseEvent) : void
      {
         if(this.FTbbEvoShope == null)
         {
            return;
         }
         this.FOutFunction();
      }
      
      public function set OverFunction(param1:Function) : void
      {
         this.FOverFunction = param1;
      }
      
      public function set OutFunction(param1:Function) : void
      {
         this.FOutFunction = param1;
      }
      
      public function set MoverFunction(param1:Function) : void
      {
         this.FMoverFunction = param1;
      }
   }
}

