package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TTreeChest extends TDatebaseVO
   {
      
      protected var FTreeLv:uint;
      
      protected var FCount:uint;
      
      protected var FVipLv:uint;
      
      protected var FRewards:String;
      
      protected var FRewardsVect:Array;
      
      public function TTreeChest()
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
         param1.writeUnsignedInt(this.FTreeLv);
         param1.writeUnsignedInt(this.FCount);
         param1.writeUnsignedInt(this.FVipLv);
         TUtilityString.FlushUTF(param1,this.FRewards);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FTreeLv = param1.readUnsignedInt();
         this.FCount = param1.readUnsignedInt();
         this.FVipLv = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         this.FRewardsVect = Json.decode(this.FRewards);
      }
      
      public function get TreeLv() : uint
      {
         return this.FTreeLv;
      }
      
      public function get Count() : uint
      {
         return this.FCount;
      }
      
      public function get VipLv() : uint
      {
         return this.FVipLv;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get RewardsVect() : Array
      {
         return this.FRewardsVect;
      }
   }
}

