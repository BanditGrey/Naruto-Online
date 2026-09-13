package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TTaskReward;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TChangeHero extends TDatebaseVO
   {
      
      protected var FDesc:String;
      
      protected var FEnlistCondition:Vector.<TTaskReward>;
      
      protected var FOriginalEnlistCondition:Vector.<TTaskReward>;
      
      protected var FUpHeroID:int;
      
      protected var FStype:int;
      
      protected var FVipLimit:int;
      
      protected var FAskNeed:String;
      
      protected var FAskOriginalNeed:String;
      
      public function TChangeHero()
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
         TUtilityString.FlushUTF(param1,this.FDesc);
         TUtilityString.FlushUTF(param1,this.FAskNeed);
         TUtilityString.FlushUTF(param1,this.FAskOriginalNeed);
         param1.writeUnsignedInt(this.FUpHeroID);
         param1.writeUnsignedInt(this.FStype);
         param1.writeUnsignedInt(this.FVipLimit);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:TTaskReward = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FAskNeed = TUtilityString.FetchUTF(param1);
         _loc6_ = Json.decode(this.FAskNeed);
         _loc7_ = _loc6_ as Array;
         this.FEnlistCondition = new Vector.<TTaskReward>();
         _loc5_ = int(_loc7_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = new TTaskReward(_loc7_[_loc4_]);
            this.FEnlistCondition.push(_loc3_);
            _loc4_++;
         }
         this.FAskOriginalNeed = TUtilityString.FetchUTF(param1);
         _loc6_ = Json.decode(this.FAskOriginalNeed);
         _loc7_ = _loc6_ as Array;
         this.FOriginalEnlistCondition = new Vector.<TTaskReward>();
         _loc5_ = int(_loc7_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = new TTaskReward(_loc7_[_loc4_]);
            this.FOriginalEnlistCondition.push(_loc3_);
            _loc4_++;
         }
         this.FUpHeroID = param1.readInt();
         this.FStype = param1.readInt();
         this.FVipLimit = param1.readInt();
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get EnlistCondition() : Vector.<TTaskReward>
      {
         return this.FEnlistCondition;
      }
      
      public function get OriginalEnlistCondition() : Vector.<TTaskReward>
      {
         return this.FOriginalEnlistCondition;
      }
      
      public function get UpHeroID() : int
      {
         return this.FUpHeroID;
      }
      
      public function get Stype() : int
      {
         return this.FStype;
      }
      
      public function get VipLimit() : int
      {
         return this.FVipLimit;
      }
      
      public function get AskNeed() : String
      {
         return this.FAskNeed;
      }
      
      public function get AskOriginalNeed() : String
      {
         return this.FAskOriginalNeed;
      }
   }
}

