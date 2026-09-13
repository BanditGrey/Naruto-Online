package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TCrossServerWarReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TGSPVP_Reward extends TDatebaseVO
   {
      
      protected var FCondition:String;
      
      protected var FRewards:String;
      
      protected var FFrom:uint;
      
      protected var FTo:uint;
      
      protected var FGroup:uint;
      
      protected var FFloor:uint;
      
      protected var FCrossServerWarRewards:Vector.<TCrossServerWarReward>;
      
      public function TGSPVP_Reward()
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
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FCondition);
         param1.writeUnsignedInt(this.FFrom);
         param1.writeUnsignedInt(this.FTo);
         TUtilityString.FlushUTF(param1,this.FRewards);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         var _loc6_:TCrossServerWarReward = null;
         this.FCondition = TUtilityString.FetchUTF(param1);
         _loc3_ = this.FCondition.split(":");
         this.FGroup = _loc3_[1];
         this.FFloor = _loc3_[2];
         this.FFrom = param1.readUnsignedInt();
         this.FTo = param1.readUnsignedInt();
         this.FRewards = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FRewards) as Array;
         _loc5_ = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc6_ = new TCrossServerWarReward(_loc3_[_loc4_]);
            this.FCrossServerWarRewards[_loc4_] = _loc6_;
            _loc4_++;
         }
      }
      
      public function get Condition() : String
      {
         return this.FCondition;
      }
      
      public function get Rewards() : String
      {
         return this.FRewards;
      }
      
      public function get Group() : uint
      {
         return this.FGroup;
      }
      
      public function get Floor() : uint
      {
         return this.FFloor;
      }
      
      public function get CrossServerWarRewards() : Vector.<TCrossServerWarReward>
      {
         return this.FCrossServerWarRewards;
      }
      
      public function get From() : uint
      {
         return this.FFrom;
      }
      
      public function get To() : uint
      {
         return this.FTo;
      }
   }
}

