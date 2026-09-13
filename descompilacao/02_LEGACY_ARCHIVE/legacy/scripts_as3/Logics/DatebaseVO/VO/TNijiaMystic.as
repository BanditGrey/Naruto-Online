package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.Items.TItem;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNijiaMystic extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FOccultEffectLv:int;
      
      protected var FOccultEffectKey:int;
      
      protected var FConsumeOccultPoint:int;
      
      protected var FConsumeExtra:String;
      
      protected var FPropsname:String;
      
      protected var FDesc:String;
      
      protected var FConsumeExtraVect:Vector.<TItem>;
      
      protected var FNextNijiaMystic:TNijiaMystic;
      
      public function TNijiaMystic()
      {
         super();
         this.FConsumeExtraVect = new Vector.<TItem>();
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
         param1.writeUnsignedInt(this.FOccultEffectLv);
         param1.writeUnsignedInt(this.FOccultEffectKey);
         param1.writeUnsignedInt(this.FConsumeOccultPoint);
         TUtilityString.FlushUTF(param1,this.FConsumeExtra);
         TUtilityString.FlushUTF(param1,this.FPropsname);
         TUtilityString.FlushUTF(param1,this.FDesc);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TItem = null;
         var _loc5_:Array = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FOccultEffectLv = param1.readUnsignedInt();
         this.FOccultEffectKey = param1.readUnsignedInt();
         this.FConsumeOccultPoint = param1.readUnsignedInt();
         this.FConsumeExtra = TUtilityString.FetchUTF(param1);
         _loc5_ = Json.decode(this.FConsumeExtra);
         _loc3_ = _loc5_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = new TItem();
            _loc4_.Type = _loc5_[_loc2_].type;
            _loc4_.ID = _loc5_[_loc2_].code;
            _loc4_.Count = _loc5_[_loc2_].amount;
            this.FConsumeExtraVect.push(_loc4_);
            _loc2_++;
         }
         this.FPropsname = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get OccultEffectLv() : int
      {
         return this.FOccultEffectLv;
      }
      
      public function set OccultEffectLv(param1:int) : void
      {
         this.FOccultEffectLv = param1;
      }
      
      public function get OccultEffectKey() : int
      {
         return this.FOccultEffectKey;
      }
      
      public function set OccultEffectKey(param1:int) : void
      {
         this.FOccultEffectKey = param1;
      }
      
      public function get ConsumeOccultPoint() : int
      {
         return this.FConsumeOccultPoint;
      }
      
      public function set ConsumeOccultPoint(param1:int) : void
      {
         this.FConsumeOccultPoint = param1;
      }
      
      public function get ConsumeExtra() : String
      {
         return this.FConsumeExtra;
      }
      
      public function set ConsumeExtra(param1:String) : void
      {
         this.FConsumeExtra = param1;
      }
      
      public function get ConsumeExtraVect() : Vector.<TItem>
      {
         return this.FConsumeExtraVect;
      }
      
      public function set ConsumeExtraVect(param1:Vector.<TItem>) : void
      {
         this.FConsumeExtraVect = param1;
      }
      
      public function get Propsname() : String
      {
         return this.FPropsname;
      }
      
      public function set Propsname(param1:String) : void
      {
         this.FPropsname = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FPropsname = this.FDesc;
      }
      
      public function get NextNijiaMystic() : TNijiaMystic
      {
         return this.FNextNijiaMystic;
      }
      
      public function set NextNijiaMystic(param1:TNijiaMystic) : void
      {
         this.FNextNijiaMystic = param1;
      }
   }
}

