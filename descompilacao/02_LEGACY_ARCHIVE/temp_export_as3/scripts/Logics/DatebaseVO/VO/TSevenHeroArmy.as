package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TSevenHeroArmy extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FServenHero:int;
      
      protected var FPrePoint:int;
      
      protected var FIsServenHero:int;
      
      protected var FOpenLevel:int;
      
      protected var FLimitLevel:int;
      
      protected var FSortNumber:int;
      
      protected var FOneWinBuff:String;
      
      protected var FOneFailBuff:String;
      
      protected var FManyWinReward:String;
      
      protected var FImage:int;
      
      protected var FModel:int;
      
      public function TSevenHeroArmy()
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
         param1.writeUnsignedInt(this.FServenHero);
         param1.writeUnsignedInt(this.FPrePoint);
         param1.writeUnsignedInt(this.FIsServenHero);
         param1.writeUnsignedInt(this.FOpenLevel);
         param1.writeUnsignedInt(this.FLimitLevel);
         param1.writeUnsignedInt(this.FSortNumber);
         TUtilityString.FlushUTF(param1,this.FOneWinBuff);
         TUtilityString.FlushUTF(param1,this.FOneFailBuff);
         TUtilityString.FlushUTF(param1,this.FManyWinReward);
         param1.writeUnsignedInt(this.FImage);
         param1.writeUnsignedInt(this.FModel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FServenHero = param1.readUnsignedInt();
         this.FPrePoint = param1.readInt();
         this.FIsServenHero = param1.readUnsignedInt();
         this.FOpenLevel = param1.readUnsignedInt();
         this.FLimitLevel = param1.readUnsignedInt();
         this.FSortNumber = param1.readUnsignedInt();
         this.FOneWinBuff = TUtilityString.FetchUTF(param1);
         this.FOneFailBuff = TUtilityString.FetchUTF(param1);
         this.FManyWinReward = TUtilityString.FetchUTF(param1);
         this.FImage = param1.readUnsignedInt();
         this.FModel = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get ServenHero() : int
      {
         return this.FServenHero;
      }
      
      public function get PrePoint() : int
      {
         return this.FPrePoint;
      }
      
      public function get IsServenHero() : int
      {
         return this.FIsServenHero;
      }
      
      public function get OpenLevel() : int
      {
         return this.FOpenLevel;
      }
      
      public function get LimitLevel() : int
      {
         return this.FLimitLevel;
      }
      
      public function get SortNumber() : int
      {
         return this.FSortNumber;
      }
      
      public function get OneWinBuff() : String
      {
         return this.FOneWinBuff;
      }
      
      public function get OneFailBuff() : String
      {
         return this.FOneFailBuff;
      }
      
      public function get ManyWinReward() : String
      {
         return this.FManyWinReward;
      }
      
      public function get Image() : int
      {
         return this.FImage;
      }
      
      public function get Model() : int
      {
         return this.FModel;
      }
   }
}

