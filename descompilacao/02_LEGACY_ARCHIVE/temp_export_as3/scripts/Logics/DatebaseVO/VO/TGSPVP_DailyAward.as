package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TCrossServerWarReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TGSPVP_DailyAward extends TDatebaseVO
   {
      
      protected var FType:uint;
      
      protected var FQuality:uint;
      
      protected var FCostType:uint;
      
      protected var FCost:uint;
      
      protected var FExchangeItem:String;
      
      protected var FCrossServerWarRewards:Vector.<TCrossServerWarReward>;
      
      public function TGSPVP_DailyAward()
      {
         super();
         this.FCrossServerWarRewards = new Vector.<TCrossServerWarReward>();
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
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FCostType);
         param1.writeUnsignedInt(this.FCost);
         TUtilityString.FlushUTF(param1,this.FExchangeItem);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TCrossServerWarReward = null;
         this.FQuality = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FCostType = param1.readUnsignedInt();
         this.FCost = param1.readUnsignedInt();
         this.FExchangeItem = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FExchangeItem) as Array;
         _loc5_ = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TCrossServerWarReward(_loc3_[_loc4_]);
            this.FCrossServerWarRewards[_loc4_] = _loc6_;
            _loc4_++;
         }
      }
      
      public function get Quality() : uint
      {
         return this.FQuality;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get CostType() : uint
      {
         return this.FCostType;
      }
      
      public function get Cost() : uint
      {
         return this.FCost;
      }
      
      public function get ExchangeItem() : String
      {
         return this.FExchangeItem;
      }
      
      public function get CrossServerWarRewards() : Vector.<TCrossServerWarReward>
      {
         return this.FCrossServerWarRewards;
      }
   }
}

