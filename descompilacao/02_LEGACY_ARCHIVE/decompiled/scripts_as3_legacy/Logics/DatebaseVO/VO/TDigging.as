package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDigging extends TDatebaseVO
   {
      
      protected var FMapid:uint;
      
      protected var FName:String;
      
      protected var FDescription:String;
      
      protected var FRate:uint;
      
      protected var FCostMoney:Vector.<Object>;
      
      protected var FAward1Vect:Vector.<Object>;
      
      protected var FAward2Vect:Vector.<Object>;
      
      protected var FDigtime:uint;
      
      protected var FRobbery:uint;
      
      protected var FRobberyaward:uint;
      
      protected var FDigmark:uint;
      
      protected var FOpenCost:Vector.<Object>;
      
      protected var FIsgold:Boolean;
      
      protected var FViplevel:uint;
      
      protected var FMoney:String;
      
      protected var FAward1:String;
      
      protected var FAward2:String;
      
      protected var FGold:String;
      
      public function TDigging()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FMapid);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FRate);
         TUtilityString.FlushUTF(param1,this.FMoney);
         TUtilityString.FlushUTF(param1,this.FAward1);
         TUtilityString.FlushUTF(param1,this.FAward2);
         param1.writeUnsignedInt(this.FDigtime);
         param1.writeUnsignedInt(this.FRobbery);
         param1.writeUnsignedInt(this.FRobberyaward);
         param1.writeUnsignedInt(this.FDigmark);
         TUtilityString.FlushUTF(param1,this.FGold);
         param1.writeUnsignedInt(int(this.FIsgold));
         param1.writeUnsignedInt(this.FViplevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         this.FMapid = param1.readUnsignedInt();
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FRate = param1.readUnsignedInt();
         this.FMoney = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FMoney);
         this.FCostMoney = Vector.<Object>(_loc3_);
         this.FAward1 = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FAward1);
         this.FAward1Vect = Vector.<Object>(_loc3_);
         this.FAward2 = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FAward2);
         this.FAward2Vect = Vector.<Object>(_loc3_);
         this.FDigtime = param1.readUnsignedInt();
         this.FRobbery = param1.readUnsignedInt();
         this.FRobberyaward = param1.readUnsignedInt();
         this.FDigmark = param1.readUnsignedInt();
         this.FGold = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FGold);
         this.FOpenCost = Vector.<Object>(_loc3_);
         this.FIsgold = Boolean(param1.readUnsignedInt());
         this.FViplevel = param1.readUnsignedInt();
      }
      
      public function get Mapid() : uint
      {
         return this.FMapid;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get Rate() : uint
      {
         return this.FRate;
      }
      
      public function get Award1Vect() : Vector.<Object>
      {
         return this.FAward1Vect;
      }
      
      public function get Award2Vect() : Vector.<Object>
      {
         return this.FAward2Vect;
      }
      
      public function get Digtime() : uint
      {
         return this.FDigtime;
      }
      
      public function get Robbery() : uint
      {
         return this.FRobbery;
      }
      
      public function get Robberyaward() : uint
      {
         return this.FRobberyaward;
      }
      
      public function get Digmark() : uint
      {
         return this.FDigmark;
      }
      
      public function get OpenCost() : Vector.<Object>
      {
         return this.FOpenCost;
      }
      
      public function get Isgold() : Boolean
      {
         return this.FIsgold;
      }
      
      public function get Viplevel() : uint
      {
         return this.FViplevel;
      }
      
      public function get Money() : String
      {
         return this.FMoney;
      }
      
      public function get Award1() : String
      {
         return this.FAward1;
      }
      
      public function get Award2() : String
      {
         return this.FAward2;
      }
      
      public function get Gold() : String
      {
         return this.FGold;
      }
   }
}

