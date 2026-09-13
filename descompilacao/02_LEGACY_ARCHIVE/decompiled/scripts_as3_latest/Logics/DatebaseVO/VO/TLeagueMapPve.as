package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TLeagueMapPve extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FDesc:String;
      
      protected var FIndex:uint;
      
      protected var FLevel:uint;
      
      protected var FRecommendlevel:uint;
      
      protected var FPrev:uint;
      
      protected var FNextHard:uint;
      
      protected var FMap:uint;
      
      protected var FBigImage:uint;
      
      protected var FAward:String;
      
      protected var FExpAward:uint;
      
      protected var FMoneyAward:uint;
      
      protected var FRewardsVect:Vector.<uint>;
      
      public function TLeagueMapPve()
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FIndex);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FRecommendlevel);
         param1.writeUnsignedInt(this.FPrev);
         param1.writeUnsignedInt(this.FNextHard);
         param1.writeUnsignedInt(this.FMap);
         param1.writeUnsignedInt(this.FBigImage);
         TUtilityString.FlushUTF(param1,this.FAward);
         param1.writeUnsignedInt(this.FExpAward);
         param1.writeUnsignedInt(this.FMoneyAward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FIndex = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FRecommendlevel = param1.readUnsignedInt();
         this.FPrev = param1.readUnsignedInt();
         this.FNextHard = param1.readUnsignedInt();
         this.FMap = param1.readUnsignedInt();
         this.FBigImage = param1.readUnsignedInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         this.FRewardsVect = Vector.<uint>(Json.decode(this.FAward));
         this.FExpAward = param1.readUnsignedInt();
         this.FMoneyAward = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Recommendlevel() : uint
      {
         return this.FRecommendlevel;
      }
      
      public function get Prev() : uint
      {
         return this.FPrev;
      }
      
      public function get NextHard() : uint
      {
         return this.FNextHard;
      }
      
      public function get Map() : uint
      {
         return this.FMap;
      }
      
      public function get BigImage() : uint
      {
         return this.FBigImage;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get RewardsVect() : Vector.<uint>
      {
         return this.FRewardsVect;
      }
      
      public function get ExpAward() : uint
      {
         return this.FExpAward;
      }
      
      public function get MoneyAward() : uint
      {
         return this.FMoneyAward;
      }
   }
}

