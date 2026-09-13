package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TongLingUint
   {
      
      protected var FRootPane:MovieClip;
      
      protected var FHeadBmp:Bitmap;
      
      protected var FContent:Object = null;
      
      protected var FLock:MovieClip;
      
      protected var Fselect:MovieClip;
      
      protected var FMain:MovieClip;
      
      protected var FIsCanEvolve:TextField;
      
      protected var FLevel:TextField;
      
      protected var FApeture:MovieClip;
      
      protected var FBack_Click:Function;
      
      protected var FBack_Down:Function;
      
      protected var FBack_Up:Function;
      
      protected var FOnBoxClick:Function;
      
      protected var FBack_Out:Function;
      
      protected var FBack_Over:Function;
      
      protected var FBack_Move:Function;
      
      public var FIsCanMov:int = 1;
      
      public var FIslock:int = 0;
      
      public var FIconHighLight:MovieClip;
      
      protected var FStatus:TBB_Status;
      
      public function TongLingUint(param1:MovieClip)
      {
         super();
         this.FRootPane = param1;
         this.FRootPane.buttonMode = true;
         this.FHeadBmp = new Bitmap();
         MovieClip(this.FRootPane["MC_Bmp_Icon"]).addChild(this.FHeadBmp);
         this.Fselect = MovieClip(this.FRootPane["MC_SelectedBox"]);
         this.FLock = MovieClip(this.FRootPane["MC_Lock"]);
         this.FMain = MovieClip(this.FRootPane["MC_Main"]);
         this.FIsCanEvolve = TextField(this.FRootPane["TF_name"]);
         this.FLevel = TextField(this.FRootPane["TF_Level"]);
         this.FIconHighLight = MovieClip(this.FRootPane["MC_Bmp_IconHighLight"]);
         this.FRootPane.addEventListener(MouseEvent.CLICK,this.BoxClick);
         this.FRootPane.addEventListener(MouseEvent.MOUSE_DOWN,this.BoxDown);
         this.FRootPane.addEventListener(MouseEvent.MOUSE_UP,this.BoxUp);
         this.FRootPane.addEventListener(MouseEvent.MOUSE_OVER,this.BoxOver);
         this.FRootPane.addEventListener(MouseEvent.MOUSE_OUT,this.BoxOut);
         this.FRootPane.addEventListener(MouseEvent.MOUSE_MOVE,this.BoxMove);
         this.FIsCanEvolve.visible = false;
         this.FIconHighLight.visible = false;
         this.FApeture = MovieClip(this.FRootPane["m_bu"]);
      }
      
      public function get Apeture() : MovieClip
      {
         return this.FApeture;
      }
      
      public function set Content(param1:Object) : void
      {
         this.FContent = param1;
         this.Initilaze();
      }
      
      public function get Content() : Object
      {
         return this.FContent;
      }
      
      protected function Initilaze() : void
      {
         if(this.FContent == null)
         {
            this.FLevel.text = "";
            this.FMain.visible = false;
            this.FHeadBmp.bitmapData = null;
            this.FIsCanEvolve.visible = false;
            this.Fselect.visible = false;
            this.FIconHighLight.visible = false;
         }
         else
         {
            this.IsCanExter();
            this.FLevel.text = STRING_COMMON.FORMAT_Level + this.FContent.Level;
            if(this.FContent.Position == 1)
            {
               this.FMain.visible = true;
               this.FMain.gotoAndStop(2);
            }
            else if(this.FContent.Position >= 2)
            {
               this.FMain.visible = true;
               this.FMain.gotoAndStop(1);
            }
            else
            {
               this.FMain.visible = false;
            }
            if(this.FContent.isSelect == 1)
            {
               this.Fselect.visible = true;
            }
            else
            {
               this.Fselect.visible = false;
            }
         }
      }
      
      public function IsCanExter() : void
      {
         this.FStatus = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FContent.Id) as TBB_Status;
         var _loc1_:int = this.FStatus.EvoLevel;
         var _loc2_:int = this.FStatus.GetPoint;
         if(_loc1_ == this.FContent.Level && _loc2_ != 0)
         {
            this.FIsCanEvolve.visible = true;
            this.SetText(STRING_TONGLING.TONGLING_GOO,4285071106);
            this.FContent.isCanEvolve = 1;
         }
         else
         {
            if(this.FContent.isPeiYang == 1)
            {
               this.FIsCanEvolve.visible = true;
               this.SetText(STRING_TONGLING.TONGLING_PeiYang,4294967295);
            }
            else
            {
               this.FIsCanEvolve.visible = false;
            }
            this.FContent.isCanEvolve = 0;
         }
      }
      
      protected function SetText(param1:String, param2:uint) : void
      {
         this.FIsCanEvolve.textColor = param2;
         this.FIsCanEvolve.text = param1;
      }
      
      public function SetValue() : void
      {
         this.FLevel.text = this.FContent.Level;
      }
      
      public function Update() : void
      {
         if(this.FContent == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBmp,CONST_MODULES.MODULE_TongLing,this.FStatus.SmPic);
      }
      
      public function set Lock(param1:Boolean) : void
      {
         if(param1)
         {
            this.FIslock = 0;
         }
         else
         {
            this.FIslock = 1;
         }
         this.FLock.visible = param1;
      }
      
      public function set selectStatus(param1:Boolean) : void
      {
         this.Fselect.visible = param1;
      }
      
      public function SetDefaultFilters(param1:Boolean) : void
      {
         if(param1)
         {
            this.FRootPane.filters = [TGameUtil.gBlackFilters];
         }
         else
         {
            this.FRootPane.filters = [];
         }
      }
      
      public function BoxClick(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(8));
         if(this.FContent == null)
         {
            if(this.FOnBoxClick != null)
            {
               this.FOnBoxClick();
            }
         }
         else
         {
            this.FContent.num = _loc3_;
            this.FContent.bai = 1;
            this.FBack_Click(this.FContent);
         }
      }
      
      public function BoxDown(param1:MouseEvent) : void
      {
         var _loc4_:Object = null;
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(8));
         if(this.FContent == null)
         {
            _loc4_ = {
               "num":_loc3_,
               "lock":this.FIslock,
               "bai":100
            };
            this.FBack_Move(_loc4_);
         }
         else
         {
            this.FContent.num = _loc3_;
            this.FContent.bai = 1;
            this.FBack_Down(this.FContent);
         }
      }
      
      public function BoxMove(param1:MouseEvent) : void
      {
         var _loc4_:Object = null;
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(8));
         if(this.FContent == null)
         {
            _loc4_ = {
               "num":_loc3_,
               "lock":this.FIslock,
               "bai":100
            };
            this.FBack_Move(_loc4_);
         }
         else
         {
            this.FContent.num = _loc3_;
            this.FContent.bai = 1;
            this.FBack_Move(this.FContent);
         }
      }
      
      public function BoxOut(param1:MouseEvent) : void
      {
         var _loc4_:Object = null;
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(8));
         if(this.FContent == null)
         {
            _loc4_ = {
               "num":_loc3_,
               "lock":this.FIslock,
               "bai":100
            };
            this.FBack_Out(_loc4_);
         }
         else
         {
            this.FContent.num = _loc3_;
            this.FContent.bai = 1;
            this.FBack_Out(this.FContent);
         }
      }
      
      public function BoxOver(param1:MouseEvent) : void
      {
         var _loc4_:Object = null;
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(8));
         if(this.FContent == null)
         {
            _loc4_ = {
               "num":_loc3_,
               "lock":this.FIslock,
               "bai":100
            };
            if(this.FBack_Over != null)
            {
               this.FBack_Over(_loc4_);
            }
         }
         else
         {
            this.FContent.num = _loc3_;
            this.FContent.bai = 1;
            if(this.FBack_Over != null)
            {
               this.FBack_Over(this.FContent);
            }
         }
      }
      
      public function set Back_Move(param1:Function) : void
      {
         this.FBack_Move = param1;
      }
      
      public function get Back_Move() : Function
      {
         return this.FBack_Move;
      }
      
      public function set Back_Over(param1:Function) : void
      {
         this.FBack_Over = param1;
      }
      
      public function get Back_Over() : Function
      {
         return this.FBack_Over;
      }
      
      public function set Back_Out(param1:Function) : void
      {
         this.FBack_Out = param1;
      }
      
      public function get Back_Out() : Function
      {
         return this.FBack_Out;
      }
      
      public function set OnBoxClick(param1:Function) : void
      {
         this.FOnBoxClick = param1;
      }
      
      public function get OnBoxClick() : Function
      {
         return this.FOnBoxClick;
      }
      
      public function BoxUp(param1:MouseEvent) : void
      {
         var _loc4_:Object = null;
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(8));
         if(this.FContent == null)
         {
            _loc4_ = {
               "num":_loc3_,
               "lock":this.FIslock,
               "bai":100
            };
            if(this.FBack_Up != null)
            {
               this.FBack_Up(_loc4_);
            }
         }
         else
         {
            this.FContent.num = _loc3_;
            this.FContent.bai = 1;
            if(this.FBack_Up != null)
            {
               this.FBack_Up(this.FContent);
            }
         }
      }
      
      public function set Back_Up(param1:Function) : void
      {
         this.FBack_Up = param1;
      }
      
      public function get Back_Up() : Function
      {
         return this.FBack_Up;
      }
      
      public function set Back_Down(param1:Function) : void
      {
         this.FBack_Down = param1;
      }
      
      public function get Back_Down() : Function
      {
         return this.FBack_Down;
      }
      
      public function get Back_Click() : Function
      {
         return this.FBack_Click;
      }
      
      public function set Back_Click(param1:Function) : void
      {
         this.FBack_Click = param1;
      }
      
      public function set IconHighLight(param1:Boolean) : void
      {
         this.FIconHighLight.visible = param1;
      }
   }
}

