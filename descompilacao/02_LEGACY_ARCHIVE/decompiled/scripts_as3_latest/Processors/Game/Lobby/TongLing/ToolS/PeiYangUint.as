package Processors.Game.Lobby.TongLing.ToolS
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TBB_Exp;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TBB_Train;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PeiYangUint
   {
      
      protected var FRootPanle:MovieClip;
      
      protected var F_Mose:int;
      
      protected var F_CurTrain:TBB_Train = null;
      
      protected var FCurTbbState:TBB_Status = null;
      
      protected var FCurBtnIndex:int = 0;
      
      protected var FBackFunction:Function;
      
      protected var FAllarr:Array = null;
      
      protected var FurPosition:int;
      
      protected var FSelect:int;
      
      protected var FBmp:Bitmap;
      
      protected var FPetId:int = 0;
      
      protected var Flevel:int = 0;
      
      protected var FCurIndex:int = 7;
      
      protected var FExteShow:Function;
      
      public function PeiYangUint(param1:MovieClip)
      {
         super();
         this.FRootPanle = param1;
         this.FBmp = new Bitmap();
         this.AddEvent();
      }
      
      public function AddEvent() : void
      {
         if(this.FRootPanle == null)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            MovieClip(this.FRootPanle["Btn0" + _loc1_]).addEventListener(MouseEvent.CLICK,this.selectBtn);
            _loc1_++;
         }
         this.setState(this.FCurBtnIndex);
         MovieClip(this.FRootPanle["BTN_GET"]).addEventListener(MouseEvent.CLICK,this.BTnClick);
         TGameUtil.setButtonMode(MovieClip(this.FRootPanle["BTN_GET"]),true);
         MovieClip(this.FRootPanle["Pic"]).addChild(this.FBmp);
      }
      
      public function SetMsg(param1:TBB_Train, param2:int, param3:int, param4:int, param5:int) : void
      {
         if(param4 == 0)
         {
            return;
         }
         this.FPetId = param4;
         this.Flevel = param5;
         this.F_CurTrain = param1;
         this.F_Mose = param2;
         this.FurPosition = param3;
         this.FillData();
      }
      
      public function update() : void
      {
         if(this.FCurTbbState == null)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FBmp,CONST_MODULES.MODULE_TongLing,this.FCurTbbState.SmPic,3);
      }
      
      public function FillData() : void
      {
         this.FCurTbbState = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,this.FPetId) as TBB_Status;
         TextField(this.FRootPanle[CONST_TONGLINGANIMAL.Select_Mod_Item_PeiYangName]).text = this.F_CurTrain.Name;
         TextField(this.FRootPanle[CONST_TONGLINGANIMAL.Select_Mod_Item_Time]).text = this.getFenZhong(this.F_CurTrain.TrainTime);
         this.SetGetExp(this.FCurIndex);
         TextField(this.FRootPanle[CONST_TONGLINGANIMAL.Select_Mod_Item_mony]).text = String(this.F_CurTrain.Cost);
         this.FAllarr = this.getMonyUint();
         var _loc1_:int = 0;
         while(_loc1_ < this.FAllarr.length)
         {
            TextField(this.FRootPanle["Btn_text0" + (_loc1_ + 1)]).text = this.getStrByArr(this.FAllarr[_loc1_]);
            _loc1_++;
         }
      }
      
      public function getFenZhong(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 < 60)
         {
            return param1 + STRING_TONGLING.TONGLING_fen;
         }
         _loc2_ += param1 / 60 + STRING_TONGLING.TONGLING_TIME;
         if(param1 % 60 == 0)
         {
            return _loc2_;
         }
         return _loc2_ + (String(param1 % 60) + STRING_TONGLING.TONGLING_fen);
      }
      
      public function getMonyUint() : Array
      {
         var _loc1_:Object = null;
         var _loc2_:Array = new Array();
         var _loc3_:String = this.F_CurTrain.ExtraExp1;
         var _loc4_:Array = _loc3_.substr(1,_loc3_.length - 2).split(",");
         _loc2_.push(_loc4_);
         _loc3_ = this.F_CurTrain.ExtraExp2;
         _loc4_ = _loc3_.substr(1,_loc3_.length - 2).split(",");
         _loc2_.push(_loc4_);
         _loc3_ = this.F_CurTrain.ExtraExp3;
         _loc4_ = _loc3_.substr(1,_loc3_.length - 2).split(",");
         _loc2_.push(_loc4_);
         return _loc2_;
      }
      
      public function selectBtn(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FRootPanle["Btn00"]:
               this.FCurBtnIndex = 0;
               this.FCurIndex = 7;
               break;
            case this.FRootPanle["Btn01"]:
               this.FCurBtnIndex = 1;
               this.FCurIndex = 0;
               break;
            case this.FRootPanle["Btn02"]:
               this.FCurBtnIndex = 2;
               this.FCurIndex = 1;
               break;
            case this.FRootPanle["Btn03"]:
               this.FCurBtnIndex = 3;
               this.FCurIndex = 2;
         }
         this.setState(this.FCurBtnIndex);
         this.SetGetExp(this.FCurIndex);
      }
      
      public function SetGetExp(param1:int) : void
      {
         var _loc2_:Number = 0;
         if(param1 == 7)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = Number(this.FAllarr[param1][0]);
         }
         TextField(this.FRootPanle[CONST_TONGLINGANIMAL.Select_Mod_Item_JingYan]).text = String(_loc2_ * Number(this.F_CurTrain.GetExp));
      }
      
      public function setState(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            MovieClip(this.FRootPanle["Btn0" + _loc2_]).gotoAndStop(2);
            _loc2_++;
         }
         MovieClip(this.FRootPanle["Btn0" + param1]).gotoAndStop(1);
      }
      
      public function getStrByArr(param1:Array) : String
      {
         var _loc2_:String = "";
         if(param1[0] == 0)
         {
            return "";
         }
         return _loc2_ + (param1[2] + this.MoneyUint(param1[1]) + " " + param1[0] + STRING_TONGLING.TONGLING_BEI + STRING_TONGLING.TONGLING_EXP);
      }
      
      public function MoneyUint(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_SILVER_COIN;
               break;
            case 1:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
               break;
            case 2:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GIFT;
               break;
            case 3:
               _loc2_ = STRING_INHERITPRACTICE.INHERIT_GOLD;
         }
         return _loc2_;
      }
      
      public function BTnClick(param1:MouseEvent) : void
      {
         var _loc2_:TBB_Exp = null;
         var _loc3_:Object = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Exp,this.FPetId) as TBB_Exp;
         if(!_loc2_.LvArr[this.Flevel] || _loc2_.LvArr[this.Flevel] == 0)
         {
            this.FExteShow(STRING_FETEBLOODMAINMANAGE.DOntTipManLevel);
            return;
         }
         if(this.FBackFunction != null)
         {
            _loc3_ = {
               "Scr":this.F_CurTrain.Name,
               "AllExp":this.F_CurTrain.GetExp,
               "mode":this.F_Mose,
               "selsect":this.FCurBtnIndex,
               "curPosition":this.FurPosition,
               "allTime":this.F_CurTrain.TrainTime
            };
            if(this.FCurBtnIndex != 0)
            {
               _loc3_.AllExp = this.F_CurTrain.GetExp * Number(this.FAllarr[this.FCurBtnIndex - 1][0]);
            }
            this.FBackFunction(_loc3_);
         }
      }
      
      public function get BackFunction() : Function
      {
         return this.FBackFunction;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function set ExteShow(param1:Function) : void
      {
         this.FExteShow = param1;
      }
   }
}

