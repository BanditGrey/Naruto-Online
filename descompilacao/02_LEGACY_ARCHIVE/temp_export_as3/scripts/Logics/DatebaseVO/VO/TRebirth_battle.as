package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TRebirth_battle extends TDatebaseVO
   {
      
      protected var FBossName:String;
      
      protected var FLocation:int;
      
      protected var FSStage:int;
      
      protected var FImage:int;
      
      protected var FAward:String;
      
      protected var FRecommendPower:int;
      
      protected var FAwards:Vector.<TFixedAward>;
      
      public function TRebirth_battle()
      {
         super();
         this.FAwards = new Vector.<TFixedAward>();
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
         TUtilityString.FlushUTF(param1,this.FBossName);
         param1.writeUnsignedInt(this.FLocation);
         param1.writeUnsignedInt(this.FSStage);
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FAward);
         param1.writeUnsignedInt(this.FRecommendPower);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:TFixedAward = null;
         this.FBossName = TUtilityString.FetchUTF(param1);
         this.FLocation = param1.readUnsignedInt();
         this.FSStage = param1.readUnsignedInt();
         this.FImage = param1.readUnsignedInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FAward);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = new TFixedAward(_loc4_[_loc3_]);
            this.FAwards[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FRecommendPower = param1.readUnsignedInt();
      }
      
      public function get BossName() : String
      {
         return this.FBossName;
      }
      
      public function get Location() : int
      {
         return this.FLocation;
      }
      
      public function get SStage() : int
      {
         return this.FSStage;
      }
      
      public function get Image() : int
      {
         return this.FImage;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get RecommendPower() : int
      {
         return this.FRecommendPower;
      }
      
      public function get Awards() : Vector.<TFixedAward>
      {
         return this.FAwards;
      }
   }
}

