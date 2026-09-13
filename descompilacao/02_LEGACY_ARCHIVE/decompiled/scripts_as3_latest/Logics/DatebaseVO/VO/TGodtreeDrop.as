package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TGodtreeDrop extends TDatebaseVO
   {
      
      protected var FGodtreeLevel:int;
      
      protected var FDropList:String;
      
      protected var FDropListFixedAward:Vector.<TFixedAward>;
      
      protected var FGifts:String;
      
      protected var FGiftsFixedAward:Vector.<TFixedAward>;
      
      public function TGodtreeDrop()
      {
         super();
         this.FDropListFixedAward = new Vector.<TFixedAward>();
         this.FGiftsFixedAward = new Vector.<TFixedAward>();
      }
      
      public function get GodtreeLevel() : int
      {
         return this.FGodtreeLevel;
      }
      
      public function get DropList() : String
      {
         return this.FDropList;
      }
      
      public function get DropListFixedAward() : Vector.<TFixedAward>
      {
         return this.FDropListFixedAward;
      }
      
      public function get Gifts() : String
      {
         return this.FGifts;
      }
      
      public function get GiftsFixedAward() : Vector.<TFixedAward>
      {
         return this.FGiftsFixedAward;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FGodtreeLevel);
         TUtilityString.FlushUTF(param1,this.FDropList);
         TUtilityString.FlushUTF(param1,this.FGifts);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:TFixedAward = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         this.FGodtreeLevel = param1.readUnsignedInt();
         this.FDropList = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FDropList);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc7_ = _loc4_[_loc3_]["value"];
            _loc6_ = 0;
            while(_loc6_ < _loc7_.length)
            {
               _loc5_ = new TFixedAward(_loc7_[_loc6_]);
               this.FDropListFixedAward.push(_loc5_);
               _loc6_++;
            }
            _loc3_++;
         }
         this.FGifts = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FGifts);
         _loc2_ = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = new TFixedAward(_loc4_[_loc3_]);
            this.FGiftsFixedAward[_loc3_] = _loc5_;
            _loc3_++;
         }
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

