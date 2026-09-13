package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSingle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FCampaign:int;
      
      protected var FHard:String;
      
      protected var FDesc:String;
      
      protected var FLevel:int;
      
      protected var FPrev:uint;
      
      protected var FStartId:uint;
      
      protected var FEndId:uint;
      
      protected var FRecommendForce:uint;
      
      protected var FBigImage:int;
      
      protected var FAwards:Vector.<int>;
      
      protected var FAward:String;
      
      public function TSingle()
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
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FCampaign);
         TUtilityString.FlushUTF(param1,this.FHard);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FPrev);
         param1.writeUnsignedInt(this.FStartId);
         param1.writeUnsignedInt(this.FEndId);
         param1.writeUnsignedInt(this.FRecommendForce);
         param1.writeUnsignedInt(this.FBigImage);
         TUtilityString.FlushUTF(param1,this.FAward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FCampaign = param1.readUnsignedInt();
         this.FHard = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FLevel = param1.readUnsignedInt();
         this.FPrev = param1.readUnsignedInt();
         this.FStartId = param1.readUnsignedInt();
         this.FEndId = param1.readUnsignedInt();
         this.FRecommendForce = param1.readUnsignedInt();
         this.FBigImage = param1.readUnsignedInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FAward);
         this.FAwards = Vector.<int>(_loc3_.award);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Campaign() : int
      {
         return this.FCampaign;
      }
      
      public function get Hard() : String
      {
         return this.FHard;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get Prev() : int
      {
         return this.FPrev;
      }
      
      public function get StartId() : uint
      {
         return this.FStartId;
      }
      
      public function get EndId() : uint
      {
         return this.FEndId;
      }
      
      public function get RecommendForce() : uint
      {
         return this.FRecommendForce;
      }
      
      public function get BigImage() : int
      {
         return this.FBigImage;
      }
      
      public function get Awards() : Vector.<int>
      {
         return this.FAwards;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
   }
}

