package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TEnchantBattle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FTower:uint;
      
      protected var FStageid:uint;
      
      protected var FStageClear:uint;
      
      protected var FLevel:uint;
      
      protected var FArmyid:uint;
      
      protected var FAward:String;
      
      protected var FAwardex:String;
      
      protected var FAwards:Vector.<TFixedAward>;
      
      protected var FAwardexs:Vector.<TFixedAward>;
      
      public function TEnchantBattle()
      {
         super();
         this.FAwards = new Vector.<TFixedAward>();
         this.FAwardexs = new Vector.<TFixedAward>();
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
         param1.writeUnsignedInt(this.FTower);
         param1.writeUnsignedInt(this.FStageid);
         param1.writeUnsignedInt(this.FStageClear);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FArmyid);
         TUtilityString.FlushUTF(param1,this.FAward);
         TUtilityString.FlushUTF(param1,this.FAwardex);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TFixedAward = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FTower = param1.readUnsignedInt();
         this.FStageid = param1.readUnsignedInt();
         this.FStageClear = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FArmyid = param1.readUnsignedInt();
         this.FAward = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FAward);
         _loc4_ = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = new TFixedAward(_loc2_[_loc3_]);
            this.FAwards[_loc3_] = _loc5_;
            _loc3_++;
         }
         this.FAwardex = TUtilityString.FetchUTF(param1);
         if(this.FAwardex != "")
         {
            _loc2_ = Json.decode(this.FAwardex);
            _loc4_ = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = new TFixedAward(_loc2_[_loc3_]);
               this.FAwardexs[_loc3_] = _loc5_;
               _loc3_++;
            }
         }
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Tower() : uint
      {
         return this.FTower;
      }
      
      public function get Stageid() : uint
      {
         return this.FStageid;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function get Armyid() : uint
      {
         return this.FArmyid;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get Awardex() : String
      {
         return this.FAwardex;
      }
      
      public function get Awards() : Vector.<TFixedAward>
      {
         return this.FAwards;
      }
      
      public function get Awardexs() : Vector.<TFixedAward>
      {
         return this.FAwardexs;
      }
      
      public function get StageClear() : uint
      {
         return this.FStageClear;
      }
   }
}

