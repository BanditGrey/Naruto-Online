package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TFixedAward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TMewBattle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FLocation:uint;
      
      protected var FType:uint;
      
      protected var FArmyid:uint;
      
      protected var FImage:uint;
      
      protected var FAward:String;
      
      protected var FAwardex:String;
      
      protected var FStageClear:uint;
      
      protected var FNeedLevel:uint;
      
      protected var FAwards:Vector.<TFixedAward>;
      
      protected var FAwardexs:Vector.<TFixedAward>;
      
      public function TMewBattle()
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
         param1.writeUnsignedInt(this.FLocation);
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FArmyid);
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FAward);
         TUtilityString.FlushUTF(param1,this.FAwardex);
         param1.writeUnsignedInt(this.FStageClear);
         param1.writeUnsignedInt(this.FNeedLevel);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:TFixedAward = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FLocation = param1.readUnsignedInt();
         this.FType = param1.readUnsignedInt();
         this.FArmyid = param1.readUnsignedInt();
         this.FImage = param1.readUnsignedInt();
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
         this.FStageClear = param1.readUnsignedInt();
         this.FNeedLevel = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Location() : uint
      {
         return this.FLocation;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function get StageClear() : uint
      {
         return this.FStageClear;
      }
      
      public function get NeedLevel() : uint
      {
         return this.FNeedLevel;
      }
      
      public function get Awards() : Vector.<TFixedAward>
      {
         return this.FAwards;
      }
      
      public function get Awardexs() : Vector.<TFixedAward>
      {
         return this.FAwardexs;
      }
      
      public function get Award() : String
      {
         return this.FAward;
      }
      
      public function get Awardex() : String
      {
         return this.FAwardex;
      }
      
      public function get Armyid() : uint
      {
         return this.FArmyid;
      }
      
      public function get Image() : uint
      {
         return this.FImage;
      }
      
      public function set Image(param1:uint) : void
      {
         this.FImage = param1;
      }
   }
}

