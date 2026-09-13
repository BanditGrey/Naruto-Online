package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TAwakenConfig extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FType:int;
      
      protected var FQuality:int;
      
      protected var FIcon:int;
      
      protected var FOrder:int;
      
      protected var FDecomposition:int;
      
      protected var FStackNum:int;
      
      protected var FDescription:String;
      
      protected var FName2:String;
      
      public function TAwakenConfig()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FIcon);
         param1.writeUnsignedInt(this.FOrder);
         param1.writeUnsignedInt(this.FDecomposition);
         param1.writeUnsignedInt(this.FStackNum);
         TUtilityString.FlushUTF(param1,this.FName2);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FType = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
         this.FIcon = param1.readUnsignedInt();
         this.FOrder = param1.readUnsignedInt();
         this.FDecomposition = param1.readUnsignedInt();
         this.FStackNum = param1.readUnsignedInt();
         this.FName2 = TUtilityString.FetchUTF(param1);
      }
      
      public function get StackNum() : int
      {
         return this.FStackNum;
      }
      
      public function get Decomposition() : int
      {
         return this.FDecomposition;
      }
      
      public function get Order() : int
      {
         return this.FOrder;
      }
      
      public function get Icon() : int
      {
         return this.FIcon;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Name2() : String
      {
         return this.FName2;
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
   }
}

