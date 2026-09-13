package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TEpicExchange extends TDatebaseVO
   {
      
      protected var FPieceName:String;
      
      protected var FPieceId:uint;
      
      protected var FEpicLevel:uint;
      
      protected var FCostType:uint;
      
      protected var FExchangeCost:uint;
      
      public function TEpicExchange()
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
         TUtilityString.FlushUTF(param1,this.FPieceName);
         param1.writeUnsignedInt(this.FPieceId);
         param1.writeUnsignedInt(this.FEpicLevel);
         param1.writeUnsignedInt(this.FCostType);
         param1.writeUnsignedInt(this.FExchangeCost);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FPieceName = TUtilityString.FetchUTF(param1);
         this.FPieceId = param1.readUnsignedInt();
         this.FEpicLevel = param1.readUnsignedInt();
         this.FCostType = param1.readUnsignedInt();
         this.FExchangeCost = param1.readUnsignedInt();
      }
      
      public function get PieceName() : String
      {
         return this.FPieceName;
      }
      
      public function get PieceId() : uint
      {
         return this.FPieceId;
      }
      
      public function get EpicLevel() : uint
      {
         return this.FEpicLevel;
      }
      
      public function get CostType() : uint
      {
         return this.FCostType;
      }
      
      public function get ExchangeCost() : uint
      {
         return this.FExchangeCost;
      }
   }
}

