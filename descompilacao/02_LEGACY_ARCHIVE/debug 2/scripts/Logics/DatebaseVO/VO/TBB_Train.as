package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TBB_Train extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FTrainTime:int;
      
      protected var FRarity:int;
      
      protected var FGetExp:int;
      
      protected var FCost:int;
      
      protected var FExtraExp1:String;
      
      protected var FExtraExp2:String;
      
      protected var FExtraExp3:String;
      
      public function TBB_Train()
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
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FRarity);
         param1.writeUnsignedInt(this.FTrainTime);
         param1.writeUnsignedInt(this.FGetExp);
         param1.writeUnsignedInt(this.FCost);
         TUtilityString.FlushUTF(param1,this.FExtraExp1);
         TUtilityString.FlushUTF(param1,this.FExtraExp2);
         TUtilityString.FlushUTF(param1,this.FExtraExp3);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FRarity = param1.readUnsignedInt();
         this.FTrainTime = param1.readUnsignedInt();
         this.FGetExp = param1.readUnsignedInt();
         this.FCost = param1.readUnsignedInt();
         this.FExtraExp1 = TUtilityString.FetchUTF(param1);
         this.FExtraExp2 = TUtilityString.FetchUTF(param1);
         this.FExtraExp3 = TUtilityString.FetchUTF(param1);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Rarity() : int
      {
         return this.FRarity;
      }
      
      public function get TrainTime() : int
      {
         return this.FTrainTime;
      }
      
      public function get GetExp() : int
      {
         return this.FGetExp;
      }
      
      public function get Cost() : int
      {
         return this.FCost;
      }
      
      public function get ExtraExp1() : String
      {
         return this.FExtraExp1;
      }
      
      public function get ExtraExp2() : String
      {
         return this.FExtraExp2;
      }
      
      public function get ExtraExp3() : String
      {
         return this.FExtraExp3;
      }
   }
}

