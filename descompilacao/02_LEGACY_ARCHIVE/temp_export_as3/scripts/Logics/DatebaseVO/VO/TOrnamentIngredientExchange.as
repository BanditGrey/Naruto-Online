package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TOrnamentIngredientExchange extends TDatebaseVO
   {
      
      protected var FExpend:int;
      
      protected var FLevel:int;
      
      protected var FGotIngredientId:int;
      
      protected var FIngredientNum:int;
      
      public function TOrnamentIngredientExchange()
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
         param1.writeUnsignedInt(this.FExpend);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FGotIngredientId);
         param1.writeUnsignedInt(this.FIngredientNum);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FExpend = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FGotIngredientId = param1.readUnsignedInt();
         this.FIngredientNum = param1.readUnsignedInt();
      }
      
      public function get Expend() : int
      {
         return this.FExpend;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get GotIngredientId() : int
      {
         return this.FGotIngredientId;
      }
      
      public function get IngredientNum() : int
      {
         return this.FIngredientNum;
      }
   }
}

