package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TLeadLevelGifts extends TDatebaseVO
   {
      
      protected var FLeadLevel:int;
      
      protected var FGifts:String;
      
      protected var FTopupgifts:String;
      
      protected var FGiftArr:Array;
      
      protected var FTopupgiftArr:Array;
      
      protected var FLevel:String;
      
      protected var FTopupnum:int;
      
      protected var FStage:int;
      
      public function TLeadLevelGifts()
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
         param1.writeUnsignedInt(this.FLeadLevel);
         TUtilityString.FlushUTF(param1,this.FTopupgifts);
         TUtilityString.FlushUTF(param1,this.FGifts);
         TUtilityString.FlushUTF(param1,this.FLevel);
         param1.writeUnsignedInt(this.FTopupnum);
         param1.writeUnsignedInt(this.FStage);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FLeadLevel = param1.readUnsignedInt();
         this.FTopupgifts = TUtilityString.FetchUTF(param1);
         this.FGifts = TUtilityString.FetchUTF(param1);
         this.FTopupgiftArr = Json.decode(this.FTopupgifts);
         this.FGiftArr = Json.decode(this.FGifts);
         this.FLevel = TUtilityString.FetchUTF(param1);
         this.FTopupnum = param1.readUnsignedInt();
         this.FStage = param1.readUnsignedInt();
      }
      
      public function get TopupgiftArr() : Array
      {
         return this.FTopupgiftArr;
      }
      
      public function get GiftArr() : Array
      {
         return this.FGiftArr;
      }
      
      public function get LeadLevel() : int
      {
         return this.FLeadLevel;
      }
      
      public function get Topupgifts() : String
      {
         return this.FTopupgifts;
      }
      
      public function get Gifts() : String
      {
         return this.FGifts;
      }
      
      public function get Level() : String
      {
         return this.FLevel;
      }
      
      public function get Stage() : int
      {
         return this.FStage;
      }
      
      public function get Topupnum() : int
      {
         return this.FTopupnum;
      }
   }
}

