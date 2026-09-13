package Processors.Game.Lobby.Store.data
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Logics.DatebaseVO.VO.TNewMall;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class NewMallData
   {
      
      protected var V1:Vector.<NewMallCellData> = null;
      
      protected var V2:Vector.<NewMallCellData> = null;
      
      protected var V3:Vector.<NewMallCellData> = null;
      
      protected var V4:Vector.<NewMallCellData> = null;
      
      protected var V5:Vector.<NewMallCellData> = null;
      
      protected var V6:Vector.<NewMallCellData> = null;
      
      protected var V7:Vector.<NewMallCellData> = null;
      
      protected var V777:Vector.<NewMallCellData> = null;
      
      protected var b:TBins = null;
      
      protected var FOpenSeverTime:uint;
      
      public function NewMallData()
      {
         super();
         this.V1 = new Vector.<NewMallCellData>();
         this.V2 = new Vector.<NewMallCellData>();
         this.V3 = new Vector.<NewMallCellData>();
         this.V4 = new Vector.<NewMallCellData>();
         this.V5 = new Vector.<NewMallCellData>();
         this.V6 = new Vector.<NewMallCellData>();
         this.V7 = new Vector.<NewMallCellData>();
         this.V777 = new Vector.<NewMallCellData>();
      }
      
      public function Initilization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TNewMall = null;
         var _loc4_:NewMallCellData = null;
         this.b = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewMall) as TBins;
         _loc1_ = this.b.Count;
         _loc2_ = 0;
         for(; _loc2_ < _loc1_; _loc2_++)
         {
            _loc3_ = this.b.GetDatebaseByIndex(_loc2_) as TNewMall;
            if(_loc3_.DisplayType == 1)
            {
               if(this.GetBooBelMonth(_loc3_.DisplayValueArray))
               {
                  continue;
               }
            }
            else if(_loc3_.DisplayType == 2)
            {
               if(this.GetBooBelYear(_loc3_.DisplayValueArray))
               {
                  continue;
               }
            }
            _loc4_ = this.GetNewMallCellData();
            _loc4_.NewMall = _loc3_;
            _loc4_.updateCondition();
            switch(_loc3_.Type)
            {
               case 1:
                  this.V1.push(_loc4_);
                  break;
               case 2:
                  this.V2.push(_loc4_);
                  break;
               case 3:
                  this.V3.push(_loc4_);
                  break;
               case 4:
                  this.V4.push(_loc4_);
                  break;
               case 5:
                  this.V5.push(_loc4_);
                  break;
               case 7:
                  this.V7.push(_loc4_);
            }
         }
      }
      
      protected function GetBooBelMonth(param1:Array) : Boolean
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         _loc2_ = STimingCore.GetServerTick() - this.FOpenSeverTime;
         _loc5_ = param1[0];
         _loc6_ = param1[1];
         _loc3_ = (_loc5_[0] - 1) * 24 * 60 * 60;
         _loc4_ = (_loc6_[0] - 1) * 24 * 60 * 60;
         if(_loc2_ > _loc4_)
         {
            return true;
         }
         if(_loc2_ < _loc3_)
         {
            return true;
         }
         return false;
      }
      
      protected function GetBooBelYear(param1:Array) : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Date = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc4_ = new Date(STimingCore.GetClientShowTime(STimingCore.GetServerTick()) * 1000);
         _loc5_ = _loc4_.fullYear;
         _loc6_ = _loc4_.month + 1;
         _loc7_ = _loc4_.date;
         _loc2_ = param1[0];
         _loc3_ = param1[1];
         if(_loc5_ < _loc2_[0] || _loc5_ > _loc3_[0])
         {
            return true;
         }
         if(_loc6_ < _loc2_[1] || _loc6_ > _loc3_[1])
         {
            return true;
         }
         if(_loc7_ < _loc2_[2] || _loc7_ >= _loc3_[2])
         {
            return true;
         }
         return false;
      }
      
      protected function GetNewMallCellData() : NewMallCellData
      {
         var _loc1_:NewMallCellData = null;
         if(this.V777.length)
         {
            _loc1_ = this.V777.shift();
         }
         else
         {
            _loc1_ = new NewMallCellData();
         }
         return _loc1_;
      }
      
      public function ClearVector() : void
      {
         var _loc1_:int = 0;
         while(this.V1.length)
         {
            this.V777.push(this.V1.shift());
         }
         while(this.V2.length)
         {
            this.V777.push(this.V2.shift());
         }
         while(this.V3.length)
         {
            this.V777.push(this.V3.shift());
         }
         while(this.V4.length)
         {
            this.V777.push(this.V4.shift());
         }
         while(this.V5.length)
         {
            this.V777.push(this.V5.shift());
         }
         while(this.V6.length)
         {
            this.V777.push(this.V6.shift());
         }
         while(this.V7.length)
         {
            this.V777.push(this.V7.shift());
         }
      }
      
      public function SetCountById(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<NewMallCellData> = null;
         var _loc5_:TNewMall = null;
         _loc5_ = this.b.GetDatebaseByIdentifier(param1) as TNewMall;
         _loc4_ = this.getArrByType(_loc5_.Type);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].NewMall.Identifier == param1)
            {
               _loc4_[_loc3_].CurGoodsBuyCount = param2;
               if(!_loc4_[_loc3_].CurGoodsIsShow)
               {
                  if(!_loc4_[_loc3_].ConditionIsOver_ShowOrHide)
                  {
                     _loc4_.splice(_loc3_,1);
                  }
               }
               break;
            }
            _loc3_++;
         }
      }
      
      public function getArrByType(param1:int) : Vector.<NewMallCellData>
      {
         var _loc2_:Vector.<NewMallCellData> = null;
         switch(param1)
         {
            case 1:
               _loc2_ = this.V1;
               break;
            case 2:
               _loc2_ = this.V2;
               break;
            case 3:
               _loc2_ = this.V3;
               break;
            case 4:
               _loc2_ = this.V4;
               break;
            case 5:
               _loc2_ = this.V5;
               break;
            case 6:
               _loc2_ = this.V7;
               break;
            case 7:
               _loc2_ = this.V7;
         }
         return _loc2_;
      }
      
      public function GetNewMallDateByPaream(param1:uint, param2:int) : NewMallCellData
      {
         var _loc3_:TNewMall = null;
         var _loc4_:NewMallCellData = null;
         var _loc5_:int = 0;
         if(!this.b)
         {
            this.b = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NewMall) as TBins;
         }
         _loc5_ = 0;
         while(_loc5_ < this.b.Count)
         {
            _loc3_ = this.b.GetDatebaseByIndex(_loc5_) as TNewMall;
            if(_loc3_.Itemid == param1)
            {
               break;
            }
            _loc5_++;
         }
         _loc4_ = new NewMallCellData();
         _loc4_.NewMall = _loc3_;
         _loc4_.CurGoodsBuyCount = param2;
         return _loc4_;
      }
      
      public function SetValueById(param1:uint, param2:int) : void
      {
         var _loc3_:TNewMall = null;
         var _loc4_:NewMallCellData = null;
         _loc3_ = this.b.GetDatebaseByIdentifier(param1) as TNewMall;
         _loc4_ = new NewMallCellData();
         _loc4_.NewMall = _loc3_;
         _loc4_.CurGoodsBuyCount = param2;
         switch(_loc3_.Type)
         {
            case 1:
               this.V1.push(_loc4_);
               break;
            case 2:
               this.V2.push(_loc4_);
               break;
            case 3:
               this.V3.push(_loc4_);
               break;
            case 4:
               this.V4.push(_loc4_);
               break;
            case 5:
               this.V5.push(_loc4_);
               break;
            case 6:
               this.V6.push(_loc4_);
               break;
            case 7:
               this.V7.push(_loc4_);
         }
      }
      
      public function UpdateSortOne() : void
      {
         this.V1 = this.V1.sort(this.ST);
         this.V2 = this.V2.sort(this.ST);
         this.V3 = this.V3.sort(this.ST);
         this.V4 = this.V4.sort(this.ST);
         this.V5 = this.V5.sort(this.ST);
      }
      
      public function UpdateSortSix() : void
      {
         this.V6 = this.V6.sort(this.ST);
         this.V7 = this.V7.sort(this.ST);
      }
      
      public function DeleteByNewMall(param1:NewMallCellData) : void
      {
         var _loc2_:Vector.<NewMallCellData> = null;
         var _loc3_:int = 0;
         switch(param1.NewMall.Type)
         {
            case 1:
               _loc2_ = this.V1;
               break;
            case 2:
               _loc2_ = this.V2;
               break;
            case 3:
               _loc2_ = this.V3;
               break;
            case 4:
               _loc2_ = this.V4;
               break;
            case 5:
               _loc2_ = this.V5;
               break;
            case 6:
               _loc2_ = this.V6;
               break;
            case 7:
               _loc2_ = this.V7;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1.NewMall.Identifier == _loc2_[_loc3_].NewMall.Identifier)
            {
               _loc2_.splice(_loc3_,1);
            }
            _loc3_++;
         }
      }
      
      protected function ST(param1:NewMallCellData, param2:NewMallCellData) : int
      {
         if(param1.NewMall.Sort < param2.NewMall.Sort)
         {
            return -1;
         }
         if(param1.NewMall.Sort > param2.NewMall.Sort)
         {
            return 1;
         }
         return 0;
      }
      
      public function get vc1() : Vector.<NewMallCellData>
      {
         return this.V1;
      }
      
      public function get vc2() : Vector.<NewMallCellData>
      {
         return this.V2;
      }
      
      public function get vc3() : Vector.<NewMallCellData>
      {
         return this.V3;
      }
      
      public function get vc4() : Vector.<NewMallCellData>
      {
         return this.V4;
      }
      
      public function get vc5() : Vector.<NewMallCellData>
      {
         return this.V5;
      }
      
      public function get vc6() : Vector.<NewMallCellData>
      {
         return this.V6;
      }
      
      public function get vc7() : Vector.<NewMallCellData>
      {
         return this.V7;
      }
      
      public function GetSurplusByType(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Vector.<NewMallCellData> = null;
         switch(param1)
         {
            case 1:
               _loc2_ = this.V1;
               break;
            case 2:
               _loc2_ = this.V2;
               break;
            case 3:
               _loc2_ = this.V3;
               break;
            case 4:
               _loc2_ = this.V4;
               break;
            case 5:
               _loc2_ = this.V5;
               break;
            case 6:
               _loc2_ = this.V6;
               break;
            case 7:
               _loc2_ = this.V7;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_].NewMall.BuyLimitArr[0] == 1 && _loc2_[_loc3_].NewMall.BuyLimitArr[1] == 1)
            {
               if(_loc2_[_loc3_].CurGoodsBuyCount < _loc2_[_loc3_].NewMall.BuyLimitArr[1])
               {
                  _loc4_++;
               }
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function set OpenSeverTime(param1:uint) : void
      {
         this.FOpenSeverTime = param1;
      }
      
      public function get OpenSeverTime() : uint
      {
         return this.FOpenSeverTime;
      }
   }
}

