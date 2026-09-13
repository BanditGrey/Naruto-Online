package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TMasterRoadEvent extends TDatebaseVO
   {
      
      public var name:String;
      
      public var type:String;
      
      public var venue:int;
      
      public var description:String;
      
      public var achievementReward:int;
      
      public var theFunction:int;
      
      public var getReward:int;
      
      public var Progress:int;
      
      public var Status:int;
      
      public var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      public function TMasterRoadEvent()
      {
         super();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
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
               _loc3_ = _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
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
         TUtilityString.FlushUTF(param1,this.name);
         TUtilityString.FlushUTF(param1,this.type);
         param1.writeUnsignedInt(this.venue);
         TUtilityString.FlushUTF(param1,this.description);
         param1.writeUnsignedInt(this.achievementReward);
         param1.writeUnsignedInt(this.theFunction);
         param1.writeUnsignedInt(this.getReward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.name = TUtilityString.FetchUTF(param1);
         this.type = TUtilityString.FetchUTF(param1);
         this.venue = param1.readUnsignedInt();
         this.description = TUtilityString.FetchUTF(param1);
         this.achievementReward = param1.readUnsignedInt();
         this.theFunction = param1.readUnsignedInt();
         this.getReward = param1.readUnsignedInt();
      }
      
      public function get Command() : int
      {
         var _loc1_:Array = null;
         _loc1_ = Json.decode(this.type);
         return _loc1_[1];
      }
   }
}

