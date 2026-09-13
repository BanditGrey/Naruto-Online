package Foundation.Resources.Bins
{
   import Foundation.Resources.Common.*;
   import Foundation.Resources.Spaces.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.TArticle;
   
   use namespace ResourcesSpace;
   
   public class TBins extends TResource
   {
      
      protected var FIdentifiers:Vector.<uint>;
      
      protected var FValues:Vector.<TDatebaseVO>;
      
      public function TBins(param1:uint)
      {
         super(param1);
         this.FIdentifiers = new Vector.<uint>();
         this.FValues = new Vector.<TDatebaseVO>();
      }
      
      ResourcesSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      ResourcesSpace function DatebaseAppend(param1:uint, param2:TDatebaseVO) : void
      {
         this.FIdentifiers.push(param1);
         param2.StubReferences.Reference(this);
         this.FValues.push(param2);
      }
      
      public function get Count() : int
      {
         return this.FIdentifiers.length;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TDatebaseVO = null;
         _loc1_ = int(this.FValues.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FValues[_loc2_];
            _loc3_.StubReferences.Dereference(this);
            _loc2_++;
         }
         this.FIdentifiers.length = 0;
         this.FValues.length = 0;
      }
      
      public function GetDatebaseByIndex(param1:int) : TDatebaseVO
      {
         return this.FValues[param1];
      }
      
      public function GetDatebaseByIdentifier(param1:uint) : TDatebaseVO
      {
         var _loc2_:TDatebaseVO = null;
         var _loc3_:int = this.FIdentifiers.indexOf(param1);
         if(_loc3_ >= 0)
         {
            _loc2_ = this.FValues[_loc3_];
         }
         return _loc2_;
      }
      
      public function GetIndexByDateBase(param1:TDatebaseVO) : int
      {
         return this.FValues.indexOf(param1);
      }
      
      public function GetDatebaseByValue(param1:String, param2:Object) : TDatebaseVO
      {
         var _loc3_:TDatebaseVO = null;
         var _loc4_:int = int(this.FValues.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this.FValues[_loc5_] as TDatebaseVO;
            if(_loc3_[param1] == param2)
            {
               return _loc3_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function GetDatebaseByValue2(param1:String, param2:Object, param3:String, param4:Object) : TDatebaseVO
      {
         var _loc5_:TDatebaseVO = null;
         var _loc6_:int = int(this.FValues.length);
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc5_ = this.FValues[_loc7_] as TDatebaseVO;
            if(_loc5_[param1] == param2 && _loc5_[param3] == param4)
            {
               return _loc5_;
            }
            _loc7_++;
         }
         return null;
      }
      
      public function GetTwoDatebaseVO(param1:String, param2:Object) : Array
      {
         var _loc3_:TDatebaseVO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = new Array();
         _loc4_ = int(this.FValues.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this.FValues[_loc5_] as TDatebaseVO;
            if(_loc3_[param1] == param2)
            {
               _loc6_.push(_loc3_);
               if(_loc6_.length == 2)
               {
                  return _loc6_;
               }
            }
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function GetArticleIdByValue(param1:int) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TArticle = null;
         _loc3_ = int(this.FValues.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this.FValues[_loc4_] as TArticle;
            if(_loc5_.FunctionValue == param1)
            {
               return _loc5_.Identifier;
            }
            _loc4_++;
         }
         return 0;
      }
   }
}

