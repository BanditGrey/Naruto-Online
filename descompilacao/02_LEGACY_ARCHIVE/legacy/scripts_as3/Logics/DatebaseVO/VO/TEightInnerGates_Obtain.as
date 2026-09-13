package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TEightInnerGates_Obtain extends TDatebaseVO
   {
      
      protected var FQuality:int;
      
      protected var FType:int;
      
      protected var FRewardType:int;
      
      protected var FBaseAward:String;
      
      protected var FBaseAwards:Vector.<TFixedAward>;
      
      protected var FBaseAwardObjectArr:Array;
      
      protected var FName:String;
      
      public function TEightInnerGates_Obtain()
      {
         super();
         this.FBaseAwards = new Vector.<TFixedAward>();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get RewardType() : int
      {
         return this.FRewardType;
      }
      
      public function get BaseAward() : String
      {
         return this.FBaseAward;
      }
      
      public function get BaseAwards() : Vector.<TFixedAward>
      {
         return this.FBaseAwards;
      }
      
      public function get BaseAwardObjectArr() : Array
      {
         return this.FBaseAwardObjectArr;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FRewardType);
         TUtilityString.FlushUTF(param1,this.FBaseAward);
         TUtilityString.FlushUTF(param1,this.FName);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TFixedAward = null;
         this.FQuality = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FRewardType = param1.readUnsignedInt();
         this.FBaseAward = TUtilityString.FetchUTF(param1);
         this.FBaseAwardObjectArr = Json.decode(this.FBaseAward);
         _loc2_ = 0;
         while(_loc2_ < this.FBaseAwardObjectArr.length)
         {
            _loc3_ = new TFixedAward(this.FBaseAwardObjectArr[_loc2_]["value"]);
            this.FBaseAwards[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.FName = TUtilityString.FetchUTF(param1);
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

