package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TDailyActivity extends TDatebaseVO
   {
      
      protected var FActivityType:int;
      
      protected var FActivityName:String;
      
      protected var FActivityTime:String;
      
      protected var FActivityDescription:String;
      
      protected var FActivityRewards:String;
      
      protected var FButtonState:String;
      
      protected var FActivityTimeVect:Vector.<String>;
      
      protected var FButtonStateVect:Vector.<String>;
      
      public function TDailyActivity()
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
         param1.writeUnsignedInt(this.FActivityType);
         TUtilityString.FlushUTF(param1,this.FActivityName);
         TUtilityString.FlushUTF(param1,this.FActivityTime);
         TUtilityString.FlushUTF(param1,this.FActivityDescription);
         TUtilityString.FlushUTF(param1,this.FActivityRewards);
         TUtilityString.FlushUTF(param1,this.FButtonState);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         this.FActivityType = param1.readUnsignedInt();
         this.FActivityName = TUtilityString.FetchUTF(param1);
         this.FActivityTime = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FActivityTime) as Array;
         _loc4_ = _loc2_.length;
         this.FActivityTimeVect = new Vector.<String>(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.FActivityTimeVect[_loc3_] = _loc2_[_loc3_];
            _loc3_++;
         }
         this.FActivityDescription = TUtilityString.FetchUTF(param1);
         this.FActivityRewards = TUtilityString.FetchUTF(param1);
         this.FButtonState = TUtilityString.FetchUTF(param1);
         this.FButtonStateVect = Vector.<String>(Json.decode(this.FButtonState));
      }
      
      public function get ActivityType() : int
      {
         return this.FActivityType;
      }
      
      public function get ActivityName() : String
      {
         return this.FActivityName;
      }
      
      public function get ActivityTime() : String
      {
         return this.FActivityTime;
      }
      
      public function get ActivityDescription() : String
      {
         return this.FActivityDescription;
      }
      
      public function get ActivityRewards() : String
      {
         return this.FActivityRewards;
      }
      
      public function get ButtonState() : String
      {
         return this.FButtonState;
      }
      
      public function get ActivityTimeVect() : Vector.<String>
      {
         return this.FActivityTimeVect;
      }
      
      public function get ButtonStateVect() : Vector.<String>
      {
         return this.FButtonStateVect;
      }
   }
}

